---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ithorgrim.
--- DateTime: 17/03/2022 11:04
---
---
local Object = require("rxi_classic")

local Paragon = require("paragon")
      Paragon.Class = Object:extend()

      Paragon.ServerInformations = {
          quest_informations = {},
          creature_informations = {},
          spells_informations = {}
      }

--[[

    Technical Function

]]--

local function GTP_Creature()
    Paragon.ServerInformations.creature_informations = {}

    local GetCreature = WorldDBQuery("SELECT * FROM "..Paragon.Config.Database..".paragon_creature")
    if (not GetCreature) then
        return false
    end

    repeat
        local cId, cExp = GetCreature:GetUInt32(0), GetCreature:GetUInt32(1)

        if (not cExp or cExp < 0) then
            cExp = Paragon.Config.UniversaleCreatureExp
        end

        Paragon.ServerInformations.creature_informations[cId] = cExp
    until not GetCreature:NextRow()
end

local function GTP_Quest()
    Paragon.ServerInformations.quest_informations = {}

    local GetQuest = WorldDBQuery("SELECT * FROM "..Paragon.Config.Database..".paragon_quest")
    if (not GetQuest) then
        return false
    end

    repeat
        local qId, qExp = GetQuest:GetUInt32(0), GetQuest:GetUInt32(1)

        if (not qExp or qExp < 0) then
            qExp = Paragon.Config.UniversaleQuestExp
        end

        Paragon.ServerInformations.quest_informations[qId] = qExp
    until not GetQuest:NextRow()
end

local function GTP_Spell()
    Paragon.ServerInformations.spells_informations = {}

    local GetSpell = WorldDBQuery("SELECT * FROM "..Paragon.Config.Database..".paragon_spell")
    if (not GetSpell) then
        return false
    end

    repeat
        local sId, sName, sMinVal, sMaxVal = GetSpell:GetUInt32(0), GetSpell:GetString(1), GetSpell:GetUInt32(2), GetSpell:GetUInt32(3)

        if (not sName) then sName = tostring(sId) end
        if (not sMaxVal or sMaxVal > 255 or sMaxVal < 0) then sMaxVal = 255 end
        if (not sMinVal or sMinVal > 255 or sMinVal < 0) then sMinVal = 0 end
        if (not sMaxVal or sMaxVal > 255 or sMaxVal < 0 or sMaxVal > Paragon.Config.MaxSpellPoints) then sMaxVal = 255 end

        Paragon.ServerInformations.spells_informations[sId] = { spellname = sName, minval = sMinVal, maxval = sMaxVal }
    until not GetSpell:NextRow()
end

local function GetTechnicalParagonInformations(event)
    GTP_Spell()

    if (Paragon.Config.QuestGiveExp) then GTP_Quest() end
end
RegisterServerEvent(33, GetTechnicalParagonInformations)

--[[

    Paragon Class

]]--

function Paragon.Class:new()
    self.status = true

    self.spells = {}

    if (#Paragon.ServerInformations.spells_informations == 0) then
        GTP_Spell()
    end

    if (#Paragon.ServerInformations.spells_informations > 0) then
        for spellId, data in pairs(Paragon.ServerInformations.spells_informations) do
            if (not self.spells[spellId]) then
                self.spells[spellId] = { points = data.minval, spell = data.spellname }
            end
        end
    end

    self.informations = {
        level = 1,
        exp = 0,
        max_exp = 500
    }

    self.points = 0
end

function Paragon.Class:SetSpellPoint(spell, points, add)
    local sPoints

    if (points < 0 ) then
        return false
    end

    if (not add) then
        local tSpell = self.spells[spell].points
        if (points > tSpell) then
            return false
        end

        sPoints = self.spells[spell].points - points
        if (sPoints <= 0) then
            return false
        end
    else
        local pPoints = self:PointCalc()
        if (pPoints > points) then
            return false
        end

        sPoints = self.spells[spell].points + points
        if (sPoints > Paragon.Config.MaxSpellPoints) then
            return false
        end
    end

    self.spells[spell].points = sPoints
    self:SetPoints()
    return true
end

function Paragon.Class:SetLevel()
    self.informations.exp = 0
    self.informations.level = self.informations.level + 1
    self:SetPoints()
end

function Paragon.Class:ExpCalc()
    if (self.informations.exp >= self.informations.max_exp) then
        local pExp = self.informations.exp - self.informations.max_exp
        self:SetLevel()
        self:SetExp(pExp)
    end
end

function Paragon.Class:SetExp(value)
    self.informations.exp = self.informations.exp + value
    self:ExpCalc()
end

function Paragon.Class:SetPoints()
    self.points = self:PointCalc()
end

function Paragon.Class:ResetSpells()
    for spell, spell_informations in pairs(self.spells) do
        self:SetSpellPoint(spell, spell_informations.points, false)
    end
end

function Paragon.Class:PointCalc()
    local tPoints = self.informations.level * Paragon.Config.PointPerLevel

    if (#self.spells > 0 ) then
        local pPoints

        for spell, spell_informations in pairs(self.spells) do
            pPoints = pPoints + spell_informations.points
        end

        if (pPoints > tPoints) then
            self:ResetSpells()
        else
            tPoints = tPoints - pPoints
        end
    end

    return tPoints
end

function Paragon.Class:Disable()
    if (not self.status) then
        return false
    end

    self.Status = false
end

function Paragon.Class:Enable()
    if (self.status) then
        return false
    end

    self.Status = true
end

--[[

    Player Class Override

]]--

function Player:SetParagon()
    local pGuid = self:GetGUIDLow()
    local pAccid = self:GetAccountId()
    local paragon = Paragon.Class()

    local GetParagonData = CharDBQuery( "SELECT * FROM "..Paragon.Config.Database..".paragon_character WHERE guid = " ..pGuid)

    if (not GetParagonData) then
        print("This player doesn't have a Paragon Information registered :\nID -> "..pAccid.." GUID -> "..pGuid)
    else
        repeat
            local spell_id, spell_points = GetParagonData:GetUInt32(1), GetParagonData:GetUInt32(2)

            for var, data in pairs(Paragon.ServerInformations.spells_informations) do
                if (data.spellid == spell_id) then
                    paragon[spell_id].points = spell_points
                end
            end
        until not GetParagonData:NextRow()
    end

    self:SetData("paragon", paragon)
end

function Player:SetAllParagonAura()
    local paragon = self:GetData("paragon")

    for spell_id, _ in pairs(paragon.spells) do
        self:SetParagonAura(spell_id)
    end
end

function Player:SetParagonAura(spell_id)
    local paragon = self:GetData('paragon')

    if (not paragon.status) then
        return false
    end

    local pAura = self:GetAura( spell_id )
    if ( not pAura ) then
        self:AddAura( spell_id, self )
    end

    local points
    for spell, spell_informations in pairs(paragon.spells) do
        if (spell == spell_id) then
            points = spell_informations.points
        end
    end

    self:GetAura( spell_id ):SetStackAmount( points )
end
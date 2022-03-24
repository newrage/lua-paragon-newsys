---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ithorgrim.
--- DateTime: 17/03/2022 11:10
---
local Paragon = require("paragon")
Paragon.Config = { }

--[[-----------------------------------------------------------------------------------------------]]--
-- Enable
--
--    Paragon.Enable
--        Description: Enables / disables the Paragon system
--        Important:   If it is true then the Paragon system is active, if it is false the system is disabled.
--        Default:     true / false
--
--[[-----------------------------------------------------------------------------------------------]]--

Paragon.Config.Enable = true

--[[-----------------------------------------------------------------------------------------------]]--
-- Paragon Type
--
--    Paragon.Type
--        Description: Paragon's system display type
--        Important:   The type can only be an int, be careful if you choose the AIO interface you must send the patch to your players.
--        Default:     1 (1 is with Gossip Menu | 2 is with AIO Interface | 3 is with the AIO interface and the Gossip Menu)
--
--[[-----------------------------------------------------------------------------------------------]]--

Paragon.Config.Type = 1

--[[-----------------------------------------------------------------------------------------------]]--
-- Database
--
--    Paragon.Database
--        Description: This is the name of the database that will hold the Paragon data
--        Important:   If the database does not exist the script will create it.
--        Default:     r1_eluna
--
--[[-----------------------------------------------------------------------------------------------]]--

Paragon.Config.Database = "r1_eluna"

--[[-----------------------------------------------------------------------------------------------]]--
-- Points Per Level
--
--    Paragon.PointPerLevel
--        Description: The number of points to be given must remain an integer
--        Important:   The number of points per level can be an integer or a float, it must always be greater than 0
--        Default:     2
--
--        Note: The calculation will be (Paragon Level * Point Per Level)
--[[-----------------------------------------------------------------------------------------------]]--

Paragon.Config.PointPerLevel = 1

--[[-----------------------------------------------------------------------------------------------]]--
-- Max Level
--
--    Paragon.MaxLevel
--        Description: The maximum number of Paragon Level
--        Important:   The level cannot be higher than 2^32 (4 294 967 296)
--        Default:     4294967296
--
--[[-----------------------------------------------------------------------------------------------]]--

Paragon.Config.MaxLevel = 4294967296

--[[-----------------------------------------------------------------------------------------------]]--
-- Max Spell Points
--
--    Paragon.MaxSpellPoints
--        Description: The maximum number of points per spell
--        Important:   The maximum number of points per spell cannot exceed 255
--        Default:     255
--
--[[-----------------------------------------------------------------------------------------------]]--

Paragon.Config.MaxSpellPoints = 255

--[[
    TODO : Change comments bellow
]]--
    --[[-----------------------------------------------------------------------------------------------]]--
    -- Quest Give Exp
    --
    --    Paragon.QuestGiveExp
    --        Description: The maximum number of points per spell
    --        Important:   The maximum number of points per spell cannot exceed 255
    --        Default:     true (false : Desactivate | true : Active (populate paragon_quest for exp))
    --
    --[[-----------------------------------------------------------------------------------------------]]--

    Paragon.Config.QuestGiveExp = true

    --[[-----------------------------------------------------------------------------------------------]]--
    -- Min Player Level Quest Give Exp
    --
    --    Paragon.MaxSpellPoints
    --        Description: The maximum number of points per spell
    --        Important:   The maximum number of points per spell cannot exceed 255
    --        Default:     1 ()
    --
    --[[-----------------------------------------------------------------------------------------------]]--

    Paragon.Config.MinPlayerLevelQuestGiveExp = 1

    --[[-----------------------------------------------------------------------------------------------]]--
    -- Universal Quest Exp
    --
    --    Paragon.MaxSpellPoints
    --        Description: The maximum number of points per spell
    --        Important:   The maximum number of points per spell cannot exceed 255
    --        Default:     500 (populate paragon_quest for individual quest exp)
    --
    --[[-----------------------------------------------------------------------------------------------]]--

    Paragon.Config.UniversaleQuestExp = 500

--[[
    TODO : Change comments bellow
]]--
    --[[-----------------------------------------------------------------------------------------------]]--
    -- Max Spell Points
    --
    --    Paragon.MaxSpellPoints
    --        Description: The maximum number of points per spell
    --        Important:   The maximum number of points per spell cannot exceed 255
    --        Default:     true (false : Desactivate | true : Active (populate paragon_quest for exp))
    --
    --[[-----------------------------------------------------------------------------------------------]]--

    Paragon.Config.CreatureGiveExp = true

    --[[-----------------------------------------------------------------------------------------------]]--
    -- Max Spell Points
    --
    --    Paragon.MaxSpellPoints
    --        Description: The maximum number of points per spell
    --        Important:   The maximum number of points per spell cannot exceed 255
    --        Default:     1 ()
    --
    --[[-----------------------------------------------------------------------------------------------]]--

    Paragon.Config.MinPlayerLevelCreatureGiveExp = 1

    --[[-----------------------------------------------------------------------------------------------]]--
    -- Max Spell Points
    --
    --    Paragon.MaxSpellPoints
    --        Description: The maximum number of points per spell
    --        Important:   The maximum number of points per spell cannot exceed 255
    --        Default:     500 (populate paragon_quest for individual quest exp)
    --
    --[[-----------------------------------------------------------------------------------------------]]--

    Paragon.Config.UniversaleCreatureExp = 500

    --[[-----------------------------------------------------------------------------------------------]]--
    -- Max Spell Points
    --
    --    Paragon.MaxSpellPoints
    --        Description: The maximum number of points per spell
    --        Important:   The maximum number of points per spell cannot exceed 255
    --        Default:     500 (populate paragon_quest for individual quest exp)
    --
    --[[-----------------------------------------------------------------------------------------------]]--

    Paragon.Config.PlayerCreatureLevelDifference = 3
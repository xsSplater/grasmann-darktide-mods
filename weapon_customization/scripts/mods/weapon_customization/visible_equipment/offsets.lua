local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

local SoundEventAliases = mod:original_require("scripts/settings/sound/player_character_sound_event_aliases")

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region local functions
    local Unit = Unit
    local unit_alive = Unit.alive
    local unit_set_local_rotation = Unit.set_local_rotation
    local vector3 = Vector3
    local vector3_box = Vector3Box
    local Quaternion = Quaternion
    local quaternion_from_euler_angles_xyz = Quaternion.from_euler_angles_xyz
    local table = table
    local table_clone = table.clone
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

local REFERENCE = "weapon_customization"
local WEAPON_MELEE = "WEAPON_MELEE"
local WEAPON_RANGED = "WEAPON_RANGED"

-- ##### ┌─┐┌─┐┌─┐┌─┐┌─┐┌┬┐┌─┐ ########################################################################################
-- ##### │ │├┤ ├┤ └─┐├┤  │ └─┐ ########################################################################################
-- ##### └─┘└  └  └─┘└─┘ ┴ └─┘ ########################################################################################

mod.visible_equipment_loading_offsets = {
    melee_big_angle = {
        {position = vector3_box(2, -.4, 3.2), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),    ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --[]--[]--
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --XX--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

        {position = vector3_box(2, .4, 3.2), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),      ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--[]--
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--XX--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

        {position = vector3_box(2, -.4, 3.2), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),    ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --XX--[]-- ?
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
        
        {position = vector3_box(2, .4, 3.2), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),      ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--XX-- ?
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
    },
    melee_big = {},
    melee_medium = {
        {position = vector3_box(2, -.5, 2.75), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),   ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --[]--[]--
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --XX--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

        {position = vector3_box(2, .5, 2.75), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),     ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--[]--
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--XX--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

        {position = vector3_box(2, -.5, 2.75), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),   ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --XX--[]-- ?
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
        
        {position = vector3_box(2, .5, 2.75), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),     ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--XX-- ?
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
    },

    ranged_bulky = {
        {position = vector3_box(2, .4, 2), rotation = vector3_box(0, 0, -40), scale = vector3_box(3, 3, 3),    ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --[]--[]--
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --XX--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

        {position = vector3_box(2, .4, 2), rotation = vector3_box(0, 0, 40), scale = vector3_box(3, 3, 3),      ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--[]--
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--XX--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

        {position = vector3_box(2, .4, 2), rotation = vector3_box(0, 0, -40), scale = vector3_box(3, 3, 3),    ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --XX--[]-- ?
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
        
        {position = vector3_box(2, .4, 2), rotation = vector3_box(0, 0, 40), scale = vector3_box(3, 3, 3),      ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--XX-- ?
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
    },
    ranged_huge = {
        {position = vector3_box(2, -.3, 3.75), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),   ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --[]--[]--
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --XX--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

        {position = vector3_box(2, .3, 3.75), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),     ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--[]--
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--XX--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------

        {position = vector3_box(2, -.3, 3.75), rotation = vector3_box(200, 0, -40), scale = vector3_box(3, 3, 3),   ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 30),                                --XX--[]-- ?
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
        
        {position = vector3_box(2, .3, 3.75), rotation = vector3_box(200, 0, 40), scale = vector3_box(3, 3, 3),     ----------
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, -30),                               --[]--XX-- ?
            position2 = vector3_box(0, 0, 0), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(0, 0, 0),      --[]--[]--
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},                              ----------
    },
    ranged_medium = {},
    ranged_small = {},

    default = {
        -- position: x = -forward / +backward | y = -left / +right | z = -down / +up
        -- rotation: x = up / down | y = roll | z = left / right
        {position = vector3_box(0, 6, 5), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3),
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 0),
            position2 = vector3_box(0, 6, 5), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(3, 3, 3),
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},
        {position = vector3_box(0, 6, 5), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3),
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 0),
            position2 = vector3_box(0, 6, 5), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(3, 3, 3),
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},
        {position = vector3_box(0, -6, 5), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3),
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 0),
            position2 = vector3_box(0, -6, 5), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(3, 3, 3),
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},
        {position = vector3_box(0, -6, 5), rotation = vector3_box(0, 0, 180), scale = vector3_box(3, 3, 3),
            step_move = vector3_box(0, 0, 0), step_rotation = vector3_box(0, 0, 0),
            position2 = vector3_box(0, -6, 5), rotation2 = vector3_box(0, 0, 0), scale2 = vector3_box(3, 3, 3),
            step_move2 = vector3_box(0, 0, 0), step_rotation2 = vector3_box(0, 0, 0)},
    },
}

mod.visible_equipment_offsets = {
    ogryn = {
        WEAPON_MELEE = {
            default = {position = vector3_box(.5, .5, -.2), rotation = vector3_box(160, -90, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(0, 2.5, 2.5)},
            backpack = {position = vector3_box(.75, .5, .2), rotation = vector3_box(180, -30, 135), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(2.5, 0, -2.5)},
            loading = mod.visible_equipment_loading_offsets.melee_medium,
        },
        WEAPON_RANGED = {
            default = {position = vector3_box(.7, .6, .2), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(5, -5, 0)},
            backpack = {position = vector3_box(.1, .6, .8), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(0, -5, 0)},
            loading = mod.visible_equipment_loading_offsets.ranged_bulky,
        },
    },
    human = {
        WEAPON_MELEE = {
            default = {position = vector3_box(.3, .25, -.025), rotation = vector3_box(180, -80, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(.025, .0225, 0), step_rotation = vector3_box(0, -7.5, -7.5)},
            backpack = {position = vector3_box(.3, .25, -.225), rotation = vector3_box(120, -95, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.025, .0125, 0), step_rotation = vector3_box(0, -5, -5)},
            loading = mod.visible_equipment_loading_offsets.melee_medium,
            step_sounds = {SoundEventAliases.sfx_ability_foley_01.events.zealot},
        },
        WEAPON_RANGED = {
            default = {position = vector3_box(.3, .22, .125), rotation = vector3_box(200, -10, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(7.5, -7.5, 0)},
            backpack = {position = vector3_box(.3, .22, .25), rotation = vector3_box(240, 10, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(7.5, -7.5, 0)},
            loading = mod.visible_equipment_loading_offsets.default,
        },
    },
    --#region Ogryn Guns
        ogryn_heavystubber_p1_m1 = {
            default = {position = vector3_box(.7, .6, .2), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(-5, -5, 0)},
            backpack = {position = vector3_box(.1, .6, .8), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(0, -5, 0)},
            loading = mod.visible_equipment_loading_offsets.ranged_bulky,
            init = function(visible_equipment_extension, slot)
                local slot_info_id = mod:get_slot_info_id(slot.item)
                local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
                local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
                if attachment_slot_info then
                    local receiver = attachment_slot_info.attachment_slot_to_unit["receiver"]
                    local attachment = attachment_slot_info.unit_to_attachment_name[receiver]
                    if receiver and unit_alive(receiver) then
                        local node_index = 17
                        if attachment == "receiver_04" then node_index = 21 end
                        local rot = vector3(0, 0, 90)
                        local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                        unit_set_local_rotation(receiver, node_index, rotation)
                    end
                end
            end,
        },
        ogryn_rippergun_p1_m1 = {
            default = {position = vector3_box(.5, .6, .4), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(-5, -5, 0)},
            backpack = {position = vector3_box(-.2, .6, .6), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(0, -5, 0)},
            loading = mod.visible_equipment_loading_offsets.ranged_bulky,
            init = function(visible_equipment_extension, slot)
                -- Get slot info
                local slot_info_id = mod:get_slot_info_id(slot.item)
                local slot_infos = mod:persistent_table(REFERENCE).attachment_slot_infos
                local attachment_slot_info = slot_infos and slot_infos[slot_info_id]
                if attachment_slot_info then
                    local handle = attachment_slot_info.attachment_slot_to_unit["handle"]
                    local attachment = attachment_slot_info.unit_to_attachment_name[handle]
                    if handle and unit_alive(handle) then
                        local node_index = 6
                        if attachment == "handle_04" then node_index = 3 end
                        local rot = vector3(0, 0, 90)
                        local rotation = quaternion_from_euler_angles_xyz(rot[1], rot[2], rot[3])
                        unit_set_local_rotation(handle, node_index, rotation)
                    end
                end
            end,
        },
        ogryn_gauntlet_p1_m1 = {
            default = {position = vector3_box(0, .6, .2), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(5, -5, 0)},
            backpack = {position = vector3_box(-.2, .9, .1), rotation = vector3_box(-90, 15, 15), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(0, -5, 0)},
            loading = mod.visible_equipment_loading_offsets.ranged_bulky,
        },
        ogryn_thumper_p1_m1 = {
            default = {position = vector3_box(.2, .5, .5), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(5, -5, 0)},
            backpack = {position = vector3_box(-.2, .5, .6), rotation = vector3_box(200, 60, 70), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.1, .05, 0), step_rotation = vector3_box(0, -5, 0)},
            loading = mod.visible_equipment_loading_offsets.ranged_bulky,
            step_sounds = {SoundEventAliases.sfx_ads_up.events.ogryn_thumper_p1_m1},
        },
    --#endregion
    --#region Ogryn Melee
        ogryn_powermaul_p1_m1 = {
            default = {position = vector3_box(.5, .5, -.2), rotation = vector3_box(160, -90, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(0, 2.5, 2.5)},
            backpack = {position = vector3_box(.9, .5, .6), rotation = vector3_box(180, -30, 135), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(2.5, 0, -2.5)},
            loading = mod.visible_equipment_loading_offsets.melee_medium,
        },
        ogryn_powermaul_slabshield_p1_m1 = {
            default = {position = vector3_box(.5, .5, -.2), rotation = vector3_box(160, -90, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(0, 2.5, 2.5),
                position2 = vector3_box(.2, .45, -.2), rotation2 = vector3_box(0, 90, 70), scale2 = vector3_box(1, 1, 1),
                step_move2 = vector3_box(-.1, .05, 0), step_rotation2 = vector3_box(5, -5, 0)},
            backpack = {position = vector3_box(.9, .5, .6), rotation = vector3_box(180, -30, 135), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(2.5, 0, -2.5),
                position2 = vector3_box(.2, .6, -.25), rotation2 = vector3_box(20, 90, 60), scale2 = vector3_box(1, 1, 1),
                step_move2 = vector3_box(-.1, .05, 0), step_rotation2 = vector3_box(5, -5, 0)},
            loading = mod.visible_equipment_loading_offsets.melee_medium,
            step_sounds = {SoundEventAliases.sfx_equip.events.default},
            step_sounds2 = {
                SoundEventAliases.sfx_weapon_foley_left_hand_01.events.ogryn_powermaul_slabshield_p1_m1,
                SoundEventAliases.sfx_weapon_foley_left_hand_02.events.ogryn_powermaul_slabshield_p1_m1,
            },
            wield = function(visible_equipment_extension, slot)
                -- visible_equipment_extension:position_equipment()
            end,
        },
    --#endregion
    --#region Guns
        forcestaff_p1_m1 = {
            default = {position = vector3_box(.3, .2, .075), rotation = vector3_box(180, 80, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
            backpack = {position = vector3_box(.3, .25, .2), rotation = vector3_box(160, 90, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
            loading = mod.visible_equipment_loading_offsets.ranged_huge,
        },
        flamer_p1_m1 = {
            default = {position = vector3_box(.3, .25, .125), rotation = vector3_box(180, -10, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
            backpack = {position = vector3_box(.3, .25, .25), rotation = vector3_box(200, 0, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.05, .025, 0), step_rotation = vector3_box(2.5, -2.5, 0)},
            loading = mod.visible_equipment_loading_offsets.default,
            step_sounds = {SoundEventAliases.sfx_weapon_locomotion.events.flamer_p1_m1},
        },
        stubrevolver_p1_m1 = {
            default = {position = vector3_box(-.05, .21, .125), rotation = vector3_box(180, -15, 85), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.025, .015, 0), step_rotation = vector3_box(5, -5, 0)},
            backpack = {position = vector3_box(-.09, .21, .1), rotation = vector3_box(180, 10, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.025, .015, 0), step_rotation = vector3_box(5, -5, 0)},
            loading = mod.visible_equipment_loading_offsets.default,
            -- step_sounds = {SoundEventAliases.sfx_equip.events.stubrevolver_p1_m1},
            -- step_sounds = {SoundEventAliases.sfx_ads_up.events.stubrevolver_p1_m1},
            step_sounds = {SoundEventAliases.sfx_ads_down.events.stubrevolver_p1_m1},
            -- step_sounds = {SoundEventAliases.sfx_weapon_revolver_open.events.stubrevolver_p1_m1},
            --sfx_weapon_revolver_close
            --sfx_weapon_eject_ammo
        },
        laspistol_p1_m1 = {
            default = {position = vector3_box(-.05, .21, .125), rotation = vector3_box(180, -15, 85), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.025, .015, 0), step_rotation = vector3_box(5, -5, 0)},
            backpack = {position = vector3_box(-.09, .21, .1), rotation = vector3_box(180, 10, 90), scale = vector3_box(1, 1, 1),
                step_move = vector3_box(-.025, .015, 0), step_rotation = vector3_box(5, -5, 0)},
            loading = mod.visible_equipment_loading_offsets.default,
        },
    --#endregion
}
--#region Other weapons
    mod.visible_equipment_offsets.ogryn_club_p1_m1 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
    mod.visible_equipment_offsets.ogryn_combatblade_p1_m1 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
    mod.visible_equipment_offsets.ogryn_combatblade_p1_m2 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
    mod.visible_equipment_offsets.ogryn_combatblade_p1_m3 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
    mod.visible_equipment_offsets.ogryn_club_p2_m1 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
    mod.visible_equipment_offsets.ogryn_club_p2_m2 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]
    mod.visible_equipment_offsets.ogryn_club_p2_m3 = mod.visible_equipment_offsets.ogryn[WEAPON_MELEE]

    mod.visible_equipment_offsets.autopistol_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.shotgun_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.shotgun_p1_m2 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.shotgun_p1_m3 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.bolter_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    -- mod.visible_equipment_offsets.stubrevolver_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.stubrevolver_p1_m2 = mod.visible_equipment_offsets.stubrevolver_p1_m1
    mod.visible_equipment_offsets.stubrevolver_p1_m3 = mod.visible_equipment_offsets.stubrevolver_p1_m1
    -- mod.visible_equipment_offsets.stubrifle_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.autogun_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.autogun_p1_m2 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.autogun_p1_m3 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.autogun_p2_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.autogun_p2_m2 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.autogun_p2_m3 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.autogun_p3_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.autogun_p3_m2 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.autogun_p3_m3 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.lasgun_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.lasgun_p1_m2 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.lasgun_p1_m3 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.lasgun_p2_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.lasgun_p2_m2 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.lasgun_p2_m3 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.lasgun_p3_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.lasgun_p3_m2 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.lasgun_p3_m3 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.laspistol_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.laspistol_p1_m3 = mod.visible_equipment_offsets.human[WEAPON_RANGED]
    mod.visible_equipment_offsets.plasmagun_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_RANGED]

    mod.visible_equipment_offsets.combataxe_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combataxe_p1_m2 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combataxe_p1_m3 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combataxe_p2_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combataxe_p2_m2 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combataxe_p2_m3 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combataxe_p3_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combatknife_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.powersword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.powersword_p1_m2 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combatsword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combatsword_p1_m2 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combatsword_p1_m3 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.thunderhammer_2h_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.thunderhammer_2h_p1_m2 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.powermaul_2h_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.chainsword_2h_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combatsword_p2_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combatsword_p2_m2 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combatsword_p2_m3 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.forcesword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.forcesword_p1_m2 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.forcesword_p1_m3 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combatsword_p3_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combatsword_p3_m2 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.combatsword_p3_m3 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.chainaxe_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
    mod.visible_equipment_offsets.chainsword_p1_m1 = mod.visible_equipment_offsets.human[WEAPON_MELEE]
--#endregion
--#region Copies
    mod.visible_equipment_offsets.ogryn_heavystubber_p1_m2 = mod.visible_equipment_offsets.ogryn_heavystubber_p1_m1
    mod.visible_equipment_offsets.ogryn_heavystubber_p1_m3 = mod.visible_equipment_offsets.ogryn_heavystubber_p1_m1
    mod.visible_equipment_offsets.ogryn_rippergun_p1_m2 = mod.visible_equipment_offsets.ogryn_rippergun_p1_m1
    mod.visible_equipment_offsets.ogryn_rippergun_p1_m3 = mod.visible_equipment_offsets.ogryn_rippergun_p1_m1
    mod.visible_equipment_offsets.ogryn_thumper_p1_m2 = mod.visible_equipment_offsets.ogryn_thumper_p1_m1
    mod.visible_equipment_offsets.ogryn_powermaul_p1_m2 = mod.visible_equipment_offsets.ogryn_powermaul_p1_m1
    mod.visible_equipment_offsets.ogryn_powermaul_p1_m3 = mod.visible_equipment_offsets.ogryn_powermaul_p1_m1

    mod.visible_equipment_offsets.forcestaff_p2_m1 = mod.visible_equipment_offsets.forcestaff_p1_m1
    mod.visible_equipment_offsets.forcestaff_p3_m1 = mod.visible_equipment_offsets.forcestaff_p1_m1
    mod.visible_equipment_offsets.forcestaff_p4_m1 = mod.visible_equipment_offsets.forcestaff_p1_m1
--#endregion

--#region Other weapons
    mod.visible_equipment_offsets.ogryn_club_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.ogryn_combatblade_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.ogryn_combatblade_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.ogryn_combatblade_p1_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.ogryn_club_p2_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.ogryn_club_p2_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.ogryn_club_p2_m3.loading = mod.visible_equipment_loading_offsets.melee_medium

    mod.visible_equipment_offsets.combataxe_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combataxe_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combataxe_p1_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combataxe_p2_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combataxe_p2_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combataxe_p2_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combataxe_p3_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combatknife_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium --tiny
    mod.visible_equipment_offsets.powersword_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.powersword_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combatsword_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combatsword_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combatsword_p1_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.thunderhammer_2h_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_big_angle
    mod.visible_equipment_offsets.thunderhammer_2h_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_big_angle
    mod.visible_equipment_offsets.powermaul_2h_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_big_angle
    mod.visible_equipment_offsets.chainsword_2h_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_big_angle
    mod.visible_equipment_offsets.combatsword_p2_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combatsword_p2_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combatsword_p2_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.forcesword_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.forcesword_p1_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.forcesword_p1_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combatsword_p3_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combatsword_p3_m2.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.combatsword_p3_m3.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.chainaxe_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
    mod.visible_equipment_offsets.chainsword_p1_m1.loading = mod.visible_equipment_loading_offsets.melee_medium
--#endregion

return mod.visible_equipment_offsets
local mod = get_mod("weapon_customization")

-- ##### ┬─┐┌─┐┌─┐ ┬ ┬┬┬─┐┌─┐ #########################################################################################
-- ##### ├┬┘├┤ │─┼┐│ ││├┬┘├┤  #########################################################################################
-- ##### ┴└─└─┘└─┘└└─┘┴┴└─└─┘ #########################################################################################

--#region Require
    local UISoundEvents = mod:original_require("scripts/settings/ui/ui_sound_events")
--#endregion

-- ##### ┌─┐┌─┐┬─┐┌─┐┌─┐┬─┐┌┬┐┌─┐┌┐┌┌─┐┌─┐ ############################################################################
-- ##### ├─┘├┤ ├┬┘├┤ │ │├┬┘│││├─┤││││  ├┤  ############################################################################
-- ##### ┴  └─┘┴└─└  └─┘┴└─┴ ┴┴ ┴┘└┘└─┘└─┘ ############################################################################

--#region Performance
    local math = math
    local Unit = Unit
    local CLASS = CLASS
    local pairs = pairs
    local World = World
    local Actor = Actor
    local Camera = Camera
    local get_mod = get_mod
    local vector3 = Vector3
    local math_pi = math.pi
    local tostring = tostring
    local managers = Managers
    local math_sin = math.sin
    local math_lerp = math.lerp
    local NilCursor = NilCursor
    local unit_alive = Unit.alive
    local actor_unit = Actor.unit
    local Quaternion = Quaternion
    local vector3_box = Vector3Box
    local PhysicsWorld = PhysicsWorld
    local vector3_lerp = vector3.lerp
    local vector3_zero = vector3.zero
    local unit_get_data = Unit.get_data
    local quaternion_box = QuaternionBox
    local vector3_unbox = vector3_box.unbox
    local math_easeInCubic = math.easeInCubic
    local RESOLUTION_LOOKUP = RESOLUTION_LOOKUP
    local vector3_normalize = vector3.normalize
    local world_unlink_unit = World.unlink_unit
    local quaternion_unbox = quaternion_box.unbox
    local unit_local_position = Unit.local_position
    local quaternion_multiply = Quaternion.multiply
    local quaternion_axis_angle = Quaternion.axis_angle
    local camera_screen_to_world = Camera.screen_to_world
    local unit_set_local_position = Unit.set_local_position
    local unit_set_local_rotation = Unit.set_local_rotation
    local unit_set_unit_visibility = Unit.set_unit_visibility
    local math_round_with_precision = math.round_with_precision
--#endregion

-- ##### ┌┬┐┌─┐┌┬┐┌─┐ #################################################################################################
-- #####  ││├─┤ │ ├─┤ #################################################################################################
-- ##### ─┴┘┴ ┴ ┴ ┴ ┴ #################################################################################################

--#region Data
	local SLOT_SECONDARY = "slot_secondary"
    local WEAPON_PART_ANIMATION_TIME = .75
    local MOVE_DURATION_OUT = .5
	local MOVE_DURATION_IN = 1
    local RESET_WAIT_TIME = 5
--#endregion

-- Change light positions
mod.set_light_positions = function(self)
	if self.preview_lights and self.cosmetics_view then
		for _, unit_data in pairs(self.preview_lights) do
			-- Get default position
			local default_position = vector3_unbox(unit_data.position)
			-- Get difference to link unit position
			local weapon_spawner = self.cosmetics_view._weapon_preview._ui_weapon_spawner
			if weapon_spawner then
				local link_difference = vector3_unbox(weapon_spawner._link_unit_base_position) - vector3_unbox(weapon_spawner._link_unit_position)
				-- Position with offset
				local light_position = vector3(default_position[1], default_position[2] - link_difference[2], default_position[3])
				-- mod:info("mod.set_light_positions: "..tostring(unit_data.unit))
				unit_set_local_position(unit_data.unit, 1, light_position)
			end
		end
	end
end

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┌─┐─┐ ┬┌┬┐┌─┐┌┐┌┌─┐┬┌─┐┌┐┌ ##################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├┤ ┌┴┬┘ │ ├┤ │││└─┐││ ││││ ##################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  └─┘┴ └─ ┴ └─┘┘└┘└─┘┴└─┘┘└┘ ##################################################################

mod:hook_require("scripts/managers/ui/ui_weapon_spawner", function(instance)

	-- ┌┬┐┌─┐┌┬┐┌┬┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌─┐┬  ┌─┐
	-- ││││ │ ││ │││││││ ┬   │ │ ││ ││  └─┐
	-- ┴ ┴└─┘─┴┘─┴┘┴┘└┘└─┘   ┴ └─┘└─┘┴─┘└─┘

	instance.get_modding_tools = function(self)
		self.modding_tools = self.modding_tools or get_mod("modding_tools")
	end

	instance.unit_manipulation_busy = function(self)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_busy then
			return self.modding_tools:unit_manipulation_busy()
		end
	end

	instance.unit_manipulation_remove = function(self, unit)
		self:get_modding_tools()
		if self.modding_tools and self.modding_tools.unit_manipulation_remove then
			self.modding_tools:unit_manipulation_remove(unit)
		end
	end

	instance.toggle_modding_tools = function(self, value)
		self._modding_tool_toggled_on = value
	end

	instance.unit_manipulation_remove_all = function(self)
		if self._weapon_spawn_data and self._modding_tool_toggled_on then
			self:unit_manipulation_remove(self._weapon_spawn_data.item_unit_3p)
			local attachment_units_3p = self._weapon_spawn_data.attachment_units_3p or {}
			for _, unit in pairs(attachment_units_3p) do
				self:unit_manipulation_remove(unit)
			end
		end
	end

	-- ┌─┐┌─┐┌┬┐┌─┐┬─┐┌─┐  ┌┬┐┌─┐┬  ┬┌─┐┌┬┐┌─┐┌┐┌┌┬┐
	-- │  ├─┤│││├┤ ├┬┘├─┤  ││││ │└┐┌┘├┤ │││├┤ │││ │ 
	-- └─┘┴ ┴┴ ┴└─┘┴└─┴ ┴  ┴ ┴└─┘ └┘ └─┘┴ ┴└─┘┘└┘ ┴ 

	instance.start_camera_movement = function(self, position)
		if position then
			self.move_position:store(vector3_unbox(position))
		else
			self.move_position:store(vector3_zero())
		end
		self.do_move = true
		-- mod:echot("start_camera_movement: "..tostring(self.move_position))
		mod.move_position = self.move_position
		mod.do_move = self.do_move
	end

	-- instance.update_camera_movement = function(self, dt, t)

	-- end

	-- ┌─┐┌─┐┌┬┐┌─┐┬─┐┌─┐  ┌─┐┌─┐┌─┐┌┬┐
	-- │  ├─┤│││├┤ ├┬┘├─┤  ┌─┘│ ││ ││││
	-- └─┘┴ ┴┴ ┴└─┘┴└─┴ ┴  └─┘└─┘└─┘┴ ┴

	instance.custom_init = function(self)
		if self._reference_name ~= "WeaponIconUI" then
			self._link_unit_position = vector3_box(vector3_zero())
			-- Rotation

			self.do_move = mod.do_move
			self.move_end = mod.move_end
			self.current_move_duration = mod.current_move_duration or MOVE_DURATION_IN
			mod.current_move_duration = self.current_move_duration
			self.last_move_position = mod.last_move_position or vector3_box(vector3_zero())
			self.move_position = mod.move_position or vector3_box(vector3_zero())
			mod.move_position = self.move_position
			self.new_position = mod.new_position or vector3_box(vector3_zero())
			mod.new_position = self.new_position
			self._link_unit_position = mod._link_unit_position or vector3_box(vector3_zero())
			mod._link_unit_position = self._link_unit_position

			self.do_rotation = mod.do_rotation
			self._rotation_angle = mod._rotation_angle or 0
			mod._rotation_angle = self._rotation_angle
			self._target_rotation_angle = mod._target_rotation_angle or self._rotation_angle
			self._last_rotation_angle = mod._last_rotation_angle or self._rotation_angle
			mod._last_rotation_angle = self._last_rotation_angle
			self.is_doing_rotation = mod.is_doing_rotation
			self._default_rotation_angle = self._last_rotation_angle or 0
			self.start_rotation = mod.start_rotation
			self.rotation_time = mod.rotation_time

			-- Build animation extension
			if mod.cosmetics_view then
				mod.build_animation:set({
					ui_weapon_spawner = self,
					world = self._world,
					item = mod.cosmetics_view._presentation_item,
				}, true)
			end
			self:init_custom_weapon_zoom()
		end
	end

	instance.init_custom_weapon_zoom = function(self)
		local item = self._weapon_spawn_data and self._weapon_spawn_data.item
		item = item or self._loading_weapon_data and self._loading_weapon_data
		if item then
			-- Get item name
			
			-- local item_name = self:item_name_from_content_string(item.name)
			-- local item_name = self._item_name
			local item_name = mod.gear_settings:short_name(item.name)
			-- Check for weapon in data
			if mod.attachment_models[item_name] then
				-- Check for custom weapon zoom
				if mod.attachment_models[item_name].customization_min_zoom then
					local min_zoom = mod.attachment_models[item_name].customization_min_zoom
					self._min_zoom = min_zoom
				else
					self._min_zoom = -2
				end
				-- Set zoom
				self._weapon_zoom_target = self._min_zoom
				self._weapon_zoom_fraction = self._min_zoom
				self:_set_weapon_zoom(self._min_zoom)
			end
		end
	end

	-- ┬ ┬┌─┐┌─┐┌─┐┌─┐┌┐┌  ┬─┐┌─┐┌┬┐┌─┐┌┬┐┬┌─┐┌┐┌
	-- │││├┤ ├─┤├─┘│ ││││  ├┬┘│ │ │ ├─┤ │ ││ ││││
	-- └┴┘└─┘┴ ┴┴  └─┘┘└┘  ┴└─└─┘ ┴ ┴ ┴ ┴ ┴└─┘┘└┘

	instance.is_rotation_disabled = function(self)
		return not self.is_doing_rotation and (self:unit_manipulation_busy() or self._rotation_input_disabled or mod.dropdown_open)
	end

	instance.unlink_units = function(self)
		if self._weapon_spawn_data then
			local item_unit_3p = self._weapon_spawn_data.item_unit_3p
			local attachment_units_3p = self._weapon_spawn_data.attachment_units_3p
			for i = #attachment_units_3p, 1, -1 do
				local unit = attachment_units_3p[i]
				if unit and unit_alive(unit) then
					world_unlink_unit(self._world, unit)
				end
			end
			if item_unit_3p and unit_alive(item_unit_3p) then
				world_unlink_unit(self._world, item_unit_3p)
			end
		end
	end

	instance.initiate_weapon_rotation = function(self, new_angle, length)
		if not self.is_doing_rotation or (new_angle and new_angle ~= self._target_rotation_angle) then
			-- mod:echot("initiate_weapon_rotation: "..tostring(new_angle))
			self._last_rotation_angle = self._rotation_angle
			mod._last_rotation_angle = self._last_rotation_angle
			if new_angle then
				self._target_rotation_angle = new_angle
			else
				self._target_rotation_angle = 0
			end
			self.do_rotation = true
			mod.do_rotation = self.do_rotation
			self.rotation_time = length or 1
		end
		mod.rotation_time = self.rotation_time
		mod._target_rotation_angle = self._target_rotation_angle
		mod._last_rotation_angle = self._last_rotation_angle
	end

	instance.update_weapon_rotation = function(self, dt, t)

		local function ease_out_elastic(t)
			if t == 0 or t == 1 then return t end
			return 2^(-10 * t) * math_sin((t - 1.4 * 0.25) * (2 * math.pi) / 1.4) + 1
		end

		if self.do_rotation then
			self.is_doing_rotation = true
			mod.is_doing_rotation = self.is_doing_rotation
			self.do_rotation = nil
			mod.do_rotation = self.do_rotation
			self.start_rotation = t
			mod.start_rotation = self.start_rotation

		elseif mod.build_animation:is_busy() then
			if self.start_rotation then
				self.start_rotation = self.start_rotation + dt
				mod.start_rotation = self.start_rotation
			end

		elseif self.start_rotation and t < self.start_rotation + self.rotation_time then
			local progress = (t - self.start_rotation) / self.rotation_time
			local anim_progress = ease_out_elastic(progress)
			self._rotation_angle = math.lerp(self._last_rotation_angle, self._target_rotation_angle, anim_progress)
			mod._rotation_angle = self._rotation_angle

		elseif self.start_rotation and t > self.start_rotation + self.rotation_time then
			self._rotation_angle = self._target_rotation_angle
			mod._rotation_angle = self._rotation_angle
			self.start_rotation = nil
			mod.start_rotation = self.start_rotation
			self.is_doing_rotation = nil
			mod.is_doing_rotation = self.is_doing_rotation
			
		end
		
		-- mod.do_rotation = self.do_rotation
		-- mod.start_rotation = self.start_rotation
		-- mod._rotation_angle = self._rotation_angle
		-- mod._last_rotation_angle = self._last_rotation_angle
		-- mod.is_doing_rotation = self.is_doing_rotation

		-- -- Camera rotation
		-- if self.do_rotation then
		-- 	local new_rotation = mod.new_rotation
		-- 	if new_rotation then
		-- 		if new_rotation ~= 0 and self._default_rotation_angle ~= new_rotation then
		-- 			-- mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
		-- 		end
		-- 		-- self._rotation_angle = mod._last_rotation_angle or 0
		-- 		self._default_rotation_angle = new_rotation
		-- 		self._last_rotation_angle = self._default_rotation_angle
		-- 		self.check_rotation = true
		-- 		self.do_reset = nil
		-- 		self.reset_start = nil
		-- 		self.do_rotation = nil
		-- 	end

		-- -- elseif self.check_rotation and not mod.dropdown_open then
		-- -- 	if math_round_with_precision(self._rotation_angle, 1) == math_round_with_precision(self._default_rotation_angle, 1) then
		-- -- 		if math_round_with_precision(self._rotation_angle, 1) ~= 0 then
		-- -- 			self.do_reset = true
		-- -- 		end
		-- -- 		self.check_rotation = nil
		-- -- 	end

		-- end
	end

	

	instance.update_carousel = function(self, dt, t)
		if mod.cosmetics_view and mod:get("mod_option_carousel") then
			mod.cosmetics_view:try_spawning_previews()
			mod.cosmetics_view:update_attachment_previews(dt, t)
		end
	end

	instance.update_animation = function(self, dt, t)
		if self._weapon_spawn_data and self._link_unit_position then
			
			local link_unit = self._weapon_spawn_data.link_unit
			local position = vector3_unbox(self._link_unit_position)
			local animation_speed = mod:get("mod_option_weapon_build_animation_speed")
			local animation_time = WEAPON_PART_ANIMATION_TIME
			local item_unit_3p = self._weapon_spawn_data.item_unit_3p

			-- Camera movement
			if self.do_move and mod:get("mod_option_camera_zoom") then
				if not vector3.equal(vector3_unbox(self.move_position), vector3_zero()) then
					local last_move_position = self.last_move_position and vector3_unbox(self.last_move_position) or vector3_zero()
					local move_position = vector3_unbox(self.move_position)
					-- if not vector3.equal(last_move_position, move_position) then
						-- mod.new_position = vector3_box(vector3_unbox(self._link_unit_base_position) + move_position)
						self.new_position:store(vector3_unbox(self._link_unit_base_position) + move_position)
						mod.new_position = self.new_position
						self.move_end = t + MOVE_DURATION_IN
						mod.move_end = self.move_end
						self.current_move_duration = MOVE_DURATION_IN
						mod.current_move_duration = self.current_move_duration
						self.last_move_position = self.move_position
						mod.last_move_position = self.last_move_position
						mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
					-- end

				elseif not vector3.equal(vector3_unbox(self.move_position), vector3_unbox(self._link_unit_base_position)) then --self._link_unit_base_position then
					local last_move_position = vector3_unbox(self._link_unit_position)
					local move_position = vector3_unbox(self._link_unit_base_position)
					-- if not vector3.equal(move_position, last_move_position) then
						-- mod.new_position = self._link_unit_base_position
						self.new_position:store(vector3_unbox(self._link_unit_base_position))
						mod.new_position = self.new_position
						self.move_end = t + MOVE_DURATION_OUT
						mod.move_end = self.move_end
						self.current_move_duration = MOVE_DURATION_OUT
						mod.current_move_duration = self.current_move_duration
						self.last_move_position:store(vector3_zero())
						mod.last_move_position = self.last_move_position
						mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_out)
					-- end

				end
				self.do_move = nil
				mod.do_move = self.do_move
				self.do_reset = nil
				self.reset_start = nil

			elseif mod.build_animation:is_busy() then
				if self.move_end then
					self.move_end = self.move_end + dt
					mod.move_end = self.move_end
				end

			else
				if self.move_end and t <= self.move_end then
					local progress = (self.move_end - t) / self.current_move_duration
					local anim_progress = math_easeInCubic(1 - progress)
					local lerp_position = vector3_lerp(position, vector3_unbox(self.new_position), anim_progress)
					-- mod.link_unit_position = vector3_box(lerp_position)
					-- self.link_unit_position:store(lerp_position)
					if link_unit and unit_alive(link_unit) then
						-- mod:info("CLASS.UIWeaponSpawner: "..tostring(link_unit))
						unit_set_local_position(link_unit, 1, lerp_position)
					end
					-- self._link_unit_position = vector3_box(lerp_position)
					self._link_unit_position:store(lerp_position)
					mod._link_unit_position = self._link_unit_position

				elseif self.move_end and t > self.move_end then
					self.move_end = nil
					mod.move_end = self.move_end
					if link_unit and unit_alive(link_unit) then
						-- mod:info("CLASS.UIWeaponSpawner: "..tostring(link_unit))
						unit_set_local_position(link_unit, 1, vector3_unbox(self.new_position))
					end
					if link_unit and unit_alive(link_unit) then
						-- mod.link_unit_position = vector3_box(unit_local_position(link_unit, 1))
						self._link_unit_position:store(unit_local_position(link_unit, 1))
						mod._link_unit_position = self._link_unit_position
					end
					if self.current_move_duration == MOVE_DURATION_IN and not mod:vector3_equal(vector3_unbox(self.new_position), vector3_zero()) then
						self.do_reset = true
					end

				end
			end
			-- mod.customization_camera:update(dt, t)

			-- Lights
			mod:set_light_positions(self)
			
			-- -- Camera rotation
			-- if self.do_rotation then
			-- 	local new_rotation = mod.new_rotation
			-- 	if new_rotation then
			-- 		if new_rotation ~= 0 and self._default_rotation_angle ~= new_rotation then
			-- 			-- mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_in)
			-- 		end
			-- 		-- self._rotation_angle = mod._last_rotation_angle or 0
			-- 		self._default_rotation_angle = new_rotation
			-- 		self._last_rotation_angle = self._default_rotation_angle
			-- 		self.check_rotation = true
			-- 		self.do_reset = nil
			-- 		self.reset_start = nil
			-- 		self.do_rotation = nil
			-- 	end

			-- elseif self.check_rotation and not mod.dropdown_open then
			-- 	if math_round_with_precision(self._rotation_angle, 1) == math_round_with_precision(self._default_rotation_angle, 1) then
			-- 		if math_round_with_precision(self._rotation_angle, 1) ~= 0 then
			-- 			self.do_reset = true
			-- 		end
			-- 		self.check_rotation = nil
			-- 	end

			-- end

			-- Reset
			-- if self.do_reset and not mod.dropdown_open then
			-- 	self.reset_start = t + RESET_WAIT_TIME
			-- 	self.do_reset = nil

			-- elseif self.reset_start and t >= self.reset_start and not mod.dropdown_open then
			-- 	if self.move_position then
			-- 		mod:play_zoom_sound(t, UISoundEvents.apparel_zoom_out)
			-- 	end
			-- 	-- mod.move_position = nil
			-- 	self.move_position:store(vector3_zero())
			-- 	mod.move_position = self.move_position
			-- 	self.do_move = true
			-- 	mod.do_move = self.do_move
			-- 	self.reset_start = nil
			-- 	self._default_rotation_angle = 0
			-- 	self._last_rotation_angle = 0
			-- 	mod._last_rotation_angle = self._last_rotation_angle

			-- elseif self.reset_start and mod.dropdown_open then
			-- 	self.reset_start = self.reset_start + dt

			-- end

			-- mod.move_position = self.move_position
			-- mod.do_move = self.do_move
			-- mod.last_move_position = self.last_move_position
			-- mod.new_position = self.new_position
			-- mod._link_unit_position = self._link_unit_position
			-- mod.move_end = self.move_end
			-- mod.current_move_duration = self.current_move_duration

			-- Weapon part animations
			mod.build_animation:update(dt, t)
		end
	end

	instance.spawn_weapon_custom = function(self)
		if self._weapon_spawn_data and self._reference_name ~= "WeaponIconUI" then

			-- mod.cosmetics_view.weapon_unit = weapon_spawn_data.item_unit_3p
			-- mod.cosmetics_view.attachment_units_3p = weapon_spawn_data.attachment_units_3p or {}

			-- if modding_tools and mod.cosmetics_view._modding_tool_toggled_on then
			-- 	local gui = mod.cosmetics_view._ui_forward_renderer.gui
			-- 	modding_tools:unit_manipulation_add(weapon_spawn_data.item_unit_3p, self._camera, self._world, gui, mod.cosmetics_view._item_name)
			-- 	local attachment_units_3p = weapon_spawn_data.attachment_units_3p or {}
			-- 	for _, unit in pairs(attachment_units_3p) do
			-- 		local name = Unit.get_data(unit, "attachment_slot")
			-- 		modding_tools:unit_manipulation_add(unit, self._camera, self._world, gui, name)
			-- 	end
			-- end

			-- local item_name = mod.cosmetics_view._item_name
			local item_name = mod:item_name_from_content_string(self._weapon_spawn_data.item.name)
			local link_unit = self._weapon_spawn_data.link_unit

			mod.weapon_spawning = true

			unit_set_unit_visibility(self._weapon_spawn_data.item_unit_3p, true, true)

			mod.gear_settings:hide_bullets(self._weapon_spawn_data.attachment_units_3p)

			-- local flashlight = mod:get_attachment_slot_in_attachments(weapon_spawn_data.attachment_units_3p, "flashlight")
			local flashlight = mod.gear_settings:attachment_unit(self._weapon_spawn_data.attachment_units_3p, "flashlight")
			
			local attachment_name = flashlight and unit_get_data(flashlight, "attachment_name")
			if flashlight then
				mod:preview_flashlight(true, self._world, flashlight, attachment_name, true)
			end


			local t = managers.time:time("main")
			local start_seed = self._auto_spin_random_seed
			if not start_seed then
				return 0, 0
			end
			local progress_speed = 0.3
			local progress_range = 0.3
			local progress = math_sin((start_seed + t) * progress_speed) * progress_range
			local auto_tilt_angle = -(progress * 0.5)
			local auto_turn_angle = -(progress * math_pi * 0.25)

			local start_angle = self._rotation_angle or 0
			local rotation = quaternion_axis_angle(vector3(0, auto_tilt_angle, 1), -(auto_turn_angle + start_angle))
			if link_unit then

				local initial_rotation = self._weapon_spawn_data.rotation and quaternion_unbox(self._weapon_spawn_data.rotation)

				if initial_rotation then
					rotation = quaternion_multiply(rotation, initial_rotation)
				end

				unit_set_local_rotation(link_unit, 1, rotation)

				if not self._link_unit_base_position_backup then
					self._link_unit_base_position_backup = vector3_box(unit_local_position(link_unit, 1))
				end

				if self._last_item_name and self._last_item_name ~= item_name then
					self.do_reset = nil
					self.reset_start = nil
					self.move_end = nil
					mod.move_end = self.move_end
					self.do_move = nil
					mod.do_move = self.do_move
					self.last_move_position:store(vector3_zero())
					-- mod.move_position = nil
					self.move_position:store(vector3_zero())
				end
				
				if mod.attachment_models[item_name] and mod.attachment_models[item_name].customization_default_position then
					local position = vector3_unbox(mod.attachment_models[item_name].customization_default_position)
					-- mod:info("CLASS.UIWeaponSpawner: "..tostring(link_unit))
					unit_set_local_position(link_unit, 1, unit_local_position(link_unit, 1) + position)
				else
					-- mod:info("CLASS.UIWeaponSpawner: "..tostring(link_unit))
					unit_set_local_position(link_unit, 1, vector3_unbox(self._link_unit_base_position_backup))
				end

				if not self._link_unit_base_position then
					self._link_unit_base_position = vector3_box(unit_local_position(link_unit, 1))
				end

				if not vector3.equal(vector3_unbox(self._link_unit_position), vector3_zero()) then
					local position = vector3_unbox(self._link_unit_position)
					-- mod:info("CLASS.UIWeaponSpawner: "..tostring(link_unit))
					unit_set_local_position(link_unit, 1, position)
				end

				-- self._link_unit_position = vector3_box(unit_local_position(link_unit, 1))
				self._link_unit_position:store(unit_local_position(link_unit, 1))
				mod._link_unit_position = self._link_unit_position
				self._last_item_name = item_name

				mod:set_light_positions(self)
			end
		end
	end

end)

-- ##### ┌─┐┬  ┌─┐┌─┐┌─┐  ┬ ┬┌─┐┌─┐┬┌─┌─┐ #############################################################################
-- ##### │  │  ├─┤└─┐└─┐  ├─┤│ ││ │├┴┐└─┐ #############################################################################
-- ##### └─┘┴─┘┴ ┴└─┘└─┘  ┴ ┴└─┘└─┘┴ ┴└─┘ #############################################################################

mod:hook(CLASS.UIWeaponSpawner, "init", function(func, self, reference_name, world, camera, unit_spawner, ...)

	-- Original function
	func(self, reference_name, world, camera, unit_spawner, ...)

	-- Custom init
	self:custom_init()

end)

mod:hook(CLASS.UIWeaponSpawner, "destroy", function(func, self, ...)
	
	-- mod._last_rotation_angle = self._rotation_angle

	-- Build animation
	mod.build_animation:set(false)

	-- Original function
	func(self, ...)

end)

mod:hook(CLASS.UIWeaponSpawner, "_mouse_rotation_input", function(func, self, input_service, dt, ...)

	if input_service and input_service:get("left_pressed") then
		self.do_rotation = nil
		mod.do_rotation = self.do_rotation
		self.start_rotation = nil
		mod.start_rotation = self.start_rotation
		self.is_doing_rotation = nil
		mod.is_doing_rotation = self.is_doing_rotation
	end

	-- Check if rotation is disabled
	if self:is_rotation_disabled() then
		-- Execute original function without input_service
		return func(self, nil, dt, ...)
	end

	-- Original function
	return func(self, input_service, dt, ...)

end)

mod:hook(CLASS.UIWeaponSpawner, "cb_on_unit_3p_streaming_complete", function(func, self, item_unit_3p, ...)

	-- Original function
	func(self, item_unit_3p, ...)

	-- Stream fix
	if self._weapon_spawn_data then
		-- Weapon not spawning anymore
		mod.weapon_spawning = nil
		-- Set streaming complete
		self._weapon_spawn_data.streaming_complete = true
	end

end)

mod:hook(CLASS.UIWeaponSpawner, "_despawn_weapon", function(func, self, ...)

	-- Unlink units
	self:unlink_units()

	-- Remove unit manipulation
	self:unit_manipulation_remove_all()

	-- Original function
	func(self, ...)
	
end)

mod:hook(CLASS.UIWeaponSpawner, "update", function(func, self, dt, t, input_service, ...)

	-- Fix streaming issues when mesh streamer is deactivated
	if self._weapon_spawn_data and not self._weapon_spawn_data.visible then
		self:cb_on_unit_3p_streaming_complete(self._weapon_spawn_data.item_unit_3p)
	end

	-- Original function
	func(self, dt, t, input_service, ...)

	if self._reference_name ~= "WeaponIconUI" and mod.cosmetics_view then --and not self.demo then

		-- Update carousel
		self:update_carousel(dt, t)

		-- Update animations
		self:update_animation(dt, t)

		self:update_weapon_rotation(dt, t)

	end

end)

mod:hook(CLASS.UIWeaponSpawner, "_spawn_weapon", function(func, self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)

	-- Original function
	func(self, item, link_unit_name, loader, position, rotation, scale, force_highest_mip, ...)

	-- Spawn custom weapon
	self:spawn_weapon_custom()

end)
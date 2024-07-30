event_inherited();

var player = instance_nearest(x, y, obj_player)
var barrel = instance_nearest(player.x, player.y, obj_hazard_barrel)

var target_direction = point_direction(x, y, target_x, target_y)

var seen_x = 0;
var seen_y = 0;
var seen_direction = point_direction(x, y, seen_x, seen_y);

currentTarget = player;

if (instance_exists(obj_player))
{
	switch(currentTarget)
	{
		case player :
			target_priority = 0;
			break;
		case barrel :
			target_priority = 1;
			break;
	}
	currentTriggerReset = clamp(currentTriggerReset - delta / 60, 0, 10000)

	var dist_to_player = point_distance(x, y, currentTarget.x, currentTarget.y)

	var blockedbywall = collision_line(x, y, currentTarget.x, currentTarget.y, obj_solid, false, false)
	
	var in_detection_radius = rectangle_in_circle(bbox_left, bbox_top, bbox_right, bbox_bottom, currentTarget.x, currentTarget.y, ai_detect_radius)
	var in_danger_close = rectangle_in_circle(bbox_left, bbox_top, bbox_right, bbox_bottom, player.x, player.y, ai_danger_close)
	var in_sidearm_radius = rectangle_in_circle(bbox_left, bbox_top, bbox_right, bbox_bottom, player.x, player.y, ai_fasterreload)

	if (char_state == CSTATE.ALIVE && player.char_state == CSTATE.ALIVE && !weapon_swapped)
	{
		#region Snipe Player
		if (player.char_state != CSTATE.ALIVE || player.char_state == CSTATE.ALIVE)
		{
			if (!blockedbywall)
			{
				if (in_detection_radius)
				{
					target_x = currentTarget.x
					target_y = currentTarget.y
					
					if ( !VO_is_playing )
					{
						playsound_at( snd_vo_ghillie_targetspotted, x, y );
						VO_is_playing = true;
					}
					
					rotate_to(target_direction, 2.5);
					if (abs(angle_difference(target_direction, charLookDir)) < 16)
					{
						currentWeapon.laser_color = merge_color(c_black, c_red, 0.06);
						charAttackWeapon(false);
						currentWeapon.trigger_pressed = true;
					}
					else
					{
						currentWeapon.trigger_pressed = false;
						currentWeapon.laser_color = merge_color(c_black, c_lime, 0.06);
					}
				}
			}
			else
			{
				currentWeapon.trigger_pressed = false;
				currentWeapon.laser_color = merge_color(c_black, c_lime, 0.06);
			}
		}
		else
		{
			currentWeapon.trigger_pressed = false;
			currentWeapon.laser_color = merge_color(c_black, c_lime, 0.06);
		}
		#endregion
		#region Snipe Explosive Barrels Near Player
		if (instance_exists(obj_hazard_barrel))
		{
		// If Player Is Close to barrels, the sniper will target them and shoot them.
			if (point_distance(player.x, player.y, barrel.x, barrel.y) <= 16 * 6)
			{
				target_priority = 1;
			}
			else
			{
				target_priority = 0;
			}
		}
		if (target_priority == 1)
		{
			currentTarget = barrel
			if (!blockedbywall)
			{
				if (in_detection_radius)
				{
					rotate_to(target_direction, 2.5);
					if (abs(angle_difference(target_direction, charLookDir)) < 15)
					{
						currentWeapon.laser_color = merge_color(c_black, c_red, 0.06);
						charAttackWeapon(false);
						currentWeapon.trigger_pressed = true;
					}
				}
			}
		}
		#endregion
		#region Backpedal if player is too close
		if (point_distance(x, y, player.x, player.y) <= 16 * 8)
		{
			movementDirection = target_direction - 180;
			charVelocity = 0.5;
		}
		else
		{
			charVelocity = 0;
		}
		#endregion
		#region Chamber a new round
		if (!reloading || !rechambering || !throwing_nade)
		{
			if (currentWeapon.eject && sprite_index = charGetSpriteFromIndex(self,currentWeapon.attack_sprite[currentWeapon.attack_index][0]))
			{
				if (image_index < currentWeapon.eject_f) && (image_index + (image_speed) >= currentWeapon.eject_f)
				{
					rechambering = true;
					playsound_at(snd_bolt, x, y, id, 16 * 8)
				}
				else
				{
					rechambering = false;
				}
			}
		}
		#endregion
		#region Throw Grenade at player if in the danger close
		if (player.char_state == CSTATE.ALIVE && currentWeapon.ammo > 0 && !rechambering && !reloading)
		{
			if (!blockedbywall)
			{
				if (in_danger_close)
				{
					throwing_nade = true;
				}
			}
		}
		if (throwing_nade)
		{
			seen_x = player.x
			seen_y = player.y
			
			rotate_to(seen_direction, 2.5);
			
			var nade = choose(obj_item_hegrenade, obj_item_stungrenade)
				
			if (nade == obj_item_hegrenade)
			{
				debris_index = 0;
			}
			if (nade == obj_item_stungrenade)
			{
				debris_index = 1;
			}
				
			var throw_index = 13;
			
			sprite_index = nade_sprite
			masksprite = nademask_sprite
			image_index += 0.02 * delta
			if (image_index < throw_index) && (image_index + (image_speed) >= throw_index)
			{
				playsound_at(snd_nadepin, x, y, id, 16 * 8)
				//playsound_at(sndThrow, x, y, id, 16 * 8)
				#region Grenade
				var spawn_x = x + lengthdir_x(26, charLookDir)
				var spawn_y = y + lengthdir_y(22, charLookDir)
				var inst = instance_create_depth(spawn_x, spawn_y, -15, nade)
				inst.grenade_spd = 10;
				inst.grenade_frc = random_range(0.2, 0.4);
				inst.direction = charLookDir
					
				var inst = instance_create_depth(spawn_x, spawn_y, -15, obj_debris_generic)
				inst.sprite_index = spr_debris_grenade_pin
				inst.image_index = debris_index;
				inst.debris_spd = random_range(4, 8);
				inst.debris_frc = random_range(0.2, 0.5);
				inst.fly_speed = true;
				inst.direction = charLookDir + random_range(-360, 360)
				inst.image_angle = inst.direction + random_range(-360, 360)
				inst.fly_speed = 8;
							
				throwing_nade = false;
			}
			#endregion
		}
		#endregion
		#region Reload if out of ammo
		if (!throwing_nade)
		{
			if (currentWeapon.ammo == 0)
			{
				#region Mag Drop
				var mag_dropframe = 9;
				if (image_index < mag_dropframe) && (image_index + (image_speed) >= mag_dropframe)
				{
					var inst = instance_create_depth(x, y, -15, obj_debris_generic)
					inst.sprite_index = spr_junk_magazines
					inst.x = x + lengthdir_x(19, charLookDir) 
					inst.y = y + lengthdir_y(27, charLookDir)
					inst.image_index = 0
					inst.flying = true;
					inst.image_angle = random_range(-360, 360)
					inst.debris_spd = random_range(3, 4)
					inst.debris_frc = random_range(0.2, 0.3)
					inst.direction = random(360)
				}
				#endregion
				sprite_index = reload_sprite
				mask_sprite = maskreload_sprite
				image_index += 0.01 * delta
				reloading = true;
			}
		}
		#endregion
	}
	else
	{
		charVelocity = 0;
	}
}
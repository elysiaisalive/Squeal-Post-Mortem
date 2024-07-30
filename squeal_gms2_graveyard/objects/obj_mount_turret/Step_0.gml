var _other = obj_character;
var dist_to_other = point_distance( _other.x, _other.y, x, y );
var IsAlive = _other.char_state == CSTATE.ALIVE;

if ( dist_to_other <= interact_radius && IsAlive )
{
	var check_radius = rectangle_in_circle( bbox_left, bbox_top, bbox_right, bbox_bottom, _other.x, _other.y, interact_radius );
	
	if ( _other.trigger_second_pressed && !interact_pressed )
	{
		interact_pressed = true;
		
		println( "Mounting Gun" )
			
		if ( check_radius )
		{
			mounted = true;
			
			with( _other )
			{
				sprite_index	= charGetSpriteFromIndex( self, "MountGun" ) ?? FALLBACK_SPRITE;
				canMove			= false;
				can_attack		= false;
			}
		}
	}
	else
	if ( _other.trigger_second_pressed && interact_pressed )
	{
		interact_pressed = false;
		
		println( "Dismounting Gun" )
		
		if ( check_radius )
		{
			mounted = false;
			
			with( _other )
			{
				sprite_index	= charGetSpriteFromIndex( self, "WalkUnarmed" ) ?? FALLBACK_SPRITE;
				canMove			= true;
				can_attack		= true;
			}
		}
	}
}

if ( mounted && IsAlive )
{
	var offset_x = lengthdir_x( sprite_xoffset - 32, _other.charLookDir );
	var offset_y = lengthdir_y( sprite_yoffset - 32, _other.charLookDir );
	
	_other.x = x + offset_x;
	_other.y = y + offset_y;
	
	var angle_diff = angle_difference( _other.charLookDir, image_angle );
	
	image_angle += angle_diff * 0.15 * delta;
	
	if ( _other.trigger_held && fire_delay >= 0 )
	{
		var offset_x = lengthdir_x( sprite_xoffset + 32, image_angle );
		var offset_y = lengthdir_y( sprite_yoffset + 32, image_angle );
		var phys_recoil = 8;
		
		fire_delay = max( 0, fire_delay - 1 * delta );
		
		if ( fire_delay == 0 )
		{
			
			if ( fire_delaymax <= 8 )
			{
				barrel_heat += 0.006;
			}
			
			fire_delaymax -= 1;
			cool_delay += 10;
			fire_delay = fire_delaymax;
			
			global.shake = 4;
			image_angle += random_range( -phys_recoil, phys_recoil );
			playsound_at( snd_gun_m16, x, y );
			
			var shell_dirx = lengthdir_x( 8, image_angle );
			var shell_diry = lengthdir_y( 8, image_angle );
			
			spawn_shell( obj_shellcasing, spr_debris_bullet, 3, image_angle + shell_dirx + shell_diry, -_other.left );
			//spawn_bullet( 1, x + offset_x, y + offset_y, image_angle, 10, obj_proj_bullet, BULLETCAL.HIGH, 12 );
			spawn_particle( obj_particle_generic, spr_effect_flashmounted, 0.2, image_angle, image_angle, 1, x + offset_x, y + offset_y, 0, 0, 1, false, false );
		}
	}
	else
	{
		cool_delay = max( 0, cool_delay - 1 * delta );
		
		if ( cool_delay == 0 )
		{
			barrel_heat -= 0.01 * delta;
			fire_delaymax += 0.05 * delta;
		}
	}
}

#region Overheated FX
if ( fire_delaymax <= 8 )
{
	var offset_x = lengthdir_x( sprite_xoffset + 32, image_angle );
	var offset_y = lengthdir_y( sprite_yoffset + 32, image_angle );
	
	heat_delay = max( 0, heat_delay - 1 * delta );
	
	if ( heat_delay == 0 )
	{
		repeat( random_range( 2, 3 ) )
		{
			spawn_particle( 
				obj_particle_generic, 
				spr_impact_smoke2, 
				0.2, 
				random(360), 
				random(360), 
				random_range( 0.8, 1 ), 
				x + offset_x, 
				y + offset_y, 
				random_range( 1, 2 ), 
				random_range( 0.2, 0.3 ), 
				1, 
				true 
				);
		}
		heat_delay = heat_delaymax;
	}
}

// Rev gun down
if ( !mounted )
{
	cool_delay = max( 0, cool_delay - 1 * delta );
		
	if ( cool_delay == 0 )
	{
		barrel_heat -= 0.01 * delta;
		fire_delaymax += 0.05 * delta;
	}
}
#endregion

if ( !IsAlive )
{
	mounted = false;
	interact_pressed = false;
}

fire_delaymax = clamp( fire_delaymax, 5, 16 );
cool_delay = clamp( cool_delay, 0, cool_delaymax );
barrel_heat = clamp( barrel_heat, 0, barrel_heatmax );

var angle_diff2 = angle_difference( image_angle, ammo_angle );

ammo_angle += angle_diff2 * 0.35 * delta;

var player = instance_nearest(x, y, obj_player)
var danger_close = 16 * 8;
var blockedbywall = collision_line(x, y, player.x, player.y, obj_wall, false, false)
var in_danger_close = rectangle_in_circle(bbox_left, bbox_top, bbox_right, bbox_bottom, player.x, player.y, danger_close)

if (!blockedbywall)
{
	if (in_danger_close)
	{
		with( obj_player )
		{
			charThrowWeapon( random_range( 4, 5 ), charLookDir + 90 );
			
			sprite_index = charGetSpriteFromIndex( self, "Stunned" );
			image_speed = 0.2;
			char_status = STATUS.STUNNED;
			can_attack = false;
			can_pickup_item = false;
			
			spawn_particle(
				obj_particle_generic,
				spr_effect_blind,
				0.1,
				0,
				0,
				1,
				x,
				y,
				0, 
				0,
				1,
				true,
				true,
				-255,
				true,
				0.02
				);
		}
		
		obj_hud.flashbang_a = 1;
		obj_hud.flashbanged = true;
		obj_hud.flash_fadedelay = 90;
	}
}
instance_destroy();
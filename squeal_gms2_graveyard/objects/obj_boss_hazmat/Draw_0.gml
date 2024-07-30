if (char_state == CSTATE.ALIVE)
{
	draw_sprite_ext(
		character_legs, 
		legindex,
		x, 
		y, 
		xscale, 
		yscale, 
		charLookDir, 
		image_blend, 
		image_alpha
		)

	if (currentWeapon.mod_laser == true)
	{
		scr_draw_laser(
			currentWeapon.laser_dist, 
			currentWeapon.laser_alpha, 
			currentWeapon.laser_width, 
			currentWeapon.laser_color
			);
	}

	draw_sprite_ext(
		sprite_index, 
		image_index,
		x, 
		y, 
		xscale, 
		yscale * sign(0.5 - flipped), 
		charLookDir, 
		image_blend, 
		image_alpha
		)

	if (mask_sprite != noone)
	{
		draw_sprite_ext(
			mask_sprite, 
			image_index,
			x, 
			y, 
			xscale, 
			yscale * sign(0.5 - flipped), 
			charLookDir, 
			image_blend, 
			image_alpha
			)
	}
}

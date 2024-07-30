// Shadow
draw_sprite_ext(
	gun.sprite, 
	gun.animIndex, 
	x, 
	y, 
	scale, 
	scale, 
	gun_angle, 
	c_black,
	0.4
);

#region Weapon Glow
var c_color;
var c_outlinecolor;
if ( weapon_valid ) {
	if ( gun.ammo <= ( gun.ammoMax / 4 ) 
	&& ( gun.attackType == ATTACKTYPE.GUN ) ) {
		c_color = merge_color( c_red, c_black, 0.1 );
		c_outlinecolor = c_red;
	}
	else if ( gun.ammo <= ( gun.ammoMax / 2 ) 
	&& ( gun.attackType == ATTACKTYPE.GUN ) ) {
		c_color = merge_color( c_yellow, c_black, 0.1 );
		c_outlinecolor = c_yellow;
	}
	else {
		c_color = merge_color( c_white, c_black, 0.6 );
		c_outlinecolor = c_white;
	}
	
	if ( ( gun.ammo > 0 ) 
	&& ( gun.attackType == ATTACKTYPE.GUN ) ) {
		gpu_set_blendmode( bm_add );
		draw_set_alpha( abs( sin( siner2 ) ) );
		draw_circle_color( x, y, 15, c_color, c_black, false );
		gpu_set_blendmode( bm_normal );
		draw_set_alpha( 1 );
	}
	else if ( gun.attackType != ATTACKTYPE.GUN ) {
		gpu_set_blendmode( bm_add );
		draw_set_alpha( abs( sin( siner2 ) ) );
		draw_circle_color( x, y, 15, c_color, c_black, false );
		gpu_set_blendmode( bm_normal );
		draw_set_alpha( 1 );
	};
	#endregion
	#region Weapon Outline
	if ( instance_exists( obj_player ) ) {
		var dist = obj_player.pickup_target == id;
		
		if ( dist ) 
		{ 
			outline_alpha += 0.05 * delta;
		} 
		else 
		{
			outline_alpha -= 0.05 * delta;
		}
		
		outline_alpha = clamp( outline_alpha, 0, 1 );
	
		if ( gun.ammo > 0 
		&& gun.attackType == ATTACKTYPE.GUN )
		{
			scr_draw_outline(
				x + ( amount * 0.9 ) + dcos( siner ) * amount, 
				y - ( amount * 0.9 ) - dcos( siner ) * amount, 
				gun.animIndex,
				1,
				gun_angle,
				c_outlinecolor,
				outline_alpha
				);
		}
		else
		if ( gun.attackType != ATTACKTYPE.GUN )
		{
			scr_draw_outline(
				x + ( amount * 0.9 ) + dcos( siner ) * amount, 
				y - ( amount * 0.9 ) - dcos( siner ) * amount, 
				gun.animIndex,
				1,
				gun_angle,
				c_white,
				outline_alpha
				);	
		};
	};
}
#endregion
#region Drawing Laser
// if (gun.mod_laser)
// {
// 	{
// 		for ( var laser_length = 0; laser_length < ( laser_dist / 2 ); ++laser_length )
// 		{
// 			var _x = x + lengthdir_x( laser_length, image_angle );
// 			var _y = y + lengthdir_y( laser_length, image_angle );
			
// 			if ( !position_empty( _x, _y ) )
// 			{
// 				if ( place_meeting(_x, _y, obj_wall ) )
// 				{
// 					gpu_set_blendmode(bm_add);
// 					draw_set_alpha(gun.laser_alpha);
// 					draw_circle_color(
// 						_x, 
// 						_y, 
// 						3.5, 
// 						c_red, 
// 						c_black, 
// 						false
// 						);
// 					draw_set_alpha(1);
// 					gpu_set_blendmode(bm_normal);
// 					break;
// 				}
// 			}
// 			gpu_set_blendmode(bm_add);
// 			draw_set_alpha(gun.laser_alpha);
// 			draw_line_width_color(
// 				x, 
// 				y, 
// 				_x, 
// 				_y, 
// 				gun.laser_width,
// 				gun.laser_color, 
// 				gun.laser_color
// 				);
// 			draw_set_alpha(1);
// 			gpu_set_blendmode(bm_normal);
// 		}
// 	}
// }
#endregion

if ( weapon_valid ) {
	if ( gun.ammo == 0 
	&& gun.attack_type == ATTACKTYPE.GUN )
	{
		draw_sprite_ext(
			gun.sprite, 
			gun.animIndex,  
			x + 1, 
			y + 1, 
			scale, 
			scale, 
			gun_angle, 
			merge_color( c_white, c_black, 0.5 ),
			1
			);
	}
	else
	{
		draw_sprite_ext(
	gun.sprite, 
	gun.animIndex,  
			x + ( amount * 0.9 ) + dcos( siner ) * amount, 
			y - ( amount * 0.9 ) - dcos( siner ) * amount, 
			scale, 
			scale, 
			gun_angle, 
			image_blend,
			1
			);
	}
}
else {
	draw_sprite_ext(
	gun.sprite, 
	gun.animIndex,  
		x + 1, 
		y + 1, 
		scale, 
		scale, 
		gun_angle, 
		merge_color( c_white, c_black, 0.5 ),
		1
	);
};

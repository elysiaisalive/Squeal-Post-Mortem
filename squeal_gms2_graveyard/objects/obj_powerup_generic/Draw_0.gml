// Shadow
draw_sprite_ext(
	sprite_index, 
	image_index, 
	x, 
	y, 
	scale, 
	scale, 
	image_angle, 
	c_black,
	0.4
	)
	
#region Outline
scr_draw_outline(
	x + ( amount * 1 ) + dcos( siner ) * amount, 
	y - ( amount * 1 ) - dcos( siner ) * amount, 
	image_index,
	1,
	image_angle,
	outline_color,
	sin( siner2 )
	)
	
if instance_exists( obj_player ) 
{
	var dist = point_distance( x, y, obj_player.x, obj_player.y )

	if ( dist <= 16 * 3 )
	{ 
		outline_alpha += 0.05 * delta
	} 
	else 
	{
		outline_alpha -= 0.05 * delta
	}
	
	outline_alpha = clamp(outline_alpha, 0, 1);

	scr_draw_outline(
		x + ( amount * 1 ) + dcos( siner ) * amount, 
		y - ( amount * 1 ) - dcos( siner ) * amount, 
		image_index,
		1,
		image_angle,
		outline_color,
		outline_alpha
		)
}
#endregion

// Sprite
draw_sprite_ext(
	sprite_index, 
	image_index, 
	x + (amount * 1) + dcos(siner) * amount, 
	y - (amount * 1) - dcos(siner) * amount, 
	scale, 
	scale, 
	image_angle, 
	c_white,
	1
	)
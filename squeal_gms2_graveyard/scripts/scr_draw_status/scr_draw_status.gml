function scr_draw_status(){
	var intensity = 0.9;
	var mergescale = 0;
	var startalpha = 1;
	var scale = window_get_width() / camera_get_view_width(CURRENT_VIEW);
	var x1 = (camera_get_view_width(CURRENT_VIEW) + 250) * scale
	var y1 = (camera_get_view_height(CURRENT_VIEW) + 250) * scale
	var x2 = (camera_get_view_width(CURRENT_VIEW) / x1 - 250) * scale
	var y2 = (camera_get_view_height(CURRENT_VIEW) / y1 - 250) * scale
	
#region Bleedout Status
if (instance_exists(obj_player)) 
{
	if (obj_player.bleedout)
	{
		draw_set_alpha(startalpha + (sin(obj_player.bleedout_a) * intensity)) 
		{
		gpu_set_blendmode(bm_add)
		draw_ellipse_color(
			x1,
			y1,
			x2,
			y2,
			merge_color(c_black, c_status, mergescale),
			c_status,
			false
		)
		}
		gpu_set_blendmode(bm_normal)
		draw_set_alpha(1)
	}
		draw_set_alpha(obj_player.hit_a) 
		{
		gpu_set_blendmode(bm_add)
		draw_ellipse_color(
			x1,
			y1,
			x2,
			y2,
			merge_color(c_black, c_status, mergescale),
			c_status,
			false
		)
		}
		gpu_set_blendmode(bm_normal)
		draw_set_alpha(1)
}
#endregion
#region Powerup Status
draw_set_alpha(sin(powerup_a)) 
{
gpu_set_blendmode(bm_add)
draw_ellipse_color(
	x1,
	y1,
	x2,
	y2,
	merge_color(c_black, c_powerup, mergescale),
	c_powerup,
	false
)
}
gpu_set_blendmode(bm_normal)
draw_set_alpha(1)
#endregion
#region Flashbang Status
if (flashbanged) 
{
	draw_set_alpha(flashbang_a) 
	{
	draw_ellipse_color
	(
		x1,
		y1,
		x2,
		y2,
		merge_color(c_white, c_black, mergescale),
		c_white,
		false
	)
	}
}
gpu_set_blendmode(bm_normal)
draw_set_alpha(1)
#endregion
}
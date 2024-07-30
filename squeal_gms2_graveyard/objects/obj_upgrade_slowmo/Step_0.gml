event_inherited();


// If player exists
if ( instance_exists( obj_player ) )
{
	var dist = point_distance( x, y, obj_player.x, obj_player.y )

	// If player == Joe
	if ( obj_player.char == "Joe" )
	{
		if ( interact_press && dist < 16 )
		{
			playsound( snd_item_hpupgrade )
			
			if ( obj_hud.show_styleuptip )
			{
				obj_hud.show_tip = true;
			}
			
			obj_player.stats.style_max += 10;
			obj_hud.current_tip = TEXT_TIP.TIP_STYLEUPGRADE;
			obj_hud.onscreen_time = obj_hud.onscreen_maxtime;
			obj_hud.c_powerup = c_lime;
			obj_hud.powerup_a ++;
		
			instance_destroy();
		}
	}
}

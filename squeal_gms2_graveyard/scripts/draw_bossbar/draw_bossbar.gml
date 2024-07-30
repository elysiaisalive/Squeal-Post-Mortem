function draw_bossbar(  ) {
	
	var scale			= window_get_width() / camera_get_view_width( CURRENT_VIEW );
	var _x				= camera_get_view_width( CURRENT_VIEW );
	var _y				= camera_get_view_height( CURRENT_VIEW );
	var shake_x			= dcos( 360 ) + random_range( -element_shake, element_shake );
	var shake_y			= dsin( 360 ) + random_range( -element_shake, element_shake );
	var hp				= obj_boss_hedge.stats.hp;
	var hp_max			= obj_boss_hedge.stats.hp_max;
	var armour		= obj_boss_hedge.stats.armour;
	var armour_max	= obj_boss_hedge.stats.armour_max;
	
	#region Hedge Boss
	if ( instance_exists( obj_boss_hedge ) )
	{
		draw_set_halign( fa_center );
		draw_set_valign( fa_top );
		
		// Bar
		draw_sprite_ext(
			spr_hud_bossbar_hedgebar,
			0,
			( _x / 2 ) * scale, 
			( _y / 10 ) * scale,
			scale / 1.5,
			scale / 1.5,
			0,
			c_white,
			image_alpha
			);
			
		#region Health bars	
		
		var hp_x = ( hp / hp_max ) * 2.6 * delta;
		
		// HP
		draw_sprite_ext(
			spr_hud_bossbar_hedgehp,
			0,
			( _x / 2.54 ) * scale, 
			( _y / 10 ) * scale,
			hp_x,
			scale / 1.5,
			0,
			c_white,
			image_alpha
			);
		// Armor
		draw_sprite_ext(
			spr_hud_bossbar_hedgehp,
			1,
			( _x / 2.54 ) * scale, 
			( _y / 10 ) * scale,
			hp_x,
			scale / 1.5,
			0,
			c_white,
			image_alpha
			);
		#endregion
		
		// Head
		draw_sprite_ext(
			spr_hud_bossbar_hedge,
			boss_hpstate,
			( ( _x + shake_x ) / 2 ) * scale, 
			( ( _y + shake_y ) / 10 ) * scale,
			scale / 1.5,
			scale / 1.5,
			0,
			c_white,
			image_alpha
			);
	}
	
	#endregion

}
liquid_sin += 0.050;
current_hud.Tick();
current_hud.UpdateElements();
screen.UpdateElements();

inventoryMenu.Tick();

if ( keyboard_check_direct( vk_5 ) )
{
	current_hud.ShowAll();
	screen.ShowAll();
};

if ( keyboard_check_direct( vk_6 ) )
{
	current_hud.HideAll();
	screen.HideAll();
};

if ( instance_exists( obj_player ) 
&& obj_player.char_state == CSTATE.ALIVE )
{	
	if ( slowmo_active )
	{	
		if ( !joe_syringeinject && ( joe_syringeindex <= 6 ) )
		{
			joe_syringeindex = lerp( joe_syringeindex, 6, 0.1 );
			joe_syringeposy = lerp( joe_syringeposy, 200, 0.2  );
			joe_syringeposy2 = lerp( joe_syringeposy2, 268, 0.2  );
			joe_juicebary = lerp( joe_juicebary, 150, 0.06  );
		
			if ( joe_syringeindex >= ( sprite_get_number( spr_hud_joe_slometer ) - 1 )  )
			{
				joe_syringeinject = true;
			}
		}
	}
	else
	{
		joe_syringeindex = lerp( joe_syringeindex, 0, 0.1 );
		joe_syringeposy = lerp( joe_syringeposy, 180, 0.2  );
		joe_syringeposy2 = lerp( joe_syringeposy2, 248, 0.2  );
		joe_juicebary = lerp( joe_juicebary, 250, 0.02  );
	}
}
else
{
	joe_syringeindex = lerp( joe_syringeindex, 0, 0.1 );
	joe_syringeposy = lerp( joe_syringeposy, 180, 0.2  );
	joe_syringeposy2 = lerp( joe_syringeposy2, 248, 0.2  );
	joe_juicebary = lerp( joe_juicebary, 250, 0.02  );
}
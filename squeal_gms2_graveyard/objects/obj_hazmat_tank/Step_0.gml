if ( hp == 0 )
{
	effects_explode_char();
	instance_create_depth( x, y, -15, obj_hazard_explosion );
	playsound_at( snd_airburst_explode );
		
	instance_destroy();
}
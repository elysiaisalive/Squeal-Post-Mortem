function init_collectibles()
{
	
	global.trophies.trophy_example			= new create_trophy( "kill the Guy", "kill him", spr_ui_collectible_generic );
	global.trophies.trophy_asire			= new create_trophy( "Manic Angel's Halo", "The bearer of this is said to have received the gift of infinite light. \n Did she get her wish?", spr_ui_collectible_asire );
	global.trophies.trophy_maid				= new create_trophy( "Mysterious Maid Dress", "It has an Amazon tag...", FALLBACK_SPRITE );
	global.trophies.trophy_joeform			= new create_trophy( "LAPD Application Form", "The LAPD Application form signed by Joe", spr_ui_choice_form );
	global.trophies.trophy_pointmask		= new create_trophy( "Point Man's Mask", "No need to FEAR.", FALLBACK_SPRITE );
	global.trophies.trophy_chess			= new create_trophy( "Gambit", "Collect every interdimensional chess piece.", FALLBACK_SPRITE );

	global.trophies.trophy_quest_example	= new create_trophy_quest( "kill the Guys", "kill them", FALLBACK_SPRITE, 10 );
	global.trophies.trophy_quest_pointman	= new create_trophy_quest( "Point Man", "Kill 100 Enemies in SloMo.", FALLBACK_SPRITE, 100 );
	global.trophies.trophy_quest_chess		= new create_trophy_quest( "The Wisecracking Gambit", "Collect every interdimensional chess piece.", FALLBACK_SPRITE, 6 );
	
	/*
	example creation code for making objects disapear on unlocks
	
	global.trophies.trophy_joeform.Unlock();

	if ( global.trophies.trophy_joeform.IsUnlocked() )
	{
		instance_deactivate_object( self );
	}
	
	*/
}
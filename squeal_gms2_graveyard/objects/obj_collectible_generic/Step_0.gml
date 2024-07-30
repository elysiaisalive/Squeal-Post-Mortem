var dist = point_distance( x, y, obj_player.x, obj_player.y );

if ( dist <= 16 && obj_player.trigger_second_pressed )
{	
	if ( !trophy.IsUnlocked() )
	{
		if ( UnlockOnPickup )
		{
			trophy.Unlock();
		}
		else
		if ( !UnlockOnPickup )
		{
			trophy.Add();
		}
		
	    obj_player.SetSpriteFromIndex( "PickUpItem" );
	    obj_player.DoAnimation( 0, 0.20 );
	    obj_player.DropWeapon( 0.50, obj_player.charLookDir );
		
		instance_destroy();
	};
	
	// Save global.trophies to a file somewhere eventually.
};

if ( animated )
{
	image_speed = anim_spd * delta;
};

if ( trophy.IsUnlocked() )
{
	println( "Unlocked [" + string( trophy.GetName() ) + "]" );
	instance_destroy();
}
event_inherited();

setWallHeight( 62 );
Solid_SetFlags( BLOCK_MOVEMENT );

on_melee_hit = function( xx, yy, dir )
{
	instance_destroy();
	return true;
};
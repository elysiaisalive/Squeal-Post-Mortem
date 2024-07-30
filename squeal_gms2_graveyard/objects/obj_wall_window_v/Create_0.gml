event_inherited();

setWallHeight( 25 );
Solid_SetFlags( BLOCK_MOVEMENT );

var inst = instance_create_depth( x, y, z - height, obj_wall_windowpane_v );

on_proj_hit = function()
{
	return true;
};
on_object_hit = function()
{
	return true;
};
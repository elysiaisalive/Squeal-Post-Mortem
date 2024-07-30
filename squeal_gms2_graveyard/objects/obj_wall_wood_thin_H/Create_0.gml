event_inherited();

setWallHeight( 62 );

penetrable			= false;

wall_hp				= 200;
wall_maxhp			= 200;

draw_simpleshadow	= true;

wall_mat			= material.wood_weak;

image_speed			= 0;

on_proj_death = function()
{
	instance_destroy();
};
event_inherited();

wall_hp			= 650;
wall_maxhp		= 650;

on_proj_hit = function()
{
	effects_impact_metalspark( proj_hit_id );
	return true;
};
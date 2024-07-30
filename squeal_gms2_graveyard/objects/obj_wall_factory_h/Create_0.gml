event_inherited();

on_proj_hit = function()
{
	effects_impact_metalspark( proj_hit_id );
	return true;
};
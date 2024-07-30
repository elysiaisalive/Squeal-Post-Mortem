event_inherited();

impactSnd = choose(
    audio().GetSound( @"env\impact\impact_fence-01" ),
    audio().GetSound( @"env\impact\impact_fence-02" ),
    audio().GetSound( @"env\impact\impact_fence-03" ),
    audio().GetSound( @"env\impact\impact_fence-04" )
    );
ricochetSnd = choose(
    audio().GetSound( @"env\impact\impact_metalric-01" ),
    audio().GetSound( @"env\impact\impact_metalric-02" ),
    audio().GetSound( @"env\impact\impact_metalric-03" ),
    audio().GetSound( @"env\impact\impact_metalric-04" ),
    audio().GetSound( @"env\impact\impact_metalric-05" ),
    audio().GetSound( @"env\impact\impact_metalric-06" )
    );

on_proj_hit = function()
{
	effects_impact_metalspark( proj_hit_id );
	sfx_play_at( self, impactSnd, false, proj_hit_id.x, proj_hit_id.y );
	sfx_play_at( self, ricochetSnd, false, proj_hit_id.x, proj_hit_id.y );
	return true;
};
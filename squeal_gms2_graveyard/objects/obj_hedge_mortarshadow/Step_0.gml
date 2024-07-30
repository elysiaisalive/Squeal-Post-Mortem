alpha = max( 0, alpha + alpha_change * delta );
scale = max( 0, scale - scale_change * delta );
	
var inst = instance_nearest( x, y, obj_hedge_mortar );

if ( alpha >= max_alpha )
{
	
	if ( scale <= 0.2 )
	{
		effects_explode_mortar();
		effects_explode_debris();
		instance_create_depth( x, y, -15, obj_hazard_explosion );
		instance_create_depth( x, y, depth, obj_effect_shockwave );
		
		instance_destroy();
		instance_destroy( inst );
	}
}

scale = clamp( scale, 0, max_scale );
alpha = clamp( alpha, 0, max_alpha );
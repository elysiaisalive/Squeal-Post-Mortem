event_inherited();

explosion_radius_inner = max( 0, explosion_radius_inner + explosion_inner_grow * delta );

outer_delay = max( 0, outer_delay - 1 * delta );

if ( outer_delay == 0 )
{
	explosion_radius_outer = max( 0, explosion_radius_outer + explosion_outer_grow * delta );
}

// Outer Explosion

// var check = collision_circle( x, y, explosion_radius_outer, obj_character, false, true );

// if ( check )
// {
// 	with( obj_character )
// 	{
// 		if ( char_state == CSTATE.ALIVE )
// 		{	
// 			if ( !body_created )
// 			{
// 				gore_explosionouter( self );
// 				body_created = true;
// 				char_state = CSTATE.DEAD;
				
// 				stats.hp = 0;
// 			};
// 		};
// 	};
// };

// var check2 = collision_explosion( obj_character, explosion_radius_inner );

// if ( check2[0] )
// {
// 	for( var i = 0; i < array_length( check2[1] ); ++i )
// 	{
// 		if ( check2[1][i].char_state == CSTATE.ALIVE )
// 		{	
// 			if ( !body_exists )
// 			{
// 				gore_explosioninner( check2[1][i] );
// 				body_exists = true;
				
// 				check2[1][i].stats.hp = 0;
// 			}
// 		}
// 	}
// }

var check3 = collision_explosion( obj_hazard_barrel, explosion_radius_outer );
var check4 = collision_explosion( obj_factory_cagelight, explosion_radius_outer );

if ( check3[0] )
{
	for( var i = 0; i < array_length( check3[1] ); ++i )
	{
		check3[1][i].hp = 25;
	}
}

if ( check4[0] ) {
	for( var i = 0; i < array_length( check4[1] ); ++i ) {
		check4[1][i].doFlicker();
	}
}


if ( explosion_radius_outer > explosion_radius_outermax )
{
	instance_destroy();
}

explosion_radius_inner	= clamp( explosion_radius_inner, 0, explosion_radius_innermax );
explosion_radius_outer	= clamp( explosion_radius_outer, 0, explosion_radius_outermax );
outer_delay				= clamp( outer_delay, 0, outer_delaymax );

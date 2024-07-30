event_inherited();
setPropHeight( 48 );

image_speed		= 0;

destructible	= true;
hp				= 100;
hp_max			= 100;
impact_snd		= snd_armor_hit3;
spr_debris		= spr_debris_concrete_small;
debris_amnt		= random_range( 4, 6 );
spr_particle	= spr_effect_spark;
particle_amnt	= random_range( 4, 6 );

shadow_depth	= 1;

draw_over		= true;
spr_over		= spr_general_monitorscreen;

Solid_RemoveFlag( BLOCK_VISION | BLOCK_MOVEMENT );
event_inherited();

hp					= 100;
hp_max				= 100;

locked				= false;

swing_spd			= 0;
swinger				= 0;
snd_door			= snd_env_door_open;

CanCollide			= true;

//y += 5;

if ( !locked )
{
	nodegraph_ignore		= true;
}

Solid_RemoveFlag( BLOCK_MOVEMENT | BLOCK_VISION );
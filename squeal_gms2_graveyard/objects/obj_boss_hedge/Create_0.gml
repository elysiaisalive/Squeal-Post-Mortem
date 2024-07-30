event_inherited();

// Init Character stats
char_boss_hedge();

enum STAGE
{
	ONE,
	TWO,
}

boss_stage			= STAGE.ONE;
smoke_deployed		= false;

mask_sprite			= spr_mask_hedge;
					
CanDown				= false;
CanBleed			= true;
can_attack			= true;

bleed_threshold		= 350;
					
currentTarget		= obj_player;
target_spotted		= false;
					
track_timer			= 60 * 1.5;
track_maxtimer		= 60 * 1.5;

barrel_heat			= 0;
heat_time			= 8;
barrel_sprite		= noone;
barrel_cool			= false;

idle_timer			= 175;
idle_maxtimer		= 175;

bomb_delay			= 20;
bomb_maxdelay		= 40;

shattered			= false;
					
currentPath			= path_add();
currentPathX				= 0;
currentPathY				= 0;

siner				= 0;

wander_dir			= 0;
wander_timer		= 90;
wander_delay_max	= 175;
wander_delay		= random_range(0, wander_delay_max)
rotation_timer		= random_range(0, 256)
walk_timer			= random_range(0, 256)
rotation_timer_max	= 175;
walk_timer_max		= 175;
ai_visiondist		= 16 * 1024;
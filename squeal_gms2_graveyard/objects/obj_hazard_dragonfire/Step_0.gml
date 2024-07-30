var entity = instance_nearest(x, y, obj_player)
image_speed = fire_spd * delta

if (entity.char_state == CSTATE.ALIVE)
{
	if (place_meeting(x, y, entity))
	{
		dmg_timer = max(dmg_timer - 1 * delta)
		dmg_timer = clamp(dmg_timer, 0, dmg_timer_max)
		if (dmg_timer == 0)
		{
			entity.stats.hp -= hazard_dmg
			entity.IsBurning = true;
			obj_player.hit_a ++
			dmg_timer = dmg_timer_max;
		}
	}
}
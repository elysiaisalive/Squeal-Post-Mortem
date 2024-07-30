event_inherited();

var entity = instance_nearest(x, y, obj_player)

goo_timer = max(0, goo_timer - 1);
goo_timer = clamp(goo_timer, 0, goo_timermax);

if (goo_timer == 0)
{
	image_alpha -= 0.02;
	
	if (image_alpha == 0)
	{
		instance_destroy();
	}
}


if (entity.char_state == CSTATE.ALIVE)
{
	//if (place_meeting(x, y, entity))
	//{
	//	entity.movement_speed = entity.movement_speed / 4
	//}
	//else
	//{
	//	entity.movement_speed = 3.5;
	//}
}
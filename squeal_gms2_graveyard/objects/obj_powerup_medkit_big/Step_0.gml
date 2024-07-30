event_inherited();

if (instance_exists(obj_player))
{
	var dist = point_distance( x, y, obj_player.x, obj_player.y )

	if ( keyboard_check_direct( global.inputs.key_secondary ) && dist <= 32 && obj_player.stats.hp < obj_player.stats.hp_max ) 
	{
		playsound( snd_medkit_pickup )
		obj_player.stats.hp += 50
		obj_hud.c_powerup = c_lime
		obj_hud.powerup_a ++
		instance_destroy();
	}
}
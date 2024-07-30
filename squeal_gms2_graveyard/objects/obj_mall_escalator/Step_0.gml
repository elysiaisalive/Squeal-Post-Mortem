image_index += conveyer_spd * delta;
direction = image_angle;

var entity = noone;
var entity2 = noone;
var entity3 = noone;
var entity4 = noone;

/* 
	I am going to make this better eventually
*/
if ( instance_exists( obj_character ) ) 
{
	entity = instance_nearest( x, y, obj_character );
}

if ( instance_exists( obj_weapon_generic ) ) 
{
	entity2 = instance_nearest( x, y, obj_weapon_generic );
}

if ( instance_exists( obj_powerup_generic ) ) 
{
	entity3 = instance_nearest( x, y, obj_powerup_generic );
}

if ( place_meeting( x, y, entity) )
{
	entity.x += dcos(direction) * conveyer_spd * delta
	entity.y -= dsin(direction) * conveyer_spd * delta
}

if ( place_meeting( x, y, entity2) )
{
	entity2.x += dcos(direction) * conveyer_spd * delta
	entity2.y -= dsin(direction) * conveyer_spd * delta
}

if ( place_meeting( x, y, entity3) )
{
	entity3.x += dcos(direction) * conveyer_spd * delta
	entity3.y -= dsin(direction) * conveyer_spd * delta
}
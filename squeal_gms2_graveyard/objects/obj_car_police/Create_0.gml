event_inherited();

car_mask = spr_car_joecarmask;

door_sprite = spr_car_joecardoor;
door_angle = 0;
door_openspeed = 5;
door_closespeed = 3;
door_offset = [ 21, -21 ];
door_targetangle = -75;

var light = instance_create_depth( x + lengthdir_x( 30, image_angle ), y + lengthdir_y( 30, image_angle ), z, obj_light_generic );
light.lightScale = 1;
light.lightSprite = spr_lightmask_car;
light.lightAngle = image_angle;
light.lightColor = #fffcc5;
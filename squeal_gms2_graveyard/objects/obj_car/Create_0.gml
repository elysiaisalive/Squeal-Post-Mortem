event_inherited();

setPropHeight( 62 );

floor_sprite = -1;
car_mask = spr_car_joecarmask;

door_sprite = spr_car_joecardoor;
door_angle = 0;
door_openspeed = 5;
door_closespeed = 3;
door_offset = [ 21, -21 ];
door_targetangle = -75;

image_speed = 0;
image_index = 0;

mask_index	= car_mask;

Solid_SetFlags( BLOCK_MOVEMENT );
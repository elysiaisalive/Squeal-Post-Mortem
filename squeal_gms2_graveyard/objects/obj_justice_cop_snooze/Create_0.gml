event_inherited();
setPropHeight( 26 );

image_speed = 0.05;
image_index = floor( random( image_number ) );

shadow_depth = 1;

Solid_AddFlag( BLOCK_MOVEMENT );
Solid_RemoveFlag( BLOCK_VISION | BLOCK_OBJECTS );
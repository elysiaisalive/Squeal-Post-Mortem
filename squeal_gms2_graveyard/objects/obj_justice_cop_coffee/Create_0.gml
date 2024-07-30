event_inherited();
setPropHeight( 45 );

image_speed = 0.15;
image_index = floor( random( image_number ) );

shadow_depth = 1;

Solid_AddFlag( BLOCK_MOVEMENT );
Solid_RemoveFlag( BLOCK_VISION | BLOCK_OBJECTS );
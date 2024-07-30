flash_index += flash_speed * delta;

x += lengthdir_x( shooter_id.currentWeapon.bullet_pos[0], shooter_id.charLookDir );
y += lengthdir_y( shooter_id.currentWeapon.bullet_pos[1], shooter_id.charLookDir );
flash_angle = shooter_id.charLookDir;

if ( image_index >= image_number )
{
    instance_destroy();   
};
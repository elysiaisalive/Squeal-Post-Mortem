anim_index += anim_spd * delta;

image_index = anim_index;
image_speed = 0;

if ( anim_index >= ( image_number ) ) {
    anim_index = 0;
    anim_spd = 0;
};

if ( instance_exists( owner ) ) {
    var bulldir			= point_direction( 0, 0, owner.currentWeapon.bullet_pos[0], owner.currentWeapon.bullet_pos[1] );
    var bulldist		= point_distance( 0, 0, owner.currentWeapon.bullet_pos[0], owner.currentWeapon.bullet_pos[1] );
    
    x = owner.x + lengthdir_x( bulldist, bulldist + owner.charLookDir );
    y = owner.y + lengthdir_y( bulldist, bulldist + owner.charLookDir );
    image_angle = owner.charLookDir;
}
else {
    instance_destroy();
}
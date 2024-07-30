var _ent_check = collision_rectangle( bbox_left, bbox_top, bbox_right, bbox_bottom, obj_character, false, true );

if ( _ent_check )
{
    ent_id = _ent_check;
    
    if( !in_clip )
    {
        prev_speed = _ent_check.movement_speed;
        _ent_check.movement_speed = prev_speed * 0.75;
    };
    
    in_clip = true;
}
else
{
    if ( ent_id != noone )
    {
        ent_id.movement_speed = prev_speed;
        in_clip = false;
        prev_speed = 0;
        ent_id = noone;
    };
};
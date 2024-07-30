function ValidateMantle( _obj = obj_solid ) {
    
    // Getting collision mask variables so we can check for a valid spot later
    var hitbox_w = sprite_get_width( charCollisionMask );
    var hitbox_h = sprite_get_height( charCollisionMask );
    
    var obj_w = sprite_get_bbox_left( _obj.sprite_index ) + sprite_get_bbox_right( _obj.sprite_index );
    var obj_h = sprite_get_bbox_top( _obj.sprite_index ) + sprite_get_bbox_bottom( _obj.sprite_index );
    
    var obj_x1 = sprite_get_bbox_left( _obj.sprite_index );
    var obj_y1 = sprite_get_bbox_top( _obj.sprite_index );   
    var obj_x2 = sprite_get_bbox_right( _obj.sprite_index );
    var obj_y2 = sprite_get_bbox_bottom( _obj.sprite_index );
    
    var min_mantleheight = HEIGHT.WAIST;
    
    var check_line = collision_line( x, y, x + lengthdir_x( 16, charLookDir ), y + lengthdir_y( 16, charLookDir ), obj_solid, false, true );
    var check_pos = collision_rectangle( obj_x1, obj_y1, obj_x2, obj_y2, obj_solid, false, true );
    
    var result = false;

    /* 
        Check the coordinates based on an offset based on the desired mantling objects width and height * 2 that way we can get the proper dimensions + an offset
        
        also return true
        
        When a ValidMantle happens we will also get the point dir of the object to the player and set the player to MANTLE cState where 
        they will mantle over the object until complete.
        
        Mantling must take into account object height and dimensions for animation length.
    */


    if ( check_line ) {
        // Temporary height that the player will use when mantling
        var temp_height = check_line.height + HEIGHT.WAIST;
        
        if ( check_line.collision_flags & BLOCK_MOVEMENT ) {
            if ( check_line.height <= min_mantleheight ) {
                height = temp_height;
                result = true;
            }
        }
    }
    
    return result;
}
event_inherited();

setPropHeight( 25 );
Solid_AddFlag( BLOCK_PROJECTILE );
Solid_RemoveFlag( BLOCK_MOVEMENT | BLOCK_VISION );

stats.hp = 25;

shadow_depth = 1;
ignore3DCollisions = true;

destroyedState = new cState();

healthState = new cState();
healthState.Run = function() {
    if ( stats.hp <= 0 ) {
        ChangeState( destroyedState, OnBreak );
    }
}

ChangeState( healthState );

OnBreak = function() {
    // Bottle will either split in half or fully break.
    if ( irandom( 2 ) == 1 ) {
        repeat( random_range( 18, 24 ) ) {
            inst = instance_create_depth( x, y, -30, obj_debris );
            inst.x = x;
            inst.y = y;
            inst.image_angle = random_range( -360, 360 );
            inst.debrisSprite = spr_debris_bottleshards;
            inst.direction = random_range( -360, 360 );
            inst.debrisIndex = ~~random_range( 0, sprite_get_number( inst.debrisSprite ) );
            inst.SetSpd( random_range( 1, 3 ) );
            inst.SetFrc( random_range( 0.20, 0.35 ) );
            inst.SetHeight( 1 );
            inst.SetWeight( 0.20 ); 
            inst.zsp = -random( 3 );
        }
    }
    else {
        repeat( random_range( 18, 24 ) ) {
            inst = instance_create_depth( x, y, -30, obj_debris );
            inst.x = x;
            inst.y = y;
            inst.image_angle = random_range( -360, 360 );
            inst.debrisSprite = spr_debris_bottleshards;
            inst.direction = random_range( -360, 360 );
            inst.debrisIndex = ~~random_range( 0, sprite_get_number( inst.debrisSprite ) );
            inst.SetSpd( random_range( 1, 3 ) );
            inst.SetFrc( random_range( 0.20, 0.35 ) );
            inst.SetHeight( 1 );
            inst.SetWeight( 0.20 ); 
            inst.bDoBounce = true;
            inst.zsp = -random( 3 );
        }
        
        // Bottle halves
        inst = instance_create_depth( x, y, -30, obj_debris );
        inst.x = x;
        inst.y = y;
        inst.image_angle = random_range( -360, 360 );
        inst.debrisSprite = spr_debris_bottletop;
        inst.direction = random_range( -360, 360 );
        inst.debrisIndex = ~~random_range( 0, sprite_get_number( inst.debrisSprite ) );
        inst.SetSpd( random_range( 1, 3 ) );
        inst.SetFrc( random_range( 0.20, 0.35 ) );
        inst.SetHeight( 1 );
        inst.SetWeight( 0.20 );
        inst.zsp = -random( 3 ); 
        
        inst = instance_create_depth( x, y, -30, obj_debris );
        inst.x = x;
        inst.y = y;
        inst.image_angle = random_range( -360, 360 );
        inst.debrisSprite = spr_debris_bottlebottom;
        inst.direction = random_range( -360, 360 );
        inst.debrisIndex = ~~random_range( 0, sprite_get_number( inst.debrisSprite ) );
        inst.SetSpd( random_range( 1, 3 ) );
        inst.SetFrc( random_range( 0.20, 0.35 ) );
        inst.SetHeight( 1 );
        inst.SetWeight( 0.20 );
        inst.zsp = -random( 3 );
    }
    
    playsound_at( snd_break_glass );
    call_later( 1, time_source_units_frames, function() {
        instance_destroy();
    } );
}

on_object_hit = function() {
    OnBreak();
}

on_proj_hit = function() {
    repeat( random_range( 12, 18 ) ) {
        inst = instance_create_depth( x, y, -30, obj_debris );
        inst.x = proj_hit_id.x;
        inst.y = proj_hit_id.y;
        inst.image_angle = random_range( -360, 360 );
        inst.debrisSprite = spr_debris_bottleshards;
        inst.direction = proj_hit_id.direction - 180 + random_range( -25, 25 );
        inst.debrisIndex = ~~random_range( 0, sprite_get_number( inst.debrisSprite ) );
        inst.SetSpd( random_range( 1, 3 ) );
        inst.SetFrc( random_range( 0.20, 0.35 ) );
        inst.SetHeight( 1 );
        inst.SetWeight( 0.20 ); 
        inst.bDoBounce = true; 
        inst.zsp = -random( 3 );
    }
    
    stats.hp = 0;
}
event_inherited();

setPropHeight( 25 );
Solid_AddFlag( BLOCK_PROJECTILE );
Solid_RemoveFlag( BLOCK_MOVEMENT | BLOCK_VISION );

stats.hp = 125;

shadow_depth = 1;
ileafAmnt = random_range( 3, 5 );
ileafIndex = ~~random_range( 0, sprite_get_number( spr_potplant ) );
fleafRotation = random_range( -360, 360 ) * random( 180 );
ignore3DCollisions = true;

destroyedState = new cState();

healthState = new cState();
healthState.Run = function() {
    if ( stats.hp >= 100 ) {
        image_index = 0;
    }
    else if ( stats.hp >= 75 ) {
        image_index = 1;
    }    
    else if ( stats.hp >= 50 ) {
        image_index = 2;
    }
    
    if ( stats.hp <= 0 ) {
        call_later( 1, time_source_units_frames, function() {
            OnBreak();
            playsound_at( snd_break_wood );
            instance_destroy();
        } );
    }
}

ChangeState( healthState );

OnBreak = function() {
    repeat( random_range( 4, 6 ) ) {
        inst = instance_create_depth( x, y, -25, obj_debris );
        inst.x = x;
        inst.y = y;
        inst.image_angle = random_range( -360, 360 );
        inst.debrisSprite = spr_debris_potshards_big;
        inst.direction = random_range( -360, 360 );
        inst.debrisIndex = ~~random_range( 0, sprite_get_number( inst.debrisSprite ) );
        inst.SetSpd( random_range( 1, 2 ) );
        inst.SetFrc( random_range( 0.20, 0.35 ) );
        inst.SetHeight( 1 );
        inst.SetWeight( 0.30 ); 
        inst.zsp = -random( 3 );
    }
}

on_proj_hit = function() {
    repeat( random_range( 2, 4 ) ) {
        inst = instance_create_depth( x, y, -25, obj_debris );
        inst.x = proj_hit_id.x;
        inst.y = proj_hit_id.y;
        inst.image_angle = random_range( -360, 360 );
        inst.debrisSprite = spr_debris_potshards_small;
        inst.direction = proj_hit_id.direction - 180 + random_range( -25, 25 );
        inst.debrisIndex = ~~random_range( 0, sprite_get_number( inst.debrisSprite ) );
        inst.SetSpd( random_range( 1, 5 ) );
        inst.SetFrc( random_range( 0.20, 0.35 ) );
        inst.SetHeight( 1 );
        inst.SetWeight( 0.20 ); 
        inst.zsp = -random( 3 );
    }
    
    stats.hp -= 25;
    
    return true;
}
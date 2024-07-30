event_inherited();

setPropHeight( 50 );
Solid_AddFlag( BLOCK_PROJECTILE );
Solid_RemoveFlag( BLOCK_VISION );

stats.hp = 75;

shadow_depth = 1;
ignore3DCollisions = false;

destroyedState = new cState();

healthState = new cState();
healthState.Run = function() {
    if ( stats.hp <= 0 ) {
        ChangeState( destroyedState, OnBreak );
    }
}

ChangeState( healthState );

OnBreak = function() {
    playsound_at( snd_break_wood );
    call_later( 1, time_source_units_frames, function() {
        instance_destroy();
    } );
}

on_proj_hit = function() {
    repeat( random_range( 16, 24 ) ) {
        inst = instance_create_depth( x, y, -30, obj_debris );
        inst.x = proj_hit_id.x;
        inst.y = proj_hit_id.y;
        inst.image_angle = random_range( -360, 360 );
        inst.debrisSprite = spr_debris_wood_splinter;
        inst.direction = proj_hit_id.direction - 180 + random_range( -25, 25 );
        inst.debrisIndex = ~~random_range( 0, sprite_get_number( inst.debrisSprite ) );
        inst.SetSpd( random_range( 1, 3 ) );
        inst.SetFrc( random_range( 0.20, 0.35 ) );
        inst.SetHeight( 1 );
        inst.SetWeight( 0.25 ); 
        inst.bDoBounce = true; 
        inst.zsp = -random( 3 );
    }
    
    stats.hp = 0;
    return true;
}
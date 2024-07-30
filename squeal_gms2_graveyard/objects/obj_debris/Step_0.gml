if ( bAnimated ) {
	debrisIndex += ( debrisSpd / 2 ) * delta;
}

debrisSpd -= debrisFrc * delta;
debrisSpd = clamp( debrisSpd, 0, 256 );

x += dcos( direction ) * debrisSpd * delta;
y -= dsin( direction ) * debrisSpd * delta;

if ( bDoBounce ) {
	debrisDir += spin;
} 
else if ( !bFollowDir ) {
	debrisDir += spin * ( debrisSpd * 4 );
}
else {
	debrisDir = direction;	
}

spin *= 0.95;

// bounce collision
zSpd += weight * delta;
z += zSpd * delta;
if ( z >= ground_z ) {
	debrisFrc = groundFrc;
	
	z = ground_z;
	if ( abs( zSpd ) >= weight ) 
	&& ( debrisSpd > weight ) {
		if ( bDoBounce ) {
			zSpd = -abs( zSpd * bounce );
			spin = zSpd * 8 * sign( angle_rot );
		}
		
		debrisSpd *= bounceFrc;
		direction += bounceDir;
		OnBounce();
		
		if ( !sound_single 
		|| !sound_played ) {
			sound_played = true;
			if ( bounceSnd ) { 
				playsound_at( bounceSnd, x, y, 16, 16 * 12 ) ;
			};
		}
	}
	else {
		call_later( 1, time_source_units_frames, OnLand );
		zSpd = 0;
		
		if ( debrisSpd <= 0 ) {
			surface_set_target( obj_surface_manager.GetSurf() );
			draw_sprite_ext
			(
				debrisSprite, 
				debrisIndex, 
				visPosX * obj_surface_manager.scale, 
				visPosY * obj_surface_manager.scale, 
				image_xscale * obj_surface_manager.scale, 
				image_yscale * obj_surface_manager.scale, 
				debrisDir, 
				image_blend, 
				image_alpha
			);
			surface_reset_target();
			instance_destroy();
		}
	}
}
else {
	debrisFrc = airFrc;
	depth = z - height;
	
	zscale = min( zscale + ( zScaleRamp ), zScaleAmnt );
    shadowX = x - ( z * zscale * 0.125 );
    shadowY = y - ( z * zscale * 0.25 );
    visPosX = x;
    visPosY = y + ( z * zscale );
}
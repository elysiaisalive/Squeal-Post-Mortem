/// @desc Function for controlling character movement
function charTickMovement( _moveEnabled = true ) {
	if ( _moveEnabled ) {
		myspeed = charWalkSpd;
		myacc = charWalkAcc;
		mydec = charWalkDec;
		myfrc = movement_frc;
		// New Controls
		var xmove = 0;
		var ymove = 0;
		var throttle_dir;
		var throttle_dis;
		
		throttle_dir = self.movementDirection;
		throttle_dis = self.charVelocity;
		
		var dest_xsp = dcos( throttle_dir ) * ( myspeed * throttle_dis );
		var dest_ysp = -dsin( throttle_dir ) * ( myspeed * throttle_dis );
		var dest_dir = point_direction(0, 0, dest_xsp, dest_ysp);
		
		var speed_dir = point_direction(0, 0, currentXSpd, currentYSpd);
		var speed_dis = point_distance(0, 0, currentXSpd, currentYSpd);
		
		myacc = lerp( charWalkAcc, charWalkAccAlt, min( 1, max( minWalkSpeed, speed_dis - ( charWalkSpd / 2 ) ) / ( charWalkSpd / 2 ) ) );
		mydec = lerp( charWalkDec, charWalkDecAlt, min( 1, max( minWalkSpeed, speed_dis - ( charWalkSpd / 2 ) ) / ( charWalkSpd / 2 ) ) );
		
		if ( throttle_dis == 0 )
		{
			mydec = myfrc;
		};
		
		myinc = 0;
		var inc_dir = point_direction( currentXSpd, currentYSpd, dest_xsp, dest_ysp );
		
		if ( ( currentXSpd == dest_xsp ) 
		&& ( currentYSpd == dest_ysp ) ) {
			inc_dir = throttle_dir;
		}
		
		var amount = 1 - ( abs( angle_difference( inc_dir, speed_dir ) ) / 180);
		
		myinc = lerp( mydec, myacc, clamp( amount, 0, 1 ) ) * delta;
		
		var inc_dis = min( point_distance( currentXSpd, currentYSpd, dest_xsp, dest_ysp ), myinc );
		
		if ( inc_dis < myinc ) 
		{
			currentXSpd = dest_xsp;
			currentYSpd = dest_ysp;
		}
		else 
		{
			currentXSpd += dcos( inc_dir ) * myinc;
			currentYSpd -= dsin( inc_dir ) * myinc;
		}
		
		collision_enable();
		
		//Leg index.
		if ( abs( currentXSpd ) == 0 
		&& abs( currentYSpd ) == 0 ) {
			isMoving = false;
			charLegAnimIndex = 0;
			charLegDir = charLookDir;
		}
		else {
			// Checks so that we don't animate on anything other than walk animations
			var legspd = min( max( 1, speed_dis ), 3 ) * 0.25;
			var _walk_check = string_pos( string_lower( "walk" ), sprite_get_name( currentAnimation.anim ) );
			
			charLegAnimIndex += legspd * currentMoveSpeedModifier * delta;
			charLegDir = point_direction( 0, 0, currentXSpd, currentYSpd );
			
			isMoving = true;
			
			if ( ( currentXSpd != 0 || currentYSpd != 0 )
			&& _walk_check ) {
				animIndex += ( ( abs( currentXSpd ) + abs( currentYSpd ) ) * 0.065 ) * delta;
			};
		};
		
		image_angle = 0;
		image_xscale = 1;
		image_yscale = 1;
		
		var cornerspeed = max( abs( currentXSpd ), abs( currentYSpd ) ); //, myspeed * 0.5)
		var cornerstep_x = sprite_get_width( mask_index ) / 2;
		var cornerstep_y = sprite_get_height( mask_index ) / 2;
		
		if ( currentXSpd != 0 ) 
		{
			if ( place_free( transform.position.x + currentXSpd, transform.position.y ) )
			{
				transform.position.x += currentXSpd * currentMoveSpeedModifier * delta;
			};
		}
		else if ( currentYSpd == 0 ) 
		{
			var cornerstepped = false;
			var cornerstep = cornerstep_y;
			while ( cornerstep > 0 ) 
			{
				if ( place_free( transform.position.x, transform.position.y - cornerstep ) && place_free( transform.position.x + currentXSpd, transform.position.y - cornerstep ) ) 
				{
					cornerstepped = true;
					transform.position.y -= min(cornerspeed, cornerstep_y) * delta;
					break;
				}
				else if (place_free(transform.position.x, transform.position.y + cornerstep) and place_free(transform.position.x + currentXSpd, transform.position.y + cornerstep)) 
				{
					cornerstepped = true;
					transform.position.y += min(cornerspeed, cornerstep_y) * delta;
					break;
				}
				cornerstep --;
			}
			if !(cornerstepped) 
			{
				move_contact_solid(90 - sign(currentXSpd) * 90, abs(currentXSpd)) ;
				currentXSpd *= (abs(currentXSpd) > myspeed * movement_rebound) ? -movement_rebound : 0;
			}
		}
		if (currentYSpd != 0) {
			if place_free(transform.position.x, transform.position.y + currentYSpd)
				transform.position.y += currentYSpd * currentMoveSpeedModifier * delta
			else {
				var cornerstepped = false
				if (currentXSpd = 0) {
					
				}
				if !(cornerstepped) {
					move_contact_solid(-sign(currentYSpd) * 90, abs(currentYSpd)) 
					currentYSpd *= (abs(currentYSpd) > myspeed * movement_rebound) ? -movement_rebound : 0
				}
			}
		}
		image_xscale = 1;
		image_yscale = 1;
		
		transform.position.x = clamp( transform.position.x, 0, room_width );
		y = clamp( y, 0, room_height );
		
		collision_disable();
	}
}

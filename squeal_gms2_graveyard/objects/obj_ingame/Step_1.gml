// if ( instance_exists( global.input_target ) ) {
// 	with( global.input_target.id ) {
// 		if ( entFlags.HasFlag( ENT_FLAGS.ACTIVE ) ) {
// 			var inputTarget_throttledir = self.movementDirection;
// 			var inputTarget_throttledis = self.charVelocity;
			
// 			audio_falloff_set_model( audio_falloff_linear_distance );
			
// 			// Mouse movement ingame.
// 			// global.look_factor is the multiplier for the visual distance of the cursor sprite from the real mouse pos.
// 			global.mousex_real = x + ( global.mousex_raw * global.look_factor );
// 			global.mousey_real = y + ( global.mousey_raw * global.look_factor );
		
// 			global.mousex = global.mousex_real;
// 			global.mousey = global.mousey_real;
			
// 			// Set the character direction to the mouse position
// 			if ( canMoveMouse ) {
// 				lookdir_raw = point_direction( 0, 0, global.mousex_raw, global.mousey_raw );
// 				charLookDir = point_direction( x, y, global.mousex, global.mousey );
// 			};
// 			//
			
// 			input_primary = input_check( "key_primary" );
// 			input_secondary = input_check( "key_secondary" );
// 			input_moveleft	= input_check( "key_left" );
// 			input_moveright	= input_check( "key_right" );
// 			input_moveup	= input_check( "key_up" );
// 			input_movedown	= input_check( "key_down" );
// 			input_strafe = input_check( "key_strafe" );
			
// 			/* 
// 				TODO: Link trigger delays to the inputs here as AI will register inputs every single frame and fire semi guns every frame.
// 			*/
// 			switch( currentWeapon.fireMode ) {
// 				case FIREMODE.SEMI :
// 					if ( input_check_pressed( "key_primary" ) ) {
// 						charAttackWeapon( true );
// 					}
// 					break;
// 				case FIREMODE.AUTO :
// 					if ( input_check( "key_primary" ) ) {
// 						charAttackWeapon( true );
// 					}
// 					break;
// 			}
// 			//
			
// 			// if ( input_check_pressed( "key_secondary" ) ) {
// 			// 	charPickupWeapon();
// 			// }
// 			// else if ( input_check_pressed( "key_secondary" )
// 			// && currentWeapon.itemName != "Unarmed" ) {
// 			// 	charThrowWeapon( , charLookDir );
// 			// }
			
// 			movementDirection = 0;
// 			charVelocity = 0;
			
// 			// Register input and do movement.
// 			// global.input is usually only disabled when performing the charMoveFor() function.
// 			if ( global.input_enabled ) {
// 				var _throttle = point_distance( 0, 0, input_moveright - input_moveleft, input_movedown - input_moveup ) * 1.125;
					
// 				movementDirection = point_direction( 0, 0, input_moveright - input_moveleft, input_movedown - input_moveup );
// 				charVelocity = min( 1, _throttle );
				
// 				if ( inputTarget_throttledis == 0 ) {
// 					xmove = ( input_moveright - input_moveleft );
// 					ymove = ( input_movedown - input_moveup );
// 					inputTarget_throttledir = point_direction( 0, 0, xmove, ymove );
// 					currentWalkDir = point_direction( 0, 0, xmove, ymove );
// 					inputTarget_throttledis = min( 1, point_distance( 0, 0, xmove, ymove ) );
// 				};
// 			}
			
// 			if ( self.input_strafe 
// 			|| global.firstperson )
// 			{
// 				inputTarget_throttledir += lookdir_raw - 90;
// 			};
// 		};
// 	};
// };
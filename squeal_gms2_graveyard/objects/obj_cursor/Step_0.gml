#region Lock On Logic
var entity = instance_nearest( global.mousex, global.mousey, obj_character );

lock_sin += 0.1;

if ( instance_exists( global.input_target ) ) {
	if ( !mouse_locked 
	&& input_check_pressed( "key_lockon" ) ) {
		if ( obj_player.can_lockon 
		&& entity.CanGetLocked 
		&& mouse_target == noone 
		&& instance_exists( entity ) ) {
			// If within lock-on range, lock on to the entity closest to mouse pos.
			if ( point_in_circle( entity.x, entity.y, global.mousex, global.mousey, lockon_range ) 
			&& entity.char_state == CSTATE.ALIVE ) {
				playsound( snd_ui_computer_select );
			
				mouse_target = entity;
				mouse_locked = true;
			}
		}
	}
	else
	// If Mouse is locked, unlock it
	if ( ( mouse_locked 
	&& input_check_pressed( "key_lockon" ) ) 
	|| !instance_exists( entity ) ) {
		playsound( snd_ui_computer_select );
	
		mouse_target = noone;
		mouse_locked = false;
	}

	// If we have a target, set the mouse pos to this target
	if ( instance_exists( mouse_target ) 
	&& ( mouse_target != noone ) 
	&& mouse_locked  ) {	
		global.mousex = mouse_target.x;
		global.mousey = mouse_target.y;
		
		var mouse_targetdir = point_direction( obj_player.x, obj_player.y, global.mousex, global.mousey );
		
		obj_player.charLookDir = mouse_targetdir;
	}

	if ( instance_exists( mouse_target ) ) {
		if ( mouse_target.char_state != CSTATE.ALIVE 
		|| obj_player.char_state != CSTATE.ALIVE ) {
			lock_sin = 1;
			mouse_target = noone;
			mouse_locked = false;
		}
	}
	else {
		lock_sin = 1;
		mouse_target = noone;
		mouse_locked = false;
	}
	#endregion
}
cursor_speed += cursor_animationspeed;
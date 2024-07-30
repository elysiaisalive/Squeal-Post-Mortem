// OLD.
function charAbilityDive() {
	var xmove = 0;
	var ymove = 0;
	var throttle_dir;
	var throttle_dis;
	
	xmove = (input_moveright - input_moveleft)
	ymove = (input_movedown - input_moveup)
	
	throttle_dir = self.movementDirection;
	throttle_dis = self.charVelocity;
	
	throttle_dir = point_direction( 0, 0, xmove, ymove );
	
	if ( ( ( currentXSpd > 0 ) || ( currentYSpd > 0 ) ) 
	|| ( ( currentXSpd < 0 ) || ( currentYSpd < 0 ) ) ) {
		if ( !bIsDiving && keyboard_check_pressed( global.inputs.key_ability1 ) || mouse_check_button_pressed( global.inputs.key_ability1 ) ) {
			sprite_index = charGetSpriteFromIndex( self, "DiveUnarmed" );
			bIsDiving = true;
			animIndex = 0;
			charLookDir = throttle_dir;
			AnimSpd = 0.95 * movement_dec * movement_acc;
			can_attack = false;
			canMoveMouse = false;
			input_enabled = true;
			can_collide_proj = false;
		}
		
		if ( sprite_index = charGetSpriteFromIndex( self, "DiveUnarmed" ) 
		&& ( animIndex <= 0 ) ) {
			movement_impulse = 5 * movement_dec * movement_acc;
			movement_impulsedir = throttle_dir;
		}
	}
	else
	if ( ( currentXSpd <= 0 ) || ( currentYSpd <= 0 ) )
	{
		if ( !bIsDiving 
		&& keyboard_check_pressed( global.inputs.key_ability1 ) 
		|| mouse_check_button_pressed( global.inputs.key_ability1 ) )
		{
			sprite_index = charGetSpriteFromIndex( self, "DiveUnarmed" );
			bIsDiving = true;
			animIndex = 0;
			charLookDir = throttle_dir;
			AnimSpd = 0.95 * movement_dec * movement_acc;
			can_attack = false;
			canMoveMouse = false;
			input_enabled = true;
		}
		
		if ( sprite_index = charGetSpriteFromIndex( self, "DiveUnarmed" ) && ( animIndex <= 0 ) )
		{
			movement_impulse = 5 * movement_dec * movement_acc;
			movement_impulsedir = charLookDir;
		}
	}	
		
	if ( floor( animIndex ) <= image_number - 1 )
	{
		sprite_index = charGetSpriteFromIndex( self, currentWeapon.walk_sprite );
		animIndex = 0;
		AnimSpd = 0;
		can_attack = true;
		canMoveMouse = true;
		bIsDiving = false;
		input_enabled = false;
		can_collide_proj = true;
	}	
		
	var checkx = floor(	( x + ( currentXSpd * delta ) +  lengthdir_x( 8, charLookDir ) ) * 16 ) / 16;
	var checky = floor(	( y + ( currentYSpd * delta ) +  lengthdir_y( 8, charLookDir ) ) * 16 ) / 16;
		
	collision_enable();
	
	if ( bIsDiving && !place_free ( checkx, checky ) )
	{
		sprite_index = charGetSpriteFromIndex( self, currentWeapon.walk_sprite );
		animIndex = 0;
		AnimSpd = 0;
		can_attack = true;
		canMoveMouse = true;
		bIsDiving = false;
		input_enabled = false;
		can_collide_proj = true;
		
		playsound_at( snd_hit_item, x, y );
	}
	
	collision_disable();
}
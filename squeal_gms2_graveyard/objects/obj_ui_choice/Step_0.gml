#region Input Detection
INPUT_UP				= clamp( keyboard_check_pressed( ord("W") ) + keyboard_check_pressed( vk_up ) + mouse_wheel_up(), 0, 1 );
INPUT_DOWN				= clamp( keyboard_check_pressed( ord("S") ) + keyboard_check_pressed( vk_down ) + mouse_wheel_down(), 0, 1 );
INPUT_LEFT				= clamp( keyboard_check_pressed( ord("A") ) + keyboard_check_pressed( vk_left ) + mouse_wheel_up(), 0, 1 );
INPUT_RIGHT				= clamp( keyboard_check_pressed( ord("D") ) + keyboard_check_pressed( vk_right ) + mouse_wheel_down(), 0, 1 );
INPUT_LEFTCLICK			= clamp( keyboard_check_pressed( vk_enter ) + mouse_check_button_pressed( mb_left ), 0, 1 );
INPUT_HOLDLEFTCLICK		= clamp( keyboard_check( vk_enter ) + mouse_check_button( mb_left ), 0, 1 );
INPUT_RIGHTCLICK		= clamp( keyboard_check_pressed( vk_escape ) + mouse_check_button_pressed( mb_right ), 0, 1 );
INPUT_SPACE				= clamp( keyboard_check_pressed( vk_space ), 0, 1 );
INPUT_ANY				= clamp( keyboard_check_pressed( vk_anykey ), 0, 1 );

if ( page_done )
{
	if ( INPUT_LEFT && !pressed  )
	{
		selected --;
	}

	if ( INPUT_RIGHT && !pressed )
	{
		selected ++;
	}
}

#endregion

if ( !surface_exists( draw_surf ) )
{
	draw_surf = surface_create( surf_x, surf_y );
}

if ( INPUT_HOLDLEFTCLICK )
{
	var mousex = mouse_x * 1;
	var mousey = mouse_y * 1;
	
	repeat( random_range( 1, 2 ) )
	{
		var inst = instance_create_depth( mousex - 155, mousey - 16, 256, obj_ui_signaturebrush );
		inst.image_index = floor( random( image_index ) );
		inst.image_angle = random_range( -180, 180 );
	}
}

//if ( INPUT_ANY )
//{
//	input_string = input_key_to_name( INPUT_ANY );
//	display_string = string_insert( input_string, display_string, string_length( display_string ) + 1 );
//}

selected = clamp( selected, -1, 1 );

if ( selected == -1 )
{
	glasses_scale = lerp( glasses_scale, 1.5, 0.08 );
}
else
{
	glasses_scale = lerp( glasses_scale, 1, 0.08 );
}

if ( selected == 1 )
{
	badge_scale = lerp( badge_scale, 1.5, 0.08 );
}
else
{
	badge_scale = lerp( badge_scale, 1, 0.08 );
}

rot += rot_speed;

print_time = max( 0, print_time - 1 );

if ( print_time == 0 )
{
	page_yoffset = lerp( page_yoffset, target_y, 0.03 );
}

//if ( floor( page_yoffset ) == target_y )
//{
//	page_done = true;
//}

if ( page_done )
{
	//if ( floor( anim_spd ) != 8 )
	//{
	//	anim_spd += 0.1;
	//}
	
	badge_xoffset = lerp( badge_xoffset, badgetarget_x, 0.02 );
	glasses_xoffset = lerp( glasses_xoffset, glassestarget_x, 0.02 );
}

target_y = clamp( target_y, 0, target_maxy );
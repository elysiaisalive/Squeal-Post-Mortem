function hud_joe() : hud_controller() constructor
{
	// if ( live_call() ) return live_result;
	
	static Primary		= #fbff9f;
	static Secondary	= #ff00c6;
	static Tertiary		= #27008a;
	
	static Init = function()
	{
		ammo = new hud_item( "Ammo" );
		ammo.SetLerpX( -2, -50 );
		ammo.SetLerpY( 240 );
		ammo.SetLerpSpeed( 6 / 60 );
		ammo.SetSinAmount( 0.050 );
		ammo.SetValue( 0 );
		ammo.Draw = function()
		{
			for( var i = 1; i < 4; ++i )
			{
				var elem_xoffset	= 1.50;
				var elem_yoffset	= 8;
				var elem_rotoffset	= 65;
				
				draw_sprite_ext( 
					spr_hud_joe_ammo, 
					ammo.elem_imageindex, 
					ammo.elem_x + ( elem_xoffset * i ), 
					240 + ( elem_yoffset * i ), 
					1, 
					1, 
					elem_rotoffset + ( sin( ammo.elem_siner ) * ( 0.75 * i ) ), 
					c_white,
					ammo.elem_alpha 
				);
			};
		
			draw_set_font( fnt_terminal );
			draw_set_color( Primary );
			draw_text( ammo.elem_x + 34, 242, ammo.elem_value );
		};
		
		jhud_hp = new hud_item( "Health" );
		jhud_hp.SetLerpX( 428 );
		jhud_hp.SetLerpY( 171 );
		jhud_hp.SetLerpSpeed( 8 / 60 );
		jhud_hp.Draw = function(){};
		
		AddElement( ammo );
		AddElement( jhud_hp );
	};
	
	static Tick = function()
	{
		ammo.elem_siner += ammo.elem_sinamount;
	};
	
	// var _index = 0;
	// var _player = obj_player.currentWeapon;
	// var scale = 1;
	// var offset_x = 1.50;
	// var offset_y = 8;
	// var offset_rot = 65;
	
	// switch( _player.attack_type )
	// {
	// 	default :
	// 		switch( _player.itemName )
	// 		{
	// 			default :
	// 				scale = 1;
	// 				break;
	// 			case "NailBat" :
	// 				_index = 9;
	// 				scale = 1.20;
	// 				draw_sprite_ext( spr_hud_joe_ammo, _index, -2 + ( offset_x ), 244 + ( offset_y ), scale, scale, offset_rot + ( sin( liquid_sin ) * 0.5 ), c_white, 1 );
	// 				break;
	// 			case "Shield" :
	// 				_index = 11;
	// 				scale = 1.20;
	// 				draw_sprite_ext( spr_hud_joe_ammo, _index, 0 + ( offset_x ), 244 + ( offset_y ), scale, scale, offset_rot + ( sin( liquid_sin ) * 0.5 ), c_white, 1 );
	// 				break;
	// 		};
	// 		break;
	// 	case ATTACKTYPE.GUN :
	// 		for( var i = 1; i < 4; ++i )
	// 		{
	// 			offset_x = 1.50;
	// 			offset_y = 8;
	// 			offset_rot = 65;
				
	// 			#region Bullet Index
	// 			switch( _player.itemName )
	// 			{
	// 				default :
	// 					_index = 0;
	// 					break;
	// 				case "Pistol" :
	// 					_index = 1;
	// 					break;								
	// 				case "Shotgun" :
	// 					_index = 2;
	// 					break;					
	// 				case "AK" :
	// 					_index = 4;
	// 					break;					
	// 				case "SW500" :
	// 					_index = 5;
	// 					break;					
	// 				case "SawedOff" :
	// 					_index = 2;
	// 					break;					
	// 				case "40MM" :
	// 					_index = 7;
	// 					break;					
	// 				case "Mac10" :
	// 					_index = 1;
	// 					break;
	// 			};
	// 			#endregion
				
	// 			var _C = merge_color( c1, c2, abs( sin( liquid_sin ) ) );
				
	// 			draw_text_color( 42 + 0.5 + abs( sin( liquid_sin ) ), 244 + 0.5 + abs( sin( liquid_sin ) ), string( obj_player.currentWeapon.ammo ), _C, _C, _C, _C, 1 );
	// 			draw_text( 42, 244, string( obj_player.currentWeapon.ammo ) );
	// 			draw_sprite_ext( spr_hud_joe_ammo, _index, -2 + ( offset_x * i ), 240 + ( offset_y * i ), 1, 1, offset_rot + ( sin( liquid_sin ) * ( 0.5 * i ) ), c_white, 1 );
	// 		};
	// 		break;
	// };
};
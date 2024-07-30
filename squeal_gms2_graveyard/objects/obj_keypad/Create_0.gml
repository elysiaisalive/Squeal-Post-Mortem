key_xoffset			= 16;
key_yoffset			= 0;

key_rows			= 4;
key_column			= 3;

key_width			= 16;
key_height			= 16;

keypad_timeout		= 60 * 2;
keypad_timeoutmax	= 60 * 2;

keypad_enddelay		= 60;
keypad_maxenddelay	= 60;


keypress_clear		= false;
keypress_submit		= false;

password			= "8008";

saved_string		= "";

inst				= noone;
hitbox = 0;
key_id				= [];

CanType				= true;

password_accepted	= false;

image_speed			= 0;

var n = 0;

for( var j = 0; j < key_rows; ++j )
{
	for( var i = 0; i < key_column; ++i )
	{
		var _x = key_xoffset + ( i * key_width );
		var _y = key_yoffset + ( j * key_height );
		
		inst = instance_create_depth( x + _x, y + _y, -500, obj_keypad_key );
		
		inst.key_number = n;
		array_push( key_id, n );
		n ++;
		
		show_debug_message(" Created New Row " + " : " + string( j ) );
		show_debug_message(" Key ID " + " : " + string( key_id ) );
	}
}
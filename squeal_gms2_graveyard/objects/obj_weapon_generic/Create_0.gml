event_inherited();

z = depth;
height = 3;
depth = ( z - height );

eventhandler_subscribe( self.id, "ev_player_enter_room", function() { 
	validateWeapon(); 
} );

gun_spd			= 0;
laser_dist		= 110;
gun_fric		= 0;
scale			= 1;
siner			= 0;
siner2			= 0;
amount			= 1;
outline_alpha	= 0;
image_speed		= 0;
mask_index		= spr_mask_weapon;

gun_angle		= 0;

currentFaction = FACTION.PLAYER;
gun = new cGunPistol();
shooting_timer = new cTimer( 30, false, true );
currentTriggerReset = 0.10;

pickup_priority = 0;

altfire = noone;

// TRUE FOR NOW, SET TO FALSE LATER
weapon_valid = true;

SaveState = function( buf = global.checkpoint )
{
	//var encoded_struct = json_stringify( gun );
	//print( "Saved :" + encoded_struct );
	//buffer_write( buf, buffer_text, encoded_struct );
	//gun.SaveState( buf );
};
LoadState = function( buf = global.checkpoint )
{
	//var decoded_struct = json_parse( buffer_read( buf, buffer_text ) );
	//gun = decoded_struct;
	//gun.LoadState( buf );
	
	validateWeapon();
};
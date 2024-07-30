event_inherited();

height = 8;
Solid_ClearFlags();

user = noone;

item = new cInteractablePickup( "Generic" );
item.SetInteractSound( snd_item_interact );
item.OnInteract = function( target ) {
	if ( user != noone ) {
		with( user ) {
	    	charThrowWeapon( 0.50, obj_player.charLookDir );
		}
		
		playsound_at( item.GetInteractSound(), x, y );
	    item.OnTrigger();
	}
};

item.OnTrigger = function() {
    instance_destroy();
};
event_inherited();

height = 8;
Solid_ClearFlags();

item = new base_pickup_inventory( "Evidence01" );
item.SetSpriteFromIndex( -1 );
item.SetIndex( 0 );
item.SetInteractSound( snd_item_interact );
item.OnInteract = function()
{
    if ( obj_player.inventory.AddItem( item.GetName() ) )
    {
	    obj_player.SetSpriteFromIndex( "PickUpItem" );
	    obj_player.DoAnimation( 0, 0.20 );
	    obj_player.DropWeapon( 0.50, obj_player.charLookDir );	
		playsound_at( item.GetInteractSound(), x, y );
		
	    item.OnTrigger();
    };
};
item.OnTrigger = function()
{
    instance_destroy();
};
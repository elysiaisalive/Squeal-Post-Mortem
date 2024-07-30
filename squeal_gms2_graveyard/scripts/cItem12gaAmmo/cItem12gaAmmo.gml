/// @self {cItem|object}
function cItem12gaAmmo() extends cItem() class {
    itemName = "12ga";
	displayName = "12 Gauge Ammo";
	displayName = LOC_STRING( "#Game.ItemName.12gaAmmo" );
	descString = LOC_STRING( "#Game.ItemDesc.12gaAmmo" );
    worldSprite = spr_pickup_12GA;
	isStackable = true;
    stackSize = 3;
    maxStackSize = 15;
}
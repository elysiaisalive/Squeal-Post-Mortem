/// @self {cItem|object}
function cItemPistolAmmo() extends cItem() class {
    itemName = "38";
	displayName = ".38 Ammo";
	displayName = LOC_STRING( "#Game.ItemName.38Ammo" );
	descString = LOC_STRING( "#Game.ItemDesc.38Ammo" );
    worldSprite = spr_pickup_357;
	isStackable = true;
    stackSize = 6;
    maxStackSize = 150;
};
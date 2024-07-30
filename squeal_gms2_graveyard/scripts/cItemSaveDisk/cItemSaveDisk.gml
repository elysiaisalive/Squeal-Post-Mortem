/// @self {cItem}
function cItemSaveDisk() : cItem() constructor {
    itemName = "savedisk";
	displayName = LOC_STRING( "#Game.ItemName.SaveDisk" );
	descString = LOC_STRING( "#Game.ItemDesc.SaveDisk" );
    worldSprite = spr_pickup_savedisk;
	isStackable = true;
    stackSize = 1;
    maxStackSize = 3;
};
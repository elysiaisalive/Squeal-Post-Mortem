/// @self {cItem|object}
function cItemKeycard() : cItem() constructor {
    self.itemName = "keycard";
	self.displayName = "Keycard";
    self.worldSprite = spr_pickup_keycards;
	self.isStackable = false;
    self.stackSize = 1;
};
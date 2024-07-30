function cUserInventory() extends cInventory() class {
    hotbar = new cHotbar();
    #region Special Slots
    /*
        ============
        WEAPON SLOTS
        ============
            holster <- Used to store a single ONE handed gun.
            sling <- Used to store a single TWO handed weapon.
            melee <- Used to store a single melee weapon.
    */
    holster = undefined;
    sling = undefined;
    melee = undefined;
    #endregion
    return self;
}
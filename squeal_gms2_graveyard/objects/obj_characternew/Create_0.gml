itemName = "";
flags = new cFlags();
hitPoints = new cHealthComponent();
equippedWeapon = new cWeaponUnarmed();
transform = new cTransform2D();
animation = new cAnimation();

#region Get
GetHealth = function() {
    return hitPoints;
}
GetEquippedWeapon = function() {
    return equippedWeapon;
}
GetAnimation = function() {
    return animation;
}
#endregion
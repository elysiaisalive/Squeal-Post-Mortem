/// @param		{string} 	name		Name of the character from an asset tag.
/// @param		{number} 	faction		Faction as an enum.
/// @param		{number} 	hp			Health Points.
/// @param		{number} 	armour		Armour Points.
function charInit( name = "Pig", faction = FACTION.NONE, hp = 100, armour = 0 ) {
	//print( string( "Initializing Character {0} with Faction {1}", name, faction ) );
	
	charName = name;
	currentFaction = faction;
	stats.hp = hp;
	stats.hp_max = hp;
	stats.armour = armour;
	stats.armour_max = armour;
	
	// Setting Default Sprites
	// currentAnimation = get_animation_from_index( charName, currentWeapon.animations[$ "walk"].animKey );
	// currentLegAnimation = get_animation_from_index( charName, "legs" );
};
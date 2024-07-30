event_inherited();

setPropHeight( HEIGHT.WAIST);
ignore3DCollisions = true;

hp				= 50;
hp_max			= 50;

flame_timer		= 4;
flame_maxtimer	= 4;

shadow_depth	= 1;

on_proj_hit = function() {
    hp -= 25;
    return true;
}
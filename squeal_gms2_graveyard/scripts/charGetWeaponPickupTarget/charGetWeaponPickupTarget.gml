// @param	{instance}		entity
/// @param	{number} 		pickup_range	Pickup range from either the character or supplied manually.
/// @return {instance}		target_weapon	Returns the target weapon instance ID
function charGetWeaponPickupTarget( entity = self.id, pickup_range = self.pickup_range ) {
	var _target_weapon = noone;
	var _target_priority = 0;
	var _max_priority = 1.5;
	var _ammo_priority_factor = 0.5;

    if ( instance_exists( obj_weapon_generic ) ) {
    	// Deactivate all instances at once and activate only the relevant region.
    	instance_deactivate_object( obj_weapon_generic );
    	instance_activate_region( entity.x - pickup_range, entity.y - pickup_range, pickup_range * 2, pickup_range * 2, true );
    
    	with ( obj_weapon_generic ) {
    		var _distance = point_distance( entity.x, entity.y, x, y );
    		if ( _distance <= pickup_range 
    		&& weapon_valid ) {
    			var priority = ( 1 - ( _distance / pickup_range ) ) * _max_priority;
    
    			if ( gun.firemode_type != FIREMODE.MELEE ) {
    				var _ammo_ratio = gun.ammo / gun.maxammo;
    				
    				priority += _ammo_ratio * _ammo_priority_factor;
    			}
    
    			pickup_priority = priority;
    
    			// Directly set target_weapon when priority is higher.
    			if ( ( !_target_weapon ) || ( priority > _target_priority ) ) {
    				_target_weapon = id;
    				_target_priority = priority;
    			}
    		}
    	}
    
    	// Reactivate all instances at once.
    	instance_activate_object( obj_weapon_generic );
    }

	return _target_weapon;
}
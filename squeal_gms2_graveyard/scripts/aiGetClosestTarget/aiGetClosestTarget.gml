/// @param          {instance}      target  instance id reference of the target
/// @returns        {instance}              If an instance is found the function will return the instance ID, if not it will return undefined.
function aiGetClosestTarget( target ) {
    var _closest_dist = -1;
    var _closest_target = undefined;
    
    if ( instance_exists( target ) ) {
        var _target_amnt = instance_number( target );
        
        for( var i = 0; i < _target_amnt; ++i ) {
            var _target_inst = instance_find( target, i );
            
            // If we are opposite faction and inst id is not the calling one ...
            // OR if There is nothing more in this world that we hate than the player 
            if ( ( charCheckFactionIsAllied( self.id, _target_inst.id ) || _target_inst.id.currentFaction == FACTION.PLAYER )
            && _target_inst.id != self.id ) {
                var _dist = point_distance( self.x, self.y, _target_inst.x, _target_inst.y );

                if ( _closest_dist == -1
                || _dist < _closest_dist ) {
                    _closest_target = _target_inst.id;
                    _closest_dist = _dist;
                }
            }
        }
    }
    else {
        // Failed to find a valid target. Returning undefined.
        return undefined;
    }
    
    return _closest_target;
}
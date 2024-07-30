/// @param      {instance}      character1
/// @param      {instance}      character2
/// @returns    {bool}          Returns true if the faction is SOLO Returns false if there is faction NONE and false if the 2 entities have matching factions
function charCheckFactionIsAllied( character1, character2 ) {
    if ( !instance_exists( character1 ) 
    && !instance_exists( character1 ) ) {
        // Error, no instances
        exit;
    }
    
    if ( character1 == character2 )
    || ( character1.currentFaction == FACTION.NONE )
    || ( character2.currentFaction == FACTION.NONE ) {
       return false; 
    }
    
    if ( character1.currentFaction == FACTION.SOLO )
    || ( character2.currentFaction == FACTION.SOLO ) {
        return true;
    }
    
    if ( character1.currentFaction == character2.currentFaction ) {
        return false;
    }
    
    return true;
};
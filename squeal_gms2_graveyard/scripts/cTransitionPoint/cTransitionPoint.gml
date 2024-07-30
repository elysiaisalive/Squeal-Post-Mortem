function cTransitionPoint() class {
    label = "transitionNode"; // The label that we will use for teleporting between rooms.
    targetRoom = undefined; // The room the game will switch to.
    targetEntity = noone; // The entity that touched the transition node that is going to be transported to the next room.
    
    teleportPosition = { x : 0, y : 0 };
    
    /* 
    INTERACT WITH TRIGGER OBJ. TRIGGER_TRANSITIONZONE <- Keeps track of CERTAIN. 
    Objects that were inside of it. On MAP CHANGE, it will BRING THESE OBEJCTS WITH THE PLAYER.
    */
    
    static SetTargetEntity = function( entity ) {
        targetEntity = entity;
    }
    static Teleport = function() {
        /* 
         There will probably eventually need to be logic here that deals with pausing when switching rooms/maps......
        */
        targetEntity.persistent = true;
        
        room_goto( targetRoom );
        
        targetEntity.x = teleportPosition.x;
        targetEntity.y = teleportPosition.y;
    }
}

function cTransitionManager() class {}
event_inherited();

ent_name    = "GenericAmbientController";
update = false;
nodes = [];
check = noone;
isParent = false;

AddAmbientZones = function() { 
    with( obj_ambientscape ) {
        array_push( nodes, self.id );
    }
}

/*

if amb==currentambscaape {
    
}



*/
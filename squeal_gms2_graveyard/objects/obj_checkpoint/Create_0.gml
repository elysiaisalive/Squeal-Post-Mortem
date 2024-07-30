active = true;
saveOnTouch = true;

ent_name = "GenericCheckpoint";

TriggerEvent = function() {
    gamestate_tempsave();
    active = false;
};
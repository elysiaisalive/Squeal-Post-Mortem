slowmo_active		= false;
joe_syringeposx		= 410;
joe_syringeposy		= 180;
joe_syringeposx2	= 416;
joe_syringeposy2	= 259;
joe_syringeinject	= false;
joe_juicebary		= 250;
joe_syringeindex	= 0;

liquid_sin = 0;
siner = 0;

current_hud = -1;
current_hud = new hud_joe();
current_hud.Init();

inventoryMenu = new cUIInventoryMenu();
// inventory.SetInventoryTarget( user().inventory );

screen = new ui_screen();
screen.Init();

alarm[0]	= 1;

#region Legacy HUD
// HUD Surf
div_factor = 2;
_w = room_width / div_factor;
_h = room_height / div_factor;

hud_surf = surface_create( _w, _h );

//Values for HUD
derby_health = 0;
derby_special = 0;
derby_scored = false;
derby_scoreanim = 0;
scoretimer = 20;

//Wave
waveamount = 0;

hud_joe_ammostartposx = -999;
hud_joe_bulletstartposx = -999;
hud_joe_slowmeterstartposy = 300;
hud_joe_combostartposx = 999;
hud_joe_combo_x_startposx = 999;
hud_joe_combo_glasses_startposx = 999;
#endregion
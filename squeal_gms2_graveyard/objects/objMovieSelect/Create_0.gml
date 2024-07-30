reel_rot = 0; // Reel Rotation
reel_xpos = 250;
pressed = 0; //Times pressed.
current_level = 0; //Level Info Display
currentlevel_selected = false; //Clicked Level
currentlevel_selected_info= 0; //Clicked Level Info
selected = 0; //Currently Hovered Level
dir = 0; //General var for rotations and movement
animate= 0; //Animation var
poster_move= 0; //Poster Movement
poster_target= 0;
poster_anim= 0;
poster_anim_target= 0;
poster_y= 300;
select_size= 0; //Bar Size
current_silouhuette= 0;
level_titlestring= 0;
level_descstring= 0;
moon_col= 0;
bg_col1 = 0; 
bg_col2 = 0;
level_song = 0;
change = false; 
pressed = 0;
//Level Info and Selection
enum level_names { 
    level_pigstay,
    level_stitches,
    level_h1n1,
    level_guts,
    level_abbatoir,
    level_spree,
    level_gutter,
	level_midnight
}
//Star Loop Init
i = 0
repeat (350) {
starx[i]=random(room_width*2)
stary[i]=random(room_height*2)
starbright[i] = random(1)
starsize[i] = random(2) * random(1)
i += 1
}
//Drawing Gradient BG
dir+=0.65
draw_rectangle_color(view_xview[0],view_yview[0]+40,view_xview[0]+view_wview[0],view_yview[0]+view_hview[0]-43,bg_col1,bg_col1,bg_col2,bg_col1,0)

//Drawing Stars
gpu_set_blendmode(bm_add)
	i=0 repeat (350) {
		draw_circle_color(starx[i],stary[i],starsize[i],merge_color(merge_color(c_aqua,c_blue,random(1)),c_white,random(starbright[i])),c_black,0)
	i+=1
}
gpu_set_blendmode(bm_normal)

//Drawing Moon
gpu_set_blendmode(bm_add) {
	draw_sprite_ext(sprMoon, 0, room_width / 2 + 250, room_height / 2 + 120, 2, 2, 0, moon_col, 1)
}
gpu_set_blendmode(bm_normal)

//Drawing Tiny Silhouettes
draw_sprite_ext(current_silouhuettetiny,animate,room_width/2+150,room_height/2+125,2,2,0,c_white,1)

//Drawing Level Text and Descriptions
draw_set_valign(fa_middle)
draw_set_halign(fa_left)
draw_set_font(fntLevelSelect)
draw_text_colour(room_width/2+100,room_height/2+340,string(level_descstring),c_white,c_white,c_white,c_white,1)

//Drawing Film Reel to Screen
draw_sprite_ext(sprFilmReel, 0, room_width / 2 - reel_xpos-250, room_height / 2, 3, 3, image_angle + reel_rot,c_white,1)

//Current Title Card
titlecard = 0
//Title Card Angle
titlecard_angle = 0
// Draw Title Cards around the reel

for(var i = 0; i < 8; ++i) {
	titlecard_angle -= 45 * i
	draw_sprite_ext(
		sprTitleCard, 
		titlecard + i, 
		room_width / 2-reel_xpos-250+lengthdir_x(250,titlecard_angle+reel_rot),
		room_height / 2+lengthdir_y(250,titlecard_angle+reel_rot), 
		3, 
		3, 
		titlecard_angle + reel_rot, 
		c_white, 1
		)	
}

//Drawing Posters and Poster Tubes
dir += -0.15
draw_sprite_ext(sprPosterTube, 0, room_width / 2 + 420, room_height / 2 - 600 + poster_y, 2, 2, lengthdir_x(2, dir * 2 + 100),c_white,1)

//Drawing Letterboxing
draw_set_alpha(1)
draw_set_colour(c_black)
var width = 960;
var height = 640;
var boxheight = 48;
draw_rectangle(0, 0, width, boxheight, false)
draw_rectangle(0, height - boxheight, width, height, false)

draw_set_color(c_white)
draw_set_font(fntDebug)
draw_text_transformed(room_width / 2 + 120, room_height / 2, "Reel Rotation" + " = " + string(reel_rot), 2, 2, 0)
draw_text_transformed(room_width / 2 + 120, room_height / 2 + 20, "Selected" + " = " + string(selected), 2, 2, 0)
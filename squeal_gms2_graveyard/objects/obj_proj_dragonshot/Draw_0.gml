draw_sprite_ext(sprite_index, bullet_index, x + bullet_life * 0.25, y + bullet_life * 0.25, 1, 1, image_angle, c_black, 0.2)
gpu_set_blendmode(bm_add)													   
draw_sprite_ext(sprite_index, bullet_index, x, y, 1, 1, image_angle, bullet_color, 1)
gpu_set_blendmode(bm_normal)

if debug = true {
	//draw_text(x,y + 10, "Index" + string(bullet_index))
	//draw_text(x,y + 20, "Ammotype" + string(ammo_type))
	//draw_text(x,y + 50, "Life" + string(bullet_life))
	draw_text(x, y + 80, "Image angle" + " " + string(image_angle))
	show_debug_message(ammo_type)
}
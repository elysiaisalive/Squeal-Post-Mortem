//var _a1 = (4 / 5)
//var _a2 = (3 / 5)
//var _c1 = merge_color(c_black, c_orange, 0.1)
//var _c2 = merge_color(c_black, c_orange, 0.5)

//var _x1 = bbox_left + 1
//var _y1 = bbox_top
//var _x2 = bbox_right
//var _y2 = bbox_bottom

//draw_primitive_begin(pr_trianglestrip)
//draw_vertex_color(_x1, _y1, _c1, _a1)
//draw_vertex_color(_x2, _y1, _c1, _a1)
//draw_vertex_color(_x1, lerp(_y1, _y2, 0.5), _c2, _a2)
//draw_vertex_color(_x2, lerp(_y1, _y2, 0.5), _c2, _a2)
//draw_primitive_end()

//draw_primitive_begin(pr_trianglestrip)
//draw_vertex_color(_x1, lerp(_y1, _y2, 0.5), _c2, _a2)
//draw_vertex_color(_x2, lerp(_y1, _y2, 0.5), _c2, _a2)
//draw_vertex_color(_x1, _y2, _c1, _a1)
//draw_vertex_color(_x2, _y2, _c1, _a1)
//draw_primitive_end()

draw_sprite_ext(sprite_index,0,x + 2, y + 2,image_xscale,image_yscale,image_angle,c_black,0.2)
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, image_blend, roof_opacity)
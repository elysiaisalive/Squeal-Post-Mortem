var xx = camera_get_view_x(CURRENT_VIEW);
var yy = camera_get_view_y(CURRENT_VIEW);
var xx2 = camera_get_view_width(CURRENT_VIEW);
var yy2 = camera_get_view_height(CURRENT_VIEW);
var c_gum = (make_color_rgb (238, 105, 127));
var c_helm = (make_color_rgb (0, 255, 114));
var c_glasses = (make_color_rgb (255, 0, 198));
var c_police = (make_color_rgb (0, 158, 153));
var c1 = c_black;
var c2 = c_black;

#region Character Colors
if ( on ) 
{
	c1 = merge_color( c_black, merge_color( c_black, bgColor1, abs( sin( bg_move ) ) ), abs( sin( bg_move ) ) );
	c2 = merge_color( bgColor2, merge_color( bgColor1, c_black, abs( sin( bg_move ) ) ), abs( sin( bg_move ) ) );
			// 	break;
			// case "Joe" :
			// 	c1 = merge_color(c_black, merge_color(c_black, c_blue, abs(sin(bg_move))), abs(sin(bg_move)));
			// 	c2 = merge_color(c_red, merge_color(c_red, c_black, abs(sin(bg_move))), abs(sin(bg_move)));
			// 	break;
			// case "Derby" :
			// 	c1 = merge_color(c_gum, merge_color(c_black, c_gum, abs(sin(bg_move))), abs(sin(bg_move)));
			// 	c2 = merge_color(c_helm, merge_color(c_helm, c_black, abs(sin(bg_move))), abs(sin(bg_move)));
			// 	break;
}
#endregion

draw_rectangle_color(
	-90 + xx,
	-90 + yy,
	90 + xx + xx2,
	90 + yy + yy2,
	c1,
	c2,
	c2,
	c1,
	false
);
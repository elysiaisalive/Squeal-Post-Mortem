// Drawing the temp controls list
var _x = room_width / 2 
var _y = room_height / 2
var offset_y2 = 100

for (var i = 0; i < (array_length(controls_list)); ++i)
{
	draw_set_color(c_lime)
	if (!pressed)
	{
		if (i == selected) 
		{
			draw_set_color(c_red)
		}
		else
		{
			draw_set_color(c_lime)
		}
	}
	if (pressed)
	{
		if (i == selected) 
		{
			draw_set_color(c_blue)
		}
		else
		{
			draw_set_color(c_lime)
		}
	}
	draw_set_valign(fa_middle)
	draw_set_halign(fa_left)
	draw_set_font(fnt_terminal)
	draw_text(
		_x - text_offset_x,
		_y - offset_y2 + (text_offset_y * i * 2),
		string(controls_list[i])
		)
}
draw_set_color(c_blue)
draw_set_halign(fa_center)
draw_text(
	_x,
	_y + 120,
	"PRESS SPACE TO SAVE CHANGES"
)
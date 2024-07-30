scr_splashdraw();

var donetext;

if debug {
	if done
		donetext = "Done"
	if !done
		donetext = "Not Done"
	draw_text(room_width/2,room_height/2,donetext)
	draw_text(room_width/2,room_height/2 + 10, looptime)
}

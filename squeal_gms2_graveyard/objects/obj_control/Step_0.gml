anim += animspeed;
delta = ( min( 1, delta_time / ( 1000000 / 60 ) ) ) * timescale;

// timestamp_timer.Tick();
	
// if ( timestamp_timer.GetTime() <= 0 ) {
// 	timestamp_x = random( camera_get_view_width( CURRENT_VIEW ) );
// 	timestamp_x = random( camera_get_view_height( CURRENT_VIEW ) );
// }

#region UI and HUD
if ( saving || loading )
{
	text_timer = max(0, text_timer - 0.2);
}
if ( text_timer == 0 )
{
	saving = false;
	loading = false;
	text_timer = 60 * 4;
}
text_timer = clamp(text_timer, 0, 60 * 4);
#endregion
#region Statistics
milliseconds = max(0, milliseconds + 2);
milliseconds = floor(milliseconds);
milliseconds = clamp(milliseconds, 0, 99);
global.seconds = clamp(global.seconds, 0, 60);
global.minutes = clamp(global.minutes, 0, 60);

if ( milliseconds == 99 ) 
{
	global.seconds = max( 0, global.seconds + 1 );
	milliseconds = 0;
}
if ( global.seconds == 59 ) 
{
	global.minutes = max( 0, global.minutes + 1 );
	global.seconds = 0;
}
#endregion	
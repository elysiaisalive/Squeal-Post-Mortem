event_inherited();

setPropHeight( 4, -30 );
Solid_ClearFlags();

triggerName = "buttonSpawnEnemy";

button = new cInteractableButton();
button.SetInteractSound( snd_keypad_release );
button.OnTrigger = function()
{
	playsound_at( button.GetInteractSound(), x, y );
    
	eventhandler_publish( "buttonSpawnEnemy" );
};

// SaveState = function( buf = global.checkpoint )
// {
// 	buffer_write( buf, buffer_u8, button.bState );
// 	buffer_write( buf, buffer_string, button.GetParent() );
// };
// LoadState = function( buf = global.checkpoint )
// {
// 	button.bState = buffer_read( buf, buffer_u8 );
// 	button.SetParent( buffer_read( buf, buffer_string ) );
// };
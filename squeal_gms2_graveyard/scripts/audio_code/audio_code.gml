/*
usage example:
audio_play_sound( audio().GetSound( "ui\confirm" ), 0, false );

weapon_shotgun.shoot_sound = audio().GetSound( @"weapons\shotgun" );
if ( weapon_shotgun.shoot_sound )
{
	audio_play_sound( weapon_shotgun.shoot_sound );
}
*/
function cAudio() constructor
{
	m_Sounds = {};
	
	static Init = function()
	{
		PrecacheDirectory( SFX_PATH );
	}
	
	static Cleanup = function()
	{
		array_foreach( variable_struct_get_names( m_Sounds ), function( Item )
		{
			var Sound = m_Sounds[$ Item];
			if ( Sound )
			{
				if audio_exists( Sound )
					audio_destroy_stream( Sound );
			}
		})
	}
	
	static GetSound = function( sRelativePath )
	{
		var Sound = m_Sounds[$ sRelativePath];
		
		if !( Sound )
		{
			var sFilePath = ( SFX_PATH + sRelativePath + ".ogg" );
			if ( file_exists( sFilePath ) )
			{
				var iStream = audio_create_stream( sFilePath );
				if audio_exists( iStream )
				{
					//ConMsg( "adding sound \"" + sFilePath + "\", stream id " + string( iStream ) );
					Sound = iStream;
					m_Sounds[$ sRelativePath] = Sound;
					return Sound;
				}
			}
			//ConMsg( "couldnt find sound " + sRelativePath, true );
		}
		
		return Sound;
	}
	
	static PlaySound = function( sRelativePath, bLoop = false )
	{
		var Sound = GetSound( sRelativePath );
		if ( Sound )
		{
			return audio_play_sound( Sound, 0, bLoop );
		}
	}
	
	static StopSound = function( sRelativePath )
	{
		var Sound = GetSound( sRelativePath );
		if ( Sound )
		{
			audio_stop_sound( Sound );
		}
	}
	
	static PrecacheDirectory = function( sFullPath, sRelativePath = "" )
	{
		// ...
		if ( !directory_exists( sFullPath ) ) {
			return;
		}
		
		//ConMsg( "audio: precaching directory \"" + sFullPath + "\"", true );
		
		var sFile = file_find_first( sFullPath + "*.ogg", 0 );
		while ( sFile != "" )
		{
			GetSound( sRelativePath + filename_change_ext( sFile, "" ) );
			sFile = file_find_next();
		}
		file_find_close();
		var aDirectories = [];
		var sFile = file_find_first( sFullPath + @"*", fa_directory );
		while ( sFile != "" )
		{
			var sDir = ( sFullPath + sFile + @"\" );
			if ( directory_exists( sDir ) )
			{
				array_push( aDirectories, [ sDir, sRelativePath + sFile + @"\" ] );
			}
			sFile = file_find_next();
		}
		file_find_close();
		for ( var i = 0; i < array_length( aDirectories ); i++ )
		{
			PrecacheDirectory( aDirectories[i][0], aDirectories[i][1] );
		}
	}
}

function audio()
{
	static s_Class = new cAudio();
	return s_Class;
}
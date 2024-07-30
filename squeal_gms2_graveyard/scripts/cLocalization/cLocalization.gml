/*------------------------------------------------------------------------*\
 Language
 @author Sage < https://github.com/Sage64 >
 Requires:

Example Use : 
    string( lang().GetString( "#Game.Hud.Hotline1.Points" );
\*------------------------------------------------------------------------*/

#macro LANG_TOKEN_CHAR "#"

function cBaseClass() constructor
{
	//variable_struct_remove( self, "toString" );
	
	m_sClassName = string( instanceof( self ) );
	m_sName = m_sClassName;
	
	static GetClassName = function()
	{
		return m_sClassName;
	};
	
	static GetName = function()
	{
		return m_sName;
	};
};

function cLocalization() : cBaseClass() constructor
{
	m_sLanguage = "";
	
	m_Languages = {};
	m_CurrentLang = undefined;
	
	
	static Init = function()
	{
		m_Languages = {};
		
		SetLanguage( "en" );
		SetFile( "lang" );
		
		GetLangString();
	}
	
	static Cleanup = function()
	{
		m_Languages = {};
		
	}
	
	static Reload = function()
	{
		m_Languages = {};
		
		GetLangString();
	}
	
	static SetLanguage = function( sLanguage )
	{
		sLanguage = string_lower( sLanguage );
		m_sLanguage = sLanguage;
		var Lang = GetLanguage( sLanguage );
		m_CurrentLang = GetLanguage( sLanguage );
	}
	
	static GetLanguage = function( sLanguage )
	{
		var Lang = m_Languages[$ sLanguage]; 
		if ( !( Lang ) )
		{
			Lang = new cLanguage( sLanguage );
			m_Languages[$ sLanguage] = Lang;
		}
		return Lang;
	}
	
	static SetFile = function( sFile = "lang" )
	{
		m_sLanguage = sFile;
	}
	
	static GetStringFrom  = function( sFile = "lang", sToken = "" )
	{
		if ( sToken == "" )
		{
			sToken = sFile;
			sFile = m_sLanguage;
		}
		if ( m_CurrentLang )
		{
			var sGet = m_CurrentLang.GetLangString( sFile, sToken );
			if ( is_string( sGet ) )
			{
				return sGet;
			}
		}
		return sToken;
	}
	
	static GetLangString = function( sToken = "#Token" )
	{
		return GetStringFrom( m_sLanguage, sToken );
	}
}

function lang()
{
	static s_Class = new cLocalization();
	return s_Class;
}

function cLanguage( sLanguage = "" ) : cBaseClass() constructor
{
	m_sLanguage = sLanguage;
	m_Files = {};
	
	/// @static
	/// @param		{string} 	sFile		Lang file name.
	/// @param		{string} 	sToken		The string to search for via a token. e.x; ( #Lang.Foo.Bar )
	/// @return		{string}				Returns a string from the lang file.
	static GetLangString = function( sFile = "lang", sToken = "" )
	{
		sFile = string_lower( sFile );
		var File = m_Files[$ sFile];
		if ( !( File ) ) {
			File = new cLocalizationFile( LANG_PATH + $"/{m_sLanguage}.lang" );
			m_Files[$ sFile] = File;
		}
		var sNewToken = File.GetLangString( sToken );
		if ( sNewToken == undefined ) && ( m_sLanguage != "en" )
		{
			sToken = lang().GetLanguage( "en" ).GetLangString( sFile, sToken );
		}
		else
			sToken = sNewToken;
		return sToken;
	}
}

function cLocalizationFile( sFullPath = "" ) : cBaseClass() constructor
{
	m_Tokens = {};
	
	Tokenize( sFullPath );
	
	static Tokenize = function( sFullPath = "" )
	{
		var timer = get_timer();
		println( "lang: tokenizing " + sFullPath );
		if ( file_exists( sFullPath ) )
		{
			var buf = buffer_load( sFullPath );
			if ( buffer_exists( buf ) )
			{
				var sFile = buffer_read( buf, buffer_string );
				buffer_delete( buf );
				var iLen = string_length( sFile );
				var aString = array_create( iLen );
				var aLetters = array_create( iLen );
				for ( var i = 0, count = iLen; i < count; i++ )
				{
					var sLetter = string_char_at( sFile, i + 1 );
					aString[i] = sLetter;
					aLetters[i] = ord( sLetter );
				}
				aString[i] = "";
				aLetters[i] = 0;
				
				for ( var i = 0; i < count; i++ )
				{
					//if ( aLetters[i] != ord( LANG_TOKEN_CHAR ) )
					if ( aLetters[i] >= 65 && aLetters[i] <= 90 )
					|| ( aLetters[i] >= 97 && aLetters[i] <= 122 )
					{}
					else
						continue;
					var sToken = LANG_TOKEN_CHAR;
					while ( !( aLetters[i] == 0 || aLetters[i] == 9 || aLetters[i] == 10 || aLetters[i] == 32 ) )
					{
						sToken += aString[i++];
					}
					while ( !( aLetters[i] == 0 ) )
					{
						if ( aLetters[i] == 34 )
						{
							i++;
							break;
						}
						i++;
					}
					var sValue = "";
					while ( !( aLetters[i] == 0 ) )
					{
						if ( aLetters[i] == 10 )
						{
							continue;
						}
						if ( aLetters[i-1] == 92 )
						{
							switch ( aLetters[i] )
							{
								case 34:
									sValue += "\"";
									break;
								case 92:
									sValue += "\\";
									break;
								case 110:
									sValue += "\n";
									break;
								default:
									sValue += aString[i];
							}
							i++;
							continue;
						}
						else if ( aLetters[i] == 92 )
						{
							i++;
							continue;
						}
						else if ( aLetters[i] == 34 )
						{
					        println( string( sToken ) );
						    
							m_Tokens[$ string_lower( sToken )] = sValue;
							i++;
							break;
						}
						sValue += aString[i++];
					}
				}
				print( string( "Localization Success - took {0}ms", ( get_timer() - timer ) / 1000 ) );
			}
		}
		else
		{
		    print( "Lang Failed!" );
		}
	}
	
	static GetLangString = function( sToken = "" )
	{
		return m_Tokens[$ string_lower( sToken )];
	}
};
/// @desc Function Creates a folder in the games APPDATA path
/// @param {string} directory The path that the folder is created in
function create_directory( directory )
{
	if ( !directory_exists( directory ) )
	{
		directory_create( directory );
	}
}

function delete_file( file ) 
{
	if ( file_exists( APPDATA_PATH + file ) )
	{
		file_delete( APPDATA_PATH + file );
		
		if ( !file_exists( file ) )
		{
			println( "File" + " [" + string( file ) + "] " + "Deleted" );
		}
	}
}
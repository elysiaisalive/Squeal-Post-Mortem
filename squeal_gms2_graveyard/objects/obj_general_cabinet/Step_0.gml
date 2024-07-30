if ( extend && ( extend_dir < 270 ) )
{
	var xscale_sub = ( 1 / 32 );
	var xscale_add = ( extend_range / 32 );
        
	extend_dir = min( extend_dir + ( ( ( extend_dir < 90 ) ? 8 : 1 ) * 18 * delta ), 270 );
	
	var amount = dsin( extend_dir );
	
	image_xscale = 1 - ( ( amount > 0 ? xscale_sub : xscale_add ) * amount );
}
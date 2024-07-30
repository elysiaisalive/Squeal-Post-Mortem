if ( open )
{
	if  ( image_index < ( image_number - 1 ) )
	{
		image_index = min( image_index + ( 0.125 * delta ), image_number - 1 );
		var amount = image_index / ( image_number - 1 );
		
		image_alpha = lerp( 1, 0.65, amount );
		z = lerp( 0, -ceiling_height, amount );
		height = lerp( ceiling_height, 0, amount );
		depth = z - height;
	}
}
else if ( image_index > 0 )
{
	image_index = max( 0, image_index - ( 0.125 * delta ) );
	var amount = image_index / ( image_number - 1 );
	
	image_alpha = lerp( 1, 0.65, amount );
	z = lerp( 0, -ceiling_height, amount );
	height = lerp( ceiling_height, 0, amount );
	depth = z - height;
}
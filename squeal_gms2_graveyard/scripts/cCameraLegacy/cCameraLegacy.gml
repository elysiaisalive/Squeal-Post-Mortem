function cCameraLegacy( _view = -1 ) constructor
{
	//ConMsg( string( "camera CURRENT_VIEW {0}", CURRENT_VIEW ), true );
	static s_aCameras = array_create( 16, undefined );
	
	camera_id = -1;
	self._view = -1;
	surf = undefined;
	x = 0;
	y = 0;
	z = 128;
	look_x = 0;
	look_y = 0;
	look_z = 0;
	up_x = 0;
	up_y = 0;
	up_z = 0;
	
	fov = 64;
	
	is_3d = false;
	
	width = 512;
	height = 512;
	aspect = 1;
	
	near = ( 1 / 8 );
	far = ( 16 * 16 * 64 );
	
	yaw = 90;
	pitch = 0;
	roll = 0;
	
	projmat = matrix_build_projection_ortho( 480, 270, 1 / 10, 4096 );
	viewmat = matrix_build_lookat( 0, 0, 32, 0, 32, 0, 0, 0, 1 );
	
	changed = true;
	
	dcos_pitch = 0;
	dsin_pitch = 0;
	dcos_yaw = 0;
	dsin_yaw = 0;
	update_trig = true;
	
	clampx = [ -infinity, infinity ];
	clampy = [ -infinity, infinity ];
	clampz = [ -infinity, infinity ];
	
	SetView( CURRENT_VIEW );
	
	static SetView = function( _view = 0 )
	{
		if !( camera_id < 0 ) && !( CURRENT_VIEW < 0 )
		{
			s_aCameras[CURRENT_VIEW] = undefined;
			camera_id = -1;
		}
		CURRENT_VIEW = _view;
		if !( _view < 0 )
		{
			camera_id = view_camera[CURRENT_VIEW];
			s_aCameras[CURRENT_VIEW] = self;
		}
	}
	
	static Cleanup = function()
	{
		SetView( -1 );
	}
	
	static SetClampX = function( _min = -infinity, _max = infinity )
	{
		clampx[0] = _min;
		clampx[1] = _max;
	}
	
	static SetClampY = function( _min = -infinity, _max = infinity )
	{
		clampy[0] = _min;
		clampy[1] = _max;
	}
	
	static SetClampZ = function( _min = -infinity, _max = infinity )
	{
		clampz[0] = _min;
		clampz[1] = _max;
	}
	
	static SetPosition = function( x = self.x, y = self.y, z = self.z )
	{
		x = clamp( x, clampx[0], clampx[1] );
		y = clamp( y, clampy[0], clampy[1] );
		z = clamp( z, clampz[0], clampz[1] );
		if ( self.x != x )
		|| ( self.y != y )
		|| ( self.z != z )
		{
			self.x = x;
			self.y = y;
			self.z = z;
			changed = true;
		}
	}
	static SetPos = SetPosition;
	
	static AddPosition = function( x = 0, y = 0, z = 0 )
	{
		SetPosition( self.x + x, self.y + y, self.z + z );
	}
	
	
	static MoveX = function( amount = 0 )
	{
		SetPosition( x + lengthdir_x( amount, yaw + 270 ), y + lengthdir_y( amount, yaw + 270 ) );
	}
	
	static MoveY = function( amount = 0 )
	{
		SetPosition( x + lengthdir_x( amount, yaw + 180 ), y + lengthdir_y( amount, yaw + 180 ) );
	}
	
	static MoveZ = function( amount = 0 )
	{
		SetPosition( , , z + amount );
	}
	
	static MoveForward = function( fAmount = 0 )
	{
		var dcos_yaw = dcos( yaw );
		var dsin_yaw = dsin( yaw );
		var dcos_pitch = dcos( 180 - pitch );
		var dsin_pitch = -dsin( 180 - pitch );
		var xdir = ( fAmount * dcos_yaw * dsin_pitch );
		var ydir = -( fAmount * dsin_yaw * dsin_pitch );
		var zdir = ( fAmount * dcos_pitch );
		AddPosition( xdir, ydir, zdir );
	}
	
	// Get[][] functions are intended for ortho projections at Y/P/R 90,0,0!
	
	static GetX1 = function()
	{
		return x - ( width / 2 );
	}
	
	static GetX2 = function()
	{
		return x + ( width / 2 );
	}
	
	static GetY1 = function()
	{
		return y - ( height / 2 );
	}
	
	static GetY2 = function()
	{
		return y + ( height / 2 );
	}
	
	
	static SetSize = function( width = 480, height = 270 )
	{
		if ( self.width != width )
		|| ( self.height != height )
		{
			self.width = width;
			self.height = height;
			if ( width ) && ( height )
			{
				aspect = ( width / height );
			}
			changed = true;
		}
	}
	
	static SetYaw = function( yaw = self.yaw )
	{
		yaw = ( ( yaw + 360 ) % 360 );
		if ( self.yaw != yaw )
		{
			self.yaw = yaw;
			changed = true;
		}
	}
	
	static GetYaw = function()
	{
		return yaw;
	}
	
	
	static SetPitch = function( pitch = self.pitch )
	{
		pitch = clamp( pitch, 0, 180 );
		if ( self.pitch != pitch )
		{
			self.pitch = pitch;
			changed = true;
		}
	}
	
	static GetPitch = function()
	{
		return pitch;
	}
	
	
	static SetRoll = function( roll = self.roll )
	{
		roll = ( roll + 360 ) % 360;
		if ( self.roll != roll )
		{
			self.roll = roll;
			changed = true;
		}
	}
	
	static GetRoll = function()
	{
		return roll;
	}
	
	
	static SetClipping = function( near = 1 / 16, far = 16 * 16 * 32 )
	{
		self.near = near;
		self.far = far;
	}
	
	static BuildMatrices = function()
	{
		var surf = self.surf ?? view_get_surface_id( CURRENT_VIEW );
		if ( changed ) && ( surface_exists( surf ) )
		{
			var dcos_yaw = dcos( yaw );
			var dsin_yaw = dsin( yaw );
			var dcos_pitch = dcos( 180 - pitch );
			var dsin_pitch = -dsin( 180 - pitch );
			
			var xdir = ( 512 * dcos_yaw * dsin_pitch );
			var ydir = -( 512 * dsin_yaw * dsin_pitch );
			var zdir = ( 512 * dcos_pitch );
			
			look_x = x + xdir;
			look_y = y + ydir;
			look_z = z + zdir
			
			if ( false )
			{
				var c = dcos( roll );
				var s = dsin( roll ) / max( math_get_epsilon(), sqrt( sqr( xdir ) + sqr( ydir ) ) );
				up_x = ydir * s;
				up_y = -xdir * s
				up_z = c;
			}
			else
			{
				up_x = -dcos_yaw * dcos_pitch;
				up_y = dsin_yaw * dcos_pitch;
				up_z = dsin_pitch;
			}
			aspect = surface_get_width( surf ) / surface_get_height( surf );
			viewmat = matrix_build_lookat( x, y, z, look_x, look_y, look_z, up_x, up_y, up_z );
			if ( is_3d )
			{
				draw_light_define_direction( 1, xdir / 512, ydir / 512, zdir / 512, draw_light_get( 1 )[6] );
				projmat = matrix_build_projection_perspective_fov( fov, aspect, near, far );
			}
			else
				projmat = matrix_build_projection_ortho( width, height, near, far );
			changed = false;
		}
	}
	
	static Apply = function()
	{
		if ( changed )
		{
			BuildMatrices();
		}
		if !( changed )
		{
			camera_set_view_pos( camera_id, x, y );
			camera_set_view_size( camera_id, width, height );
			camera_set_view_mat( camera_id, viewmat );
			camera_set_proj_mat( camera_id, projmat );
			camera_apply( camera_id );
		}
	}
	
	static ApplyHud = function( width = 1920.0, height = 1080.0, xx = width / 2.0, yy = height / 2.0 )
	{
		var cam = self.camera_id;
		//camera_set_view_mat( cam, matrix_build_lookat( xx, yy, 0, xx, yy, 0, 0, 0, 1 ) );
		//camera_set_proj_mat( cam, matrix_build_projection_ortho( width, height, -16000, 16000 ) );
		camera_set_view_pos( cam, 0, 0 );
		camera_set_view_size( cam, width, height );
		camera_set_view_angle( cam, 0 );
		camera_apply( cam );
	}
	
}

function camera_class() {
	static s_Class = new cCameraLegacy();
	return s_Class;
}

function camera_surface( surf )
{
	var width = surface_get_width( surf );
	var height = surface_get_height( surf );
	var xx = width / 2.0;
	var yy = height / 2.0;
	var cam = view_get_camera( view_current );
	camera_set_view_pos( cam, 0, 0 );
	camera_set_view_size( cam, width, height );
	camera_set_view_angle( cam, 0 );
	camera_set_view_mat( cam, matrix_build_lookat( xx, yy, 8000, xx, yy, 0, 0, -1, 0 ) );
	camera_set_proj_mat( cam, matrix_build_projection_ortho( width, height, 0, 16000 ) );
	camera_apply( cam );
}
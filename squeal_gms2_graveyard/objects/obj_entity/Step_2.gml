if (global.firstperson)
&& instance_exists(obj_camera_control)
&& instance_exists(global.camera_target)
&& (global.camera_target.id == id)
	depth = ( z - eyes ) + 5;
else
	depth = ( z - height );

var camera = view_get_camera(view_current)
switch global.camera_mode {
	case e_cameraMode.perspective_firstperson:
	case e_cameraMode.perspective_thirdperson:
		draw_clear( c_black );
		if instance_exists(global.camera_target) {
			audio_listener_position( global.camera_target.transform.position.x, global.camera_target.transform.position.y, 0 );
			audio_listener_set_position( 0, camera_x, camera_y, 0 );
			audio_listener_orientation( camera_x, camera_y, 0, -dsin( camera_angle ), dcos( camera_angle ), 0 );
			gpu_set_zwriteenable(true)
			gpu_set_ztestenable(true)
			
			var cam_lookh = global.mouseh
			var cam_lookv = global.mousev
			
			var cam_aspect = (surface_get_width(application_surface) / surface_get_height(application_surface))
			
			var camx = global.camera_target.x
			var camy = global.camera_target.y
			var camz = global.camera_target.z - (global.camera_target.eyes)
			
			if (global.camera_mode = e_cameraMode.perspective_thirdperson) {
				camx = global.camera_target.x - (dcos(cam_lookh) * thirdperson_distance) * dsin(cam_lookv)
				camy = global.camera_target.y + (dsin(cam_lookh) * thirdperson_distance) * dsin(cam_lookv)
				camz = global.camera_target.z - (global.camera_target.eyes) - (dcos(cam_lookv) * thirdperson_distance)
			}
			
			var camdis = 256
			
			var cam_fov = 64
			
			var cam_lookx = camx + (dcos(cam_lookh) * camdis) * dsin(cam_lookv)
			var cam_looky = camy - (dsin(cam_lookh) * camdis) * dsin(cam_lookv)
			var cam_lookz = camz + (dcos(cam_lookv) * camdis)
			
			var cam_upx = -dcos(cam_lookh) * dcos(cam_lookv)
			var cam_upy = dsin(cam_lookh) * dcos(cam_lookv)
			var cam_upz = dsin(cam_lookv)
			
			var cam_projmat = matrix_build_projection_perspective_fov(cam_fov, cam_aspect, 1, 2048)
			var cam_viewmat = matrix_build_lookat(camx, camy, camz, cam_lookx, cam_looky, cam_lookz, cam_upx, cam_upy, cam_upz)
			
			camera_set_view_angle(camera, -cam_lookh)
			camera_set_view_mat(camera, cam_viewmat)
			camera_set_proj_mat(camera, cam_projmat)
			camera_apply(camera)
		}
		break
		
	case e_cameraMode.ortho_topdown:
		audio_listener_position( global.camera_target.transform.position.x, global.camera_target.transform.position.y, 0 );
		audio_listener_set_position( 0, camera_x, camera_y, 0 );
		audio_listener_orientation( camera_x, camera_y, 0, -dsin( camera_angle ), dcos( camera_angle ), 0 );
		gpu_set_zwriteenable(true);
		gpu_set_ztestenable(false);
		camera_set_view_mat(camera, matrix_build_lookat(camera_x, camera_y, -512, camera_x, camera_y, 0, -dsin(camera_angle), dcos(camera_angle), 0));
		camera_set_proj_mat(camera, matrix_build_projection_ortho(camera_width * camera_zoomfactor, camera_height * camera_zoomfactor, 0, 2048));
		camera_apply(camera);
		break;
		
	default:
		gpu_set_zwriteenable(true);
		gpu_set_ztestenable(false);
		camera_set_view_angle(camera, 0);
		camera_apply(camera);
		break;
}
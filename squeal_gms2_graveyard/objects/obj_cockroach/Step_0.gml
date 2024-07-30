image_speed = cock_animate * delta
if _state < 2 {
    var inst = instance_nearest(x, y, scaredof)
	if !instance_exists(inst) {

	}
	else {
		if point_distance(x, y, inst.x, inst.y) < 32 * 3.5 {
			_state = 2
			alertdir = point_direction(x, y, inst.x, inst.y)
		}
	}
}

switch _state {
    case 0: #region idle
        idle_timer = max(0, idle_timer - delta)
        if idle_timer = 0 {
            _state = 1
            idle_timer = irandom_range(60 * 2, 60 * 4)
        }
        
        spd = max(0, spd - (dec * delta))
        RoachMove()
        break #endregion
    
    case 1: #region moving
        idle_timer = max(0, idle_timer - delta)
        if idle_timer = 0 {
          if irandom(1) {
                turnvolc = random_range(-turnspeed, turnspeed) * 0.5
                if irandom(1)
                    dir = random(360)
            }
            else {
                _state = 0
                idle_timer = irandom_range(60 * 0.5, 60 * 1.5)
            }
        }
        
        turnvolc += random_range(-turnacc , turnacc) * delta
        turnvolc = clamp(turnvolc, -turnspeed, turnspeed)
        dir += turnvolc * delta
        spd = min(spd + (acc * delta), spd_max)
        RoachMove()
        break #endregion
    
    case 2: #region alert
        var inst = instance_nearest(x, y, scaredof)
		if !instance_exists(inst)
		or point_distance(x, y, inst.x, inst.y) > 32 * 4.5
			_state = choose(0, 1)
		else if point_distance(x, y, inst.x, inst.y) < 32 * 1.75
			_state = 3
		else 
			alertdir = point_direction(x, y, inst.x, inst.y)
		dir = rotate(dir, alertdir, 5 * delta)
        break #endregion
    
    case 3: #region flee
        var inst = instance_nearest(x, y, scaredof)
		if !instance_exists(inst)
			_state = choose(0, 1)
		else {
		   var max_attempts = 10
		    var i = 0
		    repeat max_attempts {
		        var wall = instance_find(obj_wall, irandom(instance_number(obj_wall)))
		        if instance_exists(wall) {
		            var dest_x = wall.x + 4
		            var dest_y = wall.y + 4
		            var _dir = 0
		            if (wall.sprite_width > wall.sprite_height)
		                _dir = 0
		            else
		                _dir = 270
		            var length = max(sprite_width - 8, sprite_height - 8)
		            var dis = random(length)
		            dest_x += lengthdir_x(dis, _dir)
		            dest_y += lengthdir_y(dis, _dir)
					
		            mp_grid_clear_all(grid)
		            mp_grid_add_instances(grid, obj_wall, true)
		            mp_grid_add_instances(grid, scaredof, true)
		            mp_grid_add_instances(grid, objShootThrough, true)
		            mp_grid_clear_rectangle(grid, wall.bbox_left, wall.bbox_top, wall.bbox_right, wall.bbox_bottom)
		            var result = mp_grid_path(grid, path, x, y, dest_x, dest_y, true)
					//show_message(result)
		            if (result) {
		                _state = 4
						target_wall = wall
		                path_start(path, spd_max, path_action_stop, true)
		                break
		            }
		            else {
						i ++
		                _state = 5
		            }
            
		        }
			}
		}
		break #endregion
	
	case 4: #region escape
		path_speed = spd_max * delta
		dir = rotate(dir, direction, 10 * delta);
		if path_index < 0 {
	        if instance_exists(target_wall) {
				repeat irandom_range(3, 7) {
		            var inst = instance_create_depth(x + random_range(-2, 2), y + random_range(-2, 2), depth + random_range(-1, 1), obj_cockdebris)
		            inst.dir = direction + 180 + random_range(-35, 35)
		            inst.sprite_index = target_wall.sprite_index
		            inst.spd = random_range(2, 3)
					inst.xoff = random(target_wall.sprite_width - inst.size)
					inst.yoff = random(target_wall.sprite_height - inst.size)
				}
			}
			instance_destroy();
		}
        break #endregion
	
	case 5: #region panic
		
        break #endregion
}
//image_angle = dir
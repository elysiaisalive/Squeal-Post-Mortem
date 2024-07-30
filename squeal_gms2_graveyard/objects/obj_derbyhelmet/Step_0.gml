junk_spd -= junk_frc * delta
junk_spd = clamp(junk_spd, 0, 8)
image_speed = junk_spd / 2 * delta;
if junk_spd > 0
	depth = -25
scale = 1 * junk_spd / 3
scale = 1 * junk_spd / 3
scale = clamp(scale, 1, 4)

x += dcos(direction) * junk_spd * delta
y -= dsin(direction) * junk_spd * delta

var _other = obj_player
if place_meeting(x, y, _other) && self.junk_spd = 0 {
	self.junk_spd = random_range(2, 3) + (_other.movement_speed / 2)
	self.junk_fric = random_range(0.2, 0.4)
	direction = _other.direction
	image_angle = _other.charLegDir
}
var _wall = obj_wall
if !place_meeting(x, y, _other) && place_meeting(x, y, _wall) && place_free(_wall.x, _wall.y) {
	self.junk_spd = random_range(1, 2)
	self.junk_fric = random_range(0.2, 0.4)
	self.direction -= 180
	self.image_angle = self.direction
}
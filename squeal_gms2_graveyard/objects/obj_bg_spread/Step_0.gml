var scale_min = 0.1;
var scale_max = 8;

var scale_spd = 0.05;
var rot_spd = 0.5;

splotch.scale += scale_spd;
splotch.rot += rot_spd;
splotch.index += splotch.animspd;

splotch.scale = clamp(splotch.scale, scale_min, scale_max);
spd = max(0, spd - (frc * delta))
x += lengthdir_x(spd * delta, dir)
y += lengthdir_y(spd * delta, dir)
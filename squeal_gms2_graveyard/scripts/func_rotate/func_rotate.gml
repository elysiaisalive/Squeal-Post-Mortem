function rotate( _base = 0, _target = noone, turn_spd = 1 )
{
    return _base + clamp( angle_difference( _target, _base ), -turn_spd, turn_spd );
}

function rotate_to( _base, _target, turn_spd = 1 ) 
{
	  return rotate( _base, _target, abs( angle_difference( _target, _base ) * turn_spd ) );
}
function map_value(_value, _current_lower_bound, _current_upper_bound, _desired_lowered_bound, _desired_upper_bound) {
    return (((_value - _current_lower_bound) / (_current_upper_bound - _current_lower_bound)) * (_desired_upper_bound - _desired_lowered_bound)) + _desired_lowered_bound;
}
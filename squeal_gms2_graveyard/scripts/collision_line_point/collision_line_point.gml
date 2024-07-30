/// @func collision_line_point(x1, y1, x2, y2, obj, prec, notme)
/// Returns the instance and position of collision_line()
function collision_line_point( _x1, _y1, _x2, _y2, _obj, _prec, _notme ) 
{
    var _inst, _lx, _ly, _rx, _ry, _mx, _my, _minst, _dis, _dir;
    
    _inst = collision_line( _x1, _y1, _x2, _y2, _obj, _prec, _notme );
    _lx = _x1; _ly = _y1;
    _rx = _x2; _ry = _y2;
    
    if ( _inst != noone ) 
    {
        _dis = point_distance( _lx, _ly, _rx, _ry );
        _dir = point_direction( _lx, _ly, _rx, _ry );
        
        repeat( ceil( log2( _dis ) ) + 0 ) 
        {
            _dis = point_distance( _lx, _ly, _rx, _ry ) / 2.0;
            _mx = _lx + lengthdir_x( _dis, _dir );
            _my = _ly + lengthdir_y( _dis, _dir );
            _minst = collision_line( _lx, _ly, _mx, _my, _obj, _prec, _notme );
            
            if ( _minst != noone ) 
            {
                _inst = _minst;
                _rx = _mx;
                _ry = _my;
            } 
            else 
            {
                _lx = _mx;
                _ly = _my;
            };
        };
		if ( _minst != noone )
		{
			
		}
    };
    
    return
    {
        id: _inst,
        x: _rx,
        y: _ry
    };
};
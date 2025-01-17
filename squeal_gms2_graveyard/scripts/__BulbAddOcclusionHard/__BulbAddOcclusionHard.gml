function __BulbAddOcclusionHard(_vbuff)
{
    //Set up basic transforms to turn relative coordinates in arr_shadowGeometry[] into world-space coordinates
    var _sin = dsin(angle);
    var _cos = dcos(angle);
    
    var _xSin = xscale*_sin;
    var _xCos = xscale*_cos;
    var _ySin = yscale*_sin;
    var _yCos = yscale*_cos;
    
    //Loop through every line segment, remembering that we're storing coordinate data sequentially: { Ax1, Ay1, Bx1, Bx1,   Ax2, Ay2, Bx2, Bx2, ... }
    var _edgeArray = __edgeArray;
    var _i = 0;
    repeat(array_length(_edgeArray) div __BULB_ARRAY_EDGE_SIZE)
    {
        //Collect coordinates
        var _oldAx = _edgeArray[_i++];
        var _oldAy = _edgeArray[_i++];
        var _oldBx = _edgeArray[_i++];
        var _oldBy = _edgeArray[_i++];
        var _oldCx = _edgeArray[_i++];
        var _oldCy = _edgeArray[_i++];
        var _oldDx = _edgeArray[_i++];
        var _oldDy = _edgeArray[_i++];
        
        //...and transform
        var _newAx = x + _oldAx*_xCos + _oldAy*_ySin;
        var _newAy = y - _oldAx*_xSin + _oldAy*_yCos;
        var _newBx = x + _oldBx*_xCos + _oldBy*_ySin;
        var _newBy = y - _oldBx*_xSin + _oldBy*_yCos;
        var _newCx = x + _oldCx*_xCos + _oldCy*_ySin;
        var _newCy = y - _oldCx*_xSin + _oldCy*_yCos;
        var _newDx = x + _oldDx*_xCos + _oldDy*_ySin;
        var _newDy = y - _oldDx*_xSin + _oldDy*_yCos;
        
        //Add to the vertex buffer
        vertex_position_3d(_vbuff,   _newAx, _newAy, 0); vertex_float4(_vbuff,   _newCx, _newCy, _newDx, _newDy);
        vertex_position_3d(_vbuff,   _newBx, _newBy, 1); vertex_float4(_vbuff,   _newCx, _newCy, _newDx, _newDy);
        vertex_position_3d(_vbuff,   _newBx, _newBy, 0); vertex_float4(_vbuff,   _newCx, _newCy, _newDx, _newDy);
        
        vertex_position_3d(_vbuff,   _newAx, _newAy, 0); vertex_float4(_vbuff,   _newCx, _newCy, _newDx, _newDy);
        vertex_position_3d(_vbuff,   _newAx, _newAy, 1); vertex_float4(_vbuff,   _newCx, _newCy, _newDx, _newDy);
        vertex_position_3d(_vbuff,   _newBx, _newBy, 1); vertex_float4(_vbuff,   _newCx, _newCy, _newDx, _newDy);
    }
}
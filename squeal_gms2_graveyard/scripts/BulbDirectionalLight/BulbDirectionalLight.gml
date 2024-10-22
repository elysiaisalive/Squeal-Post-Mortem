/// @param renderer
/// @param angle

function BulbDirectionalLight(_renderer, _angle) constructor
{
    visible = true;
    
    angle = _angle;
    blend = c_white;
    alpha = 1.0;
    
    penumbraSize = 0.0;
    
    __oldSprite = undefined;
    __radius    = 0;
    __destroyed = false;
    
    static Destroy = function()
    {
        __destroyed = true;
    }
    
    static AddToRenderer = function(_renderer)
    {
        if (__destroyed) return;
        array_push(_renderer.__directionalLightArray, weak_ref_create(self));
    }
    
    static RemoveFromRenderer = function(_renderer)
    {
        var _array = _renderer.__directionalLightArray;
        var _i = array_length(_array) - 1;
        repeat(array_length(_array))
        {
            var _weak = _array[_i];
            if (weak_ref_alive(_weak))
            {
                if (_weak.ref == self) array_delete(_array, _i, 1);
            }
            else
            {
                array_delete(_array, _i, 1);
            }
            
            --_i;
        }
    }
    
    if (_renderer != undefined) AddToRenderer(_renderer);
}
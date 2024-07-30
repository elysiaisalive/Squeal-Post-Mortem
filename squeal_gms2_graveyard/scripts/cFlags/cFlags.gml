function cFlags( _flags = 0 ) class {
	flags = _flags;
	
	#region Get
	static GetFlag = function( _flag ) {
		return ( flags & _flag );
	}
	static GetFlags = function() {
		return flags;
	}
	#endregion
	#region Set
	static SetFlag = function( _flags = 0, _active = true ) {
		if ( _active ) {
			flags |= _flags;
		}
		else {
			flags &= ~_flags;
		}
		return self;
	}
	static SetFlags = function( _flags = 0 ) {
		flags = _flags;
		return self;
	}
	#endregion
	
	static RemoveFlag = function( _flag ) {
		flags &= ~_flag;
	}
	
	static HasFlag = function( _flags = 0 ) {
		return bool( flags & _flags );
	}
	
	return self;
};
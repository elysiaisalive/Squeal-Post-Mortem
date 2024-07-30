function globalflags_set( _flags ) {
    globFlags = _flags;
}

function globalflags_add( _flag ) {
    globFlags |= _flag;
}

function globalflags_get( _flag ) {
    return globFlags & _flag;
}

function globalflags_is_set( _flag ) {
    if ( !globFlags & ~_flag ) {
        return false;
    }
    else {
        return true;
    }
}

function globalflags_clearflag( _flag ) {
    globFlags &= ~_flag;
}

function globalflags_clearflags() {
    print( "Clearing all global flags" );
    globFlags = 0;
}
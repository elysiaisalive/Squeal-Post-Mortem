/* 
    Prompt Data Class.
*/
function cPrompt() class {
    /* 
        lines <- The dialogue for the prompt.
        
        example :
        
        promptData = new cPrompt()
        .AddLine( "This is some text." )
        .AddLine( "Read more?", true, { 
            hasOption : true 
            callbackOnConfirm : function() { AddItem( item ); } 
        } )
    */
    __lines = [];
    
    /// @param {string}
    /// @param {struct} config
    static AddLine = function( text, _config = {} ) {
        _config[$ "hasOption"] = false;
        _config[$ "callbackOnConfirm"] = function(){};
        _config[$ "callbackOnDeny"] = function(){};
        
        var _promptData = {
            text : "",
            flags : _config.flags,
            hasOption : _config.hasOption,
            callbackOnConfirm : _config.callbackOnConfirm,
            callbackOnDeny : _config.callbackOnDeny,
        };
        
        array_push( _promptData.text, text );
        array_push( __lines, _promptData );
        
        return self;
    }
    static GetLines = function() {
        return __lines;
    }
    
    return self;
}
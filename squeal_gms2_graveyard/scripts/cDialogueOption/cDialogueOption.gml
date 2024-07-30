function cDialogueOption() class {
    /* 
    optionString -> The name of the option when displaying
    dialogueString -> The dialogue branch associated with the Option
    action -> Function that is run when the option is selected
    */
    optionString = "";
    dialogueString = "";
    action = -1;
    
    static SetOptionString = function( option = "" ) {
        if ( !is_string( option ) ) {
            return;
        }
        
        optionString = option;
        return self;
    }    
    static SetDialogueString = function( text = "" ) {
        if ( !is_string( text ) ) {
            return;
        }
        
        dialogueString = text;
        return self;
    }
}
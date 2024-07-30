/// @self {cGUI|cUIInventoryNotes}
function cUIInventoryNotes() extends cGUI() class {
    currentNote = 0;
    enabled = false;
    
    static Cancel = function() {
        enabled = false;
        
        return self;
    }
}
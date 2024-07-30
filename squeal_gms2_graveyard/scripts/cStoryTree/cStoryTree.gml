/* 
    The story tree class. This is responsible for holding ALL of the data regarding Dialogue and Dialogue Prompts, as well as their branches
    and self-contained options.
*/
function cStoryTree() class {
    enum ERROR {
        INVALID_NODE = -99
    }
    
    nodes = {};
    currentNode = ERROR.INVALID_NODE;
    
    static AddNode = function() {
        return self;
    }
}
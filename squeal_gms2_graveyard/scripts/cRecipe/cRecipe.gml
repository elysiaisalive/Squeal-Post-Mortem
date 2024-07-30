/// @desc This is the class for recipes that are crafted or occur in the inventory, like for example when combining items.
function cRecipe() constructor {
    label = "";
    craftTime = 0;
    ingredients = [];
    resultItem = {};
    
    /* 
        Ingredients data structure :
        
        ingredients [
            // ingredient[i][0] <- Accessing each ingredient
            // ingredient[i][0] <- Accessing ingredient amount for recipe
            ingredient1[struct, amount]
        
        ]
    */
    
    static GetIngredientAmount = function( item_key ) {
        if ( !is_string( item_key ) ) {
            // Error, arg needs to be a struct name
            return;
        }
        
        var _amount = 0;
        
        for( var i = 0; i < array_length( self.ingredients ); ++i ) {
            if ( ingredients[i][0].itemName == item_key ) {
                _amount = ingredients[i][1];
            }
        }
        
        return _amount;
    }
    
    /// @param {struct} item
    /// @param {number:int} amount
    static AddIngredient = function( item, _amount = 1 ) {
        if ( !is_instanceof( item, cItem ) ) {
            show_error( "Ingredients cannot be non-items", true );
        }
 
        array_push( self.ingredients, undefined );
        
        for( var i = 0; i < array_length( self.ingredients ); ++i ) {
            ingredients[i][0] = item;
            ingredients[i][1] = _amount;
        }
        
        return self;
    }
    
    /// @param {struct} result_item
    /// @param {number:int} amount
    static SetResult = function( result_item, _amount = 1 ) {
        if ( !is_instanceof( result_item, cItem ) ) {
            show_error( "Recipe cannot produce a non-item!", true );
            return;
        }
        
        self.resultItem = result_item;
        self.resultItem.stackSize = _amount;
        
        return self;
    }
    
    /// @desc Crafts the item with an input of array items and returns the recipe result if success
    /// @param {struct} output_inventory The inventory that items will be taken from and produced to
    /// @param {array} input_items
    static Craft = function( input_items, output_inventory ) {
        if ( !is_struct( output_inventory )
        || !is_instanceof( output_inventory, cInventory ) ) {
            show_error( "Inventory must be a valid inventory class instance!", true );
        }
        
        var _inventory = output_inventory;
    }
    
    return self;
}

function TestIngredient() {
    recipe = new cRecipe()
    .AddIngredient( new cItem(), 6 )
    .SetResult( new cItemPistolAmmo(), 32 );
    
    print( "Crafted New Item ", recipe.Craft( [new cItem(), new cItem()], global.test ) );
    
    print( "Item Amount : ", recipe.GetIngredientAmount( "Item" ) );
    print( recipe.resultItem );
}
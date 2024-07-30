/// @desc Spawner class. Can spawn any object in the game with certain properties or flags etc etc.
function cSpawner() extends cWorldObject() class {
    #region Inherited Properties
    self.entityName = "spawner";
    #endregion
    
    self.initObject = noone;
    self.triggerName = "trigger";
    self.spawnTargetName = "";
    self.spawnAmount = 1;
    self.active = false;
    self.ignoreSpawnTimer = true;
    self.spawnTime = 0;
    self.spawnTimer = new cTimer( 0 );
    
    static Tick = function() {
        if ( self.active ) {
            self.spawnTimer.Tick();
            
            if ( !self.ignoreSpawnTimer ) {
                if ( self.spawnTimer.GetTime() <= 0 ) {
                    Spawn();
                }
            }
            else {
                Spawn();
            }
        }
    };
	
    static Spawn = function() {
        var assetName = asset_get_index( self.spawnTargetName );
        var spawnedAmount = 0;
		
        if ( assetName != -1 ) {
            repeat( self.spawnAmount ) {
                instance_create_depth( initObject.x, initObject.y, initObject.depth, assetName );
				++spawnedAmount;
            }
			
			if ( self.spawnAmount == spawnedAmount ) {
				instance_destroy( initObject );
			}
        }
    }
    
    return self;
}
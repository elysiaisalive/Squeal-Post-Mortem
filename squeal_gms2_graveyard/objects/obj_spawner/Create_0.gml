spawner = new cSpawner();
spawner.initObject = self.id;
spawner.triggerName = triggerName;
spawner.spawnAmount = spawnAmount;
spawner.spawnTimer.SetNewTime( spawnTime );
spawner.spawnTargetName = spawnTargetName;
spawner.ignoreSpawnTimer = ignoreSpawnTimer;

// Activate this spawner when the trigger Event is recieved.
eventhandler_subscribe( self.id, spawner.triggerName, method( self.id, function() {
	spawner.active = true;
} ) );
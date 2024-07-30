global.currentLevel = -1;
global.levels = {};
global.levels.zoo = new cLevel()
.SetName( "zoo" )
.AddRoom( rm_zoo );

global.levels.prologue = new cLevel()
.SetName( "prologue" )
.AddRoom( c0m0lobby )
.AddRoom( c0m0interrogation )
.AddRoom( c0m0interrogationcorridor )
.AddRoom( c0m0chief )
.AddRoom( c0m0range )
.AddRoom( c0m0armoury )
.AddRoom( c0m0eastjunction )
.AddRoom( c0m0training );

global.levels.factory = new cLevel()
.SetName( "factory" )
.AddState( "generatorActive", false )
.AddRoom( c1m2r1 );

global.currentLevel = global.levels.zoo;
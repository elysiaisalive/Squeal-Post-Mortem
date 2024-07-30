function init_levellist()
{	
	//global.level.lvl_squeal	= new init_level( [[rm_test_f1, false], [rm_test_f2, false], [rm_test_f3, false]] );
	switch( room )
	{
		case rm_prologue_killhouse_f1 :
			global.stage.current = new init_level( "KillHouse", [[]], false, 0, 0, 0 );
			break;
	};
};
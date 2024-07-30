initSystem();
initGUI();
initConfig();

window_set_cursor( cr_none );

mapTest = new cMapDraw();

musicPlayer = new cMusicPlayer();
// lockPick = new cLockpickMinigame();

valueTest = "12523,57";
valueSplit = string_split( valueTest, "," );
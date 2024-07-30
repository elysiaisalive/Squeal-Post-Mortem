function scr_loadprogress(){

// Loading / Overwriting the settings file
if file_exists(APPDATA_PATH + "\\Saves\\Savegame.sav") {
}

// Writing to the file
	ini_open(APPDATA_PATH + "\\Saves\\Savegame.sav")
	show_debug_message("Saving Progress")

// Write the options to the file

// Statistics
global.stats.HighestCombo = ini_read_real("Statistics", "Highest Combo", global.stats.HighestCombo)
global.stats.TotalBloodLost = ini_read_real("Statistics", "Blood Lost", global.stats.TotalBloodLost)
ini_close();
show_debug_message("Progress Loaded")
}
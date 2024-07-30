function scr_saveprogress(){

// Overwriting save file
if !directory_exists(APPDATA_PATH + "\\Saves\\") {
	directory_create(APPDATA_PATH + "\\Saves\\")
}

// If the save file exists, delete it
if file_exists(APPDATA_PATH + "\\Saves\\Savegame.sav")
	file_delete(APPDATA_PATH + "\\Saves\\Savegame.sav")

// Create new save file
ini_open(APPDATA_PATH + "\\Saves\\Savegame.sav")

// Write the options to the file

// Statistics
ini_write_real("Statistics", "Highest Combo", global.stats.HighestCombo)
ini_write_real("Statistics", "Blood Lost", global.stats.TotalBloodLost)
ini_close();
show_debug_message("Progress Saved")
obj_control.saving = true;
}
/* 
    The class for all the USER statistics to be tracked throughout the game.
    This Includes stuff like story-progression.
*/
function cPlayerStats() class {
    #region General Statistics
    #region Time
    // These stats will be updated once the USER saves their progress.
    totalPlaytime = 0; // Total playtime spent overrall.
    totalActivePlaytime = 0; // Total playtime spent INGAME, not in pause or other menus.
    secondsPlayed = 0;
    minutesPlayed = 0;
    hoursPlayed = 0;
    daysPlayed = 0;
    #endregion
    #region Combat
    hasTakenAnyDamage = false;
    hasKilledAnyEnemies = false;
    enemiesKilled = 0;
    bossesKilled = 0;
    bulletsFired = 0;
    grenadesThrown = 0;
    deathCount = 0;
    enemiesShoved = 0;
    
    // Hardmode
    bloodLost = 0;
    #endregion
    #region Item
    hpItemsUsed = 0;
    bandagesUsed = 0;
    morphineUsed = 0;
    medkitsUsed = 0;
    
    weaponsFound = 0;
    weaponUpgradesFound = 0;
    
    itemsFound = 0;
    itemsDropped = 0;
    
    // Hardmode
    saveSlipsUsed = 0;
    overdoses = 0;
    #endregion
    #region World
    doorsUnlocked = 0;
    secretsFound = 0;
    timesSaved = 0;
    distanceWalked = 0;
    timesVaulted = 0;
    #endregion
    #endregion
    #region Story Specific
    #endregion
    
    static Serialize = function() {
        
    }
    static Deserialize = function() {
        
    }
}
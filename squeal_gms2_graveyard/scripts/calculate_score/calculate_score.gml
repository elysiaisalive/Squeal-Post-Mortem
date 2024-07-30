/// @desc Adds score to the global.score struct
function add_score( points_scored, combo ) 
{
	global.score.total_score += points_scored;

	global.score.combo += combo;
};

// @desc Calculates the final letter grade of a level based on the scores
function calculate_grades() 
{
    // Checking if there is currently a level active/loaded
    if ( global.level )
    {
        // Instant S Grade if full combo is reached
        if ( global.score.combo == global.level.lvl.max_combo )
        {
            global.score.score_grade = 6;
        };
    };
};

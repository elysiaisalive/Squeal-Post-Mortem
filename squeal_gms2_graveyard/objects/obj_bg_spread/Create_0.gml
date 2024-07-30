splotches = [];

/* 



*/
splotch = 
{
	sprite		: 0,
	_x			: 0,
	_y			: 0,
	index		: 0,
	rotation	: 0,
	scale		: 0,
	life		: 0,
	animspd		: 0
}

// Create array of splotches with the vars from the struct
for(var i = 0; i < obj_bg_color.splotch_amnt; ++i)
{
	array_push(splotches, splotch);
}
// Set random messages
randomize();

random_msg = [
	"PIPAS",
	"😀🖕",
	"Hello World!",
	"You're gonna go far kid.",
	"Now on Blu - ray!",
	"Juicing since 2021",
	"The Mad Doctor is in.",
	"REBIRTH PROTOCOL ACTIVE",
	"I don't give a flying fuck!",
	"You should kill yourself, NOW.",
	"You're a fucking Bosnian.",
	"Why? Because I'm CRAAAAAAAZY!",
	"The creamers were here",
	"farting so hard",
	"Chicken Smell Assessment : he STINKS.",
	"https://cdn.discordapp.com/attachments/807020823444717599/925435122457649232/IMG_20211225_122539.jpg",
	"This ones for you, Scorpius",
	"chINKEN :DDD>gva",
	"Lemony Snicket!",
	"This mod was made possible thanks to objDripper"
	];

window_set_caption( "Squeal 2" + " - " + random_msg[random( array_length( random_msg ) ) - 1] )

// Splashscreen timer
splash_timer = 60 * 2;
splash_alpha = 0;
//window_set_fullscreen( true );

// Splashscreen mode
skip = false;
done = false;
splash_screen = 0;

// Dennaton
animate = 0;

debug = false;

// PC Vars
pc_on = false;
pc_timer = 600;
pc_timermax = 600;
looptime = 980;
looptimemax = 980;
// -*- compile-command: "sudo make install"; -*-
//* See LICENSE file for copyright and license details. */
/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Roboto Mono:size=11" };
static const char dmenufont[]       = "Roboto Mono:size=11";

/* static const char color1[]       = "#0b0956"; // background of bar and border of unfocused window */
/* static const char color2[]       = "#4b0956"; // background of current tag and window name */
/* static const char color3[]       = "#8f0956"; // Window border focused window */
/* static const char color4[]       = "#a9ff6c"; // Font for Selected tag and window name */
/* static const char color5[]       = "#a9c36c"; // Font for tags and status */

// Old rice putin
static const char color1[]       = "#1f1d1b";
static const char color2[]       = "#181512";
static const char color3[]       = "#A3535E";
static const char color4[]       = "#C94539";
static const char color5[]       = "#DAB733";

/* static const char color1[]       = "#3D405B"; */
/* static const char color2[]       = "#81B29A"; */
/* static const char color3[]       = "#e74c3c"; */
/* static const char color4[]       = "#F4F1DE"; */
/* static const char color5[]       = "#E07A5F"; */

static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { color5, color1, color1 },
	[SchemeSel]  = { color4, color2, color3 },
	// bar font . bar background status and unselectd tags . border of unfocused window
	// bar font selected tag and name of window . bar background for selected tag and window info . focused window border
};

/* tagging */
static const char *tags[] = {"Term", "Doom", "wWw", "Discord", "Godot", "6", "7", "8", "9"};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Emacs",     NULL,     "Todos",     0,            1,           -1 },
	{ "Emacs",     NULL,     "Scratch",   0,            1,           -1 },
	{ "Emacs",     NULL,     "Agenda",    0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       4,            0,           -1 },
	//{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[Tl]",      tile },    /* first entry is default */
	{ "[Floating]",     NULL },    /* no layout function means floating behavior */
	{ "[Monocle]",      monocle },
};

/* key definitions */
//#define MODKEY Mod1Mask
#define MODKEY Mod4Mask
#define MOD2KEY Mod1Mask

#define TAGKEYS(CHAIN,KEY,TAG) \
	{ MODKEY,                       CHAIN,    KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           CHAIN,    KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             CHAIN,    KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, CHAIN,    KEY,      toggletag,      {.ui = 1 << TAG} }, \
	//{ MOD2KEY|ShiftMask,            CHAIN,    KEY,      toggletag,      {.i = +1, .ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", color1, "-nf", color3, "-sb", color5, "-sf", color4, NULL };
static const char *termcmd[]  = { "alacritty", NULL };

static Key keys[] = {
//	modifier                     chain key   key        function        argument
//	Opening programs
	{ MODKEY,                       -1,         XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       -1,         XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_o,       XK_m,      spawn,          SHCMD("emacsclient -c -a 'emacs'") },
	{ MODKEY,                       -1,         XK_s,      spawn,          SHCMD("emacsclient -n -e '(yequake-toggle \"Scratch\")'") },
	{ MODKEY,                       -1,         XK_t,      spawn,          SHCMD("emacsclient -n -e '(yequake-toggle \"Todos\")'") },
	{ MODKEY,                       -1,         XK_a,      spawn,          SHCMD("emacsclient -n -e '(yequake-toggle \"Agenda\")'") },
	{ MODKEY,                       XK_o,       XK_r,      spawn,          SHCMD("emacsclient -c -a 'emacs' --eval '(ranger)'") },
	{ MODKEY,                       XK_o,       XK_b,      spawn,          SHCMD("firefox") },
	{ MODKEY,                       XK_o,       XK_d,      spawn,          SHCMD("discord") },
	{ MODKEY,                       -1,         XK_space,  spawn,          SHCMD("~/Documents/scripts/change_layout.sh") },
	{ MODKEY|ShiftMask,             -1,         XK_s,      spawn,          SHCMD("flameshot gui") },

    // Layout/Window movement and manipulation
	//{ MODKEY,                       -1,         XK_b,      togglebar,      {0} },
	{ MODKEY,                       -1,         XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       -1,         XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       -1,         XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       -1,         XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       -1,         XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       -1,         XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             -1,         XK_Return, zoom,           {0} },
	{ MOD2KEY,                       -1,         XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             -1,         XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_l,         XK_t,      setlayout,      {.v = &layouts[0]} }, // tiling
	{ MODKEY,                       XK_l,         XK_f,      setlayout,      {.v = &layouts[2]} }, //Monocle
	{ MODKEY,                       XK_l,         XK_m,      setlayout,      {.v = &layouts[1]} }, //Float
	{ MODKEY,                       XK_l,         XK_space,  setlayout,      {0} },
	//{ MODKEY|ShiftMask,             -1,         XK_space,  togglefloating, {0} },

    // Screen movement and manipulation
	{ MODKEY,                       -1,         XK_e,      focusmon,       {.i = -1 } },
	{ MODKEY,                       -1,         XK_q,      focusmon,       {.i = +1 } },
	{ MODKEY,                       -1,         XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       -1,         XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             -1,         XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             -1,         XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             -1,         XK_e,      tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             -1,         XK_q,      tagmon,         {.i = +1 } },

    // Tag movement and manipulation
	{ MODKEY,                       -1,         XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             -1,         XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_d,       XK_h,      viewtoleft,     {0} },
	{ MODKEY,                       XK_d,       XK_l,      viewtoright,    {0} },
	{ MODKEY,                       XK_d,       XK_j,      tagtoleft,      {0} },
	{ MODKEY,                       XK_d,       XK_k,      tagtoright,     {0} },
	TAGKEYS(                        XK_w,       XK_h,                      4)
	TAGKEYS(                        XK_w,       XK_j,                      0)
	TAGKEYS(                        XK_w,       XK_k,                      1)
	TAGKEYS(                        XK_w,       XK_l,                      2)
	TAGKEYS(                        XK_w,       XK_u,                      3)
	TAGKEYS(                        XK_w,       XK_i,                      4)
	TAGKEYS(                        XK_w,       XK_o,                      5)
	TAGKEYS(                        XK_w,       XK_n,                      6)
	TAGKEYS(                        XK_w,       XK_m,                      7)
	TAGKEYS(                        -1,         XK_1,                      0)
	TAGKEYS(                        -1,         XK_2,                      1)
	TAGKEYS(                        -1,         XK_3,                      2)
	TAGKEYS(                        -1,         XK_4,                      3)
	TAGKEYS(                        -1,         XK_5,                      4)
	TAGKEYS(                        -1,         XK_6,                      5)
	TAGKEYS(                        -1,         XK_7,                      6)
	TAGKEYS(                        -1,         XK_8,                      7)
	TAGKEYS(                        -1,         XK_9,                      8)

	// Misc
	{ MODKEY|ShiftMask,             -1,         XK_q,      quit,           {0} },
	{ MODKEY|ControlMask|ShiftMask, -1,         XK_q,      quit,           {1} },
};


/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

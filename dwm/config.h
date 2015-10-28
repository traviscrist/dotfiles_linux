/* See LICENSE file for copyright and license details. */

#define NUMCOLORS         13
static const char colors[NUMCOLORS][ColLast][8] = {
  // border      foreground   background
  { "#444444",   "#bbbbbb",   "#111111" },  // normal
  { "#888888",   "#ffffff",   "#444444" },  // selected

  { "#000000",   "#@dcyan@",   "#111111" },  
  { "#000000",   "#@lgreen@",   "#111111" },  
  { "#000000",   "#@lred@",   "#111111" },  
  { "#000000",   "#@dpurple@",   "#111111" },  
  { "#000000",   "#@dyellow@",   "#111111" },  
  { "#000000",   "#@dred@",   "#111111" },  
  { "#000000",   "#@lpurple@",   "#111111" },  
  { "#000000",   "#@lyellow@",   "#111111" },  
  { "#000000",   "#@lcyan@",   "#111111" },  
  { "#000000",   "#@dred@",   "#111111" },  
  { "#000000",   "#@dpurple@",   "#111111" },   

  { "#000000",   "#@dcyan@",   "#222222" },  
  { "#000000",   "#@lgreen@",   "#222222" },  
  { "#000000",   "#@lred@",   "#222222" },  
  { "#000000",   "#@dpurple@",   "#222222" },  
  { "#000000",   "#@dyellow@",   "#222222" },  
  { "#000000",   "#@dred@",   "#222222" },  
  { "#000000",   "#@lpurple@",   "#222222" },  
  { "#000000",   "#@lyellow@",   "#222222" },  
  { "#000000",   "#@lcyan@",   "#222222" },  
  { "#000000",   "#@dred@",   "#222222" },  
  { "#000000",   "#@dpurple@",   "#222222" }   
};

/* appearance */
static const char font[]            = "-*-stlarch-medium-r-*-*-10-*-*-*-*-*-*-*" "," "-*-dina-medium-r-normal-*-10-*-*-*-*-*-*-*";
static const char normbordercolor[] = "#111111";
static const char normbgcolor[]     = "#111111";
static const char normfgcolor[]     = "#bbbbbb";
static const char selbordercolor[]  = "#444444";
static const char selbgcolor[]      = "#444444";
static const char selfgcolor[]      = "#eeeeee";
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int snap      = 16;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = {
  " \xee\x85\x8a ", " \xee\x85\x8b ", " \xee\x83\x84 ",
  " \xee\x84\xb3 ", " \xee\x86\x9f ", " \xee\x81\x8d ",
  "   "
};

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "MPlayer",  NULL,       NULL,       0,            True,        -1 },
	{ "Gimp",     NULL,       NULL,       0,            True,        -1 },
	{ "Firefox",  NULL,       NULL,       0,       	    False,       -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ " \xee\x80\x82   ",      tile },    /* first entry is default */
	{ " \xee\x82\xb1   ",      NULL },    /* no layout function means floating behavior */
	{ " \xee\x80\x80 0 ",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/bash", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
/*static const char *termcmd[]  = { "termite", NULL };*/
static const char *termcmd[]  = { "urxvt", NULL };

static const char *MY_quitcmd[]     = { "killall", "startdwm", NULL };
static const char *MY_dissmisscmd[] = { "pkill", "dzen2", NULL };

static const char *MY_sleepcmd[] = { "/home/ben/Documents/dotfiles/scripts/sleep.sh", NULL };
static const char *MY_redshiftcmd[] = { "/home/ben/Documents/dotfiles/scripts/redshift.sh", NULL };

static const char *MY_touchpadcmd[] = { "/home/ben/Documents/dotfiles/scripts/touchpad_toggle", NULL };
static const char *MY_lockcmd[] = { "/home/ben/Documents/dotfiles/scripts/lock", NULL };

static const char *MY_nextcmd[] = { "mpc", "next", NULL };
static const char *MY_prevcmd[] = { "mpc", "prev", NULL };
static const char *MY_stopcmd[] = { "mpc", "toggle", NULL };

static const char *MY_vdowncmd[] = { "mpc", "volume", "-2", NULL };
static const char *MY_vupcmd[] = { "mpc", "volume", "+2", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	{ MODKEY|ShiftMask,         	XK_r,      quit,           {0} }, // only restarts dwm
	{ MODKEY|ShiftMask,             XK_q,      spawn,          {.v = MY_quitcmd} }, // kills all
	{ MODKEY|ShiftMask,		XK_p,	   MY_togglepadding,  {0} }, // toggle padding
	{ MODKEY,			XK_Left,   spawn,      	   {.v = MY_prevcmd} }, // toggle padding
	{ MODKEY,			XK_Right,  spawn,	   {.v = MY_nextcmd} }, // toggle padding
	{ MODKEY,			XK_Down,   spawn,	   {.v = MY_stopcmd} }, // toggle padding
	{ MODKEY,			XK_c,	   spawn, 	   {.v = MY_dissmisscmd} },
	{ MODKEY,			XK_Delete, spawn, 	   {.v = MY_sleepcmd} },
	{ MODKEY,			XK_r,      spawn, 	   {.v = MY_redshiftcmd} },
	{ MODKEY,			XK_c,      spawn, 	   {.v = MY_touchpadcmd} },
	{ MODKEY,			XK_Escape, spawn, 	   {.v = MY_lockcmd} },
  { MODKEY,     XK_9,      spawn,      {.v = MY_vdowncmd} },
  { MODKEY,     XK_0,      spawn,      {.v = MY_vupcmd} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
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


/* modifier 0 means no modifier */

#define PROG_NAME          "surf"

#define PROMPT_GO          "Saan pupunta:"
#define PROMPT_FIND        "Ano\'ng hahanapin:"
#define OUTPUT_DIR         "$HOME/Downloads/surf/"

#define CONFIG_DIR    "~/.config/surf"
#define CACHE_DIR     "~/.cache/surf"

static int surfuseragent    = 1;  /* Append Surf version to default WebKit user agent */
static char *fulluseragent  = ""; /* Or override the whole user agent string */
static char *scriptfile     = CONFIG_DIR "/script.js";
static char *styledir       = CONFIG_DIR "/styles/";
static char *bookmarkfile   = CONFIG_DIR "/bookmarks.tsv";
static char *certdir        = CACHE_DIR "/certificates/";
static char *cachedir       = CACHE_DIR "/cache/";
static char *cookiefile     = CACHE_DIR "/cookies.txt";

/* Webkit default features */
/* Highest priority value will be used.
 * Default parameters are priority 0
 * Per-uri parameters are priority 1
 * Command parameters are priority 2
 */
static Parameter defconfig[ParameterLast] = {
	/* parameter                    Arg value       priority */
	[AccessMicrophone]    =       { { .i = 0 },     },
	[AccessWebcam]        =       { { .i = 0 },     },
	[Certificate]         =       { { .i = 0 },     },
	[CaretBrowsing]       =       { { .i = 1 },     },
	[CookiePolicies]      =       { { .v = "@aA" }, },
	[DarkMode]            =       { { .i = 0 },     },
	[DefaultCharset]      =       { { .v = "UTF-8" }, },
	[DiskCache]           =       { { .i = 1 },     },
	[DNSPrefetch]         =       { { .i = 0 },     },
	[Ephemeral]           =       { { .i = 0 },     },
	[FileURLsCrossAccess] =       { { .i = 0 },     },
	[FontSize]            =       { { .i = 16 },    },
	[Geolocation]         =       { { .i = 0 },     },
	[HideBackground]      =       { { .i = 0 },     },
	[Inspector]           =       { { .i = 1 },     },
	[JavaScript]          =       { { .i = 1 },     },
	[KioskMode]           =       { { .i = 0 },     },
	[LoadImages]          =       { { .i = 1 },     },
	[MediaManualPlay]     =       { { .i = 1 },     },
	[PDFJSviewer]         =       { { .i = 1 },     },
	[PreferredLanguages]  =       { { .v = ((char *[]){ "en-US", "en", NULL }) }, },
	[RunInFullscreen]     =       { { .i = 0 },     },
	[ScrollBars]          =       { { .i = 0 },     },
	[ShowIndicators]      =       { { .i = 1 },     },
	[SiteQuirks]          =       { { .i = 1 },     },
	[SmoothScrolling]     =       { { .i = 1 },     },
	[SpellChecking]       =       { { .i = 0 },     },
	[SpellLanguages]      =       { { .v = ((char *[]){ "en_US", NULL }) }, },
	[StrictTLS]           =       { { .i = 1 },     },
	[Style]               =       { { .i = 1 },     },
	[WebGL]               =       { { .i = 0 },     },
	[ZoomLevel]           =       { { .f = 1.0 },   },
};

static UriParameters uriparams[] = {
	{ "(://|\\.)suckless\\.org(/|$)", {
	  [JavaScript] = { { .i = 0 }, 1 },
	}, },
};

/* default window size: width, height */
static int winsize[] = { 800, 600 };

static WebKitFindOptions findopts = WEBKIT_FIND_OPTIONS_CASE_INSENSITIVE |
                                    WEBKIT_FIND_OPTIONS_WRAP_AROUND;

#define GETPROP_HELPER(r) \
		 "xprop -id $1 " r " | " \
		 "sed -e 's/^" r "(UTF8_STRING) = \"\\(.*\\)\"/\\1/' " \
		 "      -e 's/\\\\\\(.\\)/\\1/g'"

/* SETPROP(readprop, setprop, prompt)*/
#define SETPROP(r, s, prompt) { \
        .v = (const char *[]){ "/bin/sh", "-c", \
			 "prop=$(" GETPROP_HELPER(r) ") && " \
             "prop=$(printf '%b' \"$prop\" | dmenu -p \"" prompt "\" -w \"$1\") && " \
             "xprop -id $1 -f " s " 8u -set " s " \"$prop\"", \
             "surf-setprop", winid, NULL \
        } \
}

#define GETPROP(r, cmd, proc) { \
		.v = (const char *[]) { "/bin/sh", "-c", \
			"url=$(" GETPROP_HELPER(r) ") && if [ -n \"$url\" ]; then " cmd "; "\
			" else " NOTIFY("critical", "Blank URL!") "; fi", \
			proc, winid, NULL \
		} \
}

#define NOTIFY(priority, msg) \
		"dunstify -r 7873 -u " priority " -t 5000 \"" PROG_NAME "\" \"" msg "\""

#define YANK_URL_TO_CLIPBOARD(sel) \
		GETPROP("_SURF_URI", \
				"echo \"$url\" | xclip -selection " sel " && " \
				NOTIFY("low", "Nakopya na ang URL sa " sel "."), \
				"surf-yank")

#define PLAY_URL_AS_VIDEO \
		GETPROP("_SURF_URI", \
				NOTIFY("low", "Ipe-play ang video mula sa \"$url\"...") " & " \
				"mpv --really-quiet \"$url\" && " \
				NOTIFY("low", "Isinara ang video player.") " || " \
				NOTIFY("critical", "Hindi mai-play ang video mula sa \"$url\"."), \
				"surf-video")

#define DOWNLOAD(u, r) { \
		.v = (const char *[]){ "/bin/sh", "-c", \
			NOTIFY("low", "Dina-download ang \"$4\"...") " && " \
			"(curl -fgLJO --create-dirs --output-dir \"" OUTPUT_DIR "\" " \
				"-A \"$1\" -b \"$2\" -c \"$2\" -e \"$3\" \"$4\" && " \
				NOTIFY("low", "Natapos i-download ang \"$4\".") " || " \
			NOTIFY("critical", "Hindi na-download ang \"$4\".") ") &", \
			"surf-download", useragent, cookiefile, r, u, NULL \
		} \
}

#define PLUMB(u) { \
        .v = (const char *[]){ "/bin/sh", "-c", \
             "xdg-open \"$0\"", u, NULL \
        } \
}

#define VIDEOPLAY(u) { \
		.v = (const char *[]) { "/bin/sh", "-c", \
			"mpv --really-quiet \"$0\"", u, NULL \
		} \
}

/* styles */
/*
 * The iteration will stop at the first match, beginning at the beginning of
 * the list.
 */
static SiteSpecific styles[] = {
	/* regexp               file in $styledir */
	{ ".*",                 "default.css" },
};

/* certificates */
/*
 * Provide custom certificate for urls
 */
static SiteSpecific certs[] = {
	/* regexp               file in $certdir */
	{ "://suckless\\.org/", "suckless.org.crt" },
};

#define MODKEY GDK_CONTROL_MASK

/* hotkeys */
/*
 * If you use anything else but MODKEY and GDK_SHIFT_MASK, don't forget to
 * edit the CLEANMASK() macro.
 */
static Key keys[] = {
	/* modifier              keyval          function    arg */
	{ MODKEY,                GDK_KEY_g,      spawn,      SETPROP("_SURF_URI", "_SURF_GO", PROMPT_GO) },
	{ MODKEY,                GDK_KEY_f,      spawn,      SETPROP("_SURF_FIND", "_SURF_FIND", PROMPT_FIND) },
	{ MODKEY,                GDK_KEY_slash,  spawn,      SETPROP("_SURF_FIND", "_SURF_FIND", PROMPT_FIND) },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_c,      spawn,      YANK_URL_TO_CLIPBOARD("clipboard") },
	
	{ 0,                     GDK_KEY_F1,     spawn,      PLAY_URL_AS_VIDEO },

	{ MODKEY,                GDK_KEY_c,      stop,       { 0 } },

	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_r,      reload,     { .i = 1 } },
	{ MODKEY,                GDK_KEY_r,      reload,     { .i = 0 } },

	{ MODKEY,                GDK_KEY_l,      navigate,   { .i = +1 } },
	{ MODKEY,                GDK_KEY_h,      navigate,   { .i = -1 } },

	/* vertical and horizontal scrolling, in viewport percentage */
	{ MODKEY,                GDK_KEY_j,      scrollv,    { .i = +10 } },
	{ MODKEY,                GDK_KEY_k,      scrollv,    { .i = -10 } },
	{ MODKEY,                GDK_KEY_i,      scrollh,    { .i = +10 } },
	{ MODKEY,                GDK_KEY_u,      scrollh,    { .i = -10 } },

	{ MODKEY,                GDK_KEY_bracketleft,  zoom,       { .i = -1 } },
	{ MODKEY,                GDK_KEY_bracketright,   zoom,       { .i = +1 } },
	{ MODKEY,                GDK_KEY_equal,  zoom,       { .i = 0  } },

	{ MODKEY,                GDK_KEY_p,      clipboard,  { .i = 1 } },
	{ MODKEY,                GDK_KEY_y,      clipboard,  { .i = 0 } },

	{ MODKEY,                GDK_KEY_n,      find,       { .i = +1 } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_n,      find,       { .i = -1 } },

	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_p,      print,      { 0 } },
	{ MODKEY,                GDK_KEY_t,      showcert,   { 0 } },

	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_a,      togglecookiepolicy, { 0 } },
	{ 0,                     GDK_KEY_F11,    togglefullscreen, { 0 } },
	{ 0,                     GDK_KEY_F12,    toggleinspector, { 0 } },

	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_v,      toggle,     { .i = CaretBrowsing } },
	//{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_g,      toggle,     { .i = Geolocation } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_s,      toggle,     { .i = JavaScript } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_i,      toggle,     { .i = LoadImages } },
	//{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_b,      toggle,     { .i = ScrollBars } },
	//{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_t,      toggle,     { .i = StrictTLS } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_m,      toggle,     { .i = Style } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_d,      toggle,     { .i = DarkMode } },
};

/* button definitions */
/* target can be OnDoc, OnLink, OnImg, OnMedia, OnEdit, OnBar, OnSel, OnAny */
static Button buttons[] = {
	/* target       event mask      button  function        argument        stop event */
	{ OnLink,       0,              2,      clicknewwindow, { .i = 0 },     1 },
	{ OnLink,       MODKEY,         2,      clicknewwindow, { .i = 1 },     1 },
	{ OnLink,       MODKEY,         1,      clicknewwindow, { .i = 1 },     1 },
	{ OnAny,        0,              8,      clicknavigate,  { .i = -1 },    1 },
	{ OnAny,        0,              9,      clicknavigate,  { .i = +1 },    1 },
	{ OnMedia,      MODKEY,         1,      clickexternplayer, { 0 },       1 },
};

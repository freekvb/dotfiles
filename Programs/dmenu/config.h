/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

/* appearance */
/* -b  option; if 0, dmenu appears at bottom */
static int topbar = 1;
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {"Terminus:pixelsize=14"};
/* -p  option; prompt to the left of input field */
static const char *prompt      = " >";
/* #include "/home/fvb/.cache/wal/colors-wal-dmenu.h" */
static const char *colors[SchemeLast][2] = {
/*                   fg         bg       */
	[SchemeNorm] = { "#c7c9cb", "#1f221c" },
    [SchemeSel] =  { "#1f221c", "#98876B" },
	[SchemeOut] =  { "#847C74", "#1f221c" },
};

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

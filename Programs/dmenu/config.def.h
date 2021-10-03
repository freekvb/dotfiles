/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

/* appearance */
/* -b  option; if 0, dmenu appears at bottom */
static int topbar = 1;
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {"Terminus:pixelsize=14", "JoyPixels:pixelsize=10"};
/* -p  option; prompt to the left of input field */
static const char *prompt      = " >";
#include "/home/fvb/.cache/wal/colors-wal-dmenu.h"
/* static const char *colors[SchemeLast][2] = { */
	/*               fg         bg       */
/*	[SchemeNorm] = { "#ebe5d9", "#1c1b1b" },
 *   [SchemeSel] = { "#ebe5d9", "#827E83" },
 *   [SchemeOut] = { "#1c1b1b", "#E4CEAB" },
 *};
 */
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

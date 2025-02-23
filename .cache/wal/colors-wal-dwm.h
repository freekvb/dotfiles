static const char norm_fg[] = "#e8e3de";
static const char norm_bg[] = "#0c0a0a";
static const char norm_border[] = "#a29e9b";

static const char sel_fg[] = "#7F8279";
static const char sel_bg[] = "#0c0a0a";
static const char sel_border[] = "#e8e3de";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
};

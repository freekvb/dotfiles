static const char norm_fg[] = "#c2c2c2";
static const char norm_bg[] = "#0d0d0d";
static const char norm_border[] = "#6a5757";

static const char sel_fg[] = "#6c6c6b";
static const char sel_bg[] = "#0d0d0d";
static const char sel_border[] = "#c2c2c2";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
};

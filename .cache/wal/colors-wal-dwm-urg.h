static const char norm_fg[] = "#c2c1c1";
static const char norm_bg[] = "#0c0a0a";
static const char norm_border[] = "#695656";

static const char sel_fg[] = "#c2c1c1";
static const char sel_bg[] = "#6b645a";
static const char sel_border[] = "#c2c1c1";

static const char urg_fg[] = "#c2c1c1";
static const char urg_bg[] = "#635b51";
static const char urg_border[] = "#635b51";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};

/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x0c0a0aff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc2c1c1ff, 0x0c0a0aff, 0x695656ff },
	[SchemeSel]  = { 0xc2c1c1ff, 0x6b645aff, 0x635b51ff },
	[SchemeUrg]  = { 0xc2c1c1ff, 0x635b51ff, 0x6b645aff },
};

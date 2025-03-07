/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x0d0d0dff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc2c2c2ff, 0x0d0d0dff, 0x6a5757ff },
	[SchemeSel]  = { 0xc2c2c2ff, 0x787875ff, 0x6c6c6bff },
	[SchemeUrg]  = { 0xc2c2c2ff, 0x6c6c6bff, 0x787875ff },
};

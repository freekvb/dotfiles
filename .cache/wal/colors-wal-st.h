const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0d0d0d", /* black   */
  [1] = "#6c6c6b", /* red     */
  [2] = "#787875", /* green   */
  [3] = "#848483", /* yellow  */
  [4] = "#90918d", /* blue    */
  [5] = "#a2a3a2", /* magenta */
  [6] = "#a7a8a5", /* cyan    */
  [7] = "#978c8c", /* white   */

  /* 8 bright colors */
  [8]  = "#6a5757",  /* black   */
  [9]  = "#91918F",  /* red     */
  [10] = "#A1A19D", /* green   */
  [11] = "#B1B1AF", /* yellow  */
  [12] = "#C1C2BD", /* blue    */
  [13] = "#D9DAD9", /* magenta */
  [14] = "#DFE0DC", /* cyan    */
  [15] = "#c2c2c2", /* white   */

  /* special colors */
  [256] = "#0d0d0d", /* background */
  [257] = "#c2c2c2", /* foreground */
  [258] = "#c2c2c2",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;

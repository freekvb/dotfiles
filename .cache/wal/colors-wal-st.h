const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0c0a0a", /* black   */
  [1] = "#635b51", /* red     */
  [2] = "#6b645a", /* green   */
  [3] = "#81786e", /* yellow  */
  [4] = "#948a7f", /* blue    */
  [5] = "#9e9389", /* magenta */
  [6] = "#a59d96", /* cyan    */
  [7] = "#968a8a", /* white   */

  /* 8 bright colors */
  [8]  = "#695656",  /* black   */
  [9]  = "#847A6C",  /* red     */
  [10] = "#8F8678", /* green   */
  [11] = "#ACA193", /* yellow  */
  [12] = "#C6B9AA", /* blue    */
  [13] = "#D3C5B7", /* magenta */
  [14] = "#DCD2C8", /* cyan    */
  [15] = "#c2c1c1", /* white   */

  /* special colors */
  [256] = "#0c0a0a", /* background */
  [257] = "#c2c1c1", /* foreground */
  [258] = "#c2c1c1",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;

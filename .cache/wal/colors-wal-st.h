const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0c0a0a", /* black   */
  [1] = "#7F8279", /* red     */
  [2] = "#8F8678", /* green   */
  [3] = "#ADA293", /* yellow  */
  [4] = "#C6B9AA", /* blue    */
  [5] = "#D3C5B8", /* magenta */
  [6] = "#DDD3C8", /* cyan    */
  [7] = "#e8e3de", /* white   */

  /* 8 bright colors */
  [8]  = "#a29e9b",  /* black   */
  [9]  = "#7F8279",  /* red     */
  [10] = "#8F8678", /* green   */
  [11] = "#ADA293", /* yellow  */
  [12] = "#C6B9AA", /* blue    */
  [13] = "#D3C5B8", /* magenta */
  [14] = "#DDD3C8", /* cyan    */
  [15] = "#e8e3de", /* white   */

  /* special colors */
  [256] = "#0c0a0a", /* background */
  [257] = "#e8e3de", /* foreground */
  [258] = "#e8e3de",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;

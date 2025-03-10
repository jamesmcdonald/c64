/* charmap.c
 * load character data and export as dasm data
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/errno.h>

struct row {
  unsigned char content[4];
  unsigned char bytes;
};

struct row decode_row(FILE *infile) {
  struct row output = {{0, 0, 0, 0}, 0};
  int i;
  char c;

  for (i = 31; i >= 0; i--) {
    int input = fgetc(infile);
    switch (input) {
    case EOF:
    case '\n':
      goto loop_exit;
    case '*':
      output.content[3 - i / 8] |= (1 << (i % 8));
      break;
    }
    if ((i + 1) % 8 == 0)
      output.bytes++;
  }
loop_exit:
#ifdef DEBUG
  printf("bytes: %d, content: %x %x %x %x\n", output.bytes, output.content[0],
         output.content[1], output.content[2], output.content[3]);
  return output;
#endif
  return output;
}

int main(int argc, char *argv[]) {
  if (argc != 2) {
    fprintf(stderr, "usage: %s <inputfile>\n", argv[0]);
    return 1;
  }
  FILE *f = fopen(argv[1], "r");
  if (f < 0) {
    fprintf(stderr, "failed to open file: %s\n", strerror(errno));
  }
  int finished = 0;
  for (int entity = 0; !finished; entity++) {
    int maxbytes = 0;
    struct row rows[8];
    for (int i = 0; i < 8; i++) {
      rows[i] = decode_row(f);
      if (rows[i].bytes > maxbytes)
        maxbytes = rows[i].bytes;
      int c = fgetc(f);
      switch (c) {
      case EOF:
        if (i != 7) {
          fprintf(stderr, "unexpected EOF\n");
          exit(1);
        }
        finished = 1;
        break;
      case '\n':
        break;
      default:
        ungetc(c, f);
      }
    }

    printf("; %d character entity\n", maxbytes);
    printf("charmap_%d:\n", entity);
    for (int i = 0; i < maxbytes; i++) {
      printf("    .byte");
      for (int j = 0; j < 8; j++) {
        printf(" $%02x%s", rows[j].content[i], j == 7 ? "" : ",");
      }
      printf("\n");
    }
  }
  return 0;
}

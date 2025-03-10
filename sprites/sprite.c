/* sprite.c
 * load sprite text data and export as BASIC data
 */

#include <stdio.h>
#include <string.h>
#include <sys/errno.h>

#define SIZE 21 * 3

unsigned char decode_byte(char input[8]) {
  unsigned char output = 0;
  int i;

  for (i = 0; i < 8; i++) {
    if (input[i] == '*') {
      output |= 1;
    }
    if (i < 7) {
      output <<= 1;
    }
  }
  return output;
}

void load(char data[SIZE * 8], unsigned char sprite[SIZE]) {
  int i, j;

  for (i = 0; i < 21; i++) {
    for (j = 0; j < 3; j++) {
      sprite[3 * i + j] = decode_byte(data + (3 * 8 * i + 8 * j));
    }
  }
}

int main() {
  unsigned char sprite[SIZE];

  char spritetext[21 * 24];
  FILE *f = fopen("smile-sprite.txt", "r");
  if (f < 0) {
    fprintf(stderr, "failed to open file: %s\n", strerror(errno));
  }
  for (int i = 0; i < 21 * 24; i++) {
    int c = fgetc(f);
    if (c == EOF) {
      fprintf(stderr, "short sprite: %d bytes read of %d\n", i, 21 * 24);
      return 1;
    }
    if (c == '\n' || c == '\r') {
      i--;
      continue;
    }
    spritetext[i] = c;
  }
  fclose(f);

  load(spritetext, sprite);

  int pos = 0;
  int line = 2000;
  while (pos < SIZE) {
    printf("%d data ", line);
    for (int i = 0; i < 9; i++) {
      printf("%u%s", sprite[pos + i], i < 8 ? ", " : "");
    }
    printf("\n");
    pos += 9;
    line += 10;
  }
}

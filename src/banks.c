#include <gb/gb.h>
#include <stdint.h>
#include <stdio.h>

uint8_t var_internal;  /* In internal RAM */
extern uint8_t array_0[128];  /* In external RAM bank 0 */
extern uint8_t array_1[128];  /* In external RAM bank 1 */

void main(void) {
  ENABLE_RAM;

  var_internal = 1;
  SWITCH_RAM(0);
  for (uint16_t i = 0; i < 128; i++) array_0[i] = i;
  SWITCH_RAM(1);
  for (uint16_t i = 0; i < 128; i++) array_1[i] = i;

  puts("Program Start...");
  printf("Var is %u\n", var_internal);
  SWITCH_RAM(0);
  printf("Array_0 is %u\n", array_0[5]);
  SWITCH_RAM(1);
  printf("Array_1 is %u\n", array_1[8]);
  puts("The End...");

  DISABLE_RAM;
}

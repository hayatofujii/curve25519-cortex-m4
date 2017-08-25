curve25519-cortex-m4
====================

This repository currently has a 256-bit multiplier modulo 2^256 - 38 optimized for ARM Cortex-M4-based processors (and above), useful to compute arithmetic over djb's Curve25519 (and birrationally equivalent curves).

To use it, compile as:

```sh
gcc _mul_coc_umaal_rdc.S -o _mul_coc_umaal_rdc.o
```

Include the `_fe_mul_coc_umaal_rdc.h` header in your code, link the ```_mul_coc_umaal_rdc.o``` object and call

```
_fe_mul_coc_umaal_rdc(fe_t result, fe_t operand_a, fe_t operand_b);
```

Performance
-----------
Running the multiplication routing on a Teensy 3.2 board equipped with an ARM Cortex-M4-based MK20DX256 controller from Freescale takes about __276__ CPU cycles.

Code tested was assembled using ```arm-none-eabi-gcc``` version ```5.4.1```.

Copyright 2017 LG Electronics and University of Campinas.
All Rights Reserved.

My playground for learning STM32 MCUs.

Setting up Eclipse:
* Install the GNU ARM Eclipse plugin: use
  http://gnuarmeclipse.sourceforge.net/updates as URL in Eclipse
* Install Mentor Sourcery CodeBench toolchain and add it to PATH
* Install the stlink tool from https://github.com/texane/stlink. OpenOCD is
  also a possibility, but the stlink tool is very easy to setup: just run it,
  no config is needed!
* In Eclipse, add new project using the Sourcery G++ toolchain. Remember the
  -mcpu setting and linker script.
* Setting up debugging in Eclipse:
  1) Create a new "External Tools Configurations -> Program" thing, point it to
  st-util binary, e.g. /usr/local/bin/st-util. Click Run to see that it works.
  2) Go to "Debug configurations" and create a new "GDB Hardware Debugging"
  profile. Select the "Standard GDB Hadware Debugging Launcher" in the lower
  right corner. In the debugger tab, set
  "arm-none-eabi-gdb" and port number 4242 (the default for st-util). The rest
  can be default.
  3) The last part is to create a launch group that combines the st-util tool
  and the GDB debug session into one single-click operation. Go to Debug
  Configurations and create a new Launch Group. Press the "Add" button and select
  "run" from the drop-down list to be able to select the st-util tool you
  created earlier. Press "OK" and then "Add" again. This time, select "debug"
  from the drop-down list to be able to select GDB Hardware Debugging. Press
  "OK" and "Debug".
* Debugging should now be a single-click operation!

Resources:
www.st.com/
http://www.bravegnu.org/gnu-eprog/ : awesome tutorial on using GNU toolchains for embedded (ARM) work


Build errors with STM32F0xx_StdPeriph_Driver library
----------------------------------------------------

If you get something like this

----
../Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_dac.c: In function 'DAC_DeInit':
../Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_dac.c:151:3: warning: implicit declaration of function 'RCC_APB1PeriphResetCmd' [-Wimplicit-function-declaration]
../Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_dac.c:151:26: error: 'RCC_APB1Periph_DAC' undeclared (first use in this function)
../Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_dac.c:151:26: note: each undeclared identifier is reported only once for each function it appears in
../Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_dac.c: In function 'DAC_Init':
../Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_dac.c:172:3: warning: implicit declaration of function 'assert_param' [-Wimplicit-function-declaration]
make: *** [Libraries/STM32F0xx_StdPeriph_Driver/src/stm32f0xx_dac.o] Error 1
----

you have forgotten to compile with `-DUSE_STDPERIPH_DRIVER`.

Based on http://www.triplespark.net/elec/pdev/arm/stm32.html

Run 'make install' to build and flash to target (STM32F0 Discovery board) with
arm-none-eabi-gdb (from Mentor Codebench Lite) and st-util from the stlink
repo: https://github.com/texane/stlink.git

In one terminal:
 $ st-util
 (automatically connects to the ST-LINK/V2 on the discovery board and waits for gdb connection)


In another terminal:

 $ arm-none-eabi-gdb main.elf -ex "tar ext :4242"
 (gdb) load
 (gdb) continue

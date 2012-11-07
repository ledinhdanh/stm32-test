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
  1) Create a new "External Tools Configurations" thing, point it to st-util
  binary, e.g. /usr/local/bin/st-util.
  2) Go to "Debug configurations" and create a new "GDB Hardware Debugging"
  profile. Select the "Standard GDB Hadware Debugging Launcher" in the lower
  right corner. In the debugger tab, set
  "arm-none-eabi-gdb" and port number 4242 (the default for st-util). The rest
  can be default.
  3) The last part is to create a launch group that combines the
  st-util tool and the GDB debug session into one single-click operation. Poke
  around in the launch group dialog until you figure out (via the drop-down
  list) how to get the tools into the launcher group.
* Debugging should now be a single-click operation!

Resources:
www.st.com/
http://www.bravegnu.org/gnu-eprog/ : awesome tutorial on using GNU toolchains for embedded (ARM) work

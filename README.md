# Low Cost BMS - STM32
This project is a rewrite of [low-cost-bms][1] for a new hardware platform based on the cheap and powerful STM32.
 A BMS, or battery management system, is an essential part of any multi battery Lithium battery pack (eg. LiFePO4).

The cell top modules atttach to the individual batteries in a large high powered array such as those in an electric car where they monitor the voltage and temperature and act to balance the individual battery with the rest in the pack.

This project aims to be backward compatible with the orignal [Low Cost BMS developed] on sourceforge.

### Installation
Clone the repo on command line:
```sh
$ git clone http://sourceforge.net/projects/low-cost-bms/
```
or with [Tortoise] from [https://github.com/spmp/Low-Cost-BMS-STM32][2]

## Hardware
The hardware is an artful design by Alan chapman, balancing the per module price with a robust micro controller and a stronly fail safe design. With horror stories of batteries and battery banks dying as result of faulty CTM's Alan has spared no effort in ensuring that the failsafe condition presented in hardware will leave your unnatended batteies alive and well!

#### Micro processor
The STM32 range of microprocessors was chosen as at this time there is a cheap and powerful development kit, the Nucleo, which pin compatible with arduino UNO enabling rapid prototyping and evaluation. 
The STM32 family are Arm cortex processors with highly versatile programmable peripherals, with the basic chip we are using costing less than $1!

## Software
Well, we are all learning new tricks for Arm on STM32.
We will be using:
- C as the primary programming language
- gcc toolchain
- bitbucket/mercurial for version control

# Getting started - IDE and workflow
It was suggested the we have a standard IDE for development, cross platform, GPL or similar license.. Sounded hard, but the defacto IDE for ARM chips meets all these criteria! 
I will attempt to outline the steps to get up and running with a 'Hello World' example, please note my experience is with GNU/Linux, yet I will try to make this as understandable for windows users. Please update with relevant experience!

###Download the tools
Essentially we are getting all the prerequesites for [GNU ARM Eclipse].

 - First we need the toolchain, [gcc-arm-none-eabi].  
  
    For windows users, download the wi32.exe or zip, extract and install.
    For linux users with apt (debian/ubuntu/etc) the command is:
    
    ``$ sudo apt-get install gcc-arm-none-eabi gdb-arm-none-eabi``
    
 - Now we need the [OpenOCD] the on chip JTAG interface.
     
    Windows users should download and install the binaries from [Here]
    
    Linux users do something like:
    
    ``$ sudo apt install openocd``
    
 - Finally we get [Eclipse] for C/C++ development - Windows and linux users should download the latest version off their website.

###Setup the hardware
Now we need to setup the hardware and check if [OpenOCD] connects to the device. Our target debug/JTAG platform is the [NUCLEO-F030R8].

 - Attach the Nucleo board to your computer via USB cable.
 - In linux (and no dount the same for windows) the command to start [OpenOCD] is:
  
   ``$ openocd -f interface/stlink-v2-1.cfg -f target/stm32f0x_stlink.cfg``
   
 - If all went well you will get a message like:
  
  ``Open On-Chip Debugger 0.8.0 (2014-10-25-15:24)
Licensed under GNU GPL v2
For bug reports, read
	http://openocd.sourceforge.net/doc/doxygen/bugs.html
Info : This adapter doesn't support configurable speed
Info : STLINK v2 JTAG v19 API v2 SWIM v2 VID 0x0483 PID 0x374B
Info : using stlink api v2
Info : Target voltage: 3.241497
Info : stm32f0x.cpu: hardware has 4 breakpoints, 2 watchpoints``

 - Well done, [OpenOCD] is running happily, leave it doing so 8)
 - In order to debug the processor on the circuit board you will need to make some minor modifications to the [NUCLEO-F030R8] as outlined in the Doc directory of this project (TODO - with the help of Alan)

###Setup Eclipse
Right, all we need to do now is setup [Eclipse].

 - Launche [Eclipse], it will prompt you for a _workspace_ directory, set it to wherever. Later on we may want to have our project in this workspace, or that workspace be in our project... we will see.
 - In [Eclipse], click on ``Help`` then ``Install New Software...```
 - Click ``Add``, and in the ``Name`` field put ``GNU ARM Eclipse Plug-ins`` (is arbitrary) and in the ``Location`` field paste ``http://gnuarmeclipse.sourceforge.net/updates``, click OK.
 - Ensure your newly added repo is selected with the dropdown, and when it is click the ``GNU ARM C/C++ Cross Development Tools`` then click next.
 - Press ``Yes`` and ``I agree`` to everything and restart [Eclipse] when it prompts you to.

###First "Hello World" project
 - In the newly restarted [Eclipse], click ``File``, ``New``, ``Project...``.
 - Expand ``C/C++`` and click on ``C Project``, then click ``Next``.
 - In ``Executable`` click on ``STM32F0XX C/C++ Project`` and fill in ``Project name`` and click ``Next``.
 - All the options in the next pane should be correct. Ensure that ``Content`` is ``Blinky (blink a led)`` and click ``Next``.
 - Click ``Next again and again.
 - In the ``Cross GNU ARM toolchain`` dialogue make sure the ``Toolchain name:`` is set to ``GNU Tools for ARM embedded Processors (arm-none-eabi-gcc)``. For the ``Toolchain path:`` click on browse and browse to the folder where you unpacked or installed [gcc-arm-none-eabi]. For GNU/Linux users who installed via ``apt`` the path will be ``/usr/bin``. Now click ``Finish``.
 - Click ''Yes'' to open the C/C++ perspective if prompted.
 - In the right most pane in ``Project Explorer`` expand your project (as named above) and expand ``include``. Double click on ``BlinkLed.h``.
 - We want to modify the ``LED definitions to give the correct port and pin of the LED. On the [NUCLEO-F030R8]  board the LED is on ``A5``, thus we change ``#define BLINK_PORT_NUMBER`` to (0) and ``#define BLINK_PIN_NUMBER`` to (5).
 - Now we compile and upload! Right click on the project name in ``Project Explorer`` and click ``Build project``

### Debug and upload
Now for the real power of this IDE, the JTAG debug and upload.
 - Right click on the project name in ``Project Explorer`` and click ``Begug as...`` then ``Debug Configurations...``.

 - Double lick on ``GDB OpenOCD Debugging``.
 - In the ``Debugger`` pane add a dummy option such as ``-f``  to the ``Config Options`` in ``OpenOCD Setup``, then unselet the ``Start OpenOCD locally`` box as we are running OpenOCD externally.
 - In the ``GDB Client Setup`` ensure that ``arm-none-eabi-gdb`` is the ``Executable``, you may need to browse to the path, especially in Windows.
 - Click ``Debug``, and answer ``Yes`` when prompet to open the ``Debug Perspective``.
 - In the Debug Perspective click on the ``Resume`` icon, and voilla! The light is blinking and you are debuggin! 

### Play
Now play with the code and the debugger until you are comfortable, then we will try it on the target board.


## Timeline/Milestones
- Peripheral setup with STM32Cube
- Hello world/blinky
- Serial interface
- Analoge input setup
- Fully test real hardware
- Iron out communication protocol
- Autonominity VS Master control PMI

## Todo's and notes to self
How do we share notes to each other that is not email? Lets try the issue tracker.

### Tools
- Getting and pushing the source:
 - [Tortoise HG]
 - Mercurial command line
 - Web 
- Editing MarkDown (This text file and others)
 - http://dillinger.io/
- For a unified cross platform IDE we could try Eclipse with STM32 plugin, see
 - https://www.youtube.com/watch?v=HKX12hJApZM
- Peripheral setup:
 - Windows: [STM32CubeMX] 
 - Linux: [STM32CubeMX with Java in Linux]

License
----

As close to GPL as we can! This will depend largely on the STM32 libraries used


**Free Software, Hell Yeah!**
[1]:http://sourceforge.net/projects/low-cost-bms/
[2]:https://github.com/spmp/Low-Cost-BMS-STM32
[Low Cost BMS developed]:http://sourceforge.net/projects/low-cost-bms/
[Tortoise HG]:http://tortoisehg.bitbucket.org/
[GNU ARM Eclipse]:http://gnuarmeclipse.livius.net/blog/toolchain-install/
[gcc-arm-none-eabi]:https://launchpad.net/gcc-arm-embedded/+download
[OpenOCD]:http://openocd.sourceforge.net/
[Here!]:http://www.freddiechopin.info/en/download/category/4-openocd
[Eclipse]:https://eclipse.org/downloads/
[NUCLEO-F030R8]:http://www.st.com/web/en/catalog/tools/FM116/SC959/SS1532/LN1847/PF259997
[STM32CubeMX]:http://www.st.com/web/catalog/tools/FM147/CL1794/SC961/SS1743/PF259242?icmp=stm32cubemx_pron_prcube_feb2014&sc=stm32cube-pr#
[STM32CubeMX with Java in Linux]:http://fivevolt.blogspot.co.nz/2014/07/installing-stm32cubemx-on-linux.htmle

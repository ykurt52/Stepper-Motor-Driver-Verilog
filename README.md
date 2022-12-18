
### PMOD Step Motor Driver with FPGA

- With the button A on the kit, the motor frequency can be reduced.
- The rotation direction of the motor can be changed with the B button on the kit.

In order to run the program on the FPGA kit, you have to open the project file via Gowin IDE and write the program to the SRAM of the FGPA kit with the "SRAM Program" method.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

- The starting rotation frequency of the motor is 10 KHz.
- Every time A button is pressed, the frequency decreases by 500 Hz.
- Pins used for motor connection;
- - IOT17B/G3/Header 1st pin = PMOD Step Board pin 1 (Signal5 pin)
- - IOT17A/G4/Header 2nd pin = PMOD Step Board pin 2 (Signal6 pin)
- - IOT14B/G5/Header 3rd pin = PMOD Step Board pin 3 (Signal7 pin)
- - IOT14A/B0/Header 4th pin = PMOD Step Board pin 4 (Signal8 pin)
- - 5V = PMOD VCC and VDD
- - GND = PMOD GND

If you cannot find the pins, there is a schematic of the kit in the Schematic Files folder in the project.

![](https://i.ibb.co/7k4PL2n/Tang-Nano-Pic.png)

You can run it by connecting.

# How to program FGPA SRAM?

Examine the link: https://wiki.sipeed.com/hardware/en/tang/Tang-Nano/examples/led/create_led.html

# How to run and what is it?

Button controls have been added on a standard stepper motor driver code (XILINX).

- Example project (XILINX) = https://www.instructables.com/How-to-Control-a-Stepper-Motor-With-an-FPGA/

Metastabilized code has been added to avoid problems in button reading.

- What is metastability? = https://nandland.com/lesson-13-metastability/

Clock divider code has been added for speed control of the motor.

- What is a clock divider? = https://en.wikipedia.org/wiki/Frequency_divider

###End

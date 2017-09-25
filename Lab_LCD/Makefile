#*******************************************************************************
#* @INSTITUTION
#*  University of Sao Paulo | Sao Carlos School of Engineering | SEL
#*------------------------------------------------------------------------------
#* @DISCIPLINE
#*  Name: SEL0337 | Applications of Microprocessors II
#*  Professor: Evandro Luis Linhari Rodrigues
#*  Semester: 2017\01
#*------------------------------------------------------------------------------
#* @DEVELOPMENT
#*  MCU: Atmel AT89S52
#*  IDE: MCU 8051 v1.5.7
#*  Compiler: SDCC 3.6.0
#*------------------------------------------------------------------------------
#* @WARRANTY
#*  Copyright (c) 2017 Andre Marcos Perez
#*  The software is provided by "as is", without warranty of any kind, express or
#*  implied, including but not limited to the warranties of merchantability,
#*  fitness for a particular purpose and noninfringement. In no event shall the
#*  authors or copyright holders be liable for any claim, damages or other
#*  liability, whether in an action of contract, tort or otherwise, arising from,
#*  out of or in connection with the software or the use or other dealings in the
#*  software.
#*------------------------------------------------------------------------------
#* @LABORATORY
#*  Practice: #1
#*------------------------------------------------------------------------------
#* @AUTHOR
#*  Name:  Andre Marcos Perez
#*  Email: andre.marcos.perez@usp.br
#*  #USP:  8006891
#******************************************************************************/

#******************************************************************************
#* @FILES
#*  Main and libraries files
#*---------------------------------------------------------------------------*/
MAIN = main
LIB = lcd.rel serial.rel

#******************************************************************************
#* @VARIABLES
#*  Compiler, sdcc flags and mcu flags
#*---------------------------------------------------------------------------*/
COMPILER = sdcc
SDCCFLAGS = --model-small
MCUFLAGS = -mmcs51 --iram-size 256 --xram-size 0 --code-size 8192  --nooverlay --noinduction --verbose --debug -V --std-sdcc89 

#******************************************************************************
#* @RULE
#*  Rule for compiling libraries (.c and .h) files into .rel file extension
#*---------------------------------------------------------------------------*/
%.rel : %.c %.h
	$(COMPILER) $(SDCCFLAGS) -c $<

#******************************************************************************
#* @RULE
#*  Rule for compiling the main (.c) file into .hex file extension
#*---------------------------------------------------------------------------*/
all: $(MAIN).hex

$(MAIN).hex: $(MAIN).c $(LIB)
	$(COMPILER) $(SDCCFLAGS) $(MCUFLAGS) $^
	packihx $(MAIN).ihx > $(MAIN).hex

#******************************************************************************
#* @RULE
#*  Rule for cleaning the directory
#*---------------------------------------------------------------------------*/
.PHONY: clean

clean:
	DEL *.ihx *.lnk *.rel *.rst *.sym
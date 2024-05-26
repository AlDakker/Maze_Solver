
_main:

;Maze_Solver.c,17 :: 		void main() {
;Maze_Solver.c,18 :: 		initialize();
	CALL       _initialize+0
;Maze_Solver.c,20 :: 		while (1) {
L_main0:
;Maze_Solver.c,21 :: 		myDelay(1500);
	MOVLW      220
	MOVWF      FARG_myDelay_x+0
	MOVLW      5
	MOVWF      FARG_myDelay_x+1
	CALL       _myDelay+0
;Maze_Solver.c,22 :: 		if(PORTC & 0b00001000){
	BTFSS      PORTC+0, 3
	GOTO       L_main2
;Maze_Solver.c,25 :: 		break;
	GOTO       L_main1
;Maze_Solver.c,26 :: 		}
L_main2:
;Maze_Solver.c,28 :: 		if ((PORTC & 0b00000100) && !(PORTC & 0b00000010)) {
	BTFSS      PORTC+0, 2
	GOTO       L_main5
	BTFSC      PORTC+0, 1
	GOTO       L_main5
L__main22:
;Maze_Solver.c,29 :: 		move_forward();
	CALL       _move_forward+0
;Maze_Solver.c,30 :: 		}
	GOTO       L_main6
L_main5:
;Maze_Solver.c,32 :: 		else if (!(PORTC & 0b00000100) && !(PORTC & 0b00000010)){
	BTFSC      PORTC+0, 2
	GOTO       L_main9
	BTFSC      PORTC+0, 1
	GOTO       L_main9
L__main21:
;Maze_Solver.c,33 :: 		stop();
	CALL       _stop+0
;Maze_Solver.c,35 :: 		move_left();
	CALL       _move_left+0
;Maze_Solver.c,36 :: 		myDelay(750);
	MOVLW      238
	MOVWF      FARG_myDelay_x+0
	MOVLW      2
	MOVWF      FARG_myDelay_x+1
	CALL       _myDelay+0
;Maze_Solver.c,37 :: 		move_left();
	CALL       _move_left+0
;Maze_Solver.c,38 :: 		myDelay(750);
	MOVLW      238
	MOVWF      FARG_myDelay_x+0
	MOVLW      2
	MOVWF      FARG_myDelay_x+1
	CALL       _myDelay+0
;Maze_Solver.c,40 :: 		}
	GOTO       L_main10
L_main9:
;Maze_Solver.c,42 :: 		else if (PORTC & 0b00000010) {
	BTFSS      PORTC+0, 1
	GOTO       L_main11
;Maze_Solver.c,43 :: 		move_right();
	CALL       _move_right+0
;Maze_Solver.c,44 :: 		myDelay(750);
	MOVLW      238
	MOVWF      FARG_myDelay_x+0
	MOVLW      2
	MOVWF      FARG_myDelay_x+1
	CALL       _myDelay+0
;Maze_Solver.c,45 :: 		move_forward();
	CALL       _move_forward+0
;Maze_Solver.c,46 :: 		}
L_main11:
L_main10:
L_main6:
;Maze_Solver.c,49 :: 		}
	GOTO       L_main0
L_main1:
;Maze_Solver.c,50 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_initialize:

;Maze_Solver.c,52 :: 		void initialize() {
;Maze_Solver.c,53 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;Maze_Solver.c,54 :: 		TRISC = 0xff;
	MOVLW      255
	MOVWF      TRISC+0
;Maze_Solver.c,55 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;Maze_Solver.c,57 :: 		OPTION_REG = 0x87; // Use internal clock Fosc/4 with a prescaler of 256
	MOVLW      135
	MOVWF      OPTION_REG+0
;Maze_Solver.c,60 :: 		TMR0 = 248; // will count 8 times before the overflow (8 * 128uS = 1ms)
	MOVLW      248
	MOVWF      TMR0+0
;Maze_Solver.c,61 :: 		INTCON = 0b11100000; // GIE, T0IE, peripheral interrupt
	MOVLW      224
	MOVWF      INTCON+0
;Maze_Solver.c,63 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;Maze_Solver.c,64 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;Maze_Solver.c,65 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;Maze_Solver.c,66 :: 		}
L_end_initialize:
	RETURN
; end of _initialize

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Maze_Solver.c,68 :: 		void interrupt() {
;Maze_Solver.c,69 :: 		if (INTCON & 0x04) { // TMR0 Overflow interrupt, will get here every 1ms
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt12
;Maze_Solver.c,70 :: 		TMR0 = 248;
	MOVLW      248
	MOVWF      TMR0+0
;Maze_Solver.c,71 :: 		tick++;
	INCF       _tick+0, 1
	BTFSC      STATUS+0, 2
	INCF       _tick+1, 1
;Maze_Solver.c,72 :: 		INTCON &= 0xFB; // Clear T0IF
	MOVLW      251
	ANDWF      INTCON+0, 1
;Maze_Solver.c,73 :: 		}
L_interrupt12:
;Maze_Solver.c,74 :: 		}
L_end_interrupt:
L__interrupt26:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_myDelay:

;Maze_Solver.c,76 :: 		void myDelay(int const x) {
;Maze_Solver.c,77 :: 		tick = 0;
	CLRF       _tick+0
	CLRF       _tick+1
;Maze_Solver.c,78 :: 		while (tick < x);
L_myDelay13:
	MOVLW      128
	XORWF      _tick+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_myDelay_x+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__myDelay28
	MOVF       FARG_myDelay_x+0, 0
	SUBWF      _tick+0, 0
L__myDelay28:
	BTFSC      STATUS+0, 0
	GOTO       L_myDelay14
	GOTO       L_myDelay13
L_myDelay14:
;Maze_Solver.c,79 :: 		}
L_end_myDelay:
	RETURN
; end of _myDelay

_move_forward:

;Maze_Solver.c,81 :: 		void move_forward() {
;Maze_Solver.c,82 :: 		turning_counter = 1;
	MOVLW      1
	MOVWF      _turning_counter+0
	MOVLW      0
	MOVWF      _turning_counter+1
;Maze_Solver.c,83 :: 		turning_threshold = 2;
	MOVLW      2
	MOVWF      _turning_threshold+0
	MOVLW      0
	MOVWF      _turning_threshold+1
;Maze_Solver.c,86 :: 		PORTB &= 0b01000100;
	MOVLW      68
	ANDWF      PORTB+0, 1
;Maze_Solver.c,88 :: 		while (turning_counter <= turning_threshold) {
L_move_forward15:
	MOVLW      128
	XORWF      _turning_threshold+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _turning_counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__move_forward30
	MOVF       _turning_counter+0, 0
	SUBWF      _turning_threshold+0, 0
L__move_forward30:
	BTFSS      STATUS+0, 0
	GOTO       L_move_forward16
;Maze_Solver.c,90 :: 		PORTB |= 0b00100010;
	MOVLW      34
	IORWF      PORTB+0, 1
;Maze_Solver.c,92 :: 		myDelay(210);
	MOVLW      210
	MOVWF      FARG_myDelay_x+0
	CLRF       FARG_myDelay_x+1
	CALL       _myDelay+0
;Maze_Solver.c,95 :: 		turning_counter++;
	INCF       _turning_counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _turning_counter+1, 1
;Maze_Solver.c,96 :: 		}
	GOTO       L_move_forward15
L_move_forward16:
;Maze_Solver.c,97 :: 		PORTB &= 0b11001001;
	MOVLW      201
	ANDWF      PORTB+0, 1
;Maze_Solver.c,98 :: 		}
L_end_move_forward:
	RETURN
; end of _move_forward

_move_right:

;Maze_Solver.c,100 :: 		void move_right() {
;Maze_Solver.c,101 :: 		turning_counter = 1;
	MOVLW      1
	MOVWF      _turning_counter+0
	MOVLW      0
	MOVWF      _turning_counter+1
;Maze_Solver.c,102 :: 		turning_threshold = 2;
	MOVLW      2
	MOVWF      _turning_threshold+0
	MOVLW      0
	MOVWF      _turning_threshold+1
;Maze_Solver.c,105 :: 		PORTB &= 0b11001001;
	MOVLW      201
	ANDWF      PORTB+0, 1
;Maze_Solver.c,107 :: 		while (turning_counter <= turning_threshold) {
L_move_right17:
	MOVLW      128
	XORWF      _turning_threshold+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _turning_counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__move_right32
	MOVF       _turning_counter+0, 0
	SUBWF      _turning_threshold+0, 0
L__move_right32:
	BTFSS      STATUS+0, 0
	GOTO       L_move_right18
;Maze_Solver.c,109 :: 		PORTB |= 0b00010010;
	MOVLW      18
	IORWF      PORTB+0, 1
;Maze_Solver.c,111 :: 		myDelay(245);
	MOVLW      245
	MOVWF      FARG_myDelay_x+0
	CLRF       FARG_myDelay_x+1
	CALL       _myDelay+0
;Maze_Solver.c,114 :: 		turning_counter++;
	INCF       _turning_counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _turning_counter+1, 1
;Maze_Solver.c,115 :: 		}
	GOTO       L_move_right17
L_move_right18:
;Maze_Solver.c,116 :: 		PORTB &= 0b11001001;
	MOVLW      201
	ANDWF      PORTB+0, 1
;Maze_Solver.c,117 :: 		}
L_end_move_right:
	RETURN
; end of _move_right

_move_left:

;Maze_Solver.c,119 :: 		void move_left() {
;Maze_Solver.c,120 :: 		turning_counter = 1;
	MOVLW      1
	MOVWF      _turning_counter+0
	MOVLW      0
	MOVWF      _turning_counter+1
;Maze_Solver.c,121 :: 		turning_threshold = 2;
	MOVLW      2
	MOVWF      _turning_threshold+0
	MOVLW      0
	MOVWF      _turning_threshold+1
;Maze_Solver.c,124 :: 		PORTB &= 0b11001001;
	MOVLW      201
	ANDWF      PORTB+0, 1
;Maze_Solver.c,126 :: 		while (turning_counter <= turning_threshold) {
L_move_left19:
	MOVLW      128
	XORWF      _turning_threshold+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      _turning_counter+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__move_left34
	MOVF       _turning_counter+0, 0
	SUBWF      _turning_threshold+0, 0
L__move_left34:
	BTFSS      STATUS+0, 0
	GOTO       L_move_left20
;Maze_Solver.c,128 :: 		PORTB |= 0b00100100;
	MOVLW      36
	IORWF      PORTB+0, 1
;Maze_Solver.c,130 :: 		myDelay(320);
	MOVLW      64
	MOVWF      FARG_myDelay_x+0
	MOVLW      1
	MOVWF      FARG_myDelay_x+1
	CALL       _myDelay+0
;Maze_Solver.c,133 :: 		turning_counter++;
	INCF       _turning_counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _turning_counter+1, 1
;Maze_Solver.c,134 :: 		}
	GOTO       L_move_left19
L_move_left20:
;Maze_Solver.c,135 :: 		PORTB &= 0b11001001;
	MOVLW      201
	ANDWF      PORTB+0, 1
;Maze_Solver.c,136 :: 		}
L_end_move_left:
	RETURN
; end of _move_left

_stop:

;Maze_Solver.c,138 :: 		void stop() {
;Maze_Solver.c,140 :: 		enables_off();
	CALL       _enables_off+0
;Maze_Solver.c,141 :: 		PORTB &= 0b11001001;
	MOVLW      201
	ANDWF      PORTB+0, 1
;Maze_Solver.c,142 :: 		}
L_end_stop:
	RETURN
; end of _stop

_enables_on:

;Maze_Solver.c,144 :: 		void enables_on() {
;Maze_Solver.c,145 :: 		PORTB |= 0b11000000;
	MOVLW      192
	IORWF      PORTB+0, 1
;Maze_Solver.c,146 :: 		}
L_end_enables_on:
	RETURN
; end of _enables_on

_enables_off:

;Maze_Solver.c,148 :: 		void enables_off() {
;Maze_Solver.c,150 :: 		PORTD &= 0b00111111;
	MOVLW      63
	ANDWF      PORTD+0, 1
;Maze_Solver.c,151 :: 		}
L_end_enables_off:
	RETURN
; end of _enables_off

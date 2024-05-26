//first code
int tick;
int turning_counter = 0;
int turning_threshold;
const int pwm = 60;

void move_forward();
void move_right();
void move_left();
void stop();
void enables_on();
void enables_off();
void interrupt();
void initialize();
void myDelay(int const x);

void main() {
    initialize();

    while (1) {
    myDelay(1500);
        if(PORTC & 0b00001000){
        // kill

         break;
        }
        // Move forward if there is no wall in front and a wall on the right
        if ((PORTC & 0b00000100) && !(PORTC & 0b00000010)) {
            move_forward();
        }
        // If there is a wall in front, stop and turn right
        else if (!(PORTC & 0b00000100) && !(PORTC & 0b00000010)){
            stop();
            //myDelay(2000)
            move_left();
            myDelay(750);
            move_left();
            myDelay(750);

        }
        // If there is no wall on the right, turn right
        else if (PORTC & 0b00000010) {
            move_right();
            myDelay(750);
            move_forward();
        }


    }
}

void initialize() {
    TRISB = 0x00;
    TRISC = 0xff;
    TRISD = 0x00;

    OPTION_REG = 0x87; // Use internal clock Fosc/4 with a prescaler of 256
    // Fosc=8MHz ==> FTMR0 = 8MHz/4 = 2MHz, TMR0 will increment every 1/2MHz * prescaler
    // 0.5uS * 256 = 128uS (per increment)
    TMR0 = 248; // will count 8 times before the overflow (8 * 128uS = 1ms)
    INTCON = 0b11100000; // GIE, T0IE, peripheral interrupt

    PORTC = 0x00;
    PORTB = 0x00;
    PORTD = 0x00;
}

void interrupt() {
    if (INTCON & 0x04) { // TMR0 Overflow interrupt, will get here every 1ms
        TMR0 = 248;
        tick++;
        INTCON &= 0xFB; // Clear T0IF
    }
}

void myDelay(int const x) {
    tick = 0;
    while (tick < x);
}

void move_forward() {
    turning_counter = 1;
    turning_threshold = 2;

    // Enables off and stop
    PORTB &= 0b01000100;

    while (turning_counter <= turning_threshold) {
        // Enables on
        PORTB |= 0b00100010;

        myDelay(210);
        // Enables off
        //myDelay(100);
        turning_counter++;
    }
    PORTB &= 0b11001001;
}

void move_right() {
    turning_counter = 1;
    turning_threshold = 2;

    // Enables off and stop
    PORTB &= 0b11001001;

    while (turning_counter <= turning_threshold) {
        // Enables on
        PORTB |= 0b00010010;

        myDelay(245);
        // Enables off
        //myDelay(150);
        turning_counter++;
    }
    PORTB &= 0b11001001;
}

void move_left() {
    turning_counter = 1;
    turning_threshold = 2;

    // Enables off and stop
    PORTB &= 0b11001001;

    while (turning_counter <= turning_threshold) {
        // Enables on
        PORTB |= 0b00100100;

        myDelay(320);
        // Enables off
        //myDelay(150);
        turning_counter++;
    }
    PORTB &= 0b11001001;
}

void stop() {
    // Enables off
    enables_off();
    PORTB &= 0b11001001;
}

void enables_on() {
    PORTB |= 0b11000000;
}

void enables_off() {
    // Enables off
    PORTD &= 0b00111111;
}



// Second code


/*int tick;
int turning_counter = 0;
int turning_threshold;
const int pwm = 60;

void move_forward();
void move_right();
void move_left();
void stop();
void enables_on();
void enables_off();
void interrupt();
void initialize();
void myDelay(int const x);
void ATD_init(void);
unsigned int ATD_read(void);


void main() {
    initialize();

    while (1) {
//    myDelay(1500);
//        if (!(PORTC & 0b00001000)){
//         kill
//
//         break;
//        }
        // Move forward if there is no wall in front and a wall on the right
        while ((PORTC & 0b00000100) && !(PORTC & 0b00000010)) {
            move_forward();
        }
        // If there is a wall in front, stop and turn right
        while (!(PORTC & 0b00000100) && !(PORTC & 0b00000010)){
            stop();
            //myDelay(2000)
            move_left();
            myDelay(750);



        }
        // If there is no wall on the right, turn right
        while (PORTC & 0b00000010) {
            move_right();
            myDelay(750);
            move_forward();
        }


    }
}

void initialize() {
    TRISB = 0x00;
    TRISC = 0xff;
    TRISD = 0x00;


    OPTION_REG = 0x87; // Use internal clock Fosc/4 with a prescaler of 256
    // Fosc=8MHz ==> FTMR0 = 8MHz/4 = 2MHz, TMR0 will increment every 1/2MHz * prescaler
    // 0.5uS * 256 = 128uS (per increment)
    TMR0 = 248; // will count 8 times before the overflow (8 * 128uS = 1ms)
    INTCON = 0b11100000; // GIE, T0IE, peripheral interrupt


    PORTC = 0x00;
    PORTB = 0x00;
    PORTD = 0x00;
}

void interrupt() {
    if (INTCON & 0x04) { // TMR0 Overflow interrupt, will get here every 1ms
        TMR0 = 248;
        tick++;
        INTCON &= 0xFB; // Clear T0IF
    }
}

void myDelay(int const x) {
    tick = 0;
    while (tick < x);
}

void move_forward() {
//    turning_counter = 1;
//    turning_threshold = 2;

    // Enables off and stop
//    PORTB &= 0b01000100;

//    while (turning_counter <= turning_threshold) {
        // Enables on
//        PORTB |= 0b00100010;

//        myDelay(60);
        // Enables off
//        PORTB &= 0b11001001;
//        myDelay(100);
//        turning_counter++;
//    }
//    PORTB &= 0b11001001;
PORTB |= 0b00100010;
myDelay(90);
PORTB &= 0b11001001;
myDelay(90);



}

void move_right() {
//    turning_counter = 1;
//    turning_threshold = 2;

    // Enables off and stop
//    PORTB &= 0b11001001;

//    while (turning_counter <= turning_threshold) {
        // Enables on
//        PORTB |= 0b00010010;

//        myDelay(125);
        // Enables off
//        PORTB &= 0b11001001;
        //myDelay(150);
//        turning_counter++;
//    }
//    PORTB &= 0b11001001;
PORTB |= 0b00010010;
myDelay(90);
PORTB &= 0b11001001;
myDelay(90);

}

void move_left() {
//    turning_counter = 1;
//    turning_threshold = 2;

    // Enables off and stop
//    PORTB &= 0b11001001;

//    while (turning_counter <= turning_threshold) {
        // Enables on
//        PORTB |= 0b00100100;

//       myDelay(125);
        // Enables off
//        PORTB &= 0b11001001;
        //myDelay(150);
//        turning_counter++;
//    }
//    PORTB &= 0b11001001;

 PORTB |= 0b00100100;
 myDelay(90);
 PORTB &= 0b11001001;
 myDelay(90);


}

void stop() {
    // Enables off
    enables_off();
    PORTB &= 0b11001001;
}

void enables_on() {
    PORTB |= 0b11000000;
}

void enables_off() {
    // Enables off
    PORTD &= 0b00111111;
}
void ATD_init(void){
 ADCON0 = 0x49;// ATD ON, Do cn't GO, Channel 1, Fosc/16
 ADCON1 = 0xC0;// All channels Analog, 500 KHz, right justified
 TRISA = 0xFF;

}
unsigned int ATD_read(void){
  ADCON0 = ADCON0 | 0x04;// GO
  while(ADCON0 & 0x04);
  return((ADRESH<<8) | ADRESL);
}*/
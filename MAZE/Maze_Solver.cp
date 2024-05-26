#line 1 "C:/Users/user1/Desktop/New folder/MAZE/Maze_Solver.c"

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


 break;
 }

 if ((PORTC & 0b00000100) && !(PORTC & 0b00000010)) {
 move_forward();
 }

 else if (!(PORTC & 0b00000100) && !(PORTC & 0b00000010)){
 stop();

 move_left();
 myDelay(750);
 move_left();
 myDelay(750);

 }

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

 OPTION_REG = 0x87;


 TMR0 = 248;
 INTCON = 0b11100000;

 PORTC = 0x00;
 PORTB = 0x00;
 PORTD = 0x00;
}

void interrupt() {
 if (INTCON & 0x04) {
 TMR0 = 248;
 tick++;
 INTCON &= 0xFB;
 }
}

void myDelay(int const x) {
 tick = 0;
 while (tick < x);
}

void move_forward() {
 turning_counter = 1;
 turning_threshold = 2;


 PORTB &= 0b01000100;

 while (turning_counter <= turning_threshold) {

 PORTB |= 0b00100010;

 myDelay(210);


 turning_counter++;
 }
 PORTB &= 0b11001001;
}

void move_right() {
 turning_counter = 1;
 turning_threshold = 2;


 PORTB &= 0b11001001;

 while (turning_counter <= turning_threshold) {

 PORTB |= 0b00010010;

 myDelay(245);


 turning_counter++;
 }
 PORTB &= 0b11001001;
}

void move_left() {
 turning_counter = 1;
 turning_threshold = 2;


 PORTB &= 0b11001001;

 while (turning_counter <= turning_threshold) {

 PORTB |= 0b00100100;

 myDelay(320);


 turning_counter++;
 }
 PORTB &= 0b11001001;
}

void stop() {

 enables_off();
 PORTB &= 0b11001001;
}

void enables_on() {
 PORTB |= 0b11000000;
}

void enables_off() {

 PORTD &= 0b00111111;
}

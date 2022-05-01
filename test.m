clc
clear
cesar=CesarCipher;
value=cesar.cipher("Jonathan Eduardo García García",777);
disp(value);
value=cesar.decipher(value,777);
disp(value);
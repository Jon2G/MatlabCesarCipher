clc
clear
cesar=CesarCipher;
value=cesar.cipher("abcdefghijklmnopqrstuvwxyz a",777);
disp(value);
value=cesar.decipher(value,777);
disp(value);
clc
clear
cesar=CesarCipher;
value=cesar.cipher("t",777);
disp(value);
value=cesar.decipher(value,777);
disp(value);


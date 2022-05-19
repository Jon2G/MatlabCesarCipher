clc
clear
lm=LanguagesManager();
disp(lm.Languages);
reader=FileReader('./Cosmografia.txt');
lang=lm.Languages(2);
value=reader.readFileAndFilter(lang); %"MONEY MONEY MONEY";
cesar=Vigenere(lang);
cesar.cipher(value,"ABBA");
disp(cesar.ResultText);
cesar.decipher(cesar.ResultText,"ABBA");
disp(cesar.ResultText);

%Notas
%arreglo =[];
%arreglo=[arreglo,'Nuevo item'];
%play fair
%Cifrado de hill matrices inversas
%reportr 
% que es el cesar, pa que se usa el algebra modular,es para que tju lo
% entiendas no el profesor000
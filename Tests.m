classdef Tests < matlab.unittest.TestCase

    properties
        lm,lang,plainText
    end
    methods(TestClassSetup)
        function setup(obj)
            obj.lm=LanguagesManager();
            obj.lang=obj.lm.Languages(1);
        end
        function readText(obj)
            reader=FileReader('./Cosmografia.txt');
            obj.plainText=reader.readFileAndFilter(obj.lang); %"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        end
    end

    methods(TestMethodSetup)
        % Setup for each test
    end

    methods(Test)
        % Test methods

        function vigenere(obj)
            cipher=Vigenere(obj.lang);   
            cipher.cipher(obj.plainText,"ABBA");
            cipherText=cipher.ResultText;
            obj.verifyNotEqual(obj.plainText,cipherText);
            cipher.decipher(cipher.ResultText,"ABBA");
            unCiphed=cipher.ResultText;
            obj.verifyEqual(unCiphed,obj.plainText);
        end
        
        function cesar(obj)
            cipher=Cesar(obj.lang);
            cipher.cipher(obj.plainText,7);
            cipherText=cipher.ResultText;
            obj.verifyNotEqual(obj.plainText,cipherText);
            cipher.decipher(cipher.ResultText,7);
            unCiphed=cipher.ResultText;
            obj.verifyEqual(unCiphed,obj.plainText);
        end

        function playFair(obj)
            cipher=PlayFair(obj.lang);
            cipher.cipher(obj.plainText,"PLAYFAIR");
            cipherText=cipher.ResultText;
            obj.verifyNotEqual(obj.plainText,cipherText);
            cipher.decipher(cipher.ResultText,"PLAYFAIR");
            unCiphed=cipher.ResultText;
            obj.verifyEqual(unCiphed,obj.plainText);
        end        
    end

end

%Notas
%arreglo =[];
%arreglo=[arreglo,'Nuevo item'];
%play fair
%Cifrado de hill matrices inversas
%reportr 
% que es el cesar, pa que se usa el algebra modular,es para que tju lo
% entiendas no el profesor000
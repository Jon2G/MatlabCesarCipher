classdef Vigenere < Chiper
   properties
        IsNumeric=false,
        IsText =true
   end
    
    methods
        function obj = Vigenere(languageDefinition)
           % Call Character constructor
            obj@Chiper(languageDefinition); 
        end
        
        function rText = normalizedCipher(obj,text,key)
            NumericKey=zeros(1,size(key,2),'single');
            rText=""; %Variable de resultado inicializada en cadena vacia
            ASCII_LENGHT=size(obj.LanguageDefinition.Alphabet,2); % Tamaño del alfabeto reducido              
            if(iscell(text))
                text=text{1};
            end
            text=convertStringsToChars(text); %convierte la cadena de texto a un arreglo de caracterés iterable
            length=size(text,2);  %Longuitud del texto a cifrar
            for j=1:length %por cada caractér
                letter=text(j); %obtener el caractér en la posición j
                if(key>0) %si se esta cifrando el offset es positivo
                    letter=obj.LanguageDefinition.normalizeChar(letter); % normalizar el texto (puede que no este normalizado)
                    text(j)=letter;
                    if(letter<=0)
                        continue;
                    end
                end
                %encontrar la letra que corresponde en el alfabeto
                %reducido y obtener la posición en base cero
                letter=obj.LanguageDefinition.indexOf(letter)-1;
                letter=letter+key; %agregar el desplazamiento de la llave de cifrado
                letter=mod(letter,ASCII_LENGHT); %modulo del valor de la letra y el tamaño del diccionario
                letter=obj.LanguageDefinition.Alphabet(letter+1).Letter; %obtener la letra en la nueva posición del alfabeto cifrado base 1
                rText=append(rText,letter); %agregar la letra al resultado del texto cifrado
            end
            rText={text,rText(1)};
        end
    end
end


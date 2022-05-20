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

        function key=getKeyVector(obj,text)
            if(iscell(text)) %si el texto es una celda
                text=text{1};
            end
            text=convertStringsToChars(text); %convierte la cadena de texto a un arreglo de caracterés iterable
            key=zeros(1,size(text,2),'single'); %tamaño de llave de cifrado
            for i=1:size(text,2) %por cada caracter
                letter=text(i); %obtener el caractér en la posición i
                letter=obj.LanguageDefinition.normalizeChar(letter);% normalizar el texto (puede que no este normalizado)
                if(letter<=0) %si el caracter en la llave es invalido
                    error('La llave de cifrado no es valida caractér no valido:['+text(i)+']');
                end
                key(i)=obj.LanguageDefinition.indexOf(letter)-1; %agregar la representación numerica del caracter al vector
            end
        end
        
        function normalizedCipher(obj)     
           obj.Key=obj.getKeyVector(obj.Key); 
           if(~obj.Encrypting)
               %la llave de cifrado debe ser negativa para el descifrado
               for i=1:size(obj.Key,2)
                   obj.Key(i)=obj.Key(i)*-1;
               end
           end
           
           key_index=1;
           key_size=size(obj.Key,2);
           ASCII_LENGHT=size(obj.LanguageDefinition.Alphabet,2); % Tamaño del alfabeto reducido  
           while(obj.Next()) %por cada caractér
               if(obj.Letter<0)
                   continue;
               end
               if(key_index>key_size)
                   key_index=1;
               end
               key_value=obj.Key(key_index);
               key_index=key_index+1;
               obj.Letter=obj.Letter+key_value; %agregar el desplazamiento de la llave de cifrado
               obj.Letter=mod(obj.Letter,ASCII_LENGHT); %modulo del valor de la letra y el tamaño del diccionario
               obj.Letter=obj.LanguageDefinition.Alphabet(obj.Letter+1).Letter; %obtener la letra en la nueva posición del alfabeto cifrado base 1
               obj.ResultText=append(obj.ResultText,obj.Letter); %agregar la letra al resultado del texto cifrado
           end
        end
    end
end


classdef CesarCipher< Chiper

   methods

       function obj=CesarCipher(languageDefinition)
           % Call Character constructor
            obj@Chiper(languageDefinition); 
       end

       %Funcion para cifrar texto
       %obj = instancia de esta clase
       %plainText = texto a cifrar
       %offsetKey = llave de desplazamiento para el cifrado
       %filterSpecialChars (true/false) = filtrar caracteres especiales del
       %texto y utilizar alfabeto reducido (false) ó todo el conjunto de
       %caracteres ASCII (true)
       function cipherText = cipher(obj,plainText,offsetKey)
           cipherText=obj.normalizedCipher(plainText,offsetKey);
       end

       %Funcion para descifrar texto
       %obj = instancia de esta clase
       %cipherText = texto a descifrar
       %offsetKey = llave de desplazamiento para el cifrado
       %filterSpecialChars (true/false) = filtrar caracteres especiales del
       %texto y utilizar alfabeto reducido (false) ó todo el conjunto de
       %caracteres ASCII (true)
       function plainText=decipher(obj,cipherText,offsetKey)
           %la llave de cifrado debe ser negativa para el descifrado
           invertedOffset=-1*offsetKey;
           %si se utilizará el alfabeto reducido llamar a normalizedCipher
           plainText=obj.normalizedCipher(cipherText,invertedOffset);
       end

       %Función para cifrar el texto utilizando el alfabeto reducido
       %reducido especificado mas arriba
       %obj = Instancia de la clase
       %text = Texto a cifrar
       %offset = llave para el cifrado
       function rText=normalizedCipher(obj,text,offset)
           rText=""; %Variable de resultado inicializada en cadena vacia
           ASCII_LENGHT=size(obj.LanguageDefinition.Alphabet,2); % Tamaño del alfabeto reducido              
           if(iscell(text))
                text=text{1};
            end
           text=convertStringsToChars(text); %convierte la cadena de texto a un arreglo de caracterés iterable
           length=size(text,2);  %Longuitud del texto a cifrar
           for j=1:length %por cada caractér
               letter=text(j); %obtener el caractér en la posición j
               if(offset>0) %si se esta cifrando el offset es positivo
                   letter=obj.LanguageDefinition.normalizeChar(letter); % normalizar el texto (puede que no este normalizado)
                   text(j)=letter;
                   if(letter<=0)
                       continue;
                   end
               end
               %encontrar la letra que corresponde en el alfabeto
               %reducido y obtener la posición en base cero
               letter=obj.LanguageDefinition.indexOf(letter)-1;
               letter=letter+offset; %agregar el desplazamiento de la llave de cifrado
               letter=mod(letter,ASCII_LENGHT); %modulo del valor de la letra y el tamaño del diccionario
               letter=obj.LanguageDefinition.Alphabet(letter+1).Letter; %obtener la letra en la nueva posición del alfabeto cifrado base 1
               rText=append(rText,letter); %agregar la letra al resultado del texto cifrado
           end      
           rText={text,rText(1)};
       end     
   end
end




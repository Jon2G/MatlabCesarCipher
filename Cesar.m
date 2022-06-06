classdef Cesar< Chiper
   properties
        IsNumeric=true,
        IsText =false
   end

   methods

       function obj=Cesar(languageDefinition)
           % Call Character constructor
            obj@Chiper(languageDefinition); 
       end

        function nkey=validateKey(obj,key)
            maxKey=obj.LanguageDefinition.GetAlphabetSize();
            if(key>=maxKey)
                msgbox("La llave debe ser menor que el tamaño del diccionario.","Error","error","modal");
                nkey=maxKey-1;
                return;
            end
            if(key<=0)
                msgbox("La llave debe ser mayor que cero.","Error","error","modal");
                nkey=1;
            end
        end

       %Función para cifrar el texto utilizando el alfabeto reducido
       %reducido especificado mas arriba
       %obj = Instancia de la clase
       %text = Texto a cifrar
       %offset = llave para el cifrado
       function normalizedCipher(obj)

           if(~obj.Encrypting)
               %la llave de cifrado debe ser negativa para el descifrado
               obj.Key=-1*obj.Key;
           end
           
           ASCII_LENGHT=size(obj.LanguageDefinition.Alphabet,2); % Tamaño del alfabeto reducido  

           while(obj.Next()) %por cada caractér
               obj.Letter=obj.Letter+obj.Key; %agregar el desplazamiento de la llave de cifrado
               obj.Letter=mod(obj.Letter,ASCII_LENGHT); %modulo del valor de la letra y el tamaño del diccionario
               obj.Letter=obj.LanguageDefinition.Alphabet(obj.Letter+1).GetLetter(1); %obtener la letra en la nueva posición del alfabeto cifrado base 1
               obj.ResultText=append(obj.ResultText,obj.Letter); %agregar la letra al resultado del texto cifrado
           end 
       end     
   end
end




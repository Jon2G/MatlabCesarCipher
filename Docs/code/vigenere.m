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
           ASCII_LENGHT=size(obj.LanguageDefinition.Alphabet,2); % Tamano del alfabeto reducido  
           while(obj.Next()) %por cada caracter
               if(obj.Letter<0)
                   continue;
               end
               if(key_index>key_size)
                   key_index=1;
               end
               key_value=obj.Key(key_index);
               key_index=key_index+1;
               obj.Letter=obj.Letter+key_value; %agregar el desplazamiento de la llave de cifrado
               obj.Letter=mod(obj.Letter,ASCII_LENGHT); %modulo del valor de la letra y el tamano del diccionario
               obj.Letter=obj.LanguageDefinition.Alphabet(obj.Letter+1).Letter; %obtener la letra en la nueva posicion del alfabeto cifrado base 1
               obj.ResultText=append(obj.ResultText,obj.Letter); %agregar la letra al resultado del texto cifrado
           end
        end
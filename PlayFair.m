classdef PlayFair < Chiper
   properties
        IsNumeric=false,
        IsText =true,
        NeutralChar
   end

   methods

       function obj=PlayFair(languageDefinition)
           % Call Character constructor
            obj@Chiper(languageDefinition); 
            if(languageDefinition.GetAlphabetSize()~=25)
                languageDefinition.mergeCharsToMatch(25);
            end
       end

        function nkey=validateKey(obj,key)
            nkey=normalizateKey(obj,key);
            nkey=unique(nkey,'stable');
        end
        

        function key=getKeyVector(obj,text)
            if(iscell(text)) %si el texto es una celda
                text=text{1};
            end
            text=convertStringsToChars(text); %convierte la cadena de texto a un arreglo de caracterés iterable
            text=obj.validateKey(text);
            key=zeros(1,size(text,2),'single'); %tamaño de llave de cifrado

            for i=1:size(text,2) %por cada caracter
                letter=text(i); %obtener el caractér en la posición i
                letter=obj.LanguageDefinition.normalizeChar(letter);% normalizar el texto (puede que no este normalizado)
                if(letter<=0) %si el caracter en la llave es invalido
                    error('La llave de cifrado no es valida caractér no valido:['+text(i)+']');
                end
                key(i)=obj.LanguageDefinition.indexOf(letter); %agregar la representación numerica del caracter al vector
            end
            
            key=unique(key,'stable');

            keySize=size(key,2);
            for i=1:obj.LanguageDefinition.GetAlphabetSize()
                char=obj.LanguageDefinition.getCharacterAt(i);
                key(keySize+i)=obj.LanguageDefinition.indexOf(char.GetLetter(1));               
            end
            key=unique(key,'stable');
            key=PlayFairKey(key,obj.LanguageDefinition);
        end
       
        function MapAlphabetCoords(obj)
            coordAlphabet=[];
            for i=1:obj.LanguageDefinition.GetAlphabetSize()
                character=obj.LanguageDefinition.getCharacterAt(i);
                coordAlphabet=[coordAlphabet,CoordCharacter(character,obj.Key)];
            end
            obj.LanguageDefinition.Alphabet=coordAlphabet;
            if(obj.LanguageDefinition.Name=="ENGLISH")
                obj.NeutralChar=obj.LanguageDefinition.getCharacterAt(24);
            elseif(obj.LanguageDefinition.Name=="ESPAÑOL")
                obj.NeutralChar=obj.LanguageDefinition.getCharacterAt(25);
            end
            
        end

        %Función para cifrar el texto utilizando el alfabeto reducido
       %reducido especificado mas arriba
       %obj = Instancia de la clase
       %text = Texto a cifrar
       %offset = llave para el cifrado
       function normalizedCipher(obj)
           obj.Key=obj.getKeyVector(obj.Key);
           obj.MapAlphabetCoords();
           
           Digrams={};
           i=1;
           while(obj.Next())
               charA=obj.LanguageDefinition.getCharacterAt(obj.Letter+1);

               if(obj.Next())
                   charB=obj.LanguageDefinition.getCharacterAt(obj.Letter+1);
               else
                   charB=obj.NeutralChar;
               end

               if(charA.isEqualTo(charB))
                   Digrams{i}=Digram(charA,obj.NeutralChar);
                   i=i+1;
                   if(obj.ReadIndex>=obj.BaseTextSize)
                       disp('a');
                       break;
                   end
                   obj.Previous();
                   continue;
               end               
               Digrams{i}=Digram(charA,charB);
               i=i+1;
           end

           %por cada digrama
           diagramsLength=size(Digrams,2);
           for i=1:diagramsLength
               digram=Digrams{i};
               digram.Cipher(obj.Encrypting,obj.Key);
               obj.ResultText=append(obj.ResultText,digram.GetText()); %agregar la letra al resultado del texto cifrado
           end
         
       end     
   end
end
classdef Hill < Chiper
   properties
        IsNumeric=false,
        IsText =true,
        NeutralChar
   end

    methods
        function obj=Hill(languageDefinition)
           % Call Character constructor
            obj@Chiper(languageDefinition); 

            if(obj.LanguageDefinition.Name=="ENGLISH")
                obj.NeutralChar=obj.LanguageDefinition.getCharacterAt(24);
            elseif(obj.LanguageDefinition.Name=="ESPAÑOL")
                obj.NeutralChar=obj.LanguageDefinition.getCharacterAt(25);
            end

        end

        function nkey=validateKey(obj,key)
            nkey=normalizateKey(obj,key);
            if(size(nkey,2)>9)
                msgbox("La llave debe tener máximo 9 caracteres","Error","error","modal");
                nkey={};
                return;
            end
        end

        function key=getKeyVector(obj,text)
            if(iscell(text)) %si el texto es una celda
                text=text{1};
            end
            text=convertStringsToChars(text); %convierte la cadena de texto a un arreglo de caracterés iterable
            text=obj.validateKey(text);
            key=zeros(1,9,'single'); %tamaño de llave de cifrado

            for i=1:size(text,2) %por cada caracter
                letter=text(i); %obtener el caractér en la posición i
                letter=obj.LanguageDefinition.normalizeChar(letter);% normalizar el texto (puede que no este normalizado)
                if(letter<=0) %si el caracter en la llave es invalido
                    error('La llave de cifrado no es valida caractér no valido:['+text(i)+']');
                end
                key(i)=obj.LanguageDefinition.indexOf(letter)-1; %agregar la representación numerica del caracter al vector
            end

            j=0;
            for i=size(text,2)+1:9
                key(i)=j;
                j=j+1;
            end
            key=HillKey(key,obj.LanguageDefinition);
            if(~key.isValid())
                key=[];
                return;
            end
            if(~obj.Encrypting)
                key.inverse();
            end
        end

        function AddPadding(obj)
           while(mod(obj.BaseTextSize,3)~=0)
               obj.BaseText=strcat(obj.BaseText,obj.NeutralChar.GetLetter(1));
               obj.BaseTextSize=obj.BaseTextSize+1;
           end
        end

        function Trigrams=GetTrigram(obj)
            Trigrams=TrigramsMatrix();
            while(obj.Next())
               %A
               charA=obj.LanguageDefinition.getCharacterAt(obj.Letter+1);
               %B
               obj.Next();
               charB=obj.LanguageDefinition.getCharacterAt(obj.Letter+1);
               %C
               obj.Next();
               charC=obj.LanguageDefinition.getCharacterAt(obj.Letter+1);
               %Make trigram
               Trigrams.AddColumn(charA,charB,charC);
            end
        end

        %Función para cifrar el texto utilizando el alfabeto reducido
       %reducido especificado mas arriba
       %obj = Instancia de la clase
       %text = Texto a cifrar
       %offset = llave para el cifrado
       function normalizedCipher(obj)
           obj.LanguageDefinition.Reindex(-1);
           obj.Key=obj.getKeyVector(obj.Key);
           if(isempty(obj.Key))
               return;
           end
           if(obj.Encrypting)
               obj.AddPadding();
           end
           trigram=obj.GetTrigram();
           trigram.Cipher(obj.Encrypting,obj.Key,obj.LanguageDefinition);
           obj.ResultText=trigram.GetText(obj.LanguageDefinition,obj.Encrypting); %agregar la letra al resultado del texto cifrado         
       end 
    end
end
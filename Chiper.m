classdef (Abstract) Chiper< handle
    %CHIPER Summary of this class goes here
    %   Detailed explanation goes here
    
   properties
       %Define un alfabeto simplificado en letras mayusculas de la A-Z
       %incluyendo la Ñ  y el espacio
       LanguageDefinition;
       BaseText;
       ResultText;
       ReadIndex;
       Key;
       Encrypting;
       Letter;

   end
   properties (Abstract)
       IsNumeric,
       IsText,
   end

   methods (Abstract)
       normalizedCipher(obj);
       validateKey(obj,key);
   end

    methods

        function nkey=normalizateKey(obj,key)
            for i=1:size(key,2)
                letter=key(i); %obtener el caractér en la posición i
                letter=obj.LanguageDefinition.normalizeChar(letter);% normalizar el texto (puede que no este normalizado)
                if(letter<=0)
                     msgbox("La llave de cifrado no es valida caractér no valido:["+key(i)+"]","Error","error","modal");
                     nkey='';
                     return;
                end
                key(i)=letter;
            end
            nkey=key;
        end
        
        function reset(obj,text,key,encrypting)
            if(iscell(text))
                rText='';
                for i=1:size(text,1)
                    row=text(i);
                    row=convertStringsToChars(row);
                    rText=append(rText,row);
                end
                text=string(rText);
            end
            text=convertStringsToChars(text); %convierte la cadena de texto a un arreglo de caracterés iterable
            obj.BaseText=text;
            obj.ResultText="";
            obj.Key=key;
            obj.ReadIndex=1;
            obj.Encrypting=encrypting;
        end

        function has_next=Next(obj)         
            if(obj.ReadIndex>size(obj.BaseText,2))
                has_next=false;
                return;
            end
             has_next=true;
            obj.Letter=obj.BaseText(obj.ReadIndex); %obtener el caractér en la posición ReadIndex
            if(obj.Encrypting) %si se esta cifrando el offset es positivo
                obj.Letter=obj.LanguageDefinition.normalizeChar(obj.Letter); % normalizar el texto (puede que no este normalizado)
                if(obj.Letter<=0)
                    obj.BaseText(obj.ReadIndex)=[];
                    obj.Letter=-1;
                    has_next=obj.Next();   
                    return;
                end
                obj.BaseText(obj.ReadIndex)=obj.Letter;
            end
            obj.ReadIndex=obj.ReadIndex+1;
            %encontrar la letra que corresponde en el alfabeto
            %reducido y obtener la posición en base cero
            obj.Letter=obj.LanguageDefinition.indexOf(obj.Letter)-1;
            return;
        end

        function canGoBack=Previous(obj)
            if(obj.ReadIndex<=1)
                canGoBack=false;
                return;
            end
            obj.ReadIndex=obj.ReadIndex-1;
            obj.Letter=obj.BaseText(obj.ReadIndex);
            canGoBack=true;
        end

       %Funcion para cifrar texto
       %obj = instancia de esta clase
       %plainText = texto a cifrar
       %offsetKey = llave de desplazamiento para el cifrado
       %filterSpecialChars (true/false) = filtrar caracteres especiales del
       %texto y utilizar alfabeto reducido (false) ó todo el conjunto de
       %caracteres ASCII (true)
       function cipher(obj,text,key)
           obj.reset(text,key,true);
           obj.normalizedCipher();
       end

       %Funcion para descifrar texto
       %obj = instancia de esta clase
       %cipherText = texto a descifrar
       %offsetKey = llave de desplazamiento para el cifrado
       %filterSpecialChars (true/false) = filtrar caracteres especiales del
       %texto y utilizar alfabeto reducido (false) ó todo el conjunto de
       %caracteres ASCII (true)
       function decipher(obj,text,key)
           obj.reset(text,key,false);
           obj.normalizedCipher();
       end
       
        function obj=Chiper(languageDefinition)
            obj.LanguageDefinition=languageDefinition;
        end
        
        function plotData = PlotFrequency(obj,text)
            
            LENGHT=size(obj.LanguageDefinition.Alphabet,2); % Tamaño del alfabeto reducido  

           Map =[];
           %Copiar todos los caracteres del alfabeto en un nuevo arreglo
           for i=1:LENGHT
               character=obj.LanguageDefinition.Alphabet(i);
               character=LanguageCharacter(i,character.GetLetter(1),0);
               character.Count=0;
               Map=[Map;character];
           end

           textLenght=0;
           %inicializar vectores en ceros para los valores x,y
           y=zeros(1,LENGHT,'double');
           x=zeros(1,LENGHT,'single');
           xtick=cell(1,LENGHT);   

           if(iscell(text))
                text=text{1};
            end
           text=convertStringsToChars(text); %convierte la cadena de texto a un arreglo de caracterés iterable
           length=size(text,2);  %Longuitud del texto a cifrar
           for j=1:length %por cada caractér
               letter=text(j); %obtener el caractér en la posición j
               index=obj.LanguageDefinition.indexOf(letter); %encontrar la letra que corresponde en el alfabeto
               if(index<0)
                   continue;
               end
               %contador de caracteres
               textLenght=textLenght+1;
               character=Map(index); %obtener el caracter el el alfabeto
               character.Count=character.Count+1; %Incrementar el numero de aparicioness
           end

           for i=1:LENGHT
               Map(i).StandardFrecuency=Map(i).Count/textLenght; %calcular la frecuencia de cada letra del alfabeto
               y(i)=Map(i).StandardFrecuency; %guardar la frecuencua en y
               x(i)=i; %guardar la posicion en x
               xtick{i}=Map(i).GetLetter(1); % caracter de la letra
           end
           plotData=PlotData(x,y);
           plotData.XTickLabels=xtick;
           plotData.Title="Histrograma de frecuencias del texto";
        end
    end
end


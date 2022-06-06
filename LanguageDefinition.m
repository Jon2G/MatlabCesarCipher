classdef LanguageDefinition < handle
    %LANGUAGE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Name='',
        Alphabet={},
        Index=0
    end
    
    methods

        function lsize=GetAlphabetSize(obj)
            lsize=size(obj.Alphabet,2);
        end

        function mergeCharsToMatch(obj,n)
            toMerge=(obj.GetAlphabetSize()-n);
             halfIndex=uint8(obj.GetAlphabetSize()/2);
            for i=1:toMerge
                charA=obj.getCharacterAt(halfIndex);
                while(charA.GetSize()>=2)
                    halfIndex=halfIndex+1;
                    charA=obj.getCharacterAt(halfIndex);
                end
                charB=obj.getCharacterAt(halfIndex+1);
                charA.merge(charB); 
                charB.merge(charA);
                halfIndex=halfIndex+2;
                %obj.Alphabet(halfIndex+1)=[];
            end
            obj.Reindex();
        end

        function obj = LanguageDefinition(index,name,alphabet)
            %LANGUAGE Construct an instance of this class
            %   Detailed explanation goes here
            obj.Alphabet=alphabet;
            obj.Name=name;
            obj.Index=index;
        end
        
        %Función para filtrar los caracteres de una cadena de texto
        %obj = Instancia de objeto
        %text = Texto a filtrar
        %ftext = Texto filtrado
        function ftext=filterSpecialChars(obj,text)      
           %NEW_LINE=sprintf('%s',13);%Almacenar la representación en cadena de el salto de linea
           length=size(text); %Obtener la longitud de el arreglo de cadenas
           ftext=""; %Inicializar el resultado en cadena vacia
           for i=1:length %Por cada fila de texo
               row=text{i}; %Obtener la fila en la posición i
               row=convertStringsToChars(row); %Convierte la fila de texto en un arreglo de caracterés
               row_lenght=size(row,2); % Obtener longitud de la cadena de caracterés
               for j=1:row_lenght % Por cada caractér
                   letter=row(j); %Obtener el caractér en la posición i
                   letter=sprintf('%s',letter); % Obtener la representación en texto de el caractér
                   letter=obj.normalizeChar(letter); % Llamada a la función de normalización de caracterés
                   if(letter>0) % si la letra en mayor que cero (NULL) significa que es valida y fue normalizada
                       ftext=append(ftext,letter); %Agregar a la cadena de texto de resultados
                   end %fin if         
               end %fin for
               %ftext=append(ftext,NEW_LINE); %Agregar a la cadena de texto de resultados un salto de linea
           end %fin for
        end

        %Función para regularizar el texto y que encaje en el alfabeto
        %reducido A-Z|Ñ|' ' en letras mayusculas
        %~ = Instancia de la clase (no requerida)
        %letter = Letra a normalizar
        %nchar = retorna la letra normalizada o cero en caso de que sea
        %invalida
        function nchar=normalizeChar(obj,letter)
            if(iscell(letter))
                letter=letter{1};
            end
            letter=upper(letter); %Convertir a letra mayuscula
            switch(letter) %Buscar caracteres acentuados
                case 'Á'
                    nchar='A'; %Eliminar acento
                    return; %Salida de la función
                case 'É'
                    nchar='E'; %Eliminar acento
                    return; %Salida de la función
                case 'Í'
                    nchar='I'; %Eliminar acento
                    return; %Salida de la función
                case 'Ó'
                    nchar='O'; %Eliminar acento
                    return; %Salida de la función
                case 'Ú'
                    nchar='U'; %Eliminar acento
                    return; %Salida de la función                       
            end
            index=obj.indexOf(letter); 
             % Si la letra esta en el rango
            if(index<=0)
                %disp("Letra invalida:["+letter+"]");
                 nchar=0; %la letra es invalida
                return; %Salida de la función
            end
            nchar=letter;
            return; %Salida de la función
        end

        function i=indexOf(obj,letter,strictCompare)
            if ~exist('strictCompare','var')
                strictCompare=false;
            end

            for i=1:obj.GetAlphabetSize()
                char=obj.getCharacterAt(i);

                if(strictCompare && char.GetLetter(1)==letter)
                    return;
                elseif(~strictCompare && char.isLetter(letter))
                        return;
                end
            end
            i=-1;
        end
        
        function Save(obj)
            path="./DB/"+obj.Name;
            file=FileWriter(path);
            file.Clear();
            for i=1:obj.GetAlphabetSize()
                letter=obj.getCharacterAt(i);               
                file.writeChar(letter.Letter);
                file.writeChar('@');
                file.writeDouble(letter.StandardFrecuency);
                file.writeChar(13);
            end
        end

        function Delete(obj)
            path=pwd+"\DB\"+obj.Name;
            file=FileWriter(path);
            file.Delete();
        end

        function Reindex(obj)
            for i=1:obj.GetAlphabetSize()
                char=obj.getCharacterAt(i);
                char.Index=i;
            end
        end

        function char=getCharacterAt(obj,index)
            index=uint8(index);
            if(iscell(obj.Alphabet))
                 char=obj.Alphabet{index};
                 return;
            end
            char=obj.Alphabet(index);
        end

        function plotData=FrequencyPlot(obj)
            length=obj.GetAlphabetSize();
            x=zeros(1,length,'single');
            xtick=cell(1,length);
            y=zeros(1,length,'double');
            for i=1:length
                char=obj.getCharacterAt(i);
                y(i)=char.StandardFrecuency/100;
                xtick{i}=char.GetLetter(1);
                x(i)=i;
            end
            plotData=PlotData(x,y);
            plotData.XTickLabels=xtick;
            plotData.Title="Histrograma de frecuencias: "+obj.Name;
        end
    end
end


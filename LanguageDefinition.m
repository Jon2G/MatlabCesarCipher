classdef LanguageDefinition < handle
    %LANGUAGE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Name=''
        Alphabet={};    
    end
    
    methods
        function obj = LanguageDefinition(name,alphabet)
            %LANGUAGE Construct an instance of this class
            %   Detailed explanation goes here
            obj.Alphabet=alphabet;
            obj.Name=name;
        end
        
        %Función para filtrar los caracteres de una cadena de texto
        %obj = Instancia de objeto
        %text = Texto a filtrar
        %ftext = Texto filtrado
        function ftext=filterSpecialChars(obj,text)      
           NEW_LINE=sprintf('%s',13);%Almacenar la representación en cadena de el salto de linea
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
               ftext=append(ftext,NEW_LINE); %Agregar a la cadena de texto de resultados un salto de linea
           end %fin for
        end

        %Función para regularizar el texto y que encaje en el alfabeto
        %reducido A-Z|Ñ|' ' en letras mayusculas
        %~ = Instancia de la clase (no requerida)
        %letter = Letra a normalizar
        %nchar = retorna la letra normalizada o cero en caso de que sea
        %invalida
        function nchar=normalizeChar(obj,letter)
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
            index=find(ismember(obj.Alphabet,letter),1);
            s=size(index,1);
             % Si la letra esta en el rango
            if(s<=0)
                disp("Letra invalida:"+letter);
                 nchar=0; %la letra es invalida
                return; %Salida de la función
            end
            nchar=letter;
            return; %Salida de la función
        end
        function Save(obj)
            path="./DB/"+obj.Name;
            file=FileWriter(path);
            file.Clear();
            for i=1:size(obj.Alphabet,2)
                file.writeChar(obj.Alphabet(i));
            end
        end
    end
end


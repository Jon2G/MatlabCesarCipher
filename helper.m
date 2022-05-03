classdef helper< handle
    %helper Clase con métodos genericos de apoyo para el desarrollo
    methods
        %Método para centrar una ventana con respecto a otra
        %~ = Instancia de la clase (no requerida)
        %fig = Figura a centrar
        %parent= Figura que se tomará como referencia para centrar la
        %figura segundaria
        function centerWindow(~,fig,parent)
            %Obtener las coordenadas x,y de la figura padre
            x=parent.Position(1);
            y=parent.Position(2);
            %Obtener el alto de la figura padre
            h=parent.Position(4);

            %Obtener el ancho y alto de la figura que será centrada
            wb_w=fig.Position(3);
            wb_h=fig.Position(4);

            %Calcular la posición de x,y de donde se debe colocar la figura
            %para que este centrada con respecto a la figura padre
            x=x+(wb_w/2); %Posición de x de la figura padre más la mitad del ancho de la figura a centrar
            y=((h/2)+y)-wb_h/2; %La mitad del alto de la figura padre más la posición en y de la figura padre menos la mitad de la altura de la figura a centrar
            movegui(fig,[x y]);  %Reposicionar la figura a centrar en las coordenadas x,y especificadas          
        end

        %Leer archivo de texto y opcionalmente filtrar caracterés
        %especiales
        % data= Cadena de texto recuperado del archivo
        % obj = Instancia de clase
        % fullpath = Ruta absoluta hacia el archivo de texto
        % filterSpecialChars = (true/false) si se desea o no filtrar los
        % caracterés del archivo de texto
        function data=readFile(obj,fullpath,filterSpecialChars)
            %Abrir archivo en modo lectura y recuperar su file id
            fileID = fopen(fullpath,'r');
            %Leer todo el contenido del archivo por linea sin remover espacios
            data=textscan(fileID,'%s', 'delimiter', '\n', 'whitespace', '');
            fclose(fileID); %Cerrar archivo
            data=data{:}; %Convertir a array de cadenas
            if(filterSpecialChars) % si se desea filtrar el texto recuperado
                data=obj.filterSpecialChars(data); %llamar a la función para filtrar el texto
            end
        end
        
        %Función para regularizar el texto y que encaje en el alfabeto
        %reducido A-Z|Ñ|' ' en letras mayusculas
        %~ = Instancia de la clase (no requerida)
        %letter = Letra a normalizar
        %nchar = retorna la letra normalizada o cero en caso de que sea
        %invalida
        function nchar=normalizeChar(~,letter)
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
            % Si la letra esta en el rango de la A-Z|' '|'Ñ'
            if((letter>=65&&letter<=90)||letter==32||letter==165)
                nchar=letter; %la letra es valida
                return; %Salida de la función
            end
            nchar=0; %La letra es invalida y se asigna a cero (NULL)
            return; %Salida de la función
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

        %Convierte una cadena de texto en una cadena de caracterés iterable
        %~ = Instancia de objeto (no requerida)
        %text = Texto a convertir
        %chars = Cadena de caracterés iterable
        function chars = toCharVector(~,text)
            chars=text;
            %Importa un objeto Stack de java
            import java.util.Stack;
            %Inicializa una nueva stack de Java
            A = Stack();
            %Determina la longitud del texto
            length=size(chars);
            for i=1:length %por cada fila en el texto
                row=chars{i}; % fila texto
                row=convertStringsToChars(row); %convierte el contenido de texto de la fila en un arreglo de caraterés
                row_lenght=size(row,2); % longitud de las filas
                for j=1:row_lenght %por cada caractér de la fila de texto
                    item=row(j); %obtiene el elemento j en la fila
                    A.push(item); %agrega la letra al objeto stack
                end %fin for
                A.push(13); % agrega un salto de linea al objeto stack
            end %fin for
            java_lenght=A.size(); %determina la longitud total del objeto stack
            chars=zeros(1,java_lenght); %crea un arrelgo de zeros del la longitud de la stack
            for i=1:java_lenght %por cada elmento en la stack
                chars(i)=A.get(i-1); %asigna el valor de el elemento en la posición i base cero de la stack al arreglo chars base 1
            end %fin for
        end
    end
end
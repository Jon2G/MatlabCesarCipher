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
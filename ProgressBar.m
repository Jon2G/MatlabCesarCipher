classdef ProgressBar < handle
    %ProgressBar Clase para mostrar barras de carga y progreso
    properties
        %Instancia de la figura de la barra de carga
        jwaitbar; 
        %Si la barar de carga es indeteminada o no
        indeterminated;
        %figura padre desde donde se lanza la barra de carga
        parentUiFigure;
    end

    methods
        %Constructor de la instancia
        %indeterminated = (true/false) Si la barar de carga es indeteminada o no
        %parentUiFigure = figura padre desde donde se lanza la barra de carga
        function obj = ProgressBar(indeterminated,parentUiFigure)
            %alamacena el valor de las propiedades
            obj.indeterminated=indeterminated;
            obj.parentUiFigure=parentUiFigure;
        end
        
        %Muestra la ventana con la barra de progreso
        %obj = Instancia de clase 
        %caption = texto a mostrar en la barra de progreso
        function obj = show(obj,caption)
            %Mostrar barra de progeso en modo modal con el texto
            %especifiado
            obj.jwaitbar = waitbar(0, caption,'WindowStyle','modal');
            %Instancia un objeto de la calse helper
            jhelper=helper;
            jhelper.centerWindow(obj.jwaitbar,obj.parentUiFigure); %Llamada a función para centrar la ventana de carga en la figura padre
            %Si la barra de carga es indeterminada
            if(isequal(obj.indeterminated,1))
                %recuperar los componentes hijos de la barra de progreso
                wbch = allchild(obj.jwaitbar);
                %acceder a la progressbar nativa de java
                jp = wbch(1).JavaPeer;
                %establecer progreso indeterminado
                jp.setIndeterminate(1);
            end
    
        end
        
        %Cierra la ventana barra de progeso
        function close(obj)
            %Cierra la ventana barra de progeso
            close(obj.jwaitbar);
        end

    end
end
classdef ProgressBar < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        jwaitbar;
        indeterminated;
        parentUiFigure;
    end

    methods
        function obj = ProgressBar(indeterminated,parentUiFigure)
            %ProgressBar Construct an instance of this class
            obj.indeterminated=indeterminated;
            obj.parentUiFigure=parentUiFigure;
        end

        function obj = show(obj,caption)
            %show Muestra la ventana con la barra de progreso
            %Mostrar barra de progeso
            obj.jwaitbar = waitbar(0, caption,'WindowStyle','modal');
            jhelper=helper;
            jhelper.centerWindow(obj.jwaitbar,obj.parentUiFigure);


            if(isequal(obj.indeterminated,1))
                %recuperar los componentes hijos de la barra de progreso
                wbch = allchild(obj.jwaitbar);
                %acceder a la progressbar nativa de java
                jp = wbch(1).JavaPeer;
                %establecer progreso indeterminado
                jp.setIndeterminate(1);
            end
    
        end
        
        function close(obj)
            %close Cierra la ventana barra de progeso
            %Cierra la ventana barra de progeso
            close(obj.jwaitbar);
        end

    end
end
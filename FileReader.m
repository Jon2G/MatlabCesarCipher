classdef FileReader< handle
    %FILEREADER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Fullpath
    end
    
    methods
        function obj = FileReader(fullpath)
            %FILEREADER Construct an instance of this class
            obj.Fullpath=fullpath;
        end
        
        %Leer archivo de texto y opcionalmente filtrar caracterés
        %especiales
        % data= Cadena de texto recuperado del archivo
        % obj = Instancia de clase
        % fullpath = Ruta absoluta hacia el archivo de texto
        % filterSpecialChars = (true/false) si se desea o no filtrar los
        % caracterés del archivo de texto
        function data=readFile(obj,~)
            %Abrir archivo en modo lectura y recuperar su file id
            fileID = fopen(obj.Fullpath,'r');
            %Leer todo el contenido del archivo por linea sin remover espacios
            data=textscan(fileID,'%s', 'delimiter', '\n', 'whitespace', '');
            fclose(fileID); %Cerrar archivo
            data=data{:}; %Convertir a array de cadenas
        end
        
        %Leer archivo de texto y opcionalmente filtrar caracterés
        %especiales
        % data= Cadena de texto recuperado del archivo
        % obj = Instancia de clase
        % fullpath = Ruta absoluta hacia el archivo de texto
        % filterSpecialChars = (true/false) si se desea o no filtrar los
        % caracterés del archivo de texto
        function data=readFileAndFilter(obj,languageDefinition)
            %Abrir archivo en modo lectura y recuperar su file id
            fileID = fopen(obj.Fullpath,'r');
            %Leer todo el contenido del archivo por linea sin remover espacios
            data=textscan(fileID,'%s', 'delimiter', '\n', 'whitespace', '');
            fclose(fileID); %Cerrar archivo
            data=data{:}; %Convertir a array de cadenas
            data=languageDefinition.filterSpecialChars(data); %llamar a la función para filtrar el texto
        end


    end
end


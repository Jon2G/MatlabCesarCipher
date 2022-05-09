classdef LanguagesManager < handle
    %LANGUAGESMANAGER Clase que administra los lenguajes soportados

    properties
        Languages={};
        files;
        fileReader;
    end
    
    methods
        function obj = LanguagesManager()
            %LANGUAGESMANAGER Construct an instance of this class
            obj.readLanguages();
        end

        function readLanguages(obj)
            obj.files=dir(fullfile('./DB/','*.'));
            for i=3:size(obj.files,1)
                info=obj.files(i);
                Name=info.name;
                Alphabet=obj.GetAlphabet(Name);
                obj.Languages=[obj.Languages;LanguageDefinition(Name,Alphabet)];
            end
        end

        function Alphabet=GetAlphabet(obj,name)
            filePath=strcat('./DB/',name);
            obj.fileReader=FileReader(filePath);
           Alphabet= obj.fileReader.readFile();
        end
    end
end


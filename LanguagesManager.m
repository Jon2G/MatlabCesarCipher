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
                obj.Languages=[obj.Languages;LanguageDefinition(i-2,Name,Alphabet)];
            end
        end

        function Alphabet=GetAlphabet(obj,name)
            Alphabet=[];
            filePath=strcat('./DB/',name);
            obj.fileReader=FileReader(filePath);
            letters=obj.fileReader.readFile();
            for i=1:size(letters)
                letter=letters{i};
                char=letter(1);
                frecuency=extractBetween(letter,3,size(letter,2));
                %disp(frecuency);
                frecuency=str2double(frecuency);
                %disp(frecuency);
                Alphabet= [Alphabet,LanguageCharacter(i,char,frecuency)];
            end
        end

        function RemoveAt(obj,index)
            obj.Languages(index)=[];
            obj.Reindex();
        end
        
        function Reindex(obj)
            for i=1:size(obj.Languages)
                obj.Languages(i).Index=i;
            end
        end
    end
end


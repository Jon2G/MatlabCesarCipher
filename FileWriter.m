classdef FileWriter< handle
    %FileWriter Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Fullpath
    end
    
    methods
        function obj = FileWriter(fullpath)
            %FILEREADER Construct an instance of this class
            obj.Fullpath=fullpath;
        end
        function Delete(obj)
            delete(obj.Fullpath);
        end
        function Clear(obj)
            fOutput = fopen(obj.Fullpath,"w");
            fprintf(fOutput,'%c','');
            fclose(fOutput);
        end
        function writeChar(obj,letter)
            fOutput = fopen(obj.Fullpath,"a+");
            letter=string(letter);
            fprintf(fOutput,'%c\n',letter(1));
            fclose(fOutput);
        end

    end
end


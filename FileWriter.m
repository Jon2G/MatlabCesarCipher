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
            fclose('all');
            delete(obj.Fullpath);
        end
        function Clear(obj)
            fOutput = fopen(obj.Fullpath,"w");
            fprintf(fOutput,'%c','');
            fclose(fOutput);
        end
        function writeChar(obj,letter)
            fOutput = fopen(obj.Fullpath,"a+");
            fprintf(fOutput,'%c',letter);
            fclose(fOutput);
        end
        function writeDouble(obj,double)
            text=sprintf('%f',double);
            obj.writeString(text); 
        end
        function writeString(obj,str)
            fOutput = fopen(obj.Fullpath,"a+");
            str=string(str);
            fprintf(fOutput,'%s',str);
            fclose(fOutput);
        end

    end
end


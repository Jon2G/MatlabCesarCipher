classdef LanguageCharacter < Character    
    properties
        StandardFrecuency=0
    end
    
    methods
        function obj = LanguageCharacter(index,letter,standardFrecuency)
            
            % Call Character constructor
            obj@Character(index,letter,0); 
            obj.StandardFrecuency=standardFrecuency;
        end
        function format=PrintFormat(obj)
            format=char(obj.Letter+" ["+obj.StandardFrecuency+"%]");
        end
    end
end


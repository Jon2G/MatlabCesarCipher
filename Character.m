classdef Character < handle
    properties
        Letter="",
        Count=0,
        Index=0
    end
    
    methods
        function obj = Character(index,letter,count)
            obj.Index=index;
            obj.Letter=letter;
            obj.Count=count;
        end
        function format=PrintFormat(obj)
            format=char(obj.Letter+' ['+obj.Count+']');
        end
    end
end


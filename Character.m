classdef Character < handle
    properties
        Count=0,
        Index=0,
        Letters={}
    end
    
    methods

        function obj = Character(index,letter,count)
            obj.Index=index;
            if(iscell(letter))
                obj.Letters=letter;
            else
                obj.Letters={};
                obj.Letters{1}=letter;
            end
            obj.Count=count;
        end

        function format=PrintFormat(obj)
            format=char(obj.GetLetter(1)+' ['+obj.Count+']');
        end
        
        function letter=GetLetter(obj,index)
            letter=obj.Letters{index};
        end

        function lsize=GetSize(obj)
            lsize=size(obj.Letters,2);
        end

        function equals=isEqualTo(obj,charB)
             for i=1:obj.GetSize()
                 letter=obj.GetLetter(i);
                 if(charB.isLetter(letter))
                     equals=true;
                     return;
                 end
             end
             equals=false;
        end

        function isl=isLetter(obj,letter)
            for i=1:obj.GetSize()
                if(obj.GetLetter(i)==letter)
                    isl=true;
                    return;
                end
            end
            isl=false;
        end

        function merge(charA,charB)
            for i=1:charB.GetSize()
                letter=charB.Letters{i};
                found=find([charA.Letters{:}]==letter);
                if(isempty(found))
                    charA.Letters{charA.GetSize()+i}=letter;
                end
            end
        end
    end
end


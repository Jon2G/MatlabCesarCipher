classdef PlayFairKey < handle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        keyVector,
        keyLenght,
        keyDimension,
        LanguageDefinition
    end

    methods
        function obj = PlayFairKey(keyVector,LanguageDefinition)
            obj.keyVector = keyVector;
            obj.keyLenght=size(obj.keyVector,2);
            obj.keyDimension=sqrt(obj.keyLenght);
            obj.LanguageDefinition=LanguageDefinition;
        end
        function coords=GetCoords(obj,char)
            i=find(obj.keyVector==char.Index);
            j=1;
            while(isempty(i))              
                char.Index=obj.LanguageDefinition.indexOf(char.GetLetter(j),true);
                i=find(obj.keyVector==char.Index);
                j=j+1;
            end
            i=i-1;

            x = mod(i,obj.keyDimension)+1;
            y = floor (i/obj.keyDimension)+1;
            coords=Coords(y,x);
        end

        function nchar=GetCharOnTheRight(obj,char)
           nchar=obj.GetXY(char.column+1,char.row);
        end

        function nchar=GetCharOnTheLeft(obj,char)
           nchar=obj.GetXY(char.column-1,char.row);
        end

        function nchar=GetAboveChar(obj,char)
           nchar=obj.GetXY(char.column,char.row-1);
        end
        
        function nchar=GetBelowChar(obj,char)
           nchar=obj.GetXY(char.column,char.row+1);
        end
        

        function char=GetXY(obj,x,y)
            if(x>obj.keyDimension||x<=0)
                if(x==0)
                    x=obj.keyDimension;
                else
                    x=mod(x,obj.keyDimension);
                end
            end
            if(y>obj.keyDimension||y<=0)
                if(y==0)
                    y=obj.keyDimension;
                else
                    y=mod(y,obj.keyDimension);
                end
            end

            i = ((x-1) + obj.keyDimension*(y-1))+1;
           
            i = obj.keyVector(i);
            char=obj.LanguageDefinition.getCharacterAt(i);
        end

    end
end
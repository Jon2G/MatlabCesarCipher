classdef Digram  < handle
    properties
        CharA,
        CharB
    end

    methods
        function obj = Digram(charA,charB)
            obj.CharA = charA;
            obj.CharB = charB;
        end

        function Cipher(obj,Encrypting,key)
            %Primera regla
            if(obj.CharA.row==obj.CharB.row)
                if(Encrypting)
                    obj.CharA=key.GetCharOnTheRight(obj.CharA);
                    obj.CharB=key.GetCharOnTheRight(obj.CharB);
                else
                    obj.CharA=key.GetCharOnTheLeft(obj.CharA);
                    obj.CharB=key.GetCharOnTheLeft(obj.CharB);
                end
                return;
            end
            %segunda regla
            if(obj.CharA.column==obj.CharB.column)
                if(Encrypting)
                    obj.CharA=key.GetBelowChar(obj.CharA);
                    obj.CharB=key.GetBelowChar(obj.CharB);
                else
                    obj.CharA=key.GetAboveChar(obj.CharA);
                    obj.CharB=key.GetAboveChar(obj.CharB);
                end
                return;
            end
            %tercera regla
            ax=obj.CharB.column; %a toma la columna de b
            bx=obj.CharA.column; %b toma la columna de a sus filas no se cambian
            obj.CharA=key.GetXY(ax,obj.CharA.row);
            obj.CharB=key.GetXY(bx,obj.CharB.row);
        end

        function text=GetText(obj)
            text=append(obj.CharA.GetLetter(1),obj.CharB.GetLetter(1));
        end
    end
end
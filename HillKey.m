classdef HillKey < handle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        keyVector,
        keyLenght=9,
        LanguageDefinition,
        keyMatrix,
        determinant,
        inverseMultiplicative
    end

    methods

        function obj = HillKey(keyVector,LanguageDefinition)
            obj.keyVector = keyVector;
            obj.keyMatrix=transpose(reshape(obj.keyVector,3,3));
            obj.keyMatrix=[35 53 12;12 21 5;2 4 1];
            obj.LanguageDefinition=LanguageDefinition;
        end

        function valid=isValid(obj)        
            obj.determinant=det(obj.keyMatrix);
            valid=true;
            if(mod(obj.determinant,2)==0)
                valid=false;
                msgbox("El determinante de la llave debe ser impar","Error","error","modal");
                return;
            end
        end

        function inverse(obj)
            inverse=[0 0 0;0 0 0; 0 0 0];
            for i=0:2
                for j=0:2
                    a=obj.keyMatrix(mod((j+1),3)+1,mod((i+1),3)+1);
                    b=obj.keyMatrix(mod((j+2),3)+1,mod((i+2),3)+1);
                    c=obj.keyMatrix(mod((j+1),3)+1,mod((i+2),3)+1);
                    d=obj.keyMatrix(mod((j+2),3)+1,mod((i+1),3)+1);
                    inverse(i+1,j+1)=((a *b) - (c * d))/ obj.determinant;
                end
            end
            obj.keyMatrix=mod(inverse,obj.LanguageDefinition.GetAlphabetSize());
            %obj.keyMatrix=mod(pinv(obj.keyMatrix),obj.LanguageDefinition.GetAlphabetSize());
        end

    end
end
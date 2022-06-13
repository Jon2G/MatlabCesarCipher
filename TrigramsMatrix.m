classdef TrigramsMatrix  < handle
    properties
        matrix
    end

    methods
        function obj = TrigramsMatrix()
            matrix=[];
        end

        function AddColumn(obj,charA,charB,charC)
            column=[charA.Index;charB.Index;charC.Index];
            obj.matrix=[obj.matrix column];
        end

        function Cipher(obj,~,key,langDefinition)
            obj.matrix=key.keyMatrix*obj.matrix;
            obj.matrix=mod(obj.matrix,langDefinition.GetAlphabetSize()); 
        end

        function text=GetText(obj,langDefinition,~)   
            text='';
            for c=1:size(obj.matrix,2)
                for r=1:3
                    mvalue=obj.matrix(r,c)+1;
                    if(mvalue>=langDefinition.GetAlphabetSize())
                       mvalue=langDefinition.GetAlphabetSize()-1;
                    end
                    character=langDefinition.getCharacterAt(mvalue);
                    text=strcat(text,character.GetLetter(1));
                end
            end       
        end
    end
end
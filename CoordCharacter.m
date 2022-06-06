classdef CoordCharacter < LanguageCharacter
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        row,column
    end
    
    methods
        function obj = CoordCharacter(char,key)
            % Call Character constructor
            obj@LanguageCharacter(char.Index,char.Letters,char.StandardFrecuency);
            coords=key.GetCoords(obj);
            obj.row=coords.row;
            obj.column=coords.column;
        end
    end
end
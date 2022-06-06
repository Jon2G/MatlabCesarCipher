classdef Coords
    properties
        row,column
    end

    methods
        function obj = Coords(row,column)
            obj.row=row;
            obj.column=column;
        end
    end
end
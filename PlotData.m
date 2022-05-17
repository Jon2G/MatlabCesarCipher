classdef PlotData
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        x=[],
        y=[],
        XTickLabels={},
        Title='Plot',
        Xlabel='x',
        Ylabel='y',
        Legends={}
    end

    methods
        function obj = PlotData(x,y )
           obj.x=x;
           obj.y=y;
        end
    end
end
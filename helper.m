classdef helper
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    methods
        function centerWindow(~,fig,parent)
            x=parent.Position(1);
            y=parent.Position(2);
            h=parent.Position(4);

            wb_w=fig.Position(3);
            wb_h=fig.Position(4);

            x=x+(wb_w/2);
            y=((h/2)+y)-wb_h/2;
            movegui(fig,[x y]);            
        end
        function chars = toCharVector(~,text)
            %convierte el texto a un vector de caracteres
            chars=text;
            import java.util.Stack;
            A = Stack();
            length=size(chars);
            for i=1:length
                row=chars{i};
                row=convertStringsToChars(row);
                row_lenght=size(row,2);
                for j=1:row_lenght
                    item=row(j);
                    A.push(item);
                end
                A.push(13);
            end
            java_lenght=A.size();
            chars=zeros(1,java_lenght);
            for i=1:java_lenght
                chars(i)=A.get(i-1);
           end
        end
    end
end
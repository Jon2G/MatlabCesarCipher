classdef helper< handle
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

        function data=readFile(obj,fullpath,filterSpecialChars)
            %Abrir archivo en modo lectura y recuperar su file id
            fileID = fopen(fullpath,'r');
            %Leer todo el contenido del archivo por linea sin remover espacios
            data=textscan(fileID,'%s', 'delimiter', '\n', 'whitespace', '');
            fclose(fileID);
            data=data{:};
            if(filterSpecialChars)
                data=obj.filterSpecialChars(data);
            end
        end

        function nchar=normalizeChar(~,letter)
            letter=upper(letter);
            switch(letter)
                case 'Á'
                    nchar='A';
                    return;
                case 'É'
                    nchar='E';
                    return;
                case 'Í'
                    nchar='I';
                    return;
                case 'Ó'
                    nchar='O';
                    return;
                case 'Ú'
                    nchar='U';
                    return;                       
            end
            if((letter>=65&&letter<=90)||letter==32||letter==165)
                nchar=letter;
                return;
            end
            nchar=0;
            return;
        end
        
        function ftext=filterSpecialChars(obj,text) 
           NEW_LINE=sprintf('%s',13);
           length=size(text);
           ftext="";
           for i=1:length
               row=text{i};
               row=convertStringsToChars(row);
               row_lenght=size(row,2);
               for j=1:row_lenght
                   letter=row(j);
                   letter=sprintf('%s',letter);
                   letter=obj.normalizeChar(letter);
                   if(letter>0)
                       ftext=append(ftext,letter);
                   end         
               end
               ftext=append(ftext,NEW_LINE);
           end
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
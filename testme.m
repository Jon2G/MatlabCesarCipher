jon='yaccholleta';
jonx='';
ix=1;

last_char='';
for i=1:size(jon,2)
    char=jon(i);
    if(last_char==char)
        ix=ix+1;
        jonx=strcat(jonx,'@');
        jonx=strcat(jonx,char);
    else
        jonx=strcat(jonx,char);
    end
    last_char=char;
    ix=ix+1;
end
disp(jon);
disp(jonx);
FID=fopen('file.txt','w','native','UTF-8');
for i=0:255
    fwrite(FID,i);
end
fclose(FID);
%disp(fileread('file.txt',Encoding='UTF-8'))
classdef CesarCipher
   methods
       
       function cipherText = cipher(obj,plainText,offsetKey)
           cipherText=obj.internalCipher(plainText,offsetKey);
       end
       
       function plainText=decipher(obj,cipherText,offsetKey)
           plainText=obj.internalCipher(cipherText,-1*offsetKey);
       end

       function text=internalCipher(~,text,offset)
           ASCII_LENGHT=255;
           NEW_LINE=sprintf('%s',mod(13+offset,ASCII_LENGHT));
           import java.util.Stack;
           javaStack=Stack();
           length=size(text);
           for i=1:length
               row=text{i};
               row=convertStringsToChars(row);
               row_lenght=size(row,2);
               for j=1:row_lenght
                   letter=row(j);
                   letter=letter+offset;
                   letter=mod(letter,ASCII_LENGHT);
                   letter=sprintf('%s',letter); %num2str(letter,'%c');
                   javaStack.push(letter);
               end
               javaStack.push(NEW_LINE);
           end
           javaStack.pop();
           length=javaStack.size();
           text="";
           for i=1:length
                letter=javaStack.get(i-1);
                text=append(text,letter);
           end
       end
   end
end




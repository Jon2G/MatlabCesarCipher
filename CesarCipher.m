classdef CesarCipher
   methods
       
       function cipherText = cipher(obj,plainText,offsetKey)
           cipherText=obj.internalCipher(plainText,offsetKey);
       end

       function plainText=decipher(obj,cipherText,offsetKey)
           plainText=obj.internalCipher(cipherText,-1*offsetKey);
       end

       function result_text=internalCipher(obj,text,offsetKey)
           matrix=double(text);
           matrix=obj.editMatrix(matrix,offsetKey);
           result_text=obj.toAsciiString(matrix);
       end

       function matrix= editMatrix(~,matrix,offset)
           ASCII_LENGHT=255;
           for i=1:length(matrix)
               letter = matrix(i);
               asciiLetter=letter+offset;
               letter=mod(asciiLetter,ASCII_LENGHT);
               matrix(i)=letter;
           end
       end

       function stringValue = toAsciiString(~,numbersMatrix)
           stringValue="";
           for i=1:length(numbersMatrix)
               number=numbersMatrix(i);
               letter=sprintf('%s',number);
               letter =string(letter);
               stringValue=stringValue+letter;
           end
           stringValue=convertStringsToChars(stringValue);
       end
   end
end




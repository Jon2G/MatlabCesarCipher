classdef CesarCipher< handle
   properties
       Alphabet=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','Ñ','O','P','Q','R','S','T','U','V','W','X','Y','Z',' '];
   end
   methods
       
       function cipherText = cipher(obj,plainText,offsetKey,filterSpecialChars)
           if(filterSpecialChars)
               cipherText=obj.normalizedCipher(plainText,offsetKey);
               return;
           end
           cipherText=obj.internalCipher(plainText,offsetKey);
       end
       
       function plainText=decipher(obj,cipherText,offsetKey,filterSpecialChars)
           if(filterSpecialChars)
               plainText=obj.normalizedCipher(cipherText,-1*offsetKey);
               return;
           end
           plainText=obj.internalCipher(cipherText,-1*offsetKey);
       end
       
       function rText=normalizedCipher(obj,text,offset)
           help=helper;
           rText="";
           ASCII_LENGHT=size(obj.Alphabet,2);
           NEW_LINE=obj.Alphabet(mod(13+offset,ASCII_LENGHT));

           length=size(text,1);
           for i=1:length
               row=text{i};
               row=convertStringsToChars(row);
               row_lenght=size(row,2);
               for j=1:row_lenght
                   letter=row(j);

                   if(offset>0)
                       letter=help.normalizeChar(letter);
                   end

                   letter=find(obj.Alphabet==letter)-1;
                   letter=letter+offset;
                   letter=mod(letter,ASCII_LENGHT);
                   letter=obj.Alphabet(letter+1);
                   rText=append(rText,letter); 
               end
               if((offset>0) && (i<length))
                rText=append(rText,NEW_LINE);
               end
           end


       end

       function rText=internalCipher(~,text,offset)
           rText="";
           ASCII_LENGHT=255;
           NEW_LINE=sprintf('%s',mod(13+offset,ASCII_LENGHT));
           length=size(text);
           for i=1:length
               row=text{i};
               row=convertStringsToChars(row);
               row_lenght=size(row,2);
               for j=1:row_lenght
                   letter=row(j);
                   letter=letter+offset;
                   letter=mod(letter,ASCII_LENGHT);
                   letter=sprintf('%s',letter);
                   rText=append(rText,letter); 
               end
               if(offset>0)
                rText=append(rText,NEW_LINE);
               end
           end
           rText=strtrim(rText);
       end
   end
end




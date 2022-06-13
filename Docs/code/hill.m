function key=getKeyVector(obj,text)
    if(iscell(text))
        text=text{1};
    end
    text=convertStringsToChars(text); 
    text=obj.validateKey(text);
    key=zeros(1,9,'single');
    for i=1:size(text,2) 
        letter=text(i); 
        letter=obj.LanguageDefinition.normalizeChar(letter);
        if(letter<=0) 
            error('La llave de cifrado no es valida caractér no valido:['+text(i)+']');
        end
        key(i)=obj.LanguageDefinition.indexOf(letter)-1; 
    end

    j=0;
    for i=size(text,2)+1:9
        key(i)=j;
        j=j+1;
    end
    key=HillKey(key,obj.LanguageDefinition);
    if(~key.isValid())
        key=[];
        return;
    end
    if(~obj.Encrypting)
        key.inverse();
    end
end

function AddPadding(obj)
   while(mod(obj.BaseTextSize,3)~=0)
       obj.BaseText=strcat(obj.BaseText,obj.NeutralChar.GetLetter(1));
       obj.BaseTextSize=obj.BaseTextSize+1;
   end
end

function Trigrams=GetTrigram(obj)
    Trigrams=TrigramsMatrix();
    while(obj.Next())
       charA=obj.LanguageDefinition.getCharacterAt(obj.Letter+1);
       obj.Next();
       charB=obj.LanguageDefinition.getCharacterAt(obj.Letter+1);
       obj.Next();
       charC=obj.LanguageDefinition.getCharacterAt(obj.Letter+1);
       Trigrams.AddColumn(charA,charB,charC);
    end
end

function normalizedCipher(obj)
   obj.LanguageDefinition.Reindex(-1);
   obj.Key=obj.getKeyVector(obj.Key);
   if(isempty(obj.Key))
       return;
   end
   if(obj.Encrypting)
       obj.AddPadding();
   end
   trigram=obj.GetTrigram();
   trigram.Cipher(obj.Encrypting,obj.Key,obj.LanguageDefinition);
   obj.ResultText=trigram.GetText(obj.LanguageDefinition,obj.Encrypting);     
end 
end
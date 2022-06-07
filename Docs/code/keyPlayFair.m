function key=getKeyVector(obj,text)
    if(iscell(text)) %si el texto es una celda
        text=text{1};
    end
    text=convertStringsToChars(text); %convierte la cadena de texto a un arreglo de caracteres iterable
    text=obj.validateKey(text);
    key=zeros(1,size(text,2),'single'); %tamano de llave de cifrado
    alphabetCopy={};
    for i=1:obj.LanguageDefinition.GetAlphabetSize()
        alphabetCopy{i}=obj.LanguageDefinition.getCharacterAt(i);
    end
    for i=1:size(text,2) %por cada caracter
        letter=text(i); %obtener el caracter en la posicion i
        letter=obj.LanguageDefinition.normalizeChar(letter);% normalizar el texto (puede que no este normalizado)
        alphabetCopy=obj.deleteFromAlphabet(alphabetCopy,letter);
        if(letter<=0) %si el caracter en la llave es invalido
            error('La llave de cifrado no es valida caracter no valido:['+text(i)+']');
        end
        key(i)=obj.LanguageDefinition.indexOf(letter); %agregar la representacion numerica del caracter al vector
    end
    key=unique(key,'stable');
    keySize=size(key,2);
    for i=1:size(alphabetCopy,2)
        char=alphabetCopy{i};
        key(keySize+i)=obj.LanguageDefinition.indexOf(char.GetLetter(1));
        if(char.GetSize()>=2)
            alphabetCopy(i)=[];
            continue;
        end
    end
    key=PlayFairKey(key,obj.LanguageDefinition);
end
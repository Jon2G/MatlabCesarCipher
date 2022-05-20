function key=getKeyVector(obj,text)
    if(iscell(text)) %si el texto es una celda
        text=text{1};
    end
    text=convertStringsToChars(text); %convierte la cadena de texto a un arreglo de caracteres iterable
    key=zeros(1,size(text,2),'single'); %tamano de llave de cifrado
    for i=1:size(text,2) %por cada caracter
        letter=text(i); %obtener el caracter en la posicion i
        letter=obj.LanguageDefinition.normalizeChar(letter);% normalizar el texto (puede que no este normalizado)
        if(letter<=0) %si el caracter en la llave es invalido
            error('La llave de cifrado no es valida caracter no valido:['+text(i)+']');
        end
        key(i)=obj.LanguageDefinition.indexOf(letter)-1; %agregar la representacion numerica del caracter al vector
    end
end
function normalizedCipher(obj)
    obj.Key=obj.getKeyVector(obj.Key);
    obj.MapAlphabetCoords();
    
    Digrams={};
    i=1;
    while(obj.Next())
        charA=obj.LanguageDefinition.getCharacterAt(obj.Letter+1);

        if(obj.Next())
            charB=obj.LanguageDefinition.getCharacterAt(obj.Letter+1);
        else
            charB=obj.NeutralChar;
        end

        if(charA.isEqualTo(charB))
            Digrams{i}=Digram(charA,obj.NeutralChar);
            i=i+1;
            obj.Previous();
            continue;
        end               
        Digrams{i}=Digram(charA,charB);
        i=i+1;
    end

    %por cada digrama
    diagramsLength=size(Digrams,2);
    for i=1:diagramsLength
        digram=Digrams{i};
        digram.Cipher(obj.Encrypting,obj.Key);
        obj.ResultText=append(obj.ResultText,digram.GetText()); %agregar la letra al resultado del texto cifrado
    end
end   
....
function Cipher(obj,Encrypting,key)
    %Primera regla
    if(obj.CharA.row==obj.CharB.row)
        if(Encrypting)
            obj.CharA=key.GetCharOnTheRight(obj.CharA);
            obj.CharB=key.GetCharOnTheRight(obj.CharB);
        else
            obj.CharA=key.GetCharOnTheLeft(obj.CharA);
            obj.CharB=key.GetCharOnTheLeft(obj.CharB);
        end
        return;
    end
    %segunda regla
    if(obj.CharA.column==obj.CharB.column)
        if(Encrypting)
            obj.CharA=key.GetBelowChar(obj.CharA);
            obj.CharB=key.GetBelowChar(obj.CharB);
        else
            obj.CharA=key.GetAboveChar(obj.CharA);
            obj.CharB=key.GetAboveChar(obj.CharB);
        end
        return;
    end
    %tercera regla
    ax=obj.CharB.column; %a toma la columna de b
    bx=obj.CharA.column; %b toma la columna de a sus filas no se cambian
    obj.CharA=key.GetXY(ax,obj.CharA.row);
    obj.CharB=key.GetXY(bx,obj.CharB.row);
end
%Funcion para cifrar texto
%obj = instancia de esta clase
%plainText = texto a cifrar
%offsetKey = llave de desplazamiento para el cifrado
%filterSpecialChars (true/false) = filtrar caracteres especiales del
%texto y utilizar alfabeto reducido (false) o todo el conjunto de
%caracteres ASCII (true)
function cipherText = cipher(obj,plainText,offsetKey)
    cipherText=obj.normalizedCipher(plainText,offsetKey);
end

%Funcion para descifrar texto
%obj = instancia de esta clase
%cipherText = texto a descifrar
%offsetKey = llave de desplazamiento para el cifrado
%filterSpecialChars (true/false) = filtrar caracteres especiales del
%texto y utilizar alfabeto reducido (false) o todo el conjunto de
%caracteres ASCII (true)
function plainText=decipher(obj,cipherText,offsetKey)
    %la llave de cifrado debe ser negativa para el descifrado
    invertedOffset=-1*offsetKey;
    %si se utilizara el alfabeto reducido llamar a normalizedCipher
    plainText=obj.normalizedCipher(cipherText,invertedOffset);
end

%Funcion para cifrar el texto utilizando el alfabeto reducido
%reducido especificado mas arriba
%obj = Instancia de la clase
%text = Texto a cifrar
%offset = llave para el cifrado
function rText=normalizedCipher(obj,text,offset)
    rText=""; %Variable de resultado inicializada en cadena vacia
    ASCII_LENGHT=size(obj.LanguageDefinition.Alphabet,1); % Tamano del alfabeto reducido
    NEW_LINE=obj.LanguageDefinition.Alphabet(mod(13+offset,ASCII_LENGHT)); %Caracter de salto de linea cifrado   
    length=size(text,1);  %Longuitud del texto a cifrar
    for i=1:length % por cada fila del texto
 row=text{i}; %recuperar la fila de texto en la posicion i
 row=convertStringsToChars(row); %convierte la cadena de texto a un arreglo de caracteres iterable
 row_lenght=size(row,2); %longitud de caracteres
 for j=1:row_lenght %por cada caracter
     letter=row(j); %obtener el caracter en la posicion j
     if(offset>0) %si se esta cifrando el offset es positivo
  letter=obj.LanguageDefinition.normalizeChar(letter); % normalizar el texto (puede que no este normalizado)
  if(letter<=0)
      continue;
  end
     end
     %encontrar la letra que corresponde en el alfabeto
     %reducido y obtener la posicion en base cero
     letter=find(ismember(obj.LanguageDefinition.Alphabet,letter),1)-1;
     letter=letter+offset; %agregar el desplazamiento de la llave de cifrado
     letter=mod(letter,ASCII_LENGHT); %modulo del valor de la letra y el tamano del diccionario
     letter=obj.LanguageDefinition.Alphabet(letter+1); %obtener la letra en la nueva posicion del alfabeto cifrado base 1
     rText=append(rText,letter); %agregar la letra al resultado del texto cifrado
 end
 if((offset>0) && (i<length)) %si se esta cifrando y aun no estamos en la utlima fila agregar un salto de linea
  rText=append(rText,NEW_LINE);
 end
    end
end
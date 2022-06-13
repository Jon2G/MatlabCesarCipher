function valid=isValid(obj)        
    obj.determinant=det(obj.keyMatrix);
    valid=true;
    if(mod(obj.determinant,2)==0)
        valid=false;
        msgbox("El determinante de la llave debe ser impar","Error","error","modal");
        return;
    end
end
function inverse(obj)
    inverse=[0 0 0;0 0 0; 0 0 0];
    for i=0:2
        for j=0:2
            a=obj.keyMatrix(mod((j+1),3)+1,mod((i+1),3)+1);
            b=obj.keyMatrix(mod((j+2),3)+1,mod((i+2),3)+1);
            c=obj.keyMatrix(mod((j+1),3)+1,mod((i+2),3)+1);
            d=obj.keyMatrix(mod((j+2),3)+1,mod((i+1),3)+1);
            inverse(i+1,j+1)=((a *b) - (c * d))/ obj.determinant;
        end
    end
    obj.keyMatrix=mod(inverse,obj.LanguageDefinition.GetAlphabetSize());
end
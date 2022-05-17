classdef (Abstract) Chiper< handle
    %CHIPER Summary of this class goes here
    %   Detailed explanation goes here
    
   properties
       %Define un alfabeto simplificado en letras mayusculas de la A-Z
       %incluyendo la Ñ  y el espacio
       LanguageDefinition;
   end
    
    methods

        function obj=Chiper(languageDefinition)
            obj.LanguageDefinition=languageDefinition;
        end
        
        function plotData = PlotFrequency(obj,text)
            
            LENGHT=size(obj.LanguageDefinition.Alphabet,2); % Tamaño del alfabeto reducido  

           Map =[];
           %Copiar todos los caracteres del alfabeto en un nuevo arreglo
           for i=1:LENGHT
               character=obj.LanguageDefinition.Alphabet(i);
               character=LanguageCharacter(i,character.Letter,0);
               character.Count=1;
               Map=[Map;character];
           end

           textLenght=0;
           %inicializar vectores en ceros para los valores x,y
           y=zeros(1,LENGHT,'double');
           x=zeros(1,LENGHT,'single');
           xtick=cell(1,LENGHT);   

           if(iscell(text))
                text=text{1};
            end
           text=convertStringsToChars(text); %convierte la cadena de texto a un arreglo de caracterés iterable
           length=size(text,2);  %Longuitud del texto a cifrar
           for j=1:length %por cada caractér
               letter=text(j); %obtener el caractér en la posición j
               index=obj.LanguageDefinition.indexOf(letter); %encontrar la letra que corresponde en el alfabeto
               if(index<0)
                   continue;
               end
               %contador de caracteres
               textLenght=textLenght+1;
               character=Map(index); %obtener el caracter el el alfabeto
               character.Count=character.Count+1; %Incrementar el numero de aparicioness
           end

           for i=1:LENGHT
               Map(i).StandardFrecuency=Map(i).Count/textLenght*100; %calcular la frecuencia de cada letra del alfabeto
               y(i)=Map(i).StandardFrecuency; %guardar la frecuencua en y
               x(i)=i; %guardar la posicion en x
               xtick{i}=Map(i).Letter; % caracter de la letra
           end
           plotData=PlotData(x,y);
           plotData.XTickLabels=xtick;
           plotData.Title="Histrograma de frecuencias del texto";
        end
    end
end


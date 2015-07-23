clc;
clear all;
close all;

N = 10; %Number of items (Divisions)
I = imread('ImagenEntrada1.jpg'); %Input Image

SubImages = cell(1,N);
AnchoSubImagen = floor(size(I,2)/N);
Inicio = 1;
Fin = AnchoSubImagen;
for i=1:N
    SubImages{1,i} = I(:,Inicio:Fin,:);
    Inicio = Fin + 1;
    Fin = Fin + AnchoSubImagen;
end

i=1; j=1;
IndexFilas = randperm(N);
figure;
set(gcf,'name','CALIFICA DE 1 - 5 (1=IGUAL, 5=MUY DIFERENTE)','numbertitle','off');
OutPut = -1*ones(N,N);
while(i<=N)
    IndexColumnas = randperm(N);
    Fil = IndexFilas(i);
    j=1;
    while(j<=N)
        Col = IndexColumnas(j);
        subplot(1,2,1); imshow(SubImages{1,Fil}); title('IMAGEN DE REFERENCIA');
        subplot(1,2,2); imshow(SubImages{1,Col}); title('IMAGEN DE COMPARACIÓN');
        j=j+1;        
        if (OutPut(Fil, Col) == -1) 
            Calificacion = input('Ingrese su CALIFICACIÓN: ');
            OutPut(Fil, Col) = Calificacion;
            OutPut(Col, Fil) = Calificacion;
        end
        
    end
    i = i+1;
end
disp('');
disp('END.');
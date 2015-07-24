clc;
clear all;
close all;

N = 5; %Number of items (Divisions)
I = imread('ImagenEntrada1Medio.png'); %Input Image

SubImages = cell(N);
AnchoSubImagen = floor(size(I,2)/N);
Inicio = 1;
Fin = AnchoSubImagen;
for i=1:N
    SubImages{i} = I(:,Inicio:Fin,:);
    Inicio = Fin + 1;
    Fin = Fin + AnchoSubImagen;
end

%indiceReferenciai = randperm(N);
%indiceComparacionk = randperm(N);
%indiceComparacionl = randperm(N);

perceptualKernel = 30*eye(N);
indice = 0;

for i = 1:N
    for k = 1:N
        for l = 1:N
            indiceReferenciai = randi(N);
            indiceComparacionk = randi(N);
            indiceComparacionl = randi(N);
            while(indiceComparacionk == indiceComparacionl)
                indiceComparacionk = randi(N);
                indiceComparacionl = randi(N);
            end  
            
            while(indiceReferenciai == indiceComparacionk)
                indiceComparacionk = randi(N);
            end
            
            while(indiceReferenciai == indiceComparacionl)
                indiceComparacionl = randi(N);
            end
             
            subplot(2,3,2); imshow(SubImages{indiceReferenciai});title('Imagen de Referencia')
            subplot(2,3,4); imshow(SubImages{indiceComparacionk});title('a');
            subplot(2,3,6); imshow(SubImages{indiceComparacionl});title('b');
            calificacion = input('Cual es más similar a la imagen de referencia ? a o b ?: ','s');
            if(calificacion == 'a')
                indice = indiceComparacionk;
            else
                indice = indiceComparacionl;
            end
            if(i~=indice)
                perceptualKernel(indiceReferenciai,indice) = perceptualKernel(indiceReferenciai,indice) + 1;
                perceptualKernel(indice,indiceReferenciai) = perceptualKernel(indice,indiceReferenciai) + 1;
            else
                perceptualKernel(indiceReferenciai,indice) = perceptualKernel(indiceReferenciai,indice) + 1;
            end
        end
    end    
end
close all;
subplot(2,2,1);
imshow(perceptualKernel,[0 max(max(perceptualKernel))]);title('Mas blanco es mas parecido')
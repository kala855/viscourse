I = imread('imagen.jpg');
[fil, col, canal] = size(I);


Iaux = double(I)/255; %Entrada
Ixyzaux = zeros(fil, col, canal); % Salida Aux


M = [0.41, 0.36, 0.18; 0.21, 0.72, 0.07; 0.02, 0.12, 0.95];

for i=1:fil
    for j=1:col
        RGB = [Iaux(i,j,1), Iaux(i,j,2), Iaux(i,j,3)]';
        XYZ = M*RGB;
        Ixyzaux(i,j,1) = XYZ(1);
        Ixyzaux(i,j,2) = XYZ(2);
        Ixyzaux(i,j,3) = XYZ(3);
        
    end
end

Ixyz = uint8(255*Ixyzaux);

X = Ixyz(:,:,1);
Y = Ixyz(:,:,2);
Z = Ixyz(:,:,3);

subplot(2,3, 2); imshow(I); title('IMAGEN DE ENTRADA');
subplot(2,3, 4); imshow(X); title('CANAL MATIZ');
subplot(2,3, 5); imshow(Y); title('CANAL SATURACIoN');
subplot(2,3, 6); imshow(Z); title('CANAL VALOR (LUMINANCIA)');



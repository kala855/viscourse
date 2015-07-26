I = imread('Imagen2.jpg');


Red = double(I(:,:,1))/255;
Green = double(I(:,:,2))/255;
Blue = double(I(:,:,3))/255;

Black = min((1-(double(I)/255)), [], 3);
Cyan = (1-Red-Black)./(1-Black);
Magenta = (1-Green-Black)./(1-Black);
Yellow = (1-Blue-Black)./(1-Black);


subplot(2,4, 2); imshow(I); title('IMAGEN DE ENTRADA');
subplot(2,4, 5); imshow(uint8(255*Cyan)); title('CANAL CYAN');
subplot(2,4, 6); imshow(uint8(255*Magenta)); title('CANAL MAGENTA');
subplot(2,4, 7); imshow(uint8(255*Yellow)); title('CANAL YELLOW');
subplot(2,4, 8); imshow(uint8(255*Black)); title('CANAL BLACK');
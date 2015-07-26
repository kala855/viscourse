clc;
close all;
clear;

I = imread('imagen2.jpg');
Iaux = double(I)./255.0;
tam = size(I);
Ixyz = zeros(tam);




Ihsv = rgb2hsv(I);
h = Ihsv(:,:,1);
s = Ihsv(:,:,2);
v = Ihsv(:,:,3);

subplot(2,3,2); imshow(I);
subplot(2,3,4); imshow(h);
subplot(2,3,5); imshow(s);
subplot(2,3,6); imshow(v);

%M = [0.4124564 0.3575761 0.1804375;
 % 0.2126729 0.7151522 0.0721750;
  %0.0193339 0.1191920 0.9503041] ;

%for i=1:tam(1)
 %   for k = 1:tam(2)
  %      Ixyz(i,k,:) = M*I(i,k,:);
   % end
%end

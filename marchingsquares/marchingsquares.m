clc;
close all;
clear;

imagen = ones(5);
imagebin = zeros(5);
imcon = zeros(4);

imagen(2,2) = 2;
imagen(3,3) = 3;
imagen(4,4) = 2;
imagen(2,3) = 3;
imagen(2,4) = 2;
imagen(4,2) = 2;
imagen(4,3) = 3;
imagen(3,2) = 3;
imagen(3,4) = 3;

isovalue = min(min(imagen));

for i = 1:5
    for k = 1:5
        if(isovalue < imagen(i,k))
            imagebin(i,k) = 0;
        else
            imagebin(i,k) = 1;
        end
    end
end

for i = 1:4
    for k = 1:4
        imcon(i,k) = imagebin(i,k)*8+imagebin(i,k+1)*4+imagebin(i+1,k+1)*2+imagebin(i+1,k)*1;
    end
end

image = imread('el2.png');
%imshow(test);
image_gray = rgb2gray(image);
figure(); 
[C, h] = contour(image_gray,1)
contur(:,1)=[];

[z, a, b, alpha] = fitellipse(contur, 'linear', 'constraint', 'trace');

hF = figure();
plot(contur(1,:), contur(2,:),'r.');
hold on
plotellipse(z, a, b, alpha);

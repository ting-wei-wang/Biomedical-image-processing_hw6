b = imread('gantrycrane.png');
b = rgb2gray(b);
%figure();
%imshow(b);
sig = 1;
[E, M, A, Gx, Gy] = canny2(b, sig);
E = E/255*10;
M = M/255*10;
A = A/255*10;
Gx = Gx/255*10;
Gy = Gy/255*10;
figure();
imshow(E);title('non-supression');
figure();
imshow(M);title('magnitude');
figure();
imshow(A);title('angle');
figure();
imshow(Gx);title('gradient-x');
figure();
imshow(Gy);title('gradient-y');
%%
[H,T,R] = hough(E,'RhoResolution',0.5,'Theta',-10:0.5:10);
figure();
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('theta'), ylabel('rho');
axis on, axis normal, hold on;
colormap(gca,hot);
P  = houghpeaks(H,5);
lines = houghlines(E,T,R,P,'FillGap',6,'MinLength',90);
figure, imshow(b), hold on
title('find line');
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
end

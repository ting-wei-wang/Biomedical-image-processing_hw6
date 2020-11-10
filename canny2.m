function[E, M, A, Gx, Gy] = canny2(I, sig)
 f = fspecial('gaussian',[5,5],sig);
 blurimg = imfilter(I,f);
 [Gx,Gy] = gradient(double(blurimg));
 M = sqrt(Gx.^2+Gy.^2);
 A = atan(Gy./Gx);
 
 [m ,n] = size(blurimg);
 z = zeros(m ,m);
 for i = 1:m
     for j = 1:n
      if(A(i,j) < 0)
          A(i,j) = A(i,j) +180;
      end
     end
 end
 
 for i = 2:m-1
     for j = 2:n-1
         %q = 255;
         %r = 255;
         if(((A(i,j) >= 0) && (A(i,j)) < 22.5)||((A(i,j) >= 157.5) && (A(i,j) <= 180)))
             q = M(i,j+1);
             r = M(i,j-1);
         elseif(((A(i,j) >= 22.5) && (A(i,j)) < 67.5))
             q = M(i+1,j-1);
             r = M(i-1,j+1);
         elseif(((A(i,j) >= 67.5) && (A(i,j)) < 112.5))
             q = M(i+1,j);
             r = M(i-1,j);
         else
             q = M(i-1,j-1);
             r = M(i+1,j+1);
         end
         if((M(i,j) >= q) && (M(i,j) >= r))
             z(i,j) = M(i,j);
         else
             z(i,j) = 0;
         end
     end
 end 
 E = z;
end
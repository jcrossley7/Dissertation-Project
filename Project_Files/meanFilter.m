%Mean Filter
function mean_filt = meanFilter(I)
Igray = rgb2gray(I);
[a,b] = size(I);
meanI = zeros(a,b);
Idouble = im2double(Igray);
count = 1;
array = zeros(1,25);

%Filtering
 for row = 3 : size(I, 1) - 2
     for col = 3 : size(I, 2) - 2
         for a = row - 2 : row + 2
             for b = col - 2 : col + 2
                 array(count)=Idouble(a,b);
                 count = count + 1;
             end
         end
         count = 1;
         average = mean(array);
         meanI(row,col) = average;
     end
 end
 mean_filt = meanI;
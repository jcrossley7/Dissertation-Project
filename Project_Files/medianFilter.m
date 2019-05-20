%median filter
function med_filt = medianFilter(I)
Igray = rgb2gray(I);
[a,b] = size(I);
medianI = zeros(a,b);
Idouble = im2double(Igray);
count = 1;
array = zeros(1,25);
for row = 3 : size(Idouble, 1) - 2
    for col = 3 : size(Idouble,2) - 2
        for a = row - 2 : row + 2
            for b = col - 2 : col + 2
                array(count) = Idouble(a,b);
                count = count + 1;
            end
        end
        count = 1;
        %sortedArray = sort(array);
        Idouble(row, col) = median(array);
    end
end
medianI = Idouble;
med_filt = medianI;
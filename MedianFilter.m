%Created on Wed 2022.03.19 00:07
%Author Emine DURMUSKAYA
%Last updated on 2022.04.01 20.24
%Song # Steve Miller Band - Fly Like an Eagle
function filteredImage = MedianFilter(Image, Filter)

    [M,N,RGB]=size(Image);
    if length(RGB)==3   %transform image to black and white image
        Image = rgb2gray(Image);
    end
    
    Image = double(Image); %turning image into double in order to do mathematical operations
    [filterRow, filterColumn] = size(Filter);  %take size of filter for offsets
    [imageRow, imageColumn] = size(Image);
    filteredImage(1:imageRow,1:imageColumn)=Image(1:imageRow,1:imageColumn); %create an image equal to original image, 
    %this image will be updated after each operation
    
    %offsets
    upperOffset = round(filterRow/2);   %rounds up for 5x5 filter result 3   
    bottomOffset = floor(filterRow/2);  %for 5x5 filter result 2
    leftOffset = round(filterColumn/2);      
    rightOffset = floor(filterColumn/2);   
    
    for instantRow = upperOffset:imageRow-bottomOffset
        for instantColumn = leftOffset:imageColumn-rightOffset
            %create an instant matrix with center of specified pixel, that will be multiplied by filter
            instantMatrix = Image(instantRow-bottomOffset:instantRow+bottomOffset, instantColumn-rightOffset:instantColumn+rightOffset);
   
            counter =0;
            for instantFilterRow = 1: filterRow
                for instantFilterColumn = 1: filterColumn
                    counter = counter+1;
                    %obtaining the result for center pixel
                    medianVector(counter) = Filter(instantFilterRow, instantFilterColumn)*instantMatrix(instantFilterRow,instantFilterColumn);
                    
                end
            end
            medianVector = sort(medianVector(:));
            %updating the filtered image
            filteredImage(instantRow,instantColumn)=medianVector(round((length(medianVector)+1)/2));
        end
    end
    %converting filtered image double to uint8
    filteredImage = uint8(filteredImage);
end
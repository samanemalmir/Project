clc
clear all

imrd=imread ('E:\5\AI\pics\52.jpg');
imrd=rgb2gray(imrd); %image toolbox dependent
imgs=fspecial ('gaussian', 15, 0.00000000001);
imfltr=imfilter(imrd, imgs);
figure,imshow(imfltr)

figure, imhist(imfltr)
title (' Histogram Of Image','FontSize', 12);
imhis= histeq (imfltr);
%figure, imshow (imhis)
title ('Enhance contrast using histogram equalization','FontSize', 12);

%figure, imhist (imhis)
title (' Histogram OF Image ','FontSize', 12);


imedge=edge (imhis,'canny');
figure, imshow (imedge)
title ('Find edges in grayscale image using Canny Method','FontSize', 12);

pd=imdilate(imedge,strel('diamond',1)); %SAYESH
pe=imerode(pd,strel('diamond',1)); % SAYESH
figure,imshow(pe)

imfill=imfill (pe,'hole');
figure, imshow (imfill)
title ('Fill image regions and holes ','FontSize', 12);

imlabl=bwlabel(imfill);
figure,imshow(imlabl);

stat=regionprops(imlabl,'Area','Extent','BoundingBox','Image','Orientation','Centroid');
index = (find([stat.Area] == max([stat.Area]))); %meghdare barchasb dakhele bozorgtarin masahat ra mikhanad
ppout=stat(index).Image;


x1 = floor(stat(index).BoundingBox(1)); %shomare stone awalin pixel  
x2 = ceil(stat(index).BoundingBox(3));  %pahnaye abject dar sathe ofoghi
y1 = ceil(stat(index).BoundingBox(2));  %shomare satre avalin pixel
y2 = ceil(stat(index).BoundingBox(4));  %pahnaye abject dar sathe amodi
bx=[y1 x1 y2 x2];  %MOKHTASAT e KOLI
ppc=imcrop(imrd(:,:,:),[x1,y1,x2,y2]);
figure,imshow(ppc)

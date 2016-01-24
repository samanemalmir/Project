%% start
clear all
close all
clc
p0=imread('E:\5\AI\data\070603\P6070101.jpg');
figure(1),imshow(p0);title('initial img');
p =rgb2gray(p0);
%%figure(2),imshow(p);title('rgb2gray');


%p=im2double(p);
%figure(3),imshow(p);title('im2double');

%f=fspecial('gaussian');
%pf=imfilter(p,f,'replicate');
%figure(4),imshow(pf);title('gaussian');
%% miangin giri
%{
Pm=mean2(p);   % Average eleman matris
Pv=((std2(p))^2); % variance E yek  M-by-N matris ' square' E halat standard ast - pf tasvire replicate shude ast
T=Pm+Pv;
%%
% taerife astaneÇ
[m n]=size(p);
for j=1:n
for i=1:m
if p(i,j)>T;
p(i,j)=1;
else
p(i,j)=0;
end
end
end
%}

ps=edge(p,'roberts',0.18,'both');
%%figure(5),imshow(ps);title('edge');

se=[1;1;1];
I3=imerode(ps,se);
%%figure(6),imshow(I3);title('corrosion image');

se=strel('rectangle',[25,25]);
I4=imclose(I3,se);
%%figure(7),imshow(I4);title('smothing image');
%% SAYESH TASVIR
pd=imdilate(I4,strel('diamond',1)); %SAYESH
pe=imerode(pd,strel('diamond',1)); % SAYESH
%%HOFRE YABI
pl=imfill(pe,'holes');  %yaftane hofre ha
figure(8),imshow(pl);title('yaftane hofre ha');
[m n]=size(pl);
%% barchasb gozary
pll=bwlabel(pl);
%%figure(9),imshow(pll);title('label');
I5=bwareaopen(pll,2000);
%%figure(10),imshow(I5);title('remove the small objects');

stat=regionprops(I5,'Area','Extent','BoundingBox','Image','Orientation','Centroid');
index = (find([stat.Area] == max([stat.Area]))); %meghdare barchasb dakhele bozorgtarin masahat ra mikhanad
ppout=stat(index).Image;
figure(8),imshow(ppout);title('last section ');







%% yaftane mokhtasate pelak az nemone bainery

x1 = floor(stat(index).BoundingBox(1)); %shomare stone awalin pixel (B = floor(A) rounds the elements of A to the nearest integers less than or equal to A) 
x2 = ceil(stat(index).BoundingBox(3));  %pahnaye abject dar sathe ofoghi(B = ceil(A) rounds the elements of A to the nearest integers greater than or equal to A)
y1 = ceil(stat(index).BoundingBox(2));  %shomare satre avalin pixel(B = ceil(A) rounds the elements of A to the nearest integers greater than or equal to A)
y2 = ceil(stat(index).BoundingBox(4));  %pahnaye abject dar sathe amodi(B = ceil(A) rounds the elements of A to the nearest integers greater than or equal to A)
bx=[y1 x1 y2 x2];  %MOKHTASAT e KOLI
ppc=imcrop(p0(:,:,:),[x1,y1,x2,y2]);
figure(8),imshow(ppc)
%% JODA SAZI akse asli pelak
ppg=imcrop(p(:,:),[x1,y1,x2,y2]);
%%figure,imshow(ppg)
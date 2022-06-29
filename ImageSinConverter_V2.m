%% BildSinConverter
clear
close all

%% input
% [A,map] = imread("IMG_20200821_110538.JPG");      % Ramon
% [A,map] = imread("ichBewerb_edge.png");              % Ich Bewerbung_edge
[A,map] = imread("ichBewerb.jpg");              % Ich Bewerbung
% [A,map] = imread("IMG_0514.JPG");                   % Ich
bild = im2double(A);

%% display original image
figure(1)
imshow(A)

%% convert to grayscale
A_gray = rgb2gray(A);
% display grayscale image
figure(2)
imshow(A_gray)

%% edge detection
A_edge = edge(A_gray,'sobel');
% display
figure(3)
imshow(A_edge)

%% entropy filter
A_ent1 = entropyfilt(A_edge);
% display
figure(4)
imshow(A_ent1,[])

%% other type of entropy filter
A_ent2 = rangefilt(A_edge,ones(7));
% display
figure(5)
imshow(A_ent2,[])

%% other type of entropy filter
A_ent3 = stdfilt(A_edge,ones(11));
% display
figure(6)
imshow(A_ent3,[])

%% convert to only X rows
bild = A_ent2;
s = size(bild);
nr = round(s(1)/40);               % Anzahl Reihen, auf die zusammengefasst werden soll
nRows = round(s(1)/nr);
A_quant = zeros(nRows*nr,s(2));
for i = 1:(nr)
    for j = 1:s(2)
        A_quant((nRows*i-(nRows-1)):nRows*i,j) = sum(bild((nRows*i-(nRows-1)):nRows*i,j))/nRows;
    end
end
A_quant = (A_quant-min(A_quant(:)))/max(A_quant(:));
s2 = size(A_quant);


%% display image with less rows
figure(7)
imshow(A_quant)


%% Averages durch Sinus ersetzen (frequenzen sind in 1/(komplettes Bild) angegeben)
fmin = 10;
fmax = 100;
amplitude = floor(nRows/2);

%% Bild aus Sinuswellen erstellen
z = zeros(nr,s2(2)*100);
parfor i = 1:nr            % eine Sinuswelle für jede Zeile
    color = A_quant(i*nRows-1,:);
        
    [y,xsin] = SinRow(color,fmin,fmax);
    y2 = amplitude*y*0.8;
    y3 = movmean(y2,300);
    z(i,:) = y3 + amplitude + (nr-i+1)*nRows;
end
xsin = 1:length(z);

% Display Image with Sinewaves
figure(8)
clf
hold on
plot(xsin,z,'Color','black')











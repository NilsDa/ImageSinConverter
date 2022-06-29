%% BildSinConverter
clear
close all

%% input
% [A,map] = imread("IMG_20200821_110538.JPG");      % Ramon
[A,map] = imread("ichBewerb_edge.png");              % Ich Bewerbung_edge
% [A,map] = imread("ichBewerb.jpg");              % Ich Bewerbung
% [A,map] = imread("IMG_0514.JPG");                   % Ich
bild = im2double(A);

%% display original image
figure(1)
imshow(bild)

%% convert to grayscale
s = size(bild);
new1 = zeros(s(1),s(2));

for i = 1:s(1)      % jeden einzelnen RGB-Pixel in grayscale umwandeln
    for j = 1:s(2)
        new1(i,j) = sum(bild(i,j,:));
    end
end


%% display grayscale image
figure(2)
imshow(new1,[])


%% convert to only X rows
nr = round(3456/40);               % Anzahl Reihen, auf die zusammengefasst werden soll
% nr = round(640/40);               % Anzahl Reihen, auf die zusammengefasst werden soll

nRows = round(s(1)/nr);
new2 = zeros(nRows*nr,s(2));
for i = 1:(nr)
    for j = 1:s(2)
%         new2((nRows*i-(nRows-1)):nRows*i,j) = (bild(3*i,j)+bild(3*i-1,j)+bild(3*i-2,j))/3;
        new2((nRows*i-(nRows-1)):nRows*i,j) = sum(bild((nRows*i-(nRows-1)):nRows*i,j))/nRows;
    end
end
new2 = (new2-min(new2(:)))/max(new2(:));

%% display grayscale image with less rows
figure(3)
imshow(new2)



%% average of each row
s2 = size(new2);
new2avg = zeros(1,nr);
new3 = zeros(size(new2));
for i = 1:length(new2avg)
    new2avg(i) = sum(new2(i*nRows,:))/s2(2);
    new3((nRows*i-(nRows-1)):nRows*i,:) = new2avg(i);
end

% % display image with average grayscale values
% figure(4)
% imshow(new3)



%% Start mit dem Sinuskurven-gedöns

%% Averages durch Sinus ersetzen (frequenzen sind in 1/(komplettes Bild) angegeben)
fmin = 20;
fmax = 900;
favg = fmin+new2avg*fmax;
xsin = 1:s2(2);
% ysin = zeros(nr,s2(2));
amplitude = floor(nRows/2);
% for i = 1:nr
%     ysin(i,:) = round(nRows/2)*sin(xsin*2*pi*favg(i)/s2(2))+round(nRows/2)+(i-1)*nRows;
% end

%% Bild aus Sinuswellen erstellen
figure(5)
close 5
z = zeros(nr,s2(2)*100);
parfor i = 1:nr            % eine Sinuswelle für jede Zeile
    color = new2(i*nRows-1,:);
        
    [y,xsin] = SinZeile(color,fmin,fmax);
%     ysin(i,:) = amplitude*y + amplitude + (i-1)*nRows;
    y = amplitude*y*0.8;
    z(i,:) = y + amplitude + (nr-i+1)*nRows;
%     ysin(i,1:length(y)) = y;
end
xsin = 1:length(z);

% Display Image with Sinewaves
figure(5)
hold on
plot(xsin,z,'Color','black')











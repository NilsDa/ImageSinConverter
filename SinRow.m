function [y,x] = SinRow(color,fmin,fmax)
% [ZeileY] = SinRow(xlength,color)
% xlength: Zeilenlaenge
% color: Farbe in Graustufen (Werte zwischen 0 und 1 erlaubt)
% y: Vektor mit y-Werten der Sinuswelle der Zeile
% fmin,fmax: min und max Frequenzen für y, entsprechend für 0 und 1 in vektor color

%% Parameterdefinitionen
xlength = length(color);
a = 100;                 % Faktor zwischen xlength und ylength (für höhere Auflösung der Sinuswelle)
ylength = xlength*a;
y = zeros(1,ylength);
x = 1:ylength;
f = fmin + (fmax-fmin)*color;   % frequenz an jeder Stelle von color



%% Berechnungen (neu... sieht besser aus)
% zuerst noch nf und f ordentlich erweitern
f2 = zeros(1,ylength);
for i = 1:(xlength)
    for j = 1:a
        if (i == 1)     % erster Pixel
            if j < a/2
                f2(j) = f(i);
            elseif j >= a/2
                f2(j) = f(i) + (f(i+1)-f(i))*(j-1)/(a-1);
            end
        elseif (i == (xlength))       % letzter Pixel
            if j >= a/2
                f2(j+(i-1)*a) = f(i);
            elseif j < a/2
                f2(j+(i-1)*a) = f(i-1) + (f(i)-f(i-1))*((j-1)+(a)/2)/(a-1);
            end
        elseif (i ~= 1) && (i ~= xlength)       % alle weiteren Pixel
            if j < a/2
                f2(j+(i-1)*a) = f(i-1) + (f(i)-f(i-1))*((j-1)+(a)/2)/(a-1);
            elseif j >= a/2
                f2(j+(i-1)*a) = f(i) + (f(i+1)-f(i))*(j-1)/(a-1);
            end
        end
    end
end
% nf an das neue f2 anpassen
nf = zeros(1,length(f2));
parfor i = 1:length(f2)
    nf(i) = floor(ylength/f2(i));          % anzahl Werte pro Periode an entsprechender Stelle von color (aber in hoher Auflösung)
end

% jetzt das Signal berechnen
phi_0 = rand(1);
phi = 1/nf(1);
for i = 1:ylength
    phi = phi + (1/nf(i));
    y(i) = sin(phi_0*2*pi+phi*2*pi);
end


%% Berechnungen (old alternative calculation... doesn't look as nice)
% for i = 1:xlength
%     for j = 1:a
%         if i == 1       % Spezialbehandlung von erstem Wert in color
%             y(j) = sin(rand(1)*2*pi+(j/nf(i))*2*pi);
%         else            % Alle weiteren Werte in color
%             if j == 1   % Anfangswert für Sinuswelle finden
%                 w = asin(y((i-1)*a));
%                 % Quadrantenerkennung
%                 if w > 0 && (y((i-1)*a)-y((i-1)*a-1) <= 0)
%                     w = pi - w;
%                 elseif w < 0 && (y((i-1)*a)-y((i-1)*a-1) < 0)
%                     w = abs(w) + pi;
%                 elseif w < 0 && (y((i-1)*a)-y((i-1)*a-1) >= 0)
%                     w = w + 2*pi;
%                 end
%             end
%             y((i-1)*a+j) = sin(w+(j/nf(i))*2*pi);
%         end
%     end
%     
% end
% for i = 1:xlength
%     for j = 1:a
% %         amplitude = color(i);
%         amplitude = 0.5;
%         y((i-1)*a+j) = y((i-1)*a+j)*amplitude;
%         % Lowpass filter with wpass = 2*pi*fmax
%     end
% end
% y = lowpass(y,fmax,ylength);

end


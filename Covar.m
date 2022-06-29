% Covarianz diskrete Vektoren

x = [6,4,2,8,8,6];
m = sum(x)/length(x);

y = [8,8,6,6,4,2];
n = sum(y)/length(y);

covar = 0;

for i = 1:6
    covar = covar + (x(i)-n)*(y(i)-n);
end

covar = covar*1/6
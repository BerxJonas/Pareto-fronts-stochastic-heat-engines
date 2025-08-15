function out = collective_engine(X)
options = optimoptions('fsolve','Display','off');

x0 = [1 0];
fun = @(n)steady_state(n,X);
sol = fsolve(fun,x0,options);
n1 = sol(1); 
n3 = sol(2);

F = X(:,1);
D = X(:,2);
b1 = X(:,3);
b2 = X(:,4);
eps = X(:,5);

etac = 1-b2./b1;

de21 = (n3-n1).*eps - D;
de32 = (n3-n1).*eps +D;
de13 = -2.*(n3-n1).*eps;

% Reservoir 1 rates

w211 = exp(-b1.*(de21-F)/2);
w121 = exp(-b1.*(-de21+F)/2);

w321 = exp(-b1.*(de32-F)/2);
w231 = exp(-b1.*(-de32+F)/2);

w131 = exp(-b1.*(de13-F)/2);
w311 = exp(-b1.*(-de13+F)/2);

% Reservoir 2 rates

w212 = exp(-b2.*(de21+F)/2);
w122 = exp(-b2.*(-de21-F)/2);

w322 = exp(-b2.*(de32+F)/2);
w232 = exp(-b2.*(-de32-F)/2);

w132 = exp(-b2.*(de13+F)/2);
w312 = exp(-b2.*(-de13-F)/2);

work1 = F.*((w211-w311).*n1 + (w321-w121).*(1-n1-n3) + (w131-w231).*n3);
work2 = F.*((w312-w212).*n1 + (w122-w322).*(1-n1-n3) + (w232-w132).*n3);
%heat1 = ((2.*eps.*n1 - 2.*eps.*n3 - F).*w131 + (eps.*n1 - eps.*n3 - D + F).*w231).*n3 + ((-2.*eps.*n1 + 2.*eps.*n3 + F).*w311 + (-eps.*n1+eps.*n3 - D - F).*w211).*n1 + ((eps.*n1-eps.*n3 + D + F).*w121 + (-eps.*n1 + eps.*n3 + D - F).*w321).*(1-n1-n3);
heat2 = ((2.*eps.*n1 - 2.*eps.*n3 + F).*w132 + (eps.*n1 - eps.*n3 - D - F).*w232).*n3 + ((-2.*eps.*n1 + 2.*eps.*n3 - F).*w312 + (-eps.*n1+eps.*n3 - D + F).*w212).*n1 + ((eps.*n1-eps.*n3 + D - F).*w122 + (-eps.*n1 + eps.*n3 + D + F).*w322).*(1-n1-n3);

P = (work1+work2);
%entropy = -b1.*heat1 - b2.*heat2;
eta = -P./heat2;

out(1) = real(P);
%out(2) = -real(eta);
out(2) = -real(eta./etac);
%out(3) = entropy;

end
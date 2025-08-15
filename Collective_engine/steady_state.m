function out = steady_state(n,params)

n1 = n(:,1);
n3 = n(:,2);

F = params(:,1);
D = params(:,2);
b1 = params(:,3);
b2 = params(:,4);
eps = params(:,5);

de21 = (n3-n1).*eps - D;
de32 = (n3-n1).*eps + D;
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


out = [(w131+w132).*n3 + (w121+w122).*(1-n1-n3)-(w311+w312+w211+w212).*n1;
    (w211+w212).*n1 + (w231+w232).*n3 - (w121+w122+w321+w322).*(1-n1-n3)];
end
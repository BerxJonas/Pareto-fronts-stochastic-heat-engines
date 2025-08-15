function [c,ceq] = engine_constraints(X)
ceq = [];

e1 = X(:,1);
e2 = X(:,2);
b1 = X(:,3);
b2 = X(:,4);

P = real((e1 - e2).*sech((1/4).*(b1.*e1 + b2.*e2)).*sinh((1/4).*(b1.*e1 - b2.*e2)));
s = real((b1.*e1 - b2.*e2).*sech((1/4).*(b1.*e1 + b2.*e2)).*sinh((1/4).*(b1.*e1 - b2.*e2)));
var = real((1/8).*((e1-e2).^2).*(2+cosh(b1.*e1)+cosh(b2.*e2)).*sech((1/4).*(b1.*e1-b2.*e2)).*sech((1/4).*(b1.*e1+b2.*e2)).^3);
eff = real(1-(e1./e2));
ec = real(1-b2./b1);

c = [
     -eff;
     eff-ec;
     ec-1;
     -s;
     -var;
     P;
     %b2-b1;
    ];
end

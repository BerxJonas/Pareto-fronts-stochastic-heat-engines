function out = engine(X,params)

e1 = X(:,1);
e2 = X(:,2);
b1 = X(:,3);
b2 = X(:,4);

P = (e1 - e2).*sech((1/4).*(b1.*e1 + b2.*e2)).*sinh((1/4).*(b1.*e1 - b2.*e2));
s = (b1.*e1 - b2.*e2).*sech((1/4).*(b1.*e1 + b2.*e2)).*sinh((1/4).*(b1.*e1 - b2.*e2));
var = (1/8).*((e1-e2).^2).*(2+cosh(b1.*e1)+cosh(b2.*e2)).*sech((1/4).*(b1.*e1-b2.*e2)).*sech((1/4).*(b1.*e1+b2.*e2)).^3;
eff = 1-(e1./e2);
ec = 1-b2./b1;

for i=1:length(params)
    switch abs(params(i))
        case 1
            if params(i) < 0
                out(i) = -P;
            else 
                out(i) = P;
            end
        case 2
            if params(i) < 0
                out(i) = -eff./ec;
            else 
                out(i) = eff./ec;
            end
        case 3
            if params(i) < 0
                out(i) = -s;
            else 
                out(i) = s;
            end
        case 4
            if params(i) < 0
                out(i) = -var;
            else 
                out(i) = var;
            end
        otherwise 
            out(i) = 0;
    end
end

out(1) = -eff;
out(2) = P;
end
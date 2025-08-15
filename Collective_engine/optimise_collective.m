clear all; clc; close all;

nvar = 5;
optionssingle = optimoptions('gamultiobj', ... % Genetic Algorithm options
        'ParetoFraction',0.75, ...
        'PlotFcn',{@gaplotpareto,@gaplotspread}, ...
        'FunctionTolerance',1e-6, ...
        'ConstraintTolerance',1e-20, ...
        'CreationFcn','gacreationlinearfeasible', ...
        'UseParallel',true,...
        'PopulationSize',2000,...
        'MaxStallGenerations',300,...
        'MaxGenerations',3000);

lb = [1 5/2 5 1 -25];
ub = [1 5/2 5 1 -1];

constr = @(X) collective_engine_constraints(X);
optimise = @(X) collective_engine(X);

count = 0;
err_count = 0;
while count==err_count
    try
    [x,fval] = gamultiobj(optimise,nvar,[],[],[],[],lb,ub,constr,optionssingle); 
    catch MyErr
        err_count = err_count+1;
    end
    count = count +1;
end

%scatter(hax1,-fval(:,2),fval(:,1));

%writematrix(fval,'power_efficiency_collective_F1_D2_b15_b21.txt','Delimiter','tab');
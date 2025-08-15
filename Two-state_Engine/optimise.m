clear all; clc; close all;

seed = sum(clock());
rng(seed);

nvar = 4;

lb = [-7 -7 0 1]; % Lower bound on kinetic rates
ub = [0 0 2 2]; % Upper bound on kinetic rates

options = optimoptions('gamultiobj', ... % Genetic Algorithm options
    'ParetoFraction',0.9, ...
    'PlotFcn',{@gaplotpareto}, ...
    'FunctionTolerance',1e-6, ...
    'ConstraintTolerance',1e-40, ...
    'CreationFcn',{@gacreationnonlinearfeasible}, ...
    'UseParallel',true,...
    'PopulationSize',3000, ...
    'MaxStallGenerations',300, ...
    'MaxGenerations', 15000);

%% Order of objectives to be optimised: (1) Power, (2) Efficiency, (3) Entropy production, (4) Power fluctuations


% Full 4D optimisation
% params = [1 -2 3 4];
% 
% optimise_engine = @(X) engine(X,params);
% constr = @(X) engine_constraints(X);
% 
% [xfull,fvalfull] = gamultiobj(optimise_engine,nvar,[],[],[],[],lb,ub,constr,options); % Optimization function

% 2D Power-efficiency trade-off

params = [-2 1];

optimise_engine = @(X) engine(X,params);
constr = @(X) engine_constraints(X);

[x,fval] = gamultiobj(optimise_engine,nvar,[],[],[],[],lb,ub,constr,options); % Optimization function

% Plotting

figure;
hold on;
%scatter(-fvalfull(:,2),fvalfull(:,1),'.');
scatter(-fval(:,1),fval(:,2),'.');
%writematrix(fval,'test3.txt');

%writematrix([xfull fvalfull(:,1) -fvalfull(:,2) x -fval(:,1) fval(:,2)],'Pareto_P_eta_scaled.txt','Delimiter','tab')

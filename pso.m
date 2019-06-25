clc;
clear;
close all;

%% Problem definition

%CostFunction = @(x) Sphere(x);  %Cost Function
%nVar = 5;                       % Number of unknown (decision) variables
%VarSize = [1 nVar];             % Matrix size of decision variables

problem.CostFunction = @(x) Sphere(x);  %Cost Function
problem.nVar = 5;                       % Number of unknown (decision) variables

problem.VarMin = -10;                   % Lower bound of decision variables
problem.VarMax =  10;                   % Upper bound of decision variables

%% Parameters of PSO

%MaxIt = 1000;                    % Maximum number of iterations
%nPop = 50;                      % Population size (Swarm size)
%w = 1;                          % Inertia coefficient
%wdamp = 0.99;                   % Damping ratio of inertia coefficient
%c1 = 2;                         % Personal accleration coefficient
%c2 = 2;                         % Social acceleration coefficient

params.MaxIt = 1000;                    % Maximum number of iterations
params.nPop = 50;                      % Population size (Swarm size)
params.w = 1;                          % Inertia coefficient
params.wdamp = 0.99;                   % Damping ratio of inertia coefficient
params.c1 = 2;                         % Personal accleration coefficient
params.c2 = 2;                         % Social acceleration coefficient
params.ShowIterationInfo = true;       %Flag for show iteration information

%% Calling PSO

out = funcPSO(problem, params);

BestSol = out.BestSol;
BestCosts = out.BestCosts;

%% Results

figure;
%plot(BestCosts, 'LineWidth', 2);
semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;
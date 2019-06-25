% Clerc and Kennedy, 2002 : Constriction Coefficients

clc;
clear;
close all;

%% Problem definition

%CostFunction = @(x) Sphere(x);  %Cost Function
%nVar = 5;                       % Number of unknown (decision) variables
%VarSize = [1 nVar];             % Matrix size of decision variables

problem.CostFunction = @(x) Sphere(x);  %Cost Function
problem.nVar = 10;                       % Number of unknown (decision) variables

problem.VarMin = -10;                   % Lower bound of decision variables
problem.VarMax =  10;                   % Upper bound of decision variables

%% Parameters of PSO

% Constriction coefficients
kappa = 1;
phi1 = 2.05;
phi2 = 2.05;
phi = phi1 + phi2
chi = 2*kappa/abs(2-phi-sqrt(phi^2-4*phi));

params.MaxIt = 1000;                    % Maximum number of iterations
params.nPop = 50;                      % Population size (Swarm size)
params.w = chi;                          % Inertia coefficient
params.wdamp = 0.99;                   % Damping ratio of inertia coefficient
params.c1 = chi*phi1;                         % Personal accleration coefficient
params.c2 = chi*phi2;                         % Social acceleration coefficient
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
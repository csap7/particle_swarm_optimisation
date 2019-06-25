function out = PSO(problem, params)

        %% Problem definition

        CostFunction = problem.CostFunction;    %Cost Function

        nVar = problem.nVar;                    % Number of unknown (decision) variables

        VarSize = [1 nVar];                     % Matrix size of decision variables

        VarMin = problem.VarMin;                % Lower bound of decision variables
        VarMax = problem.VarMax;                % Upper bound of decision variables

        %% Parameters of PSO

        MaxIt = params.MaxIt;                   % Maximum number of iterations

        nPop = params.nPop;                     % Population size (Swarm size)

        w = params.w;                           % Inertia coefficient
        wdamp = params.wdamp;                   % Damping ratio of inertia coefficient
        c1 = params.c1;                         % Personal accleration coefficient
        c2 = params.c2;                         % Social acceleration coefficient
        
        % Show Iteration Information
        ShowIterationInfo = params.ShowIterationInfo;
        
        MaxVelocity = 0.2*(VarMax - VarMin);
        MinVelocity = -MaxVelocity;

        %% Initialization

        % The particle template
        empty_particle.Position = [];
        empty_particle.Velocity = [];
        empty_particle.Cost = [];
        empty_particle.Best.Position = [];
        empty_particle.Best.Cost = [];

        % Create population array
        particle = repmat(empty_particle, nPop, 1);

        % Initialize global best
        GlobalBest.Cost = inf;

        % Initialize population members
        for i=1:nPop

            % Generate random solution
            particle(i).Position = unifrnd(VarMin, VarMax, VarSize);

            % Initialize velocity
            particle(i).Velocity = zeros(VarSize);

            % Evaluation
            particle(i).Cost = CostFunction(particle(i).Position);

            % Update the personal best
            particle(i).Best.Position = particle(i).Position;
            particle(i).Best.Cost = particle(i).Cost;

            % Update global best
            if particle(i).Best.Cost < GlobalBest.Cost
                GlobalBest = particle(i).Best;
            end

        end

        % Array to hold best cost value on each iteration
        BestCosts = zeros(MaxIt, 1);

        %% Main loop of PSO

        for it = 1:MaxIt

            for i = 1:nPop

                % Update velocity
                particle(i).Velocity = w*particle(i).Velocity ...
                    + c1*rand(VarSize).*(particle(i).Best.Position - particle(i).Position)...
                    + c2*rand(VarSize).*(GlobalBest.Position - particle(i).Position);
                
                % Apply velocity limits
                particle(i).Velocity = max(particle(i).Velocity, MinVelocity);
                particle(i).Velocity = min(particle(i).Velocity, MaxVelocity);

                % Update position
                particle(i).Position = particle(i).Position + particle(i).Velocity;
                
                % Apply lower and upper bound limits
                particle(i).Position = max(particle(i).Position, VarMin);
                particle(i).Position = min(particle(i).Position, VarMax);

                % Evaluation
                particle(i).Cost = CostFunction(particle(i).Position);

                % Update personal best
                if particle(i).Cost < particle(i).Best.Cost

                    particle(i).Best.Position = particle(i).Position;
                    particle(i).Best.Cost = particle(i).Cost;

                    % Update global best
                    if particle(i).Best.Cost < GlobalBest.Cost
                        GlobalBest = particle(i).Best;
                    end            

                end
            end

            %Store the best cost value
            BestCosts(it) = GlobalBest.Cost;

            % Display iteration information
            if ShowIterationInfo
                disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
            end
            % Damp inertia coefficient
            w = w * wdamp;
        end
        
        out.pop = particle;
        out.BestSol = GlobalBest;
        out.BestCosts = BestCosts;
        
end
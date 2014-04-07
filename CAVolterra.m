function [ ] = CAVolterra( steps )
% Cellular automata model of Lotka-Volterra predator-prey relationship


% 10 x 10 grid
% do 12x12 and use empty boundaries
states = zeros(12,12);
% cells are 0 (empty), 1 (prey) or 2 (predator)
% INITIAL
% pred 3rd row+1, 3rd col+1
states(4,4) = 2;
% prey 5th row+1, 6th col+1
states(6,7) = 1;
% prey 7th row+1, 9th col+1
states(8,10) = 1;

%disp(states);

prey = [];
pred = [];

for time=1:steps
   
    % counter
    cprey = 0;
    cpred = 0;
    % RULES
    % if 0 70% chance remain in 0, 30% goes to 1 (prey born)
    % if 1 and no neighbours stays 1
    % if 1 and at least one neighbour goes to 2 (pred eats prey)
    % if 2 70% chance remains 2, 30% chance goes to 0 (pred death)
    tempStates = zeros(12,12);
    
    for i=2:11,
        for j=2:11,
       
            %curr = states(i,j);
            % find neighbours
            %neigh = 1;
            
            if states(i,j) == 0
                % 70/30
                r = ceil(rand*10);
                if r <= 3
                    tempStates(i,j) = 1;
                else
                    tempStates(i,j) = 0;
                end
            elseif states(i,j) == 1 && (states(i-1,j) == 0 && states(i-1,j)==0 && states(i-1,j+1)==0 && states(i,j-1)==0 && states(i,j+1)==0 && states(i+1,j-1)==0 && states(i+1,j)==0 && states(i+1,j+1)==0)
                tempStates(i,j) = 1;
                cprey = cprey + 1;
            elseif states(i,j) == 1 && (states(i-1,j) == 1 || states(i-1,j)==1 || states(i-1,j+1)==1 || states(i,j-1)==1 || states(i,j+1)==1 || states(i+1,j-1)==1 || states(i+1,j)==1 || states(i+1,j+1)==1)
                tempStates(i,j) = 2;
                cprey = cprey + 1;
            elseif states(i,j) == 2
                cpred = cpred + 1;
                % 70/30
                s = ceil(rand*10);
                if s<= 3
                    tempStates(i,j) = 0;
                else
                    tempStates(i,j) = 2;
                end
            end
        
        end
    end
    
    % updated counts
    prey = cat(1, prey, cprey);
    pred = cat(1, pred, cpred);
   
    %disp(states);
    
    %figure;
        for i=1:12,
            for j=1:12,
                    xcoor = [j-1, j, j, j-1];
                    ycoor = [i-1, i-1, i, i];
                if states(i,j) == 0
                    patch(xcoor, ycoor, [1 1 1]);
                elseif states(i,j) == 1
                    patch(xcoor, ycoor, [0 1 0]);
                elseif states(i,j) == 2
                    patch(xcoor, ycoor, [1 0 0]);
                end
            end
        end
       
        drawnow;
    
    
    states = tempStates;
    
        
end

% Print final temp states
        for i=1:12,
            for j=1:12,
                    xcoor = [j-1, j, j, j-1];
                    ycoor = [i-1, i-1, i, i];
                if states(i,j) == 0
                    patch(xcoor, ycoor, [1 1 1]);
                elseif states(i,j) == 1
                    patch(xcoor, ycoor, [0 1 0]);
                elseif states(i,j) == 2
                    patch(xcoor, ycoor, [1 0 0]);
                end
            end
        end
        
    % PLOT
    % pred and prey over time
    time = 1:steps;
    figure;
    plot(time, prey, 'g');
    hold;
    plot(time, pred, 'r');
    title('Pred vs Prey Over Time');
    xlabel('time t');
    ylabel('Population Level');
    legend('Prey', 'Predators');

end


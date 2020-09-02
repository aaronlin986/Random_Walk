function [matrix, count, visit] = rand_walk(h, w, st, N)
table = [0, 1, 1, -1, 1, 0, -1, 1; 0, 1, -1, -1, -1, 1, 0, -1]; % Stores all 8 possible movements in the form of increments and decrements
xmax = w-1; % Maximum x coordinate
ymax = h-1; % Maximum y coordinate
pos = st;   % Start position
matrix = st;    % Include start position into output
count = 0;  % Increments until [4,4] is encountered
begin = 1;  % Switches off when [4,4] is encounterd
visit = 0;  % Increments whenever [2,4] is encountered

for i = 1:N     % Runs for N time steps
     if(pos == [0, 0] | pos == [0, ymax] | pos == [xmax, 0] | pos == [xmax, ymax])
        % Runs if the current position indicates that it is on a corner
        % The algorithm of if statements are condensed into a single arithmetic formula
        
        p = unidrnd(3); % Determines which one of the 3 paths to take
        % Implements the coordinate changes
        pos = [mod((p + round(p/3)), 2) * (pos(1) + (mod(pos(1) + 1, h) - mod(h - pos(1), h))), (round(p/3)) * (pos(2) + (mod(pos(2) + 1, h) - mod(h - pos(2), h)))];
        
        if(begin == 1)  % Tracker for [4,4] encounter
            if(pos ~= [4,4])
                count = count + 1;
            else
                count = count + 1;
                begin = 0;
            end
        end
        
        if(pos == [2,4])    % Tracker for [2,4] encounters
            visit = visit + 1;
        end
     
     elseif(pos(1) == 0 || pos(1) == xmax || pos(2) == 0 || pos(2) == ymax)
          % Runs if the current position indicates that it is on an edge
          % Uses a table lookup algorithm after creating the table of relevant coordinate changes
          
          temp = zeros(2,5);    % Creates a new table lookup of 5 coordinate changes
          index = 1;
          for k = 1:8       % Goes through the original table lookup of 8 coordinate changes, and determines which 5 is relevant to the current position
              if((pos(1) == 0 && table(k) ~= -1) || (pos(1) == h-1 && table(k) ~= 1) || (pos(2) == 0 && table(k+8) ~= -1) || (pos(2) == h-1 && table(k+8) ~= 1))
                  temp((2*index)-1) = table(k);   
                  temp(2*index) = table(k + 8);
                  index = index + 1;
              end
              if(index == 6)    %For loop is exited early if 5 relevant coordinate changes have been found
                  break;
              end 
          end
          p = unidrnd(5);   % Determines which one of the 5 paths to take
          pos = [pos(1) + temp((2*p)-1), pos(2) + temp(2*p)]; % Implements the change in position
          
          if(begin == 1)    % Tracker for [4,4] encounter
            if(pos ~= [4,4])
                count = count + 1;
            else
                count = count + 1;
                begin = 0;
            end
          end
          
        if(pos == [2,4])    % Tracker for [2,4] encounters
            visit = visit + 1;
        end
           
     else   % Runs if current position indicates it is not a corner nor an edge
     % Uses a table lookup algorithm 
         
         p = unidrnd(8);    % Determines which one of the 8 paths to take
         pos = [pos(1) + table(p), pos(2) + table(p + 8)];  % Implements the change in position
         
         if(begin == 1)     % Tracker for [4,4] encounter
            if(pos ~= [4,4])
                count = count + 1;
            else
                count = count + 1;
                begin = 0;
            end
         end
         
         if(pos == [2,4])   % Tracker for [2,4] encounters
            visit = visit + 1;
         end
           
     end  
    matrix(1:2,i+1) = pos;  % Adds position into the output matrix
end 

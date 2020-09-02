%%
% Script name : Discrete Random Walk
% Author : Aaron Lin (111133107)
% Description : This script simulates a random walk T times for ts time
% steps each. The grid is described by NxM, with a starting point of s. In
% this random walk, a point on a corner has 3 paths to take, a point on an
% edge has 5 paths to take, and a point on neither a corner nor an edge has
% 8 paths to take. The probability of a point taking each of its allowed
% paths is equal. The number of time steps needed for each simulation to
% reach point (4,4) is recorded in vector count. The log normal distribution
% and histogram of vector count is plotted. The number of times (2,4)
% is visited is also recorded in vector visits. The average time (2,4) is
% visited is calculated and the probability of visiting (2,4) is
% calculated.
%%
clear
clc

T = 10000;      % Number of simulations
N = 5;          % Height size of grid
M = 5;          % Width size of grid
ts = 10000;     % Number of time steps
s = [0,0];      % Start position
count = zeros(1,T); % Keeps track of number of time steps in each simulation to reach [4,4]
visits = zeros(1,T); % Keeps track of number of times (2,4) was visited in each simulation
for i = 1:T
    [result, count(i), visits(i)] = rand_walk(N, M, s, ts);   
end
t = 0:0.1:50;
median = median(count);     % Calculates median of the count data
meanlog = mean(count);      % Calculates mean of the count data
mu = log(median);           % Calculates mu of the count data
sigma = sqrt(2*abs(log(meanlog/median)));   % Calculates sigma of the count data
y = lognpdf(t, mu, sigma);  % Creates log normal distribution using the count data
figure();
hold on;
histogram(count, 'Normalization', 'pdf');   % Plots histogram of count data
plot(t, y);                 % Plots log normal distribution of count data
hold off;
skew = skewness(count)  % Calculates skewness of count data
var = var(count)        % Calculates variance of count data
avg = mean(count)       % Calculates mean of count data

visitsmean = mean(visits);      % Calculates the average number of times (2,4) was visited 
visitsmean/ts                   % Calculates the probability of being in position (2,4)
% This script file simulates the fragments generation process for a number
% of predefined experiments. During each experiment the average coverage is
% computed so that finally the complete history of coverage is plotted
% along with the corresponding mean average coverage over all experiments.

clc
clear all

% Set the nucleodite length.
L = 100;
% Generate a random L-lengthed nucleodite.
N = GenerateRandomNucleoditeSequence(L);
% Simulate the fragment generation process.
% Set the desired average coverage.
Cmean = 5;
% Set the minimum fragment size.
FSmin = 3;
% Set the maximum fragment size.
FSmax = 6;
% Set the probability of accepting a given fragment during the fragment
% generation process.
Pinc = 0.5;
% Set the number of experiments to be conducted.
experiments_number = 1000;
% Initialize vector for storing the average coverage for each experiment.
AverageCoverage = zeros(1,experiments_number);

% Loop through the various experiments.
for experiment_index = 1:1:experiments_number
    fprintf('Conducted Experiment %d\n',experiment_index);
    [~,~,Coverage] = GenerateFragmentsX(N,Cmean,FSmin,FSmax,Pinc);
    AverageCoverage(experiment_index) = Coverage;
end;

% Compute the mean average coverage.
AverageCoverageMean = mean(AverageCoverage);
AverageCoverageStd = std(AverageCoverage);

% Plot the average coverages throughout the whole experimentation process.
experiment_indices = 1:1:experiments_number;
AverageCoverageMeanVector = AverageCoverageMean * ones(1,experiments_number);
AverageCoverageStdVector = AverageCoverageStd * ones(1,experiments_number);
figure('Name','Fragment Generation Experimentation');
hold on
plot(experiment_indices,AverageCoverage,'.b','LineWidth',1.5);
plot(experiment_indices,AverageCoverageMeanVector,'-r','LineWidth',1.5);
plot(experiment_indices,AverageCoverageMeanVector-AverageCoverageStdVector,'-g','LineWidth',1.5);
plot(experiment_indices,AverageCoverageMeanVector+AverageCoverageStdVector,'-g','LineWidth',1.5);
xlabel('Experiment Index');
ylabel('Average Coverage');
grid on
hold off
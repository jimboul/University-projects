% This script file generates and solves an instance of the Shortest Common
% Superstring Problem in Bioinformatics.

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
% Get the actual fragments.
[Fragments,OccurrenceMatrix,Coverage] = GenerateFragmentsX(N,Cmean,FSmin,FSmax,Pinc);
% Remove fragments (sub-sequences of bases) that are contained completety 
% within other fragments.
PurifiedFragments = PreprocessFragments(Fragments);
% Get the p value
prompt = 'What is the p value?\n';
p = input(prompt);
% Compute pairwise overalaps and corresponding graph connection weights.
[Soverlap,Woverlap] = OverlapWeightMatrix(PurifiedFragments,p);
% Create corresponding biograph object.
BG = CreateBiograph(PurifiedFragments,Woverlap,Soverlap);
% Obtain a maximum weight overlap Hamiltonian path on the constructed
% graph.
[P,W] = GreedyHamiltonianPathX(Woverlap);
% Obtain the corresponding shortest common superstring.
S = ShortestCommonSuperstring(PurifiedFragments,Soverlap,P)
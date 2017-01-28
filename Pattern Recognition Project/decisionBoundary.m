function [ res ] = decisionBoundary()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

x = 0:0.1:10;
func = log(x-1.8) + 0.9;
res = plot(x,func);

end


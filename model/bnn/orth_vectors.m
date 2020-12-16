function [yr,r] = orth_vectors (y,x)
% Orthognalise y with respect to x
% FORMAT [yr,r] = orth_vectors (y,x)

r=(x'*y)/(x'*x);
p=r*x;
yr=y-p;
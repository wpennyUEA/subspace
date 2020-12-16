function [opt] = bnn_default_opt()
% Default optimisation parameters
% FORMAT [opt] = bnn_default_opt()

opt.verbose=0;
%opt.alg='Newton';
%opt.maxits=128;
opt.alg='LineSearch';
opt.maxits=64;
opt.tol=0.001;
opt.restarts=8;
opt.pcthresh=0.60;
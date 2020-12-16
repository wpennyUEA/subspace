function [Lsum] = bnn_loglike (theta,net,tau)
% Compute log-likelihood from vectorised params
% FORMAT [Lsum] = bnn_loglike (theta,net,tau)
%
% theta         vectorised parameters
% net           Neural Net Data Structure
% tau           Data from Learning Episode
%
% Lsum          Log Likelihood

net = bnn_unpack(theta,net,'weights');

[v,L] = bnn(net,tau);
Lsum = sum(L);

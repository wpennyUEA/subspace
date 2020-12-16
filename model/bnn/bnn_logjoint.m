function [J,dJdtheta,lambda,pc,LogLike] = bnn_logjoint (theta,net,tau)
% Compute LogJoint and derivative from vectorised params
% FORMAT [J,dJdtheta,lambda,pc,LogLike] = bnn_logjoint (theta,net,tau)
%
% theta         vectorised parameters
% net           Neural Net Data Structure
% tau           Data from Learning Episode
%
% J             Log Joint
% dJdtheta      Derivative of Log Joint
% lambda        Current posterior precision
% pc            Probability of correct decision
% LogLike       Log Likelihood

net = bnn_unpack(theta,net,'weights');

[v,L,back] = bnn(net,tau,1);
g = back.g;
hess = back.hess;
LogLike = sum(L);
T = length(L);
pc = exp(LogLike/T);

err = theta-net.m;
err2 = err.^2;
LogPrior = -0.5*net.P*log(2*pi)+0.5*sum(log(net.lambda))-0.5*sum(net.lambda.*err2);

J = LogLike + LogPrior;

if net.analytic_gradient
    dJdtheta = sum(g')'-net.lambda.*err;
else
    gc = spm_diff ('bnn_loglike',theta,net,tau,1);
    gc = full(gc);
    gc = gc(:);
    dJdtheta = gc-net.lambda.*err;
end

lambda = net.lambda - hess;
function [E,dJdtheta] = bnn_tune_alpha (alpha,theta,net,tau,dJdtheta)
% Compute negative Log Joint for given step size and gradient
% FORMAT [E,dJdtheta] = bnn_tune_alpha (alpha,theta,net,tau,dJdtheta)
%
% alpha         step size
% theta         vectorised parameters
% net           Neural Net Data Structure
% tau           Data from Learning Episode
% dJdtheta      gradient
%
% E             Negative Log Joint

theta_new = theta + alpha*dJdtheta;

[J,dJdtheta] = bnn_logjoint (theta_new,net,tau);

E = -J;
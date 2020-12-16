function [ymod] = bnn_mod_output (a,vara)
% Compute moderated output
% FORMAT [ymod] = bnn_mod_output (a,vara)
%
% a         activation
% vara      variance of activation

kappa = sqrt(1+pi*vara./8);
kappa = 1./kappa;
ymod = 1./(1+exp(-kappa.*a));

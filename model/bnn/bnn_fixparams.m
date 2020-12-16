function [net] = bnn_fixparams (net,set,lambda_hard)
% Fix parameters to chosen values using hard prior
% FORMAT [net] = bnn_fixparams (net,set,lambda_hard)
%
% net           Neural Net Data Structure
% set           List of fields contains parameters to set
% lambda_hard   Prior Precision
%
% net.m         Set relevant prior means
% net.lambda    Set relevant prior precisions

if nargin < 3, lambda_hard=1000; end

theta_old = bnn_pack(net,'weights');

F=fields(set);
N=length(F);
for f=1:N,
    str=['net.',F{f},'=set.',F{f},';'];
    eval(str);
end

theta_new = bnn_pack(net,'weights');

% Find parameters that have been updated
ind=~((theta_new-theta_old)==0);

% Set prior mean to new values with high prior precision
net.m(ind) = theta_new(ind);
net.lambda(ind) = lambda_hard;
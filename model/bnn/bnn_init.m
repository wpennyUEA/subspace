function [net] = bnn_init (net)
% Initialise new Bayes neural net (bnn)
% FORMAT [net] = bnn_init (net)
%
% net       Neural Net Data Structure
%
% net       Neural Net Data Structure

net.task_index=1;

D = net.D;

% Scale prior STD DEV's to sqrt(in+1) with in=fan in
% Nabney p.153
scale.W1 = ones(net.H1,D)/sqrt(D+1);
scale.W2 = ones(net.H2,net.H1)/sqrt(net.H1+1);
scale.task{1}.w = ones(net.H2,1)/sqrt(net.H2+1);
scale.b1 = ones(net.H1,1)/sqrt(D+1);
scale.b2 = ones(net.H2,1)/sqrt(net.H1+1);
scale.task{1}.b = ones(1,1)/sqrt(net.H2+1);
scale.task_index = net.task_index;
std_dev = bnn_pack (scale,'weights');

net.P = length(std_dev);

% Prior mean and precision
net.m = zeros(net.P,1);
net.lambda=1./(std_dev.^2);
net.lambda = net.lambda/10;
net.std_dev = sqrt(1./net.lambda);

net.task{1}.P = eye(net.H2);
net.task{1}.Nx = size(net.task{1}.P,1);

theta = randn(net.P,1).*std_dev;
net = bnn_unpack(theta,net,'weights');

net.layer1='linear';
%net.layer2='RELU';
net.layer2='GELU';
%net.layer2='COS';
%net.layer2='Gabor';

net.analytic_gradient = 1;

net = bnn_indices (net);


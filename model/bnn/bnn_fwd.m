function [R] = bnn_fwd (net,u,s)
% Forward pass through MLP
% FORMAT [R] = bnn_fwd (net,u,s)
%
% net       Neural Net Data Structure (see bnn.m)
% u         Input Stimulus
% s         Task
% a         Decision
%
% R         Responses
%           .x1        First layer responses
%           .x2        Second layer responses
%           .x         Second layer responses specific to task s
%           .act       activation
%           .y         Output 

R.a1 = net.W1*u+net.b1;
R.x1 = bnn_actfun (R.a1,net.layer1);

R.a2 = net.W2*R.x1+net.b2;
R.x2 = bnn_actfun (R.a2,net.layer2);

R.x = net.task{s}.P*R.x2;
R.act = net.task{s}.w'*R.x + net.task{s}.b;
R.y = 1/(1+exp(-R.act));



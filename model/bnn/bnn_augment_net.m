function [net2] = bnn_augment_net (net1,new)
% Create augmented parameter values from old and new
% FORMAT [net2] = bnn_augment_net (net1,new)
%
% net1      Network trained on task1
% new       Data structure describing new connections
%           e.g. means or precisions
%           .W1, .b1        first layer
%           .back_W2        new hidden units to task1 output net
%           .transfer_W2    transfer units
%           .within_W2      new hidden units to task2 output net

net2.W1 = [net1.W1;new.W1];
net2.b1 = [net1.b1;new.b1];
net2.H1 = size(net2.W1,1);

% New (zero) connections back to task 1 subnetwork
% Precisions will be Inf
net2.W2=[net1.W2,new.back_W2];

% New fully connected connections to task2 subnetwork
% Precisions will be lower - some for transfer, some for new mapping

net2.H2=net1.H2+new.H2;
net2.W2=[net2.W2; [new.transfer_W2,new.within_W2]];
net2.b2=[net1.b2;new.b2];

net2.task{1} = net1.task{1};
net2.task{2}.w = new.w;
net2.task{2}.b = new.b;
net2.task{2}.Nx = new.H2;
net2.task{2}.P = [zeros(new.H2,net1.H2),eye(new.H2)];
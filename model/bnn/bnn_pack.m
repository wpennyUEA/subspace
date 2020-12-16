function [theta] = bnn_pack (net,params)
% Pack parameters into vector 
% FORMAT [theta] = bnn_pack (net,params)
%
% net           bnn data structure
% params        'weights' or 'derivs'
%
% theta         vectorised parameters
%
% Because parameters are a function of task this code will only
% support Sequential/Continual learning and not Simultaneous/Multitask
% learning (the latter being where training examplars from multiple tasks
% are intermixed in a single batch).

n = net.task_index;

switch params,
    case 'weights',
        theta = [net.W1(:);net.W2(:);net.task{n}.w;net.b1(:);net.b2(:);net.task{n}.b(:)];
    case 'derivs',
        theta = [net.dLdW1(:);net.dLdW2(:);net.dLdw(:);net.dLdb1(:);net.dLdb2(:);net.dLdb];
    otherwise
        disp('Unknown packing type in bnn_pack.m');
end
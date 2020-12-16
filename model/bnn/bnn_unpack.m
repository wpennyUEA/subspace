function [net] = bnn_unpack (theta,net,params)
% Unpack vectorised parameter format
% FORMAT [net] = bnn_unpack (theta,net,params)
%
% theta         vectorised parameters
% net           Neural Net Data Structure
% params        'weights' or 'derivs'
% n             Task index
%
% net           Neural Net Data Structure

n = net.task_index;

switch params,
    case 'weights',
        
        P = net.H1*net.D;
        net.W1 = reshape(theta(1:P),net.H1,net.D);
        theta(1:P)=[];
        
        P = net.H2*net.H1;
        net.W2 = reshape(theta(1:P),net.H2,net.H1);
        theta(1:P)=[];
        
        %P = net.H2;
        P = net.task{n}.Nx;
        net.task{n}.w = theta(1:P);
        theta(1:P)=[];
        
        P = net.H1;
        net.b1 = theta(1:P);
        theta(1:P)=[];
        
        P = net.H2;
        net.b2 = theta(1:P);
        theta(1:P)=[];
        
        net.task{n}.b=theta;
        
    case 'derivs',
        disp('Error in bnn_unpack.m: Code not written yet !');
end
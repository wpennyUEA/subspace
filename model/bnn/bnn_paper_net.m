function [netA,netB,netC,theta_init] = bnn_paper_net (tau)
% Train network for paper using default method
% FORMAT [netA,netB,netC,theta_init] = bnn_paper_net (tau)
%
% tau       data set
%
% netA          initialised using bnn_init.m
% netB          after prior is setup
% netC          fitted to data
% theta_init    from bnn_default_params

prior='weak-bias';
if strcmp(prior,'weak-bias')
    % Fix first layer bias weights to zero
    % But add extra input - the constant '6'
    T=length(tau.r);
    tau.u = [tau.u; 6*ones(1,T)];
    net.D = 3;
else
    net.D = 2;
end
net.H1=1;
net.H2=4;
netA = bnn_init(net);

[theta_init,netB,opt] = bnn_default_params (netA,prior);
opt.verbose = 1;

[netC,op] = bnn_opt (theta_init,netB,tau,opt);
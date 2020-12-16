function [net2,theta] = bnn_init_fixed (net1,lambda)
% Initialise second (augmented) neural net - no new first layer units
% FORMAT [net2,theta] = bnn_init_fixed (net1,lambda)
%
% net1          Fitted net1 model
% lambda        .forward from task1 hidden to task2 out
%               .out     output network for task two
%
% net2          .m       prior mean
%               .lambda  prior precision
%               .P       number of parameters
%               .oldind  indices of old parameters (from net1)
%               .newind  indices of new parameters
%
% theta         new parameters sampled from prior,
%               old parameters as before

task_index =2;

% Prior means of new parameters
new.H2 = 4;
new.transfer_W2 = zeros(new.H2,net1.H1);
new.b2 = zeros(new.H2,1);
new.w = zeros(new.H2,1);
new.b = 0;

net2 = bnn_augment_fixed (net1,new);
net2.task_index = task_index;
net2.D = net1.D;
net2.layer1=net1.layer1;
net2.layer2=net1.layer2;

% Prior precisions of new parameters
Lnew = new;
Lnew.transfer_W2 = lambda.forward*ones(new.H2,net1.H1);
Lnew.b2=lambda.out*ones(new.H2,1);
Lnew.w = lambda.out*ones(new.H2,1);
Lnew.b = lambda.out;

Lambda1 = bnn_unpack(net1.lambda_post,net1,'weights');
Lambda2 = bnn_augment_fixed (Lambda1,Lnew);
Lambda2.task_index = 2;

% Set prior mean and precision vectors for net2
net2.m = bnn_pack(net2,'weights');
net2.lambda = bnn_pack(Lambda2,'weights');
net2.P = length(net2.m);

% Sample from the informative prior
std_dev = sqrt(1./net2.lambda);
theta = randn(net2.P,1).*std_dev + net2.m;

% Get indices of old parameters in net2 
key=rand(1);
tmp1=net1;
tmp1.W1=key*ones(net1.H1,net1.D);
tmp1.W2=key*ones(net1.H2,net1.H1);
tmp1.b1=key*ones(net1.H1,1);
tmp1.b2=key*ones(net1.H2,1);
tmp2 = bnn_augment_fixed (tmp1,new);
tmp2.task_index = task_index;
m2 = bnn_pack(tmp2,'weights');
ind2=find(m2==key);

% Get indices of old parameters in net1
m1 = bnn_pack(tmp1,'weights');
ind1 = find(m1==key);

% Re-instate old values
theta(ind2)=net1.m_post(ind1);

net2.oldind=ind2;
net2.newind=setdiff([1:net2.P],ind2)';


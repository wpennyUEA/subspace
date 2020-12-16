function [rewards,pcexp,block] = task2_mix (sim,net1,train)
% Fit block-by-block models to task 2 data - using mixture priors
% FORMAT [rewards,pcexp,block] = task2_mix (sim,net1,train)
%
% sim       Simulation data structure
% net1      bnn trained on first task
% train     Task 2 Data Set
%
% rewards   actual rewards received
% pcexp     expected reward
% block     Block-by-block models

second = sim.second;          % Task 1 definition e.g. Sub1
Nblock = sim.Nblock;        % Number of blocks

opt = bnn_default_opt();
opt.verbose = 1;
opt.restarts = sim.restarts;

net1 = bnn_unpack(net1.m_post,net1,'weights');

% Prior component for net 2
group1.ind = net1.unit(1).ind;
if net1.H1==2
    group1.ind = [group1.ind; net1.unit(1).ind];
end
group1.m(:,1) = [net1.W1(:);net1.b1];
group1.lambda(:,1) = net1.lambda_post(group1.ind);
group1.prior = [1-sim.Gamma,sim.Gamma]';
    
% Initialise Variable Capacity Network - Tabula Rasa
net2 = [];
net2.D = net1.D;
net2.H1 = net1.H1;
net2.H2 = net1.H2;
net2 = bnn_init(net2);

% Now add prior component from net 1
[tmp,net2,opt] = bnn_default_params (net2,sim.prior,group1);
net2.analytic_gradient=1;
opt.verbose=0;
opt.restarts = sim.restarts;

% Get new data set of decisions from BNN agent
% interacting with environment
[a,r] = bnn_agent (net2,second.task,train{1});
train{1}.a=a;
train{1}.r=r;
rewards(1)=mean(r);
tau = train{1};

% Also record expected probability of being correct
pcexp(1) = bnn_epc (net2,second.task,train{1});
    
net2.analytic_gradient=1;

% First sample of theta is from mixture prior
theta = bnn_sample (net2,opt.restarts);
[block(1).net,op] = bnn_opt (theta,net2,tau,opt);
block(1).net.op = op;

for b=2:Nblock,
    %disp(sprintf('Task 1, Block %d',b));
    
    % Get new data set of decisions from BNN agent
    % interacting with environment
    [a,r] = bnn_agent (block(b-1).net,second.task,train{b});
    train{b}.a=a;
    train{b}.r=r;
    rewards(b)=mean(r);
    tau = train{b};
    
    % Also record expected probability of being correct
    pcexp(b) = bnn_epc (block(b-1).net,second.task,train{b});
    
    % Update block model by training on new data
    net = block(b-1).net;
    
    % Update component mean and precisions
    for p=1:2,
        net.group(p).m = net.m_post(net.group(p).ind);
        net.group(p).lambda = net.lambda_post(net.group(p).ind);
    end
    net.m = net.m_post;
    net.lambda = net.lambda_post;
    theta = bnn_sample(net,opt.restarts);
    theta(:,1) = net.m;
    
    [block(b).net,op] = bnn_opt (theta,net,tau,opt);
    block(b).net.op = op;
       
end




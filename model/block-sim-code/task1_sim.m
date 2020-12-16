function [rewards,pcexp,block] = task1_sim (sim,train)
% Fit block-by-block models to task 1 data
% FORMAT [rewards,pcexp,block] = task1_sim (sim,train)
%
% sim       Simulation data structure
% train     Task 1 Data Set
%
% rewards   actual rewards received
% pcexp     expected reward
% block     Block-by-block models

first = sim.first;          % Task 1 definition e.g. Sub1
Nblock = sim.Nblock;        % Number of blocks

% Initialise BNN 
sim.net = bnn_init(sim.net);
[theta,block(1).net,opt] = bnn_default_params (sim.net,sim.prior);
opt.verbose = 0;    
opt.restarts = sim.restarts;

for b=1:Nblock,
    %disp(sprintf('Task 1, Block %d',b));
    
    % Get new data set of decisions from BNN agent
    % interacting with environment
    if b==1
        [a,r] = bnn_agent (block(1).net,first.task,train{1});
        pcexp(1) = bnn_epc (block(1).net,first.task,train{1});
    else
        [a,r] = bnn_agent (block(b-1).net,first.task,train{b});
        pcexp(b) = bnn_epc (block(b-1).net,first.task,train{b});
    end
    train{b}.a=a;
    train{b}.r=r;
    rewards(b)=mean(r);
    tau = train{b};
    
    % Update block model by training on new data
    if b==1
        theta = bnn_sample(block(1).net,opt.restarts);
        block(1).net = bnn_opt (theta,block(1).net,tau,opt);
    else
        net = block(b-1).net;
        net.m = net.m_post;
        net.lambda = net.lambda_post;
        theta = bnn_sample(net,opt.restarts);
        theta(:,1) = net.m;
        block(b).net = bnn_opt (theta,net,tau,opt);
    end
       
end




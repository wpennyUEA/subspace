function [a,r] = bnn_agent (net,task,test)
% Compute decisions made and reward received by BNN agent
% FORMAT [a,r] = bnn_agent (net,task,test)
%
% net       network data structure
% task      see e.g. rl_task_qlr (i.e. type of environment)
% test      .c, .u test set inputs
%
% a         [T x 1] vector of decisions made
% r         [T x 1] vector of rewards received
          
% Task index is fixed over all time points in batch
% tau.s is not read !!!
st = net.task_index;

Ntest=length(test.c);
for t=1:Ntest,
    ut=test.u(:,t);
    %st=test.s(t);
    
    R = bnn_fwd (net,ut,st);
    vt = [R.y, 1-R.y];
    
    a(t) = rl_decide(vt,1);
    [v,pr,r(t)] = rl_task_reward(task{1},ut,a(t));
end
function [pcexp,Lexp] = bnn_epc (net,task,test)
% Compute expected probability of being correct 
% FORMAT [pcexp,Lexp] = bnn_epc (net,task,test)
%
% mvl       data structure
% task      see e.g. rl_task_qlr
% test      .c, .u test set inputs
%
% mvl       .
% pcexp     expected prob corr (per pattern likelihood) at test
% Lexp      expected log likelihood of reward at test
          
% Task index is fixed over all time points in batch
% tau.s is not read !!!
st = net.task_index;

Ntest=length(test.c);
for t=1:Ntest,
    ut=test.u(:,t);
    %st=test.s(t);
    
    R = bnn_fwd (net,ut,st);
    vt = [R.y, 1-R.y];
    
    a = rl_decide(vt,1);
    [v,pr] = rl_task_reward(task{1},ut,a);
    ell(t) = pr*log(vt(a)+eps)+(1-pr)*log(1-vt(a)+eps);
end
Lexp=sum(ell);
pcexp=exp(Lexp/Ntest);
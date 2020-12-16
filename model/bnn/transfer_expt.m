function [expt,results] = transfer_expt (expt)
% Transfer Experiment 
% FORMAT [expt,results] = transfer_expt (expt)

% --------------------------------------------
% Define task 1 and 2 mappings

map={'tau_Sub1_100','tau_Add1_100','tau_Sub2_100','tau_Add2_100'};
mapname={'Sub1','Add1','Sub2','Add2'};

load_str=sprintf('load data/%s',map{expt.a});
eval(load_str);
task1.tau=tau;

load_str=sprintf('load data/%s',map{expt.b(1)});
eval(load_str);
task2(1).tau=tau;

load_str=sprintf('load data/%s',map{expt.b(2)});
eval(load_str);
task2(2).tau=tau;

results.task1=task1;
results.task2=task2;

% Set up network for first task
prior='weak-bias';
if strcmp(prior,'weak-bias')
    % Fix first layer bias weights to zero
    % But add extra input - the constant '6'
    T=length(task1.tau.r);
    task1.tau.u = [task1.tau.u; 6*ones(1,T)];
    task2(1).tau.u = [task2(1).tau.u; 6*ones(1,T)];
    task2(2).tau.u = [task2(2).tau.u; 6*ones(1,T)];
    net.D = 3;
else
    net.D = 2;
end
net.H1=expt.H1;
net.H2=4;
net = bnn_init(net);
    
for rep = 1:expt.Nreps,
    
    disp(sprintf('Rep %d out of %d',rep,expt.Nreps));
    
    % --------------------------------------------
    % Train on Task 1
    
    [theta,net1,opt] = bnn_default_params (net,'weak-bias');
    opt.verbose = 0;
    
    opt.restarts=expt.max_restarts_1;
    theta = bnn_sample(net1,opt.restarts);
    
    [net1,op] = bnn_opt (theta,net1,task1.tau,opt);
    net1 = bnn_unpack(net1.m_post,net1,'weights');
    
    results.rep(rep).net1=net1;
    
    task1.pcexp(rep)=op.pcexp;
    task1.totalits(rep)=sum(op.its);
    task1.restarts(rep)=op.r;
    
    % Prior component for net 2
    group1.ind = net1.unit(1).ind;
    if expt.H1==2
        group1.ind = [group1.ind; net1.unit(1).ind];
    end
    group1.m(:,1) = [net1.W1(:);net1.b1];
    if expt.reset_precision
        group1.lambda(:,1) = net1.lambda(group1.ind);
    else
        group1.lambda(:,1) = net1.lambda_post(group1.ind);
    end
    group1.prior = [1-expt.Gamma,expt.Gamma]';
        
    % --------------------------------------------
    % Train on Task 2
    
    for i=1:2,
        
        disp(sprintf('Task 2 from %s ...',map{expt.b(i)}));
        net2 = [];
        % Initialise Variable Capacity Network - Tabula Rasa
        net2.D = net1.D;
        net2.H1 = net1.H1;
        net2.H2 = net1.H2;
        net2 = bnn_init(net2);
        
        [tmp,net2,opt] = bnn_default_params (net2,'mixture',group1);
        
        net2.analytic_gradient=1;
        
        opt.restarts=expt.max_restarts_2;
        opt.verbose=0;
        [theta,z1] = bnn_sample (net2,opt.restarts); 
        
        [net2,op] = bnn_opt (theta,net2,task2(i).tau,opt);
        
        [tmp,ind] = max(op.pc);
        disp(sprintf('Solution found for z1=%d', z1(ind)));
        
        results.rep(rep).task2(i).net2=net2;
        task2(i).z1(rep)=z1(ind);
        
        task2(i).pcexp(rep)=op.pcexp;
        task2(i).totalits(rep)=sum(op.its);
        task2(i).restarts(rep)=op.r;
        
    end
    
end

results.task1=task1;
results.task2=task2;

pc_sem=std(task1.pcexp)/sqrt(expt.Nreps);
pc1_sem=std(task2(1).pcexp)/sqrt(expt.Nreps);
pc2_sem=std(task2(2).pcexp)/sqrt(expt.Nreps);

disp(' ');
disp(expt.task1);
disp(sprintf('Gamma = %1.2f, Nreps=%d',expt.Gamma,expt.Nreps));
disp(' ');
disp(sprintf('Task 1 pc = %1.2f (sem=%1.2f)', mean(task1.pcexp),pc_sem));
disp(sprintf('Task 2 (Same) pc = %1.2f (sem=%1.2f)', mean(task2(1).pcexp),pc_sem));
disp(sprintf('Task 2 (Diff) pc = %1.2f (sem=%1.2f)', mean(task2(2).pcexp),pc_sem));
disp(' ');
disp('PCEXP:');
my_ttest_paired(task2(1).pcexp,task2(2).pcexp,{'Same','Diff'});
disp('RESTARTS:');
my_ttest_paired(task2(1).restarts,task2(2).restarts,{'Same','Diff'});
disp('ITERATIONS:');
my_ttest_paired(task2(1).totalits,task2(2).totalits,{'Same','Diff'});


[R,pval]=corrcoef(task1.pcexp,task2(1).pcexp);
disp(sprintf('Same Subspace: r_pc = %1.2f (p=%1.3f)',R(1,2),pval(1,2)));

[R,pval]=corrcoef(task1.pcexp,task2(2).pcexp);
disp(sprintf('Diff Subspace: r_pc = %1.2f (p=%1.3f)',R(1,2),pval(1,2)));

if expt.Gamma > 0
    for i=1:2,
        ind=find(task2(i).z1==1);
        pc1=task2(i).pcexp(ind);
        
        ind=find(task2(i).z1==2);
        pc2=task2(i).pcexp(ind);
        disp(mapname{b(i)});
        [mx,my] = my_ttest2 (pc1,pc2,{'Z1','Z2'});
    end
end


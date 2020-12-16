
clear all
close all

% Create data set data from each task
sim.rbf_type='RBF-C';

mvl = mvl_default_params ();
D=2;

% Each task has 5 blocks wih 50 trials each
blocktrials = 100;

name={'Sub1','Sub2','Add1','Add2'};
for i=1:4,
    first_task{1} = rl_subspace_task (name{i});
    train{1} = rl_task_train_all (first_task{1},blocktrials,D);
    train{1}.s = ones(blocktrials,1);
    [tmp,tau] = mvl_rbf_learn (mvl,first_task,train{1});
    
    save_str=sprintf('save ../bnn/data/tau_%s_%d',name{i},blocktrials);
    eval(save_str);
end



function [outfile] = task2_sim_expt(task1,task1_results_file,sim2)
% Run nets on task2
% FORMAT [outfile] = task2_sim_expt(task1,task1_results_file,sim2)
%
% task1                 1 for Sub1, 2 for Add1
% task1_results_file    Filename
%

load_str=['load results/',task1_results_file];
eval(load_str);
task1_str=map(task1).name;
disp(sprintf('Task 2 after Task1 = %s ...',task1_str));

Din=2;
B=sim.Nblock;

% 0 - for fixed number of first layer units
% 1 - to add more for second task
sim.addH1units=0;

sim.prior = sim2.prior;
sim.Gamma = sim2.Gamma;
verbose = 0;

names={'Sub2','Add2'};
for i=1:length(names),
    disp(sprintf('Task 2 = %s',names{i}));
    second_task{1} = rl_subspace_task (names{i},verbose);
    sim.second.task = second_task;
    
    % Task 1 Data - Sub1 or Add1
    for b=1:B,
        train{b} = rl_task_train_all (second_task{1},sim.blocktrials,Din);
        train{b}.s = ones(sim.blocktrials,1);
        
        if sim.net.D==3
            % Add column of 6's to input
            train{b}.u = [train{b}.u; 6*ones(1,sim.blocktrials)];
        end
    end
    
    for r=1:sim.R,
        disp(sprintf('Repetition %d out of %d',r,sim.R));
        
        net1 = map(task1).run(r).block(B).net;
        if strcmp(sim.prior,'mixture')
            [rewards(r,:),pcexp(r,:),block] = task2_mix (sim,net1,train);
        else
            [rewards(r,:),pcexp(r,:),block] = task2_sim (sim,net1,train);
        end
        run(r).block=block;
    end
    
    map2(i).name=names{i};
    map2(i).mr=mean(rewards);
    map2(i).semr=std(rewards)/sqrt(sim.R);
    map2(i).me=mean(pcexp);
    map2(i).seme=std(pcexp)/sqrt(sim.R);
    
    map2(i).rewards=rewards;
    map2(i).pcexp=pcexp;
    map2(i).run=run;
end

outfile=['task2-after-',task1_str,'-',task1_results_file];
save_str=['save results/',outfile,' map2 sim names task1_str'];
eval(save_str);

figure
plot_task2_by_block (task1_str,map2);


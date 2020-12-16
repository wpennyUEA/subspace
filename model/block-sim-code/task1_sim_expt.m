function [outfile] = task1_sim_expt (postfix,sim)
% Fit NN model to blocks of data
% FORMAT [outfile] = task1_sim_expt (postfix,sim)
%
% postfix       determines output filename
% sim           .R      number of simulation runs
%               .net    network data structure
%               .prior  type of prior
%
% outfile       output filename

disp('Task 1 Experiment ...');

Din=2;

verbose=0;

%names={'Sub1','Add1','Sub2','Add2'};
names={'Sub1','Add1'};
%names={'Sub2','Add2'};
for i=1:length(names),
    first_task{1} = rl_subspace_task (names{i},verbose);
    sim.first.task = first_task;
    
    % Task 1 Data - Sub1 or Add1
    for b=1:sim.Nblock,
        train{b} = rl_task_train_all (first_task{1},sim.blocktrials,Din);
        train{b}.s = ones(sim.blocktrials,1);
        
        if sim.net.D==3
            % Add column of 6's to input
            train{b}.u = [train{b}.u; 6*ones(1,sim.blocktrials)];
        end
    end
    
    for r=1:sim.R,
        disp(sprintf('Repetition %d out of %d',r,sim.R));
        [rewards(r,:),pcexp(r,:),block] = task1_sim (sim,train);
        run(r).block=block;
    end
    
    map(i).name=names{i};
    map(i).mr=mean(rewards);
    map(i).semr=std(rewards)/sqrt(sim.R);
    map(i).me=mean(pcexp);
    map(i).seme=std(pcexp)/sqrt(sim.R);
    
    map(i).rewards=rewards;
    map(i).pcexp=pcexp;
    map(i).run=run;
   
end

outfile=['task1',postfix];
save_str=['save results/',outfile,' map sim names'];
eval(save_str);

figure
plot_task1_by_block(names,map);



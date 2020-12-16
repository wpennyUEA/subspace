

sim2.prior = 'mixture';
sim2.Gamma = 0;

% F1 is the results data file produced by
% transfer_expt_part1.m

tic; F2 = task2_sim_expt (1,F1,sim2); toc
tic; F3 = task2_sim_expt (2,F1,sim2); toc

plot_results (F1,F2,F3);

corr_results(F1,F2,F3);
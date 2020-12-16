%
% Block-by-Block (within- and between-task) learning code.
% 
% December 2020
%
% For "Multitask Learning over Shared Subspace" submitted to 
% PLoS Computational Biology
%
% Nicho Menghi and Will Penny, 
% School of Psychology, 
% University of East Anglia, UK.
%
% These scripts and functions require the following directories
% on your search path. These are also distributed in this archive
%
% ../bnn                    Bayes neural nets
% ../spm-stats              Stats and other routines
% ../classic-stats          Wrappers for simple statistical tests
% ../mtl-devel/mtl-code     Old multitask learning code
% ../mtl-devel/rl-tasks     Mapping functions (Sub1/Add1/Sub2/Add2)
%
% -------------------------------------------------------------------------
%
% transfer_expt_part1.m     These two scripts together run the simulations
% transfer_expt_part2.m 
%
% -------------------------------------------------------------------------
% Auxiliary Functions
%
% task1_sim_expt.m      Organise data structures before callign task1_sim
% task2_sim_expt.m      Organise data structures before callign task2_sim
% task1_sim.m           Run learning on task 1 blocks
% task2_mix.m           Run learning on task 2 blocks
%
% corr_results.m        correlations over tasks
% plot_resub_results.m  block-by-block learning plots over both tasks
% task1_save_tau.m      create "tau", a data set of actions, rewards etc.
% -------------------------------------------------------------------------
%

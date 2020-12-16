%
% BEHAVIOURAL DATA ANALYSIS
% 
% October 2020
%
% For "Multitask Learning over Shared Subspace" submitted to 
% PLoS Computational Biology
%
% Nicho Menghi and Will Penny, 
% School of Psychology, 
% University of East Anglia, UK.
%
%
% -------------------------------------------------------------------------
%
% sbj/sjbn                  Data folder for subject n=1..80 in study
%                           These data files are read into Matlab 
%                           using the function get_expML_data.m which 
%                           is called by the script DataStructure.m 
%                           (see below)
% -------------------------------------------------------------------------
%
% second_analyses.m         Run data analyses and create images for 
%                           second version of paper
%
% first_analyses.m          Analyses and plots for first paper submission
%
% -------------------------------------------------------------------------
%
% declarations.xlsx         Declarations data file in XL format           
%                           
%
% DataStructure.m           Reads in XL file, creates matlab format data: 
%                           Results.mat. See help for Data Format
%
% effect_of_mapping.m       Is accuracy higher for linear vs 
%                           nonlinear mappings ? Is accuracy higher for add
%                           versus sub mappings ?
%
% mean_trajectories.m       Plot block trajectories in same format as 
%                           modelling results.
%
% mean_trajectories_novag.m    As previous but without average effect
%
% corr_trajectories.m       Plot correlation between last block of task 1,
%                           and block b of task 2, versus b, with 95% CIs.
%                           Separately for Same/Diff and Add/Sub.
%
% mean_diff_tests.m         Is the difference in mean accuracy for task1
%                           versus task2 different for Same versus Diff
%                           subspaces ? ie. Interaction (Task * Subspace).
%                           Ask this separately for task1 = add,
%                           task1 = sub, and collapsing over both.
%
% corr_diff_tests.m         Is correlation between task1 and task2 accuracy
%                           stronger for Same versus Diff
%                           Subspace ? Ask this separately for task1 = add,
%                           task1 = sub, and collapsing over both.
%
% SignSubspaceBlock.m       Three-way mixed ANOVA with independent factors 
%                           of Sign (Sub/Add), Subspace (Same/Diff) and 
%                           Block (1-5). Dependent data is correct rate on
%                           Task2 blocks.
%                           
% -------------------------------------------------------------------------
% Auxiliary Functions
%
% get_expML_data.m          Extract data for specific subject
% get_dec_table.m           Extract declarations for subjects
% get_data_same_diff.m      Get data in same/diff x add/sub format
%
% -------------------------------------------------------------------------
%

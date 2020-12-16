
clear all
close all

% Run this script and then transfer_expt_part2.m
% for block-by-block within- and between-task learning simulations

c=clock;
postfix=['-',num2str(c(2)),'-',num2str(c(3)),'-',num2str(c(4)),'-',num2str(c(5))];

% Simulation parameters
sim.R=40;
sim.net.D=3;
sim.net.H1=1;
sim.net.H2=4;

sim.Nblock = 10;
sim.blocktrials = 25;
sim.verbose = 1;
sim.prior = 'weak-bias';
%sim.prior='fix-bias';
sim.restarts = 3;

tic; F1 = task1_sim_expt (postfix,sim); toc

disp(' ');
disp('Part 1 filename:');
disp(F1);
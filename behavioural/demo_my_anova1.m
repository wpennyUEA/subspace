
close all
clear all

disp('One-Way ANOVA demo.');
disp(' ');

% Name your groups here
group(1).name='Frogs';
group(2).name='Bears';
group(3).name='Bats';

% Add your data in here
group(1).x = randn(10,1)+3;
group(2).x = randn(13,1)+4;
group(3).x = randn(9,1)+2;

[p,stats] = my_anova1 (group);


[p,stats] = glm_anova1 (group);
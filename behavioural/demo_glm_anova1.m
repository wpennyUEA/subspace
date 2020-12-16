
close all
clear all

disp('One-Way ANOVA demo using the GLM approach');
disp('This allows you to also enter confounds');
disp(' ');

% Name your groups here
group(1).name='Frogs';
group(2).name='Bears';
group(3).name='Bats';

% Add your data in here
N1=12; N2=13; N3=9;
group(1).x = randn(N1,1)+3;
group(2).x = randn(N2,1)+4;
group(3).x = randn(N3,1)+2;

disp(' ');
disp('Without confounds:');
[p,stats] = glm_anova1 (group);

disp(' ');
disp('With confounds:');
Xc = randn(N1+N2+N3,3);
[p,stats] = glm_anova1 (group,Xc);
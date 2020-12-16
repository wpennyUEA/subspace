
clear all
close all

N=12;
X=randn(N,2);
e=randn(N,1);
        
ex=1;
switch ex,
    case 1,
        disp('Example 1:');
        beta = [0 0]';
        
    case 2,
        disp('Example 2:');
        beta = [3 2]';
end

y = X * beta + e;

effect(1).c = [1 0; 0 1];
effect(2).c = [1 -1]';

for i=1:length(effect)
    stats = glm_test_hypothesis (X,y,effect(i).c);
    disp(' ');
    disp('True effect:');
    disp(effect(i).c'*beta);
    disp(' ');
    disp('Estimated effect:');
    disp(stats.effect);
    disp(sprintf('F=%1.2f, df=(%1.2f,%1.2f), p=%1.6f', stats.F,stats.df(1),stats.df(2),stats.p));
    disp(' ');
end



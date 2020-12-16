
clear all
close all

% ---------------------------------------------------------
% This code produces simulution results for the second  
% submission of the PLoS-CB paper: 
%
% minimal capacity network (H1=1)
% increased capacity network (H1=2)
% reduced precision representation (expt.reset_precision=1)
% ---------------------------------------------------------

expt.Gamma = 0;
expt.Nreps = 40;
expt.max_restarts_1=3;
expt.max_restarts_2=3;
expt.reset_precision=1;

task1_names={'Sub1','Add1'};

for H1=1:2,
    for t1=1:2,
        expt.H1 = H1;
        expt.task1 = task1_names{t1};
        disp(sprintf('H1 = %d, Task1 = %s',H1,expt.task1));
        if strcmp(expt.task1,'Sub1')
            expt.a = 1;
            expt.b = [3,4];
        else
            expt.a = 2;
            expt.b = [4,3];
        end
        
        [expt,results] = transfer_expt (expt);
        
        c=clock;
        postfix=['-',num2str(c(2)),'-',num2str(c(3)),'-',num2str(c(4)),'-',num2str(c(5))];
        outfile=[expt.task1,'-H',int2str(H1),'-R',int2str(expt.Nreps),postfix];
        save_str=['save results/',outfile,' expt results'];
        eval(save_str);
    end
end
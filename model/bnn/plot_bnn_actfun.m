
clear all
close all

%name={'linear','sigmoid','RELU','GELU','SoftPlus'};
name={'sigmoid','RELU','GELU','COS','Gaussian','Gabor'};
x=[-5:0.1:5];

figure
N=length(name);
for i=1:length(name),
    y = bnn_actfun (x,name{i});
    subplot(2,N,i);
    plot(x,y);
    grid on
    ylabel('y');
    title(name{i});
    
    dydx = bnn_actfun_deriv (x,name{i});
    subplot(2,N,N+i);
    plot(x,dydx);
    grid on
    ylabel('dydx');
    xlabel('x');
end
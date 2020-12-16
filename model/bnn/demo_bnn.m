
clear all
close all

% Load Data Set
%data='tau_Sub2_100';
%data='tau_Add2_100';
%data='tau_Sub2_50';
data='tau_Add1_100';
%data='tau_Sub1_100';
%data='tau_Sub1_50';
load_str=sprintf('load data/%s',data);
eval(load_str);

check_gradients = 1;
fit_data = 1;

plot_data_map(tau);

prior='weak-bias';
if strcmp(prior,'weak-bias')
    % Fix first layer bias weights to zero
    % But add extra input - the constant '6'
    T=length(tau.r);
    tau.u = [tau.u; 6*ones(1,T)];
    net.D = 3;
else
    net.D = 2;
end
net.H1=1;
net.H2=4;
net = bnn_init(net);

[theta,net,opt] = bnn_default_params (net,prior);
opt.verbose = 1;

if check_gradients
    % Check gradient, g=dL/dw, using central differences
    [v,L,back] = bnn(net,tau);
    g = back.g;
    gt=sum(g');
    
    theta = bnn_pack(net,'weights');
    gc = spm_diff ('bnn_loglike',theta,net,tau,1);
    gc = full(gc);
    
    disp('Analytic Gradients:');
    disp(gt);
    disp('Numeric Gradients:');
    disp(gc);
    disp('Mean Abs Difference');
    mean(abs(gt-gc))
end

if fit_data
    
    %[net] = bnn_opt_online (theta,net,tau);
    
    [net,op] = bnn_opt (theta,net,tau,opt);
    
    plot_learnt_maps (net);
    
    %net = bnn_kl_profile (net);
end

    

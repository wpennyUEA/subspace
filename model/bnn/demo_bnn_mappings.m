
clear all
close all

S=20;
%prior='add-sub';
%prior='fix-bias';
prior='weak-bias';

% data={'tau_Sub1_100','tau_Add1_100','tau_Sub2_100','tau_Add2_100'};
% data_name={'Sub1','Add1','Sub2','Add2'};

data={'tau_Add1_100'};
data_name={'Add1'};

for i=1:length(data),
    load_str=sprintf('load data/%s',data{i});
    eval(load_str);
    disp(load_str);
    
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
    
    %[netA,netB,netC,theta_init] = bnn_paper_net (tau);
    
    for s=1:S,
        disp(sprintf('Run %d out of %d',s,S));
        [theta,net,opt] = bnn_default_params (net,prior);
        opt.verbose = 0;
        [net,op] = bnn_opt (theta,net,tau,opt);
        total_its(i,s)=sum(op.its);
        pcexp(i,s)=op.pcexp;
        restarts(i,s)=op.r;
        run(s).net = net;
    end
end

figure
bar(mean(pcexp'));
set(gca,'XTickLabel',data_name);
grid on
ylabel('pcexp');

figure
subplot(2,1,1);
bar(mean(total_its'));
set(gca,'XTickLabel',data_name);
grid on
ylabel('Total Iterations');
subplot(2,1,2);
bar(mean(restarts'));
set(gca,'XTickLabel',data_name);
grid on
ylabel('Restarts');




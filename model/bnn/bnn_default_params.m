function [theta,net,opt] = bnn_default_params (net,prior,group1)
% Return default parameters
% FORMAT [theta,net,opt] = bnn_default_params (net,prior,group1)
%
% net           network data structure
%               .D          number of inputs
% prior         'default'       as in Nabney's book
%               'add-sub'       Add/Sub subspaces
%               'fix-bias'      fix bias to useful values for add/sub
%               'weak-bias'    weakly fix first layer bias weights to 0
%               'mixture'       mixture of subnetworks model
%
% For 'mixture' prior also specify:
% group1        .m(:,1)         mean of component 1 in group 1 
%               .ind            indices of group 1 parameters
%               .prior          [2 x 1] vector of prior probs over
%                               2 components in group 1.

opt = bnn_default_opt();
net.prior = prior;

lambda_fix = 100;

switch lower(prior)
    case 'mixture',
        
        if nargin < 3
            disp('Error in bnn_default_params.m');
            return
        end
        net.group(1).m(:,1) = group1.m(:,1);
        net.group(1).prior = group1.prior;
        net.group(1).ind = group1.ind;
        net.group(1).Np = length(net.group(1).ind);
        
        % First component is informative
        %net.group(1).lambda(:,1) = lambda_fix * ones(net.group(1).Np,1);
        %net.group(1).lambda(net.D+1,1) = 1;
        net.group(1).lambda(:,1) = group1.lambda(:,1);
        net.group(1).std_dev(:,1) = sqrt(1./net.group(1).lambda(:,1));
        
        
        % Second component is vague
        net.group(1).lambda(:,2) = net.lambda(net.group(1).ind);
        net.group(1).std_dev(:,2) = sqrt(1./net.group(1).lambda(:,2));
        net.group(1).m(:,2) = net.m(net.group(1).ind);
        
        % Other units are in output subnetwork (partition 2)
        Np=length(net.m);
        net.group(2).ind = setdiff([1:Np]',net.group(1).ind);
        net.group(2).Np = length(net.group(2).ind);
        
        % One component
        net.group(2).prior = 1;
        
        net.group(2).lambda(:,1) = net.lambda(net.group(2).ind);
        net.group(2).std_dev(:,1) = sqrt(1./net.group(2).lambda(:,1));
        net.group(2).m(:,1) = net.m(net.group(2).ind);
        
        for p=1:2,
            net.m(net.group(p).ind)=net.group(p).m(:,1);
            net.lambda(net.group(p).ind)=net.group(p).lambda(:,1);
        end
        
    case 'add-sub',    
        % Prior means are set encode Add and Diff subspaces
        % with precision set by lambda_fix
        set.W1 = [1 1; 1 -1];
        set.b1 = [-6, 0]';
        
        if net.D==3,
            set.W1 = [setW1, zeros(2,1)];
        end
        net = bnn_fixparams (net,set,lambda_fix);
        
    case 'fix-bias',
        net.b1 = [-6, 0]';
        lambda_b1 = [100,1]';
        
    case 'weak-bias',
        net.b1 = zeros(net.H1,1);
        lambda_b1 = 1*ones(net.H1,1);
        
    otherwise
        disp('Unknown prior in bnn_default_params.m');
        return
end

switch lower(prior)
    case {'fix-bias','weak-bias'}
        for i=1:net.H1,
            ind = net.unit(i).ind;
            bias_ind = ind(end);
            net.m(bias_ind) = net.b1(i);
            net.lambda(bias_ind) = lambda_b1(i);
        end
end
  
theta = bnn_sample(net,1);

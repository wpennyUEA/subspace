function [net] = bnn_indices (net)
% Get indices of vectorised parameters for each network unit
% FORMAT [net] = bnn_fixparams (net)
%
% net           Neural Net Data Structure
%
% net.unit      (i).name  Name of hidden unit
%               (i).ind   Indices

% Some large arbitrary number
key=789887766211;

theta_old = bnn_pack(net,'weights');

k=1;
for h=1:net.H1,
    tmp_net = net;
    tmp_net.W1(h,:) = key;
    tmp_net.b1(h) = key;
    
    theta_new = bnn_pack(tmp_net,'weights');

    % Find parameters that have been updated
    ind_logical=~((theta_new-theta_old)==0);
    ind_int = find(ind_logical==1);
    unit(k).ind=ind_int;
    unit(k).name=['L1U',int2str(h)];
    k=k+1;
end

for h=1:net.H2,
    tmp_net = net;
    tmp_net.W2(h,:) = key;
    tmp_net.b2(h) = key;
    
    theta_new = bnn_pack(tmp_net,'weights');

    % Find parameters that have been updated
    ind_logical=~((theta_new-theta_old)==0);
    ind_int = find(ind_logical==1);
    unit(k).ind=ind_int;
    unit(k).name=['L2U',int2str(h)];
    k=k+1;
end

N=length(net.task);
for h=1:N,
    tmp_net = net;
    tmp_net.task{h}.w(:,1) = key;
    tmp_net.task{h}.b = key;
    
    theta_new = bnn_pack(tmp_net,'weights');

    % Find parameters that have been updated
    ind_logical=~((theta_new-theta_old)==0);
    ind_int = find(ind_logical==1);
    unit(k).ind=ind_int;
    unit(k).name=['L3U',int2str(h)];
    k=k+1;
end

net.unit=unit;

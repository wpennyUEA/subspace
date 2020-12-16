function [net] = bnn_kl_profile (net,show)
% Compute KL between prior and posterior for each network unit
% FORMAT [net] = bnn_kl_profile (net,show)
%
% net       network data structure
% show      1 (default) to make plot of KL profile
%

if nargin < 2, show=1; end

% Number of units in network
U = length(net.unit);

for u=1:U,
    ind = net.unit(u).ind;
    mp = net.m_post(ind);
    vp = 1./net.lambda_post(ind);
    m0 = net.m(ind);
    v0 = 1./net.lambda(ind);
    d_nats = spm_kl_normald (mp,vp,m0,v0);
    net.unit(u).kl = d_nats/log(2); % Nats to bits conversion
    kl(u) = net.unit(u).kl;
    names{u}= net.unit(u).name;
end

if show
    figure
    bar(kl);
    set(gca,'XTickLabel',names);
    grid on
    ylabel('KL-Divergence (bits)');
    xlabel('Network Unit');
    title(sprintf('Total KL-Divergence = %1.2f bits',sum(kl)));
end



function [theta,z1] = bnn_sample (net,S,verbose)
% Sample from prior
% FORMAT [theta,z1] = bnn_sample (net,S,verbose)
%
% net       network data structure
% S         number of samples
% verbose   1 for verbose
%
% theta     [P x S] parameter vectors
% z1        [S x 1] vector containing selected components for subnet 1  

if nargin < 3, verbose=0; end

if strcmp(net.prior,'mixture')
    theta = zeros(net.P,S);
    for s=1:S,
        for p=1:length(net.group),
            % Choose component for this partition/group
            c = spm_multrnd(net.group(p).prior, 1);
            if p==1, z1(s)=c; end
            % Sample parameters
            delta = randn(net.group(p).Np,1).*net.group(p).std_dev(:,c);
            theta(net.group(p).ind,s) = net.group(p).m(:,c) + delta;
        end
    end
else
    if ~isfield(net,'std_dev')
        net.std_dev = sqrt(1./net.lambda);
    end
    for s=1:S,
        delta = randn(net.P,1).*net.std_dev;
        theta(:,s) = net.m + delta;
    end
end


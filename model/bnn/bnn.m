function [v,L,back] = bnn (net,tau,bp,fullhess)
% Forward and Backward Pass through network
% FORMAT [v,L,back] = bnn (net,tau,bp,fullhess)
%
% net       Neural Net Data Structure
%           .layer1    'linear','sigmoid','RELU' etc.
%           .layer2    'linear','sigmoid','RELU' etc
%           .H1  number of units in first layer
%           .H2  number of units in second layer
%
% tau       T Data points from Learning Episode
% bp        bp=1 (default) to also run backprop (backward pass)
% fullhess  1 to return full Hessian matrix (default is 0)
%
% v         [T x 1] value vector 
% L         [T x 1] log-likelihood
%
% back      .g         [P x T] gradient vectors dL_t/dtheta
%           .hess      [P x 1] Diagonal of Hessian
%           .H         [P x P] Full Hessian matrix (outer product approx)
%           .vmod      [T x 1] moderated value vector
%           .Lmod      [T x 1] moderated log-likelihood
%
% g, hess, H, vmod, Lmod are only returned if bp=1
% P is number of model parameters

if nargin < 3 | isempty(bp), bp=1; end
if nargin < 4 | isempty(fullhess), fullhess=0; end

[D,T]=size(tau.u);
v = zeros(T,1);

hess = zeros(net.P,1);

if fullhess
    H = zeros(net.P,net.P);
else
    H=[];
end
L = 0;

% Task index is fixed over all time points in batch
% tau.s is not read !!!
s = net.task_index;

for t=1:T,
    u = tau.u(:,t); % Sensory Input
    a = tau.a(t); % Decision
    r = tau.r(t); % Reward
    
    R = bnn_fwd (net,u,s);
    if a==1,
        v(t) = R.y;
    else
        v(t) = 1-R.y;
    end
    
    % Log-Likelihood
    L(t) = r*log(v(t)+eps) + (1-r)*log(1-v(t)+eps);
    
    if isnan(L(t))
        keyboard
    end
    
    if bp
        % Run Backprop
        %tg=zeros(net.H2,1);
        tg=zeros(net.task{s}.Nx,1);
        
        % Derivative of Likelihood wrt output activation
        if a==1,
            dout = r-v(t);
        else
            dout = -(r-v(t));
        end
        
        % Eq. 22
        grad.dLdw=dout*R.x;
        grad.dLdb=dout;
        
        % Eq. 23
        for h=1:net.task{s}.Nx,
            dydx = bnn_actfun_deriv (R.a2(h),net.layer2);
            tg(h) = dydx*net.task{s}.w(h)*dout;
        end
        
        % Pre-pad d2 with zeros for task 2
        % as per second line of Equation 23
        if s==2
            d2 = [zeros(net.task{s}.Nx,1);tg];
        else
            d2 = tg;
        end
 
        
        % Eq. 24
        for h=1:net.H2,
            grad.dLdW2(h,:)=d2(h)*R.x1';
            grad.dLdb2(h)=d2(h);
        end
        
        % Eq. 25
        for h=1:net.H1,
            dydx = bnn_actfun_deriv (R.a1(h),net.layer1);
            d1(h) = dydx*net.W2(:,h)'*d2;
        end
        
        % Eq. 26
        for h=1:net.H1,
            grad.dLdW1(h,:)=d1(h)*u;
            grad.dLdb1(h)=d1(h);
        end
        
        % Vectorised gradient, dL/dtheta - used for gradient ascent
        grad.task_index = net.task_index;
        g(:,t) = bnn_pack (grad,'derivs');
        
        % Vectorised gradient, dan/dtheta - used for Hessian
        if sum(g(:,t))==0
            eta(:,t) = zeros(net.P,1);
        else
            eta(:,t) = g(:,t)/dout;
        end
        
        if isnan(eta(:,t))
            keyboard
        end
        
        % Hessian
        hess = hess - v(t)*(1-v(t))*eta(:,t).^2;
        if fullhess
            H = H - v(t)*(1-v(t))*eta(:,t)*eta(:,t)';
        end
        
        % Get moderated values
        post_cov = diag(1./net.lambda);
        var_act = eta(:,t)'*post_cov*eta(:,t);
        ymod = bnn_mod_output (R.act,var_act);
        if a==1,
            vmod(t) = ymod;
        else
            vmod(t) = 1-ymod;
        end
        
        % Moderated Log-Likelihood
        Lmod(t) = r*log(vmod(t)+eps) + (1-r)*log(1-vmod(t)+eps);
    
    end
end

back.g = g;
back.hess = hess;
back.H = H;
back.vmod = vmod;
back.Lmod = Lmod;


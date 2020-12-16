function [net] = bnn_opt_online (theta,net,tau)
% Find MAP parameters using ONLINE gradient ascent of Log Joint
% FORMAT [net] = bnn_opt_single (theta,net,tau)
%
% theta         initialisation (vectorised parameters)
% net           Neural Net Data Structure
%                   .m      [P x 1] Prior mean
%                   .lambda [P x 1] Prior precision
% tau           Data from Learning Episode
%
% net
%               .m_post         [P x 1] Posterior mean
%               .lambda_post    [P x 1] Posterior precision
%               .W1,.W2,.b1,.b2         Unpacked from .m_post
%               .task{}.w,.task{}.b     Unpacked from .m_post


maxits = 4;
T=length(tau.r);
for t = 1:T,
    tau_t = get_tau_single (tau,t);
    
    increase(t)=0;
    alpha(t) = 0;
    
    for it = 1:maxits,
        [J(it),dJdtheta,lambda] = bnn_logjoint (theta,net,tau_t);
        
        alpha_vec = 1./lambda;
        improved=0;
        jmax=8;
        for j=1:jmax,
            theta_new = theta + alpha_vec.*dJdtheta;
            Jnew = bnn_logjoint (theta_new,net,tau_t);
%             [J(it),Jnew,mean(alpha_vec)]
%             pause
            % Halve step-size if solution not improved
            alpha_vec = alpha_vec/2;
            if Jnew > J(it),
                improved=1;
                break;
            end
        end
        if improved,
            theta = theta_new;
            J(it) = Jnew;
            alpha(t) = mean(alpha_vec);
            increase(t)=1;
        end
        disp(sprintf('Sample %d, it=%d, J=%1.2f',t,it,J(it)));
    end
end

[Jend,tmp,lambda,pc,LogLike] = bnn_logjoint (theta,net,tau);
net = bnn_unpack (theta,net,'weights');
net.m_post = theta;
net.lambda_post = lambda;
net.J = Jend;
net.LogLike = LogLike;
net.LogPrior = Jend - LogLike;
net.pc = pc;

disp(sprintf('Online, <alpha> = %1.4f, <inc>=%1.2f, J = %1.4f, pc = %1.3f',mean(alpha),mean(increase),Jend,pc));
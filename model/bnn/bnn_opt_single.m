function [net] = bnn_opt_single (theta,net,tau,opt)
% Find MAP parameters using gradient ascent of Log Joint
% FORMAT [net] = bnn_opt_single (theta,net,tau,opt)
%
% theta         initialisation (vectorised parameters)
% net           Neural Net Data Structure
%                   .m      [P x 1] Prior mean
%                   .lambda [P x 1] Prior precision
% tau           Data from Learning Episode
% opt           Optimisation parameters
%                   .alg        'FixedStepSize','LineSearch,'Newton'
%                   .maxits     Max number of iterations
%                   .tol        tolerance for convergence 
%
% net
%               .m_post         [P x 1] Posterior mean
%               .lambda_post    [P x 1] Posterior precision
%               .W1,.W2,.b1,.b2         Unpacked from .m_post
%               .task{}.w,.task{}.b     Unpacked from .m_post
%               .it             number of iterations to convergence

if isfield(opt,'alg'), alg=opt.alg; else alg='LineSearch'; end
if isfield(opt,'maxits'), maxits=opt.maxits; else maxits=32; end
if isfield(opt,'tol'), tol=opt.tol; else tol=0.001; end

% Learning rate for fixed step size
alpha=0.1;

[J(1),dJdtheta] = bnn_logjoint (theta,net,tau);

if opt.verbose
    disp(' ');
    disp(sprintf('Optimisation using %s algorithm',upper(alg)));
    disp(' ');
    disp(sprintf('Iteration 1, alpha = 0.0000, J = %1.4f',J(1)));
end

for it=2:maxits,
        
    [J(it),dJdtheta,lambda] = bnn_logjoint (theta,net,tau);
    
    if it > 8
        if abs((J(it-1)-J(it-2))/J(it-1)) < tol
            break;
        end
    end
    
    switch lower(alg),
        case 'fixedstepsize',
            dJdtheta = dJdtheta/norm(dJdtheta);
            theta = theta + alpha*dJdtheta;
            J(it) = bnn_logjoint (theta,net,tau);
            % Could also start with a high learning rate and
            % halve it if better solution not found
            
        case 'linesearch',
            dJdtheta = dJdtheta/norm(dJdtheta);
            E = Inf;
            alpha_max = 1;
            improved=0;
            jmax=4;
            for j=1:jmax,
                [alpha, E] = fminbnd(@(alpha) bnn_tune_alpha(alpha,theta,net,tau,dJdtheta),0,alpha_max);
                % Halve step-size if solution not improved
%                 disp(j)
%                 disp(alpha)
%                 disp(E)
                alpha_max = alpha_max/2;
                if -E > J(it-1)
                    improved=1;
                    break;
                end
            end
            if improved
                theta = theta + alpha*dJdtheta;
                J(it) = -E;
            else
                J(it) = J(it-1);
            end
            
        case 'newton',
            alpha_vec = 1./lambda;
            improved=0;
            jmax=4;
            for j=1:jmax,
                theta_new = theta + alpha_vec.*dJdtheta;
                J(it) = bnn_logjoint (theta_new,net,tau);
                % Halve step-size if solution not improved
                alpha_vec = alpha_vec/2;
                if J(it) > J(it-1);
                    improved=1;
                    break;
                end
            end
            if improved,
                theta = theta_new;
            else
                J(it) = J(it-1);
            end
            alpha = mean(alpha_vec);
            
            
        otherwise
            disp('Unknown algorithm in bnn_Learn.m');
    end
    
    if opt.verbose
        disp(sprintf('Iteration %d, alpha = %1.4f, J = %1.4f',it,alpha,J(it)));
    end
    
end

[tmp,tmp,lambda,pc,LogLike] = bnn_logjoint (theta,net,tau);
net = bnn_unpack (theta,net,'weights');
net.m_post = theta;
net.lambda_post = lambda;
net.J = J(it);
net.LogLike = LogLike;
net.LogPrior = J(it) - LogLike;
net.pc = pc;
net.it = it-1;
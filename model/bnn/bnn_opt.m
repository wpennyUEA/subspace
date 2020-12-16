function [net,op] = bnn_opt (theta,net,tau,opt)
% Find MAP parameters allowing for multiple restarts
% FORMAT [net,op] = bnn_opt (theta,net,tau,opt)
%
% theta         [P x R] initial parameter vecs (for up to R restarts)
% net           Neural Net Data Structure
%                   .m      [P x 1] Prior mean
%                   .lambda [P x 1] Prior precision
% tau           Data from Learning Episode
% opt           Optimisation parameters
%                   .restarts   maximum number of restarts
%                   .pcthresh   required probability of correct decision
%
% net
%               .m_post         [P x 1] Posterior mean
%               .lambda_post    [P x 1] Posterior precision
%               .W1,.W2,.b1,.b2         Unpacked from .m_post
%               .task{}.w,.task{}.b     Unpacked from .m_post
% op            Optimisation Profile          
%               .pcexp         prob correct (best)
%               .r             number of restarts made
%               .pc(r)         prob correct on restart r
%               .its           [r x 1] number of iterations on each restart
%               .res(r).z1post post prob of selecting partition 1 components

if ~isfield(opt,'verbose'), opt.verbose=1; end
if isfield(opt,'restarts'), restarts=opt.restarts; else restarts=1; end
if isfield(opt,'pcthresh'), pcthresh=opt.pcthresh; else pcthresh=0.65; end

disp(sprintf('Max restarts = %d',opt.restarts));

solution_found=0;
for r=1:opt.restarts,
    
    net = bnn_opt_single (theta(:,r),net,tau,opt);
    
    restart(r).net=net;
    pc(r)=net.pc;
    its(r)=net.it;
    
    if net.pc > pcthresh
        solution_found=1;
        break
    end
    
end

op.pc = pc;
op.its = its;
op.r = r;

if solution_found
    net=restart(r).net;
    op.pcexp = pc(r);
else
    [op.pcexp,ind]=max(pc);
    net=restart(ind).net;
end

if opt.verbose
    for i=1:r,
        disp(sprintf('Restart %d: Probability of correct = %1.3f',i,pc(i)));
    end
end

    
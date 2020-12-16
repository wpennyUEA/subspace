function [] = plot_data_map (tau)
% Plot reward probabilities evident in data set
% FORMAT [] = plot_data_map (tau)

tau_sub=tau;
tau_sub.u=tau_sub.u(:,1);
tau_sub.a=tau_sub.a(1);
tau_sub.a(1)=1;
        
map=ones(5,5)*0.5;
nn_map=ones(5,5)*0.5;
for i=1:25,
    ind=find(tau.c==i);
    a=tau.a(ind);
    r=tau.r(ind);
    rval=[];
    for j=1:length(ind);
        if a(j)==1
            rval(j)=r(j);
        else
            rval(j)=1-r(j);
        end
    end
    if length(ind)>1
        ev=mean(rval);
        x=tau.u(1,ind(1));
        y=tau.u(2,ind(1));
        map(x,y)=ev;
        
    end
    
end

figure
plot_map(map);




clear all

[t1,t2,same,diff,name] = get_data_same_diff();

for n=1:3,
    
    disp('---------------------------------');
    disp(sprintf('Task 1 = %s',name{n}));
    
    disp('Correlations:');
    [rs,ps]=corrcoef(t1(same{n}.ind),t2(same{n}.ind));
    disp(sprintf('Same Subspace r(task1, task2)=%1.3f (p=%1.6f)',rs(1,2),ps(1,2)));
    [rd,pd]=corrcoef(t1(diff{n}.ind),t2(diff{n}.ind));
    disp(sprintf('Diff Subspace r(task1, task2)=%1.3f (p=%1.6f)',rd(1,2),pd(1,2)));
    
    Nsame=length(same{n}.ind);   
    Ndiff=length(diff{n}.ind);
    [P,Z] = corr_rtest(rs(1,2),rd(1,2),Nsame,Ndiff);
    p_twosided=P(2);
    disp(sprintf('Are Correlations different? p=%1.3f (z=%1.3f), N1=%d, N2=%d',P(2),Z,Nsame,Ndiff));
    
    
end




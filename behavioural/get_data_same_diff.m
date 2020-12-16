function [t1,t2,same,diff,name,data] = get_data_same_diff()
% Get data in task1=add/sub, task2=same/different subspace,  format
% 
% t1        performance on task1
% t2        performance on task2
% same      same{c}.ind indices of "same" subjects in condition c
% same      diff{c}.ind indices of "diff" subjects in condition c
% name      {'Overall','Add','Sub'}
% data      [Nsub x Nblocks] with Nsub=80, Nblocks=10

load Results

data = Results(:,[8:17]);

%-----------------------------------------------------------------------
% Extract data and indices for same/different subspaces 
% and sub/add tasks

idxSub = find(Results(:,6)==1);
idxAdd = find(Results(:,6)==0);

idxSame = find(Results(:,4)==1);
idxDiff = find(Results(:,4)==0);

sameind=[];
diffind=[];
subind=[];
addind=[];
for k = 1:80
    if sum(k == idxSub)
        Sign{k} = 'Subtraction';
        subind=[subind,k];
    elseif sum(k == idxAdd)
        Sign{k} = 'Addition';
        addind=[addind,k];
    else
        error('Error in sign')
    end
    
    if sum(k == idxSame)
        Subspace{k} = 'Same';
        sameind=[sameind,k];
    elseif sum( k == idxDiff)
        Subspace{k} = 'Diff';
        diffind=[diffind,k];
    else
        error('Error in subsp')
    end
end

t1 = mean(data(:,1:5)');
t2 = mean(data(:,6:10)');

%-----------------------------------------------------------------------
name{1}='Overall';
name{2}='Add';
name{3}='Sub';

same{1}.ind=sameind;
same{2}.ind=intersect(addind,sameind);
same{3}.ind=intersect(subind,sameind);

diff{1}.ind=diffind;
diff{2}.ind=intersect(addind,diffind);
diff{3}.ind=intersect(subind,diffind);





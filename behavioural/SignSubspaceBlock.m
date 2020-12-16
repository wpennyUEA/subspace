
clear all

load Results

[t1,t2,same,diff,name,data] = get_data_same_diff();

t2b = data(:,6:10);

idxSub = find(Results(:,6)==1);
idxAdd = find(Results(:,6)==0);

idxSame = find(Results(:,4)==1);
idxDiff = find(Results(:,4)==0);

for k = 1:80
    if sum(k == idxSub)
        Sign{k} = 'Subtraction';
    elseif sum(k == idxAdd)
        Sign{k} = 'Addition';
    else
        error('Error in sign')
    end
    
    if sum(k == idxSame)
        Subspace{k} = 'Same';
    elseif sum( k == idxDiff)
        Subspace{k} = 'Diff';
    else
        error('Error in subsp')
    end
end

within_factor = table({'Block1' 'Block2' 'Block3' 'Block4' 'Block5'}', 'VariableNames', {'Blocks'});

data = table(Sign', Subspace', t2b(:,1), t2b(:,2), t2b(:,3), t2b(:,4), t2b(:,5), ...
        'VariableNames', {'Sign', 'Subspace', 'B1', 'B2', 'B3', 'B4', 'B5'});
    
anova_model=2;
switch anova_model,
    case 1,
        disp('These results same as Subspace*Block interactions in first submission:');
        rm = fitrm(data, 'B1-B5~Sign+Subspace', 'WithinDesign', within_factor);
    case 2
        disp('Main effect of subspace now significant. Subspace*Blocks sig one-sided.');
        rm = fitrm(data, 'B1-B5~Sign+Subspace+Sign*Subspace', 'WithinDesign', within_factor);
end
    
ranova_table = ranova(rm, 'WithinModel', 'Blocks')

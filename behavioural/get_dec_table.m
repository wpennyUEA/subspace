function dec_array = get_dec_table()
tabletemp = readtable('declarations.xlsx');

tem= table2array(tabletemp(1:80, 10:13));

for r = 1:length(tem)
    for c = 1:4
        
        dec_array(r,c) = strcmp(tem{r,c},'Yes') || strcmp(tem{r,c},'yes');
    end
end

end
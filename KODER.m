function tab = KODER(tab_gen)
    
    tab = 1 : 3 * length(tab_gen);
    k = 1;
    
    for i = 1 : length(tab_gen)
        for j = 1 : 3
            tab(k) = tab_gen(i);
            k = k + 1;
        end
    end
    
end


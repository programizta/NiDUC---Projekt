function tab = KANAL(tab_kod, sigma)

    tab = tab_kod + normrnd(0, sigma, [1, length(tab_kod)]);
    
    for i = 1 : length(tab)
        if tab(i) <= 0
            tab(i) = 0;
        else
            tab(i) = 1;
        end
    end

end


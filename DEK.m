function tab = DEK(tab_kan)

    x = 1;
    k = 0;

    tab = 1 : length(tab_kan) / 3;

    for i = 1 : length(tab_kan)

        if tab_kan(i) == 1
            k = k + 1;
        end

        if mod(i, 3) == 0
           if k > 1
               tab(x) = 1;
           else
               tab(x) = 0;
           end
           k = 0;
           x = x + 1;
        end
    end

end


function tab = BER(size, sigma)

    tab = GEN(size);
    tab1 = KODER(tab);
    tab2 = KANAL(tab1, sigma);
    tab3 = DEK(tab2);

    k = 0; % iloœæ nieprzek³amanych bitów

    for i = 1 : length(tab)
        if tab(i) == tab3(i)
            k = k + 1;
        end
    end
    
    tab = (size - k) / size;
end
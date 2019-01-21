function tab = KANALPP(tab_gen, pp)
    for i = 1 : length(tab_gen)
        rand_val = rand();
        if rand_val > (1-pp) % jeœli spe³nione to przek³am
            if tab_gen(i) == 0 % jeœli bit by³ 0 to ustaw 1
                tab_gen(i) = 1;
            else
                tab_gen(i) = 0; % jeœli bit by³ 1 to ustaw 0
            end
        end
    end
    tab = tab_gen;
end
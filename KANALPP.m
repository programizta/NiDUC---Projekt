function tab = KANALPP(tab_gen, pp)
    for i = 1 : length(tab_gen)
        rand_val = rand();
        if rand_val > (1-pp) % je�li spe�nione to przek�am
            if tab_gen(i) == 0 % je�li bit by� 0 to ustaw 1
                tab_gen(i) = 1;
            else
                tab_gen(i) = 0; % je�li bit by� 1 to ustaw 0
            end
        end
    end
    tab = tab_gen;
end
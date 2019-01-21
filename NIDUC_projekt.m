size = 1000; % iloœæ bitów nadawanych 

tab = GEN(size);
tab1 = KODER(tab);
tab2 = KANALPP(tab1, 0.1);
tab3 = DEK(tab2);

k = 0; % iloœæ nieprzek³amanych bitów

for i = 1 : length(tab)
   if tab(i) == tab3(i)
       k = k + 1;
   end
end

BER = (size - k) / size; % stosunek bitów przek³amanych do wszystkich bitów

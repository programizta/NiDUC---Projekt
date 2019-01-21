m = 6; % ustawiamy parametr m zgodnie z tabel� kod�w BCH
n = 2^m - 1; % d�ugo�� s�owa koduj�cego
k = 45; % d�ugo�� s�owa, kt�re kodujemy

msg = gf(GEN(k)); % wygenerowanie wiadomo�ci
% [genpoly, t] = bchgenpoly(n, k);
% t = 15; 

% zakodowanie BCH
code = bchenc(msg, n, k);

for i = 1 : 100
    for j = 1 : 100
        % przepuszczenie przez kana�
        noisy_code = KANALPP(code.x, 0.01 * i);

        % zdekodowanie
        [decoded_message, err, ccode] = bchdec(gf(noisy_code), n, k);
        
        wrong_bits += numel(find(msg.x ~= decoded_message.x)); % liczba bit�w danych odebranych b��dnie
        correct_bits = numel(find(msg.x == decoded_message.x)); % liczba bit�w danych odebranych prawid�owo
        received_data_bits = length(decoded_message.x); % liczba odebranych bit�w danych
        all_received_bits = length(code); % liczba wszystkich odebranych bit�w 
    end

    BER_values(i) = wrong_bits / received_data_bits * 100; % wyliczenie BER: (liczba bit�w danych odebranych b��dnie) / (liczba odebranych bit�w danych)
    E_values(i) = correct_bits / all_received_bits * 100; % wyliczenie E: (liczba prawid�owo odebranych bit�w danych) / (liczba przes�anych bit�w)
end

lin = linspace(0, 100, 100);

figure(1);
plot(lin, BER_values);
title(['n: ' num2str(n) '    k: ' num2str(k)]);
xlabel("Prawdopodobienstwo przeklamania");
ylabel("BER");

figure(2);
plot(E_values);
title(['n: ' num2str(n) '    k: ' num2str(k)]);
xlabel("Prawdopodobienstwo przeklamania");
ylabel("E");

figure(3);
p = polyfit(BER_values, lin, 1);
y1 = polyval(p,lin);
plot(y1);

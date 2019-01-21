m = 6; % ustawiamy parametr m zgodnie z tabel¹ kodów BCH
n = 2^m - 1; % d³ugoœæ s³owa koduj¹cego
k = 45; % d³ugoœæ s³owa, które kodujemy

msg = gf(GEN(k)); % wygenerowanie wiadomoœci
% [genpoly, t] = bchgenpoly(n, k);
% t = 15; 

% zakodowanie BCH
code = bchenc(msg, n, k);

for i = 1 : 100
    for j = 1 : 100
        % przepuszczenie przez kana³
        noisy_code = KANALPP(code.x, 0.01 * i);

        % zdekodowanie
        [decoded_message, err, ccode] = bchdec(gf(noisy_code), n, k);
        
        wrong_bits += numel(find(msg.x ~= decoded_message.x)); % liczba bitów danych odebranych b³êdnie
        correct_bits = numel(find(msg.x == decoded_message.x)); % liczba bitów danych odebranych prawid³owo
        received_data_bits = length(decoded_message.x); % liczba odebranych bitów danych
        all_received_bits = length(code); % liczba wszystkich odebranych bitów 
    end

    BER_values(i) = wrong_bits / received_data_bits * 100; % wyliczenie BER: (liczba bitów danych odebranych b³êdnie) / (liczba odebranych bitów danych)
    E_values(i) = correct_bits / all_received_bits * 100; % wyliczenie E: (liczba prawid³owo odebranych bitów danych) / (liczba przes³anych bitów)
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

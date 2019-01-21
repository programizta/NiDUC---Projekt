clear all;
close all;
clc;

m = 3 : 8;
n = [7, 15, 31, 63, 127, 255];
k = [4, 11, 7, 5, 26, 21, 16, 11, 6, 57, 51, 45, 39, 36, 30, 24, 18, 16, 10, 7, 120, 113, 106, 99, 92, 85, 78, 71, 64, 57, 50, 43, 36, 29, 22, 15, 8, 247, 239, 231, 223, 215, 207, 199, 191, 187, 179, 171, 163, 155, 147, 139, 131, 123, 115, 107, 99, 91, 87, 79, 71, 63, 55, 47, 45, 37, 29, 21, 13, 9];

sigma = 0.1;
pp = 0.1;

x = 1;
N = 100;

wrong_bits_sum = 0;
correct_bits_sum = 0;
received_data_bits_sum = 0;
all_received_bits_sum = 0;

wrong_bits_sigma_sum = 0;
correct_bits_sigma_sum = 0;
received_data_bits_sigma_sum = 0;
all_received_bits_sigma_sum = 0;

for i = 1 : length(k)
    
    msg = gf(GEN(k(i))); % wygenerowanie wiadomości 

    code = bchenc(msg, n(x), k(i));  % zakodowanie BCH

    for j = 1 : N

    %------------------------------PP-----------------------------------------%
    
    noisy_code = KANALPP(code.x, pp); 
    
    [decoded_message, err, ccode] = bchdec(gf(noisy_code), n(x), k(i)); 

    wrong_bits = numel(find(msg.x ~= decoded_message.x)); 
    correct_bits = numel(find(msg.x == decoded_message.x)); 
    received_data_bits = length(decoded_message.x);
    all_received_bits = length(code); 
    
    wrong_bits_sum = wrong_bits_sum + wrong_bits;
    correct_bits_sum = correct_bits_sum + correct_bits;
    received_data_bits_sum = received_data_bits_sum + received_data_bits;
    all_received_bits_sum = all_received_bits_sum + all_received_bits;
    
    %-----------------------------Sigma-----------------------------------------%
    
    noisy_code_sigma = KANAL(double(code.x), sigma); 
    
    [decoded_message_sigma, err, ccode] = bchdec(gf(noisy_code_sigma), n(x), k(i)); 

    wrong_bits_sigma = numel(find(msg.x ~= decoded_message_sigma.x)); 
    correct_bits_sigma = numel(find(msg.x == decoded_message_sigma.x)); 
    received_data_bits_sigma = length(decoded_message_sigma.x);
    all_received_bits = length(code);
    
    wrong_bits_sigma_sum = wrong_bits_sigma_sum + wrong_bits_sigma;
    correct_bits_sigma_sum = correct_bits_sigma_sum + correct_bits_sigma;
    received_data_bits_sigma_sum = received_data_bits_sigma_sum + received_data_bits_sigma;
    all_received_bits_sigma_sum = all_received_bits_sigma_sum + all_received_bits;
    
    end
    
    wrong_bits_average = wrong_bits_sum / N;
    correct_bits_average = correct_bits_sum / N;
    recevied_data_bits_average = received_data_bits_sum / N;
    all_received_bits_average = all_received_bits_sum / N;
    
    wrong_bits_sigma_average = wrong_bits_sigma_sum / N;
    correct_bits_sigma_average = correct_bits_sigma_sum / N;
    recevied_data_bits_sigma_average = received_data_bits_sigma_sum / N;
    all_received_bits_sigma_average = all_received_bits_sigma_sum / N;
    
    BER_values(i) = wrong_bits_average / recevied_data_bits_average; 
    E_values(i) = correct_bits_average / all_received_bits_average; 
    
    BER_values_sigma(i) = wrong_bits_sigma_average / recevied_data_bits_sigma_average; 
    E_values_sigma(i) = correct_bits_sigma_average / all_received_bits_sigma_average;
    
    if(i == 1)
        x = 2;
    elseif(i == 4)
        x = 3;
    elseif(i == 9)
        x = 4;
    elseif(i == 20)
        x = 5;
    elseif(i == 37)
        x = 6;
    end
        
end

figure(1);
%plot();
labels = ['  7,4  '; ' 15,11 '; ' 15,7  '; ' 15,5  '; ' 31,26 '; ' 31,21 '; ' 31,16 '; ' 31,11 '; ' 31,11 '; ' 31,6  '; ' 63,57 '; ' 63,51 '; ' 63,45 '; ' 63,39 '; ' 63,36 '; ' 63,30 '; ' 63,24 '; ' 63,18 '; ' 63,16 '; ' 63,10 '; ' 63,7  '; '127,120'; '127,113'; '127,106'; '127,99 '; '127,92 '; '127,85 '; '127,78 ';'127,71 '; '127,64 '; '127,57 '; '127,50 '; '127,43 '; '127,36 '; '127,29 '; '127,22 '; '127,15 '; '127,8  '; '255,247'; '255,239'; '255,231'; '255,223'; '255,215'; '255,207'; '255,199'; '255,191'; '255,187'; '255,179'; '255,171'; '255,163'; '255,155'; '255,147'; '255,139'; '255,131'; '255,123'; '255,115'; '255,107'; '255,99 '; '255,91 '; '255,87 '; '255,79 '; '255,71 '; '255,63 '; '255,55 '; '255,47 '; '255,45 '; '255,37 '; '255,29 '; '255,21 '; '255,13 '; '255,9  '];
labels = cellstr(labels);
scatter(E_values, BER_values, 20, 'filled');
for ii=1:70
    text(E_values(ii), BER_values(ii), labels(ii), 'FontSize', 7);
end
hold on
xlabel('E');
ylabel('BER');
title('Prawdopodobieństwo przekłamania');

figure(2);
%plot();
scatter(E_values_sigma, BER_values_sigma, 20, 'filled');
for ii=1:70
    text(E_values_sigma(ii), BER_values_sigma(ii), labels(ii), 'FontSize', 7);
end
hold on
xlabel('E');
ylabel('BER');
title('Sigma');

%------------------------ Drukuj punkty --------------------------%

fprintf('Prawdopodobieństwo przekłamania\n\n');

for i = 1 : length(k)
   fprintf(['E = ', num2str(E_values(i)), '; BER = ', num2str(BER_values(i)), '\n']); 
end

fprintf('\n\nSigma\n\n');

for i = 1 : length(k)
   fprintf(['E = ', num2str(E_values_sigma(i)), '; BER = ', num2str(BER_values_sigma(i)), '\n']); 
end
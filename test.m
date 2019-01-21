for i = 1 : 1000
    t(i) = BER(10000, i/10);
end
lin = linspace(0,100,10000);
figure(1);
plot(lin, t);
xlabel("sigma");
ylabel("BER");

for i = 1 : 100
    t2(i) = BERPP(10000, i/100);
end
lin = linspace(0,1,100);
figure(2);
plot(lin, t2);
xlabel("Prawdopodobienstwo przeklamania");
ylabel("BER");
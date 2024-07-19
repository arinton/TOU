n = 0:0.1:3;
P = 2048000.*(n.^3)./1000;
plot(n,P)
grid on, title('График зависимости P(n)')
xlabel('n, об/с'), ylabel('P, кВт')

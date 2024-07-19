n = 0:0.1:3;
T = 40480.*(n.^2);
plot(n,T)
grid on, title('График зависимости T(n)')
xlabel('n, об/с'), ylabel('T, H')
v = 0:0.1:10;
R = 4773.23.*v.*abs(v); 
plot(v,R)
grid on, title('График зависимости R(V)')
xlabel('V, m/s'), ylabel('R, H')
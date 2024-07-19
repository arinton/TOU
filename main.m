clear
global flagplot parmodel

% for part 2
needOpt = 0;  % 0 - simulation only

%PUT YOUR DATA HERE
kv = 0.000207; % 0.5*Omega*C/m
vmax = 24.5*0.514;  %m/s
reverse = 1; %enable reverese
kregv = 10;  % av: kv*(V*-v)
distance = 50*1852;  %m
vset = 20*0.514;  %m/s

% Simulation settings
dt = 1;
tmax = 10*distance/vmax;  
if reverse==0,
 tmax = tmax*2;
end

vend = 0.5;  %v<vend in the end of trackstop

parmodel = [distance, vset, kregv, kv, vmax, dt, tmax, reverse, vend];

%SIMULATION
%PUT YOUR PARAMS HERE
t1 = 281.471;
stopdistance = 3179.46;

params = [t1, stopdistance];
flagplot = 1;
J = kurscrit(params);


% fmins optimization
if needOpt,
 flagplot = 0;
 paropt = fminsearch('kurscrit',params)
 flagplot = 1;
 J = kurscrit(paropt)
%  time1 = 0:20:300;
% sur2 = 0:500:10000;
% J1 = [];
% for i = 1:1:16
% for j = 1:1:21
%         J1(i,j) = kurscrit([time1(i), sur2(j)]);
% end
% end
% figure;
% mesh(time1, sur2, J1');
% hold on
% scatter3(paropt(1), paropt(2), J, '*r');
% hold off
% xlabel('t1, c');
% ylabel('S2, м');
% zlabel('J');

end


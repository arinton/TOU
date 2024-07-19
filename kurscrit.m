function J = kurscrit(params)
global flagplot parmodel
v0 = 0;
%PUT YOUR PARAMS HERE 
%kcrit_a = 0.8;
distance = parmodel(1);
vset = parmodel(2);
kregv = parmodel(3);
kv = parmodel(4);
vmax = parmodel(5);
dt = parmodel(6);
tmax = parmodel(7);
reverse = parmodel(8);
vend = parmodel(9);
tnorm = distance/vmax; % s
anorm = 1;
kcrit_R1 = 2;
kcrit_R2 = 5;
x = [0;v0];
t1 = params(1);
stopdistance = params(2);
pend = 0;
if t1<0,pend = 1e3*abs(t1);
t1 = 0;
end
if stopdistance>distance*0.9,pend = pend+(stopdistance-distance*0.9)^2;
stopdistance=distance*0.9;
end
dmin = 0;
if stopdistance < dmin,stopdistance = dmin;
pend = pend+(dmin-stopdistance)^2;
end
xe = distance-stopdistance;

for i=1:tmax/dt,
  s = x(1);
  v = x(2);
  aS(i) = s;
  aV(i) = v;
  t = i*dt;
  at(i) = t;
  if s<xe, 
    vdes = vset;
    if t < t1, 
      mnv(i) = 1;
      vdes = vset/t1*t;
    end
  else
    mnv(i) = 1;
    vdes = 0; %vset-vset*(s-xe)/(distance-xe);
  end
  aVdes(i) = vdes;
  u = vdes^2+kregv*(vdes-v);
  umax = vmax^2;


  if u<0, 
    if reverse ==0,
      u = 0;
    elseif u<-umax,
      u = -umax;
    end
  elseif u>umax,
    u = umax;
  end

  aU(i) = u/umax;
  aP(i) = abs(aU(i))^(3/2);
  z = kurs_rp(x,u,at(i));
  adv_dt(i) = z(2);
  x = x+z*dt;
  if s > distance || (s>xe && v<vend), 
    break
  end

end

pend = pend+0.001*(s-distance)^2;
if v > vend,
 pend = pend + 100*(v-vend)^2;
end

timeend = max(at);
maxacc= max(abs(adv_dt));

idx = find(mnv==1);
Pmean = mean(aP(idx));


useAcc = 1;
% 0 - useP 


J = kcrit_R1*timeend/tnorm +pend;

if useAcc==1, 
 J  = J + kcrit_R2*maxacc/anorm;
else
 J  = J + kcrit_R2*Pmean;
end



if flagplot==1,

 disp('Time of maneuver')
 disp(timeend)
 disp('Max acc, m/s^2')
 disp(maxacc)
 disp('Mean power of start/stop')
 disp(Pmean)
 disp('Final speed, m/s')
 disp(v)
 disp('Pending function')
 disp(pend)
 disp('Total criteria')
 disp(J)


 subplot(311), plot(at, aS), grid, title('S(t)')
 subplot(312), plot(at, aV, at, aVdes), grid, title('v(t)'), legend('v(t)','vdes(t)')
 subplot(313), plot(at, aU, at, aP), grid, title('U/Umax(t), Power/Powermax'),legend('U/Umax(t)','P/Pmax(t)')
end
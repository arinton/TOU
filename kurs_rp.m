function z = kurs_rp(x,u,t)
global parmodel
s = x(1);
v = x(2);
fdist = 0;
kv = parmodel(4);
dv_dt = -kv*v*abs(v)+kv*u+fdist; 
dx_dt = v;
z = [dx_dt;dv_dt];
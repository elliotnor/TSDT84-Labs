flags = [Amplidudkar, Faskar, Impulssvar];
H1=in(1,[1 -Realdel],'s');
figure(411), pz_mod(H1, [10, 10]);
title('Pol-nollställediagram för H_1(s)')
axis(10*[-1 1 -1 1]), xticks(-10:2:10), ohfig
if plot3D, figure(412),splane(H1), end
figure(413),
spectmod2(H1, KlabL, flags,fmax,tmax);
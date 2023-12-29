flags = [Amplidudkar, Faskar, Impulssvar];
H2=addpo(in(1,1,'s'),Realdel+j*Imagdel);
figure(413), pz_mod(H2, [10, 50]);
title('Pol-nollställediagram för H_2(s)')
xticks(-10:2:10), yticks(-50:10:50), xlim([-10, 10]), ohfig
if plot3D, figure(414),splane(H2), end
figure(414), spectmod2(H2, KlabL, flags, fmax, tmax);
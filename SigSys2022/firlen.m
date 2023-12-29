function L=firlen(Fp,Fs,r,K)
%FIRLEN Approximativ längd för ett optimalt FIR-filter.
%
%    L = FIRLEN(theta_p,theta_s,r,K) - theta_p, theta_s, r och K är reella tal.
%    
%    Beskrivning:
%    Beräknar ungefärlig längd för ett optimalt FIR-filter enligt Remez 
%    algoritm med passbandsgräns theta_p, spärrbandsgräns theta_s, rippel 
%    r [dB]i passbandet och förhållande K mellan rippel i pass- och spärrband.
%    
%    See also:
%    FIROPT, RIPPLE
%    

global pm1 pm2 pm3 pm4 KlabL
if nargin<4, K=1; end
r=10^(r/20)-1;
s1=r;
s2=r/K;
c1=5.309e-3;
c2=71.14e-3;
c3=-.4761;
c4=-2.66e-3;
c5=-.5941;
c6=-.4278;
d1=11.01217;
d2=.51244;
df=Fs-Fp;
D=(c1*(log10(s1))^2+c2*log10(s1)+c3)*log10(s2);
D=D+c4*(log10(s1))^2+c5*log10(s1)+c6;
f=d1+d2*log10(s1/s2);
L=ceil(D/df-f*df+1);



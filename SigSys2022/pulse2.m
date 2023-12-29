function p=pulse2(t1,t2);

% PULSE2 Specialgenerering av pulsfunktionen
%     p = PULSE2(t1,t2) returnerar u(t-t1)-u(t-t2),
%     där u(.) är Heavisidefunktionen (enhetssteget).
%     pulse2 samplar funktionen med så hög sampelfrekvens som möjligt.
%     Funktionen pulse, å andra sidan, samplar funktionen med en (oftast) 
%     "lagom" hög sampelfrekvens.
%     PULSE2 kan t.ex. *inte* användas tillsammans med andra funktioner
%     i Kretslabfunktionerna "in", "fouser", "sample" och andra funktioner. 
%     Eventuell amplitudskalning av pulsen utförs m.h.a. Kretslab-funktionen "ampl".
% 
%     Exempel på användning:
%     x=in('sin(1000*t)','t');
%     p=pulse2(2,3);
%     p=ampl(p,2);
%     w=mult(x,p);
%     signal(p,w);
%
%   See also:
%     PULSE, US 

% Lasse A. sept. 2004
%
% t0 = max{ abs(t1) , abs(t1) }
% |t0|>2621 sek  => fs=12.5 Hz,  |t0|<1311 sek => fs=25 Hz,   
% |t0|<655 sek   => fs=50 Hz,    |t0|<328  sek => fs=100 Hz,
% |t0|<164 sek   => fs=200 Hz,   |t0|<82   sek => fs=400 Hz,
% |t0|<41 sek    => fs=800 Hz,   |t0|<20   sek => fs=1600 Hz,
% |t0|<10.24 sek => fs=3200 Hz,  |t0|<5.12 sek => fs=6400 Hz  

global KlabL FSMAX

if nargin==1, t2=t1; t1=0; end

fs_vek=12.5*2.^(log2(FSMAX/12.5):-1:0);       % = [12.5 25 50 ... 1600 ... FSMAX]
p=zeros(1,KlabL);
to=max(abs(t1),abs(t1));
fs_max=max(12.5,KlabL/2/to);
f=find(fs_vek<fs_max);  
fs=fs_vek(f(1));

t=1/fs*(-KlabL/2:(KlabL/2-1));	% ca. -5 till 5 sek vid |t0|<5.12 sek, -10 till 10 sek vid |t0|<5.12 sek, osv.
t_pos=find(t>=t1 & t<t2);
p=zeros(size(t));
p(t_pos)=p(t_pos)+1;
p=[p 1/fs];






d(KlabL+1)=1/fs;
t=1/fs*(-KlabL/2:KlabL/2-1);
a=find(t-to>=0);
d(a(1))=fs/2;

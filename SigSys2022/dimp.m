function d=dimp(to)
% DIMP Specialgenerering av dirac-impuls
% 
%   d = DIMP(to) returnerar en approximerad dirac-impuls vid t=to
%   d = DIMP är ekvivalent med dimp(0)
%   OBS! 
%   DIMP kan *ej* användas vid signal-inmatning m.h.a. Kretslabfunktionen in!
%
%   Beskrivning: 
%   DIMP väljer så hög sampelfrekvens fs som möjligt, bland
%   tillgängliga {12.5 25 50 100 ... 3200 6400} Hz.
%   d(to)=fs/2 och d(t)=0 f.ö.
% 
%   Användningsexempel:
%   -------------------
%   x=in('sin(t)^2*pulse(t,0,pi)','t');  % Mjuk puls från t=0 till t=pi sek
%   d1=dimp(2);       % diracapproximation vid t=2 sek
%   d2=dimp(-4);      % diracapproximation vid t=-4 sek
%   d=add(d1,d2);     % diracapproximation vid t=2 och t=-4 sek
%   y=output(x,d);    % Falta x(t) med de två dirac-approximationerna
%   signal(x,y,6)     
%
%   Anm 1: Kom ihåg att dimp endast ger en *approximation* av dirac-impulsen!
%   Anm 2: Egentligen är d(to)=fs en mer korrekt approximation än d(to)=fs/2,
%          som används här, men vid tidskontinuerlig faltning skulle det resultera
%          i en felaktig skalning av faltningsresultatet med en faktor 2.
%          Då dirac-approximationen används vid signalmanipulationer i tidsdomänen
%          (t.ex. vid faltning), erhålles dock korrekta resultat med den aktuella
%          dimp-funktionen.
%          Däremot medför det felaktigt amplitudskalade funktionsvärdet d(to)=fs/2
%          att fouriertransformen till diracimpuls-approximationen blir felaktigt
%          skalad med faktorn 0.5 !
%          Vid sådan tillämpning kan "korrekt" dirac-approximation erhållas som
%          d=ampl(dimp(to),2).

% Lasse A, 31 aug. 2004


% |t0|>2621 sek  => fs=12.5 Hz,  |t0|<1311 sek => fs=25 Hz,   
% |t0|<655 sek   => fs=50 Hz,    |t0|<328  sek => fs=100 Hz,
% |t0|<164 sek   => fs=200 Hz,   |t0|<82   sek => fs=400 Hz,
% |t0|<41 sek    => fs=800 Hz,   |t0|<20   sek => fs=1600 Hz,
% |t0|<10.24 sek => fs=3200 Hz,  |t0|<5.12 sek => fs=6400 Hz  

global pm1 pm2 pm3 pm4 KlabL FSMAX

if nargin==0, to=0; end

fs_vek=12.5*2.^(log2(FSMAX/12.5):-1:0);       % = [12.5 25 50 ... 3200 ... FSMAX]
d=zeros(1,KlabL);
if to          % to=/0;
    fs_max=max(12.5,KlabL/2/abs(to));
    f=find(fs_vek<fs_max);  
    fs=fs_vek(f(1));
else            
    fs=FSMAX;   % to=0;
end
d(KlabL+1)=1/fs;
t=1/fs*(-KlabL/2:KlabL/2-1);
a=find(t-to>=0);
d(a(1))=fs/2;

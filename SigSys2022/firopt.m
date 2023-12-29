function h=firopt(N,F1,F2,K)
%FIROPT Optimering av FIR-filter med Remez algoritm.
%
%    h = FIROPT(L,theta_p,theta_s) - L är reellt heltal,
%                                  theta_p och theta_s är reella tal.
%    h = FIROPT(L,theta_p,theta_s,K) - L är reellt heltal, 
%                                    theta_p, theta_s och K är reella tal.
%    
%    Beskrivning:
%    Beräknar impulssvaret för ett optimalt kausalt FIR-filter av LP-typ med 
%    längd L, passbandsgräns theta_p, spärrbandsgräns theta_s och fårhållande 
%    K mellan rippel i pass- och spärrband. 
%    Om K ej anges sätts denna till 1, vilket man bland annat erhåller för
%    ripple(1,18.3) och ripple(3,7.7).
%    
%    
%    Example:
%    Tag fram impulssvaret för ett optimalt FIR-filter av LP-typ med passbands-
%    gräns theta_p = 0.1, spärrbandsgräns theta_s = 0.2, 1 dB rippel i passbandet 
%    och minst 60 dB dämpning i spärrbandet:
%    K = ripple(1,60);
%    L = firlen(0.1,0.2,l,K);
%    h = firopt(L,0.1,0.2,K);
%    
%    See also:
%    FIRLEN, RIPPLE
%    

global pm1 pm2 pm3 pm4 KlabL
if nargin<4, K=1; end
if N>KlabL, N=KlabL; end
h=fir(remez(N-1,[0 2*F1 2*F2 1],[1 1 0 0],[1 K]));

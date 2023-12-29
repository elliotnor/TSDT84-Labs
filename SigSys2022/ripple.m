function K=ripple(rp,rs)
%RIPPLE Beräkning av rippelforhållande.
%
%    K = RIPPLE(rp,rs) - rp och rs är reella tal.
%    
%    Beskrivning:
%    Beräknar förhållandet mellan rippel i pass- och spärrband för ett filter
%    med passbandsrippel rp [dB] och spärrbandsrippel rs [dB].
%    
%    See also:
%    FIROPT, FIRLEN
%    

global pm1 pm2 pm3 pm4 KlabL
K=(10^(rp/20)-1)*10^(rs/20);

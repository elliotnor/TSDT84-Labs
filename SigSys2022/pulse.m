function x=pulse(t,t1,t2);

% PULSE Pulsfunktionen 
%   pulse(t,t1,t2) = u(t-t1)-u(t-t2) 
%   (kan naturligtvis även matas in som us(t-t1)-us(t-t2) )
%   
% See also:
%   US, PULSE2


global pm1 pm2 pm3 pm4 KlabL
if nargin==2, t2=t1; t1=0; end
x=zeros(size(t));
a=find(t>=t1 & t<t2);
x(a)=x(a)+1;




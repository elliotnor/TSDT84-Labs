function y=intp(x)
%intp
% y=intp(x) - interpolering av signal. Används lokalt av Kretslabfunktioner
global pm1 pm2 pm3 pm4 KlabL FSMAX
if vtype(x)~=4, error('Input incorrect: not signal'); end
if bandwi(x)>=FSMAX/2
    disp(['Signal bandwidth too large (> ' num2str(FSMAX/2) ' Hz) !!']); 
    disp('Kretslab will proceed, but be aware of the fact')
    disp('that the result may is erroneous!!')
    disp(['However, if the bandwidth is only slightly larger than ' num2str(FSMAX/2) ' Hz,'])
    disp('the result may still be reliable.')
end
T=x(KlabL+1)/2;
y=[zeros(1,KlabL) T];
y(1:2:KlabL)=2*x(KlabL*.25+1:KlabL*.75);
x=[];
y=lp(y,1/(4*T));

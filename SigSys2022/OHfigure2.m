function OHfigure2(parent)
%OHfigure2
% OHfigure2 anropar direkt ohfig
% OHfigure2 finns endast kvar p.g.a. att den anropas av vissa demo-funktioner

if nargin==0, 
    ohfig
else
    ohfig(parent)
end

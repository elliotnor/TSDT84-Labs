function OHfigure3(lw,ftsz)
%OHfigure3
% OHfigure3(lw,ftsz)
% Samma som OHfig, men vid anrop med  två (2!!) argument kan valfri
% linjetjocklek och fontstorlek väljas (default: lw=2, ftsz = 14
%
% OHfigure3(f) byter (i figur #f) fontstorleken på 
% all text, vertical position på x-, y-, and z-label, 
% och linjebredder.
% Det kan finnas flera ''axes'' per figur.
% nargin=0 => f=current figure

% Lasse Alfredsson, September 1997

if nargin==0 | nargin==2, parent=gcf; end

if  nargin<2,
lw=2;
ftsz=14;
end

child=get(parent,'Children');
if isempty(child)		
	if strcmp(get(parent,'type'),'line')		% type==line
		set(parent,'linewidth',lw)
	elseif strcmp(get(parent,'type'),'text')	% type==text
		set(parent,'Fontsize',ftsz)
	elseif strcmp(get(parent,'type'),'axes')	% empty axes
		set(parent,'Fontsize',ftsz)	
	end
else
	if strcmp(get(parent,'type'),'axes')		% type==axes
		set(parent,'FontSize',ftsz)
		set(get(parent,'XLabel'),'FontSize',ftsz)
		set(get(parent,'YLabel'),'FontSize',ftsz)
		set(get(parent,'ZLabel'),'FontSize',ftsz)
		set(get(parent,'Title'),'FontSize',ftsz)
	end
	for a=1:length(child)
		OHfigure2(child(a))
	end
end



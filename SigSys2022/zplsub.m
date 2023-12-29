function zplsub(x)
%zplsub
% zplsub används av funktionen zplane

% (c) Lasse Alfredsson

load ZPLANEMAT
kk=surf(X,Y,a);
%kk=surfl(X,Y,a);
%shading interp
%colormap(pink)
%set(kk,'meshstyle','row');
hold off



tt = uicontrol('style','text','units','normal','position',[.012 .94 .25 .04], ...
	'string','Zaxelns maxvärde:','fore','red','back',get(gcf,'color'),'horizontal','left','fontsize',14);

limz = uicontrol('Style','edit','Units','normalized', ...
       'Position',[0.012 .9 .08 .04],'String',num2str(cut/2),'CallBack', ...
       'TEMAXIS=axis; axis([TEMAXIS(1:5) str2num(get(get(gcf,''currentobject''),''string''))]); clear TEMAXIS;', ...
       'foreground','black','background','yellow','horizontal','left','fontsize',14);
   
delete ZPLANEMAT.mat
rotate3d on % Möjliggör rotering av plotten med musen


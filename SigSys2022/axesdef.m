function axesdef(axtyp,fignamn)




% (c) Lasse Alfredsson, Linkoping University, Sweden; lasse@isy.liu.se

if nargin==0
    figure
    for a=1:12	% a_max = axtyp_max 
	clg
	axesdef(a,[' - axtyp = ' int2str(a)])
	OHfigure2
	pause
    end
    axtyp=0;
end


global AX

% Linjer skall ha bredd 2; 'LineWidth',2
% xlabel och texter (och ev. ylabel) skall ha 'FontSize',14
% title skall ha 'FontSize',16

% Specificera figurnamn:
set(gcf,'name',[get(gcf,'name') fignamn])

% Bestaem positioner och bredder/hoejder paa alla typer av axes:
xposv=[0.05 0 0 0];
yposv=[0.08 0 0 0.39 0.7];
xw=[0.6 0.42 0 0.28 0.20]; % Ev. aendra 0.28 till 0.27 om foer traangt
yw=[0.34 0.6 0.23];
   xposv(3)=0.5+xposv(1);
   xw(3)=xw(2)+xposv(3)-xposv(1);
   xposv(2)=2*xposv(1)+xw(4);
   xposv(4)=xposv(2)+xw(4)+xposv(1);
   yposv(2)=(1-yw(2))/2;
   yposv(3)=0.5+yposv(1);
  
clf

if axtyp==1
       AX(1,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(3) xw(1) yw(1)]);
       AX(2,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(1) xw(1) yw(1)]);
       
    elseif axtyp==2
       AX(1,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(3) xw(2) yw(1)]);
       AX(1,2)=axes('Units','normal', ...
   		'Position',[xposv(3) yposv(3) xw(2) yw(1)]);
       AX(2,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(1) xw(2) yw(1)]);
       AX(2,2)=axes('Units','normal', ...
   		'Position',[xposv(3) yposv(1) xw(2) yw(1)]);

     elseif axtyp==3
       AX(1,1)=axes('Units','normal', ...
   		 'Position',[xposv(1) yposv(3) xw(3) yw(1)]);
       AX(2,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(1) xw(2) yw(1)]);
       AX(2,2)=axes('Units','normal', ...
   		'Position',[xposv(3) yposv(1) xw(2) yw(1)]);

    elseif axtyp==4
       AX(1,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(3) xw(4) yw(1)]);
       AX(1,2)=axes('Units','normal', ...
   		'Position',[xposv(2) yposv(3) xw(4) yw(1)]);
       AX(1,3)=axes('Units','normal', ...
   		'Position',[xposv(4) yposv(3) xw(4) yw(1)]);
       AX(2,1)=axes('Units','normal', ...
   		 'Position',[xposv(1) yposv(1) xw(4) yw(1)]);
       AX(2,2)=axes('Units','normal', ...
   		'Position',[xposv(2) yposv(1) xw(4) yw(1)]);
       AX(2,3)=axes('Units','normal', ...
   		'Position',[xposv(4) yposv(1) xw(4) yw(1)]);

    elseif axtyp==5
       AX(1,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(2) xw(2) yw(2)]);
       AX(1,2)=axes('Units','normal', ...
   		'Position',[xposv(3) yposv(2) xw(2) yw(2)]);

    elseif axtyp==6
       AX(1,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(2) xw(2) yw(2)]);
       AX(1,2)=axes('Units','normal', ...
   		'Position',[xposv(3) yposv(3) xw(2) yw(1)]);
       AX(2,2)=axes('Units','normal', ...
   		'Position',[xposv(3) yposv(1) xw(2) yw(1)]);

    elseif axtyp==7
       AX(1,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(3) xw(2) yw(1)]);
       AX(1,2)=axes('Units','normal', ...
   		'Position',[xposv(3) yposv(3) xw(2) yw(1)]);
       AX(2,2)=axes('Units','normal', ...
   		'Position',[xposv(3) yposv(1) xw(2) yw(1)]);

    elseif axtyp==8
       AX(3,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(1) xw(3) yw(3)]);

       AX(2,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(4) xw(3) yw(3)]);

       AX(1,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(5) xw(3) yw(3)]);

    elseif axtyp==9
       AX(1,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(1) xw(3) xw(3)-0.07]);

    elseif axtyp==10	% Lite smalare i x-led an axtyp=9
	dx=.03;
       AX(1,1)=axes('Units','normal', ...
   		'Position',[xposv(1)+dx yposv(1) xw(3)-dx xw(3)-0.07]);

    elseif axtyp==11
       dx=0.01;
       AX(1,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(3) xw(1) yw(1)]);
       AX(2,1)=axes('Units','normal', ...
   		'Position',[xposv(1) yposv(1) xw(1) yw(1)]);

       AX(3,2)=axes('Units','normal', ...
   		'Position',[xposv(4) yposv(1) xw(4)-dx yw(3)]);

       AX(2,2)=axes('Units','normal', ...
   		'Position',[xposv(4) yposv(4) xw(4)-dx yw(3)]);

       AX(1,2)=axes('Units','normal', ...
   		'Position',[xposv(4) yposv(5) xw(4)-dx yw(3)]);

   elseif axtyp==12
       dx=0.93;
       AX(1,1)=axes('Units','normal', ...
   		'Position',[dx*xposv(1) yposv(3) xw(5) yw(1)]);

       AX(1,2)=axes('Units','normal', ...
   		'Position',[xposv(1)+xw(5)+dx*xposv(1) yposv(3) xw(5) yw(1)]);

       AX(1,3)=axes('Units','normal', ...
   		'Position',[xposv(1)+2*(xw(5)+dx*xposv(1)) yposv(3) xw(5) yw(1)]);

       AX(1,4)=axes('Units','normal', ...
   		'Position',[xposv(1)+3*(xw(5)+dx*xposv(1)) yposv(3) xw(5) yw(1)]);

       AX(2,1)=axes('Units','normal', ...
   		'Position',[dx*xposv(1) yposv(1) xw(5) yw(1)]);

       AX(2,2)=axes('Units','normal', ...
   		'Position',[xposv(1)+xw(5)+dx*xposv(1) yposv(1) xw(5) yw(1)]);

       AX(2,3)=axes('Units','normal', ...
   		'Position',[xposv(1)+2*(xw(5)+dx*xposv(1)) yposv(1) xw(5) yw(1)]);

       AX(2,4)=axes('Units','normal', ...
   		'Position',[xposv(1)+3*(xw(5)+dx*xposv(1)) yposv(1) xw(5) yw(1)]);

  elseif axtyp==13
       dx=0.93;
       h=0.65;
       AX(1,1)=axes('Units','normal', ...
   		'Position',[dx*xposv(1) 1.25*yposv(3) xw(5) h*yw(1)]);

       AX(1,2)=axes('Units','normal', ...
   		'Position',[xposv(1)+xw(5)+dx*xposv(1) yposv(3) xw(5) yw(1)]);

       AX(1,3)=axes('Units','normal', ...
   		'Position',[xposv(1)+2*(xw(5)+dx*xposv(1)) yposv(3) xw(5) yw(1)]);

       AX(1,4)=axes('Units','normal', ...
   		'Position',[xposv(1)+3*(xw(5)+dx*xposv(1)) yposv(3) xw(5) yw(1)]);

       AX(2,1)=axes('Units','normal', ...
   		'Position',[dx*xposv(1) 1.2*(yposv(3)+yposv(1))/2 xw(5) h*yw(1)]);

       AX(2,2)=axes('Units','normal', ...
   		'Position',[xposv(1)+xw(5)+dx*xposv(1) yposv(1) xw(5) yw(1)]);

       AX(2,3)=axes('Units','normal', ...
   		'Position',[xposv(1)+2*(xw(5)+dx*xposv(1)) yposv(1) xw(5) yw(1)]);

       AX(2,4)=axes('Units','normal', ...
   		'Position',[xposv(1)+3*(xw(5)+dx*xposv(1)) yposv(1) xw(5) yw(1)]);

       AX(3,1)=axes('Units','normal', ...
   		'Position',[dx*xposv(1) 0.85*yposv(1) xw(5) h*yw(1)]);
end
      
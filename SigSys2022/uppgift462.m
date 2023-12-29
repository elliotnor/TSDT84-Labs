if Insignal
    figure(461); signalmod(toner,4.5); axis([-0.3 4.3 -6.6 6.6])
    title('BP-filtrets insignal'), ohfig
end
if INSPEKTRUM
    figure(462); spectmod(X,'A'); xlim([600 1700]), xticks([600 697 941 1209 1477 1700])
    title('Insignalens amplitudspektrum'), ohfig
end
if AMPLKAR
    figure(463); spectmod(H_BP,'A'); axis([600 1700 0 1.05]), xticks([600 697 941 1209 1477 1700])
    title('BP-filtrets amplitudkaraktäristik'), ohfig
    hold on, plot(941*[1 1],[0 1.1],'--k'), plot(1209*[1 1],[0 1.1],'--k'), 
    plot([0 2000],1/sqrt(2)*[1 1],'.--k'), hold off
end
if Utsignal
    figure(464); signalmod(y,4.5); axis([-0.3 4.3 -4.5 4.5])
    title('BP-filtrets utsignal'), ohfig
end
if UTSPEKTRUM
    figure(465); spectmod(Y,'A'); xlim([600 1700]), xticks([600 697 941 1209 1477 1700])
    title('Utsignalens amplitudspektrum'), ohfig
end
if PZ | AM | hn  % Visa minst en graf


[B1, A1] = butter(N, 2*0.15, filtertyp);
[B2, A2] = cheby1(N, 3, 2*0.15, filtertyp);
    
Hb = in(B1, A1, 'z');
Hc = in(B2, A2, 'z');

if PZ   % Rita pol-nollställediagrammen
    figure(631); 
        pz(Hb)
        title("Butterworth:  H_{Butt}[z]"); 
        ohfig
    figure(632); 
        pz(Hc)
        title("Chebyshev:  H_{Cheb}[z]"); 
        ohfig
end

if AM  % Visa amplitudkaraktäristik
    if AM==1    % LINJÄR SKALA
        figure(633)
        spect(Hb,Hc,fmax)
        subplot(2,1,1)
            title('Butterworth: |H_{Butt}[\theta]|')
        subplot(2,1,2)
            title('Chebyshev: |H_{Cheb}[\theta]|')

        ohfig
    else        % dB-SKALA
        figure(633)
            subplot(2,1,1)
                logspectmod(Hb,fmax)
                if dBmin, 
                    ylim([-10 5]);
                end
                TIT_hand=get(gca,'title');
                TIT=get(TIT_hand,'string');
                set(TIT_hand,'string',['|H_{Butt}[\theta]|_{dB} :  ' TIT])

            subplot(2,1,2)
                logspectmod(Hc,fmax)
                if dBmin, 
                    ylim([-10 5]);
                end
                TIT_hand=get(gca,'title');
                TIT=get(TIT_hand,'string');
                set(TIT_hand,'string',['|H_{Cheb}[\theta]|_{dB} :  ' TIT])
            ohfig
    end
    
end

if hn   % Visa impulssvaren
    figure(634)
    signal(iztr(elimpz(Hb)), iztr(elimpz(Hc)),nmax);
    subplot(2,1,1)
        xlim([-5 nmax])
        title("h_{Butt}[n]"); 
    subplot(2,1,2)
        xlim([-5 nmax])
        title("h_{Cheb}[n]"); 
    ohfig
end


end
    
    
    
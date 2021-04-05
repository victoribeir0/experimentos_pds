#{
    Série de filtros para processamento de sinal ECG.
    x = Sinal ECG de entrada.
    fs = Frequência de amostragem do sinal.
#}

function [y] = ecg_filt(x,fs)
    
    # Retira o nível DC do sinal.
    x = x-mean(x);
    
    # Filtro passa-baixas FIR, ordem = 100, fc = 50 Hz.
    x = pb_pt(x,50,fs,100);

    # Filtro passa-altas FIR, ordem = 300, fc = 2 Hz.
    x = pa_pt(x,2,fs,300);
    
    # Filtro de média móvel, tempo janela = 25 ms.
    y = ma(x,(25/1000)*fs);
    
endfunction

function [y] = pb_pt(x,fc,fs,M)
    [h,w,coef] = firr(fc,fs,M,'pb');
    y = conv(h,x);
endfunction

function [y] = pa_pt(x,fc,fs,M)
    [h,w,coef] = firr(fc,fs,M,'pa');
    y = conv(h,x);
endfunction

function [saida] = ma(x,win)
    for n = win:length(x)
        for i = 1:(win-1)
            a(i) = x(n-i);
        endfor
        saida(n) = sum(a)/win;
        a = 0;
    endfor
    
endfunction

#{
Voice Scrambler (encripitador baseado em filtros e modulação AM).
x = Sinal a ser encripitado.
fs = Freq. de amostragem (em Hz). 
f_port = Freq. da onda portadora (em Hz).
#}

function y = voz_enc(x,fs,f_port)
                     
    [h,w,coef] = firr(f_port,fs,100,'pb'); # Coeficientes do filtro FIR. 

    y1 = conv(x,coef); # Convolução, y1 = Sinal filtrado.

    # Modulação AM:
    t = 0:1/fs:length(y1)/fs;
    port = 2*sin(2*pi*t*f_port); # Onda portadora.
    y2 = y1.*port(1:end-1)'; # y2 = Sinal modulado.
       
    y = conv(y2,coef); # Última convolução, sinal encripitado.

endfunction

#{
    Determina os coeficientes do filtro FIR pelo método das janelas.
    fc = freq. de corte (em Hz));
    fs = freq. de amostragem (em Hz));
    M = ordem do filtro (inteiro positivo).
    filtro = 'pb' (passa-baixas)  ou 'pa' (passa-altas).
#}

function [h,w,coef] = firr(fc,fs,M,filtro)

    omegac = 2*pi*(fc/fs); # Frequência de corte normalizada.

    if filtro == 'pb' 

        # Resposta ao impulso do filtro passa-baixas.
        for n = -M/2:M/2
            if(n == 0)        
                h(M/2+1) = omegac/pi;
            else
                h(n+(M/2+1)) = (sin(omegac*n))/(n*pi);
            endif
        endfor

    elseif filtro == 'pa'

        # Resposta ao impulso do filtro passa-altas.
        for n = -M/2:M/2
            if(n == 0)        
                h(M/2+1) = (pi-omegac)/pi;
            else
                h(n+(M/2+1)) = -(sin(omegac*n))/(n*pi);
            endif
        endfor
    endif

    # Janela de Hamming.
    for n = 0:M/2*2
        w(n+1) = 0.54 - (0.46 * (cos((2*pi*n)/(M/2*2))));
    endfor

    # Determina os coeficientes.
    coef = h.*w;

endfunction

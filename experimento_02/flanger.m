#{
    Flanger com filtro comb.
    x = sinal de entrada.
    fs = Freq. de amostragem.
    fd = Feedback, controla o quanto do sinal atrasado é incluído na efeito.
    f_lfo = freq. do LFO que controla o atraso variante no tempo.
    atraso = Determina o range de atraso.
#}

function y = flanger(x,fs,fd,f_lfo,atraso)

    N = length(x);    # Dimensão do sinal.
    y = zeros(1,N); # Sinal de saida com eco.
        
    t = 0:1/fs:(N/fs);
    d = 3*cos(2*pi*f_lfo*t)+atraso; # Entre 2 e 8 ms de atraso.
    d = (d/1000)*fs;     # Converte em amostras.
    inicio = d(1); # (5/1000)*fs

    # A parte inicial do sinal de saída é igual a entrada.
    y(1:inicio) = x(1:inicio); 

    # Filtro comb.
    for n = inicio:N               
        atraso = round((d(n)-1));
        y(n) = 0.7*x(n) + fd*x(n-atraso);
    endfor

endfunction

function y = gera_ondas(fa)

// Freq. de notas musicais escala C (Dó).
frequencias = [262 294 330 349 392 440 494 523]; 

// Freq. de amostragem, no mínimo duas vezes a frequência máxima.
// fa = 2*max(frequencias); 

// Perído da onda, inverso da frequência.
periodo = 1/fa;

// Tempo.
tempo = 0:1/fa:0.2;

y = [];

for n = 1:length(frequencias)
    y = [y sin(2*%pi*frequencias(n)*tempo)];        
end

// FFT
espectro = fft(y);
espectro = abs(espectro);
espectro = espectro(1:length(y)/2+1);
espectro = espectro/length(y);
f = fa*(0:length(y)/2)/length(y);
plot(f,espectro);

endfunction

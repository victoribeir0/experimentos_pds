function X = fft_(x,fs)
    N = length(x); // Número de amostras em x.
    k = 0:N-1; 
    n = 1:N;
    
    M = exp((-%i*2*%pi*n'*k)/N); // Matriz de senoides.
    X = abs(x*M); // Valor absoluto.
    X = X/N; // Normalizar o valor.
    X = X(1:length(X)/2+1);
    
    f = fs*(0:length(x)/2)/length(x);
    // plot(f,X);
            
endfunction

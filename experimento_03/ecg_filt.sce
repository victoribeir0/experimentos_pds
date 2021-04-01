function [y] = ecg_filt(x,fs)
    x = x-mean(x);

    x = pb_pt(x,11,fs,100);

    x = pa_pt(x,5,fs,100);

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
        end
        saida(n) = sum(a)/win;
        a = 0;
    end
endfunction

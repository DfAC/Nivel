% S.Guillaume
function [freq, AmpliNorm, Phase,a,b] = DFT(t,F,sampling, nbr_freq,do_plot)

%************
% ** INPUT **
%************
% t = time [sec]
% F = signal [?],
% sampling = sampling = 0 -> Max(diff(t)) sampling ~= 0 -> samplingrate [s]
% nbr_freq = number of freq between 0 and Nyquist
% do_plot = 0 -> no, 1 -> yes

%*************
% ** OUTPUT **
%*************
% freq = frequency [Hz]
% AmpliNorm = Amplitude [?]
% Phase = Phase [deg],
% a = cos fourier coeff
% b = sin fourier coeff

%**************
% ** EXAMPLE **
%**************
% dt = 0.01;
% t=[0:dt:20]';s=2*sin(2*pi*0.5*t)+3*sin(2*pi*2.5*t);
% nbr_freq = size(t,1)/2;
% [freq, Ampli, Phase,a , b] = DFT(t,s,dt,nbr_freq,1);

L=length(F);

if sampling ~= 0
    fgrenz=1/(2*sampling);
else
    fgrenz=1/(2*max(diff(t)));
end

freq(:,1)=0:fgrenz/nbr_freq:fgrenz;
k=1;

for i=0:fgrenz/nbr_freq:fgrenz
    ai=0;
    bi=0;

    for j=2:L
        ai=ai+F(j,1)*cos(2*pi*i*t(j,1))*(t(j,1)-t(j-1,1));
        bi=bi+F(j,1)*sin(2*pi*i*t(j,1))*(t(j,1)-t(j-1,1));
    end

    a(k,1)=i;
    b(k,1)=i;
    a(k,2)=ai*2/(t(L,1)-t(1,1));
    b(k,2)=bi*2/(t(L,1)-t(1,1));
    Ampli(k,1)=sqrt(a(k,2)^2+b(k,2)^2);
    Phase(k,1)=atan(b(k,2)/a(k,2))*180/pi;
    k=k+1;
end

AmpliNorm=Ampli;

if do_plot == 1
    figure

    subplot(2,1,1)
    stem(freq,AmpliNorm,'k','MarkerFaceColor','k','MarkerSize',2);
    grid on;
    box on;
    title('Discret Fourier Transform')
    xlabel('freq [hz]')
    ylabel('Amplitude')

    subplot(2,1,2)
    stem(freq,Phase,'k','MarkerFaceColor','k','MarkerSize',2);
    grid on;
    box on;
    xlabel('freq [hz]')
    ylabel('Phase [deg]')

end

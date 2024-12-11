%Grabar Audio Matlab
close all;
clear all;%borra las variables del archivo%
clc;

%t = input ('Cuantos segundos quieres grabar '); %variable de tiempo en segundos%
%Fs= input ('Con que Frecuencia quieres grabarlo ');%variable de la frecuencia de la se–al%
t = 2;
Fs = 44100;
v = audiorecorder(Fs, 24, 1);
v.StartFcn = 'disp(''   iniciando grabación'')';
v.StopFcn = 'disp(''   terminando grabación'')';

input ('Presione enter para grabar la primera senal'); %impresion de pantalla
recordblocking(v, t)
y = v.getaudiodata()
wavwrite (y,Fs,'grabacion1'); %guarda el sonido en formato wav%
which 'grabacion1.wav'
input ('Señal capturada');

input ('Presione enter para grabar la señal');%impresion de pantalla%
recordblocking(v, t);
x = v.getaudiodata();
wavwrite (x,Fs,'grabacion2');%guarda el sonido en formato wav%
which 'grabacion2.wav'
input ('Señal capturada');

input ('Presione enter para escuchar la primera grabacion');%impresion de pantalla%
sound(y,Fs);%reproduce sonido%

input('Presione enter para escuchar la segunda grabacion'); %impresion de pantalla%
sound(x,Fs);%reproduce sonido%

close all;
clear all;%borra las variables del archivo%

s = audioread('grabacion1.wav');
g = audioread('grabacion2.wav');

s = normalizar(s);
voz1 = abs(fft (s)); % se obtiene la transformada de fourier de la primera grabacion %
voz1 = voz1.*conj (voz1); % se obtiene el conjugado% 
voz1f = voz1 (1:100); % Solo acepta las Frecuencias arriba de 100 HZ %
voz1fn = voz1f/sqrt(sum (abs (voz1f).^2)); % se normaliza el vector %

g = normalizar(g);
voz2 = abs(fft (g)); % se obtiene la transformada de fourier de la segunda grabacion %
voz2 = voz2.*conj (voz2); % se obtiene el conjugado% 
voz2f = voz2 (1:100); % Solo acepta las Frecuencias arriba de 100 HZ %
voz2fn = voz2f/sqrt(sum (abs (voz2f).^2)); % se normaliza el vector %

%%
c = audioread('grabacion_casa.wav');
p = audioread('grabacion_perro.wav');
l = audioread('grabacion_lunes.wav');
a = audioread('grabacion_azul.wav');
n = audioread('grabacion_navidad.wav');

c = normalizar(c);
vozc = abs(fft (c)); % se obtiene la transformada de fourier de la primera grabacion %
vozc = vozc.*conj (vozc); % se obtiene el conjugado% 
vozcf = vozc (1:100); % Solo acepta las Frecuencias arriba de 600 HZ %
vozcfn = vozcf/sqrt(sum (abs (vozcf).^2)); % se normaliza el vector %

p = normalizar(p);
vozp = abs(fft (p)); % se obtiene la transformada de fourier de la primera grabacion %
vozp = vozp.*conj (vozp); % se obtiene el conjugado% 
vozpf = vozp (1:100); % Solo acepta las Frecuencias arriba de 600 HZ %
vozpfn = vozpf/sqrt(sum (abs (vozpf).^2)); % se normaliza el vector %

l = normalizar(l);
vozl = abs(fft (l)); % se obtiene la transformada de fourier de la primera grabacion %
vozl = vozl.*conj (vozl); % se obtiene el conjugado% 
vozlf = vozl (1:100); % Solo acepta las Frecuencias arriba de 600 HZ %
vozlfn = vozlf/sqrt(sum (abs (vozlf).^2)); % se normaliza el vector %

a = normalizar(a);
voza = abs(fft (a)); % se obtiene la transformada de fourier de la primera grabacion %
voza = voza.*conj (voza); % se obtiene el conjugado% 
vozaf = voza (1:100); % Solo acepta las Frecuencias arriba de 600 HZ %
vozafn = vozaf/sqrt(sum (abs (vozaf).^2)); % se normaliza el vector %

n = normalizar(n);
vozn = abs(fft (n)); % se obtiene la transformada de fourier de la primera grabacion %
vozn = vozn.*conj (vozn); % se obtiene el conjugado% 
voznf = vozn (1:100); % Solo acepta las Frecuencias arriba de 600 HZ %
voznfn = voznf/sqrt(sum (abs (voznf).^2)); % se normaliza el vector %

%%

disp('Diferencias fft')
disp(mean(abs(voz1-voz2)))
disp('Correlacion de Pearson')
disp(corr(voz1,voz2))
disp('Coeficiente de Error  casa:')
error(1) = mean(abs(voz2-vozc));
disp(error(1))
disp('Correlacion de Error  perro:')
error(2) = mean(abs(voz2-vozp));
disp(error(2))
disp('Correlacion de Error  lunes:')
error(3) = mean(abs(voz2-vozl));
disp(error(3))
disp('Correlacion de Error  azul:')
error(4) = mean(abs(voz2-voza));
disp(error(4))
disp('Correlacion de Error  navidad:')
error(5) = mean(abs(voz2-vozn));
disp(error(5))

min_error = min(error);

switch min_error
    case error(1) 
        disp('Palabra: CASA')
    case error(2)
        disp('Palabra: PERRO')
    case error(3)
        disp('Palabra: LUNES')
    case error(4)
        disp('Palabra: AZUL')
    case error(5)
        disp('Palabra: NAVIDAD')
end

subplot(2,5,1),plot(s); %relacion de posicion de la grafica%
title ('Grabacion 1')
subplot(2,5,2),plot(voz1fn); % Espectro de la grabacion 1 
title ('Espectro de la grabacion 1')

subplot(2,5,3),plot(g); %relacion de posicion de la grafica%
title ('Grabacion 2')
subplot(2,5,4),plot(voz2fn); % espectro de la grabacion 2 
title ('Espectro de la grabacion 2')

 subplot(2,5,6),plot(vozcfn); % espectro de la grabacion c 
 title ('Grabacion casa')
 subplot(2,5,7),plot(vozpfn); % espectro de la grabacion p 
 title ('Grabacion perro')
 subplot(2,5,8),plot(vozlfn); % espectro de la grabacion l 
 title ('Grabacion lunes')
 subplot(2,5,9),plot(vozafn); % espectro de la grabacion a 
 title ('Grabacion azul')
 subplot(2,5,10),plot(voznfn); % espectro de la grabacion n 
 title ('Grabacion navidad')
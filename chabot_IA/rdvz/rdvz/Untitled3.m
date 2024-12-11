global yy fs;
fs=44100;
disp('grabando');
yy=audiorecord(3*40000,fs);
sound(yy,fs)
audiowrite(yy,fs,'voz')

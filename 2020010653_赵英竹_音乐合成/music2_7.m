clear all
load('Guitar.mat')
Fs = 8000;
t = [0:1/Fs:length(wave2proc)/Fs];
t = t(1:length(wave2proc));
realwave = resample(realwave,10,1);
[pks,locs] = findpeaks(realwave,'minpeakheight',0.15);
inter = 0;
for i = 2:length(locs)
    inter  = inter + locs(i) - locs(i-1); 
end
inter = round(inter/(length(locs)-1));
times = length(realwave)/inter;
average = zeros(size(wave2proc));
for i = 1:243
    for j = 0:times-1
    average(i) = average(i) + realwave(i+j*inter);
    end
    average(i) = average(i) / times;
end
new_realwave = repmat(average,times,1);
new_realwave = resample(new_realwave,1,10);
plot(t,new_realwave,'k-')
hold on
plot(t,wave2proc,'b--')

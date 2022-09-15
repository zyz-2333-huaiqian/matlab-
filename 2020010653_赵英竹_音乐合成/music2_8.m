clear all
load('Guitar.mat')
Fs = 8000;
wave2proc = repmat(wave2proc,5,1);
y = fft(wave2proc);   
f = (0:length(y)-1)*Fs/length(y);
y = abs(y);
[pks,locs] = findpeaks(y,'minpeakheight',10);
locs = (locs-1) * Fs /length(y);
pks = pks/pks(1);

note_dict 
notes_dist = abs(notes_list - locs(1));
[~,note] = min(notes_dist);
note = notes_list(note);
notes_map(note)

plot(f,y)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
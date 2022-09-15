clear all
Fs = 8000;

music_begin = [2392,14290,18100,22170,25380,29040,32750,36310,40370,48570,56260,62480,68010,...
    71790,75810,79010,81190,82910,84630,86660,90470,94080,102200,106300,114700,119800,131072];
Fs = 8000;
music = audioread('fmt.wav');
note_sheet  = {};
for i = 1:length(music_begin)-1
    music_read = music(music_begin(i):music_begin(i)+700);
    
    y = fft(music_read);   
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
    note_time = round((music_begin(i+1)-music_begin(i))/8000*2)/2;

    note_sheet(i,:) = {notes_map(note),locs(1:min(4,length(locs))),pks(1:min(4,length(locs))),note_time};
    %plot(f,y)
end

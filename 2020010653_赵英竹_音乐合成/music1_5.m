Fs = 8000;
notes_F = [349.23, 392, 440, 466.16, 523.25,  587.33, 659.25,698.80];
notes_F_b = [174.61, 196, 220, 233.08, 261.63, 293.66, 329.63];
sheet_notes = [5,3,5,8,6,8,6,5,5,1,2,3,2,1,2];
sheet_time = [0.5, 0.25, 0.25, 1, 0.5, 0.25, 0.25, 1,0.5,0.25,0.25,0.5,0.25,0.25,1.5];
music = [];
for i = 1:length(sheet_notes)
    fre = notes_F(sheet_notes(i));
    t = [0:1/Fs:sheet_time(i)];
    y = ADSR_1(t);
    apmusic = (sin(2 * pi * fre *t) + 0.2*sin(4 * pi * fre *t) ...
        + 0.3*sin(6 * pi * fre *t)).*y;
    music = [music,apmusic];
end
sound(music,Fs)
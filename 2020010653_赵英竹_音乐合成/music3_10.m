%降一个八度后的

Fs = 8000;

notes_F = [349.23, 392, 440, 466.16, 523.25,  587.33, 659.25]/2;
notes_F_b = [174.61, 196, 220, 233.08, 261.63, 293.66, 329.63]/2;
sheet_basic = [0 0 0 0  0 0 1 0 ];
sheet_notes = [5 5 6 2  1 1 6 2 ];
sheet_time = [0.5, 0.25, 0.25, 1, 0.5, 0.25, 0.25, 1];
music = [];
for i = 1:8
    if sheet_basic(i) == 0
        fre = notes_F(sheet_notes(i));
    else
        fre = notes_F_b(sheet_notes(i));
    end
    t = [0:1/Fs:sheet_time(i)];
    y = ADSR_2(t);
    apmusic = (sin(2 * pi * fre *t)+1.4572*sin(4 * pi * fre *t)+0.9587*sin(6 * pi * fre *t)...
        +1.0999*sin(8 * pi * fre *t)).*y;
    music = [music,apmusic];
end
plot(music)
sound(music,Fs)
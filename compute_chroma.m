function [chroma, T] = compute_chroma(filepath, win_size, hop_size)
    [x_t, fs] = audioread(filepath);
    x_t = resample(x_t, 1, 4);
    x_t = x_t(:,1);
    [x, f, ts] = spectrogram(x_t, hamming(win_size), win_size - hop_size, win_size, fs);
    N = length(f);
    T = length(ts);
    filterbank = zeros(12, N);
    A0 = 440.0/4;
    fmax = fs/2;
    for i = 1:12
        row = zeros(1, N);
        fbase = A0 * 2^((i-1)/12);
        maxOctave = floor(log(fmax/fbase)/log(2));
        for octave = 0:maxOctave
            fi = fbase*2^octave;
            k = find_nearest(f,fi);
            bump = 1:N;
            bump = exp(-15*abs(log(bump/k)/log(2)));
            bump = bump/norm(bump);
            row = row + bump;
        end
        filterbank(i, :) = row;
    end
    chroma = filterbank*abs(x);
    chroma = chroma.^2;
    for i=1:T
         chroma(:,i) = (chroma(:,i)-min(chroma(:,i)))/max(chroma(:,i)-min(chroma(:,i)));
    end
    for i=1:12
         chroma(:,i) = chroma(:,i)/sum(chroma(:,i));
    end
end


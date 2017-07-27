function [mfccs, T] = compute_mfccs(filepath, win_size, hop_size, min_freq, max_freq, num_mel_filts, n_dct)
    [x_t, fs] = audioread(filepath);
    x_t = resample(x_t, 1, 4);
    x_t = x_t(:,1);
    [x, f, ts] = spectrogram(x_t, hamming(win_size), win_size - hop_size, win_size, fs);
    T = length(ts);
    min_mel = hz2mel(min_freq);
    max_mel = hz2mel(max_freq);
    interval = (max_mel - min_mel) / (num_mel_filts - 1);
    mel_array = [min_mel - interval : interval : max_mel + interval];
    freq_array = mel2hz(mel_array);
    freq_round = find_nearest(f, freq_array);
    
    %build the mel filter
    mel_filter = zeros(num_mel_filts, length(f));
    for i = 1 : (length(freq_round)-2)
        left = freq_round(i);
        mid = freq_round(i+1);
        right = freq_round(i+2);
        for j = left:mid
            mel_filter(i, j) = (j - left)/(mid - left);
        end
        for j = mid+1:right
            mel_filter(i, j) = (right - j)/(right - mid);
        end
        mel_filter(i,:) = mel_filter(i,:)/sum(mel_filter(i,:));
    end
    mel = mel_filter*abs(x);
    mel_dB = log(mel.^2);
    dct_result = dct(mel_dB);
    dct_result = dct_result(2:n_dct,:);
    for i=1:(length(ts))
        dct_result(:,i) = (dct_result(:,i)-min(dct_result(:,i)))/max(dct_result(:,i)-min(dct_result(:,i)));
        dct_result(:,i) = dct_result(:,i)/sum(dct_result(:,i));
    end
    mfccs = dct_result;
    fs_mfcc = fs/hop_size;
%     figure  
%     imagesc(mfccs);
end

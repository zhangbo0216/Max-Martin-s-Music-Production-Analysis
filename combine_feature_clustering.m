fileFolder = fullfile('./Set');
dirOutput = dir(fullfile(fileFolder,'*.wav'));
fileNames = {dirOutput.name};
N = length(fileNames);
mfcc = [];
chroma = [];
l = [0];
win_size = 4096;
hop_size = 512;
min_freq = 86;
max_freq = 8000;
num_mel_filts = 40;
n_dct = 15;
for i = 1:N
    [c, n] = compute_mfccs(['./Set/',char(fileNames(i))], win_size, hop_size, min_freq, max_freq, num_mel_filts, n_dct);
    mfcc = [mfcc c];
    l = [l l(length(l))+n];
end
for i = 1:N
    [c, n] = compute_chroma(['./Set/',char(fileNames(i))], win_size, hop_size);
    chroma = [chroma c];
end
num_features = 800;
num_cluster = 30;
[cluster, C, sumd, D] = clustering_the_data([mfcc', chroma']', l, N,num_features, num_cluster, 200);
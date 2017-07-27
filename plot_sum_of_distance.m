fileFolder = fullfile('./Set');
fileNames = [];
dirOutput = dir(fullfile(fileFolder,'*.wav'));
fileNames = [fileNames, {dirOutput.name}];
N = length(fileNames);
mfcc = [];
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
x = [];
y = [];
for j =400:1000
    J = sum_of_distance(mfcc ,j, 1000);
    x = [x, j];
    y = [y, J];
end
plot(x,y);
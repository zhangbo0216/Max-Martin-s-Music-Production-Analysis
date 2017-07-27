fileFolder = fullfile('./Set');
dirOutput = dir(fullfile(fileFolder,'*.wav'));
fileNames = {dirOutput.name};
N = length(fileNames);
chroma = [];
l = [0];
win_size = 4096;
hop_size = 512;
for i = 1:N
    [c, n] = compute_chroma(['./Set/',char(fileNames(i))], win_size, hop_size);
    chroma = [chroma c];
    l = [l l(length(l))+n];
end
num_features = 400;
num_cluster = 24;
[cluster, C, sumd, D] = clustering_the_data(chroma, l, N,num_features, num_cluster, 500);


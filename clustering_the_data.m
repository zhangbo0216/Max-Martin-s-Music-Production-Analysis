function [cluster, C, sumd, D] = clustering_the_data(low_level_features, l, N, num_features, num_cluster, MaxIter)
    [frame_cluster, C1, sumd1, D1] = kmeans(low_level_features', num_features, 'MaxIter', MaxIter);
%     frame_cluster;
%     sumd1;
    features = zeros(N, num_features);
    for i = 1:N
        for j = l(i)+1:l(i+1)
            if ~isnan(frame_cluster(j))
                features(i, frame_cluster(j)) = features(i, frame_cluster(j)) + 1;
            end
        end
        features(i, :) = features(i, :)/sum(features(i, :));
    end
[cluster, C, sumd, D] = kmeans(features, num_cluster, 'MaxIter', MaxIter);
end
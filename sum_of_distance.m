function R = sun_of_distance(features, num_features, MaxIter)
    R = inf;
    for i = 1:50
    [cluster, C, sumd, D] = kmeans(features', num_features, 'MaxIter', MaxIter);
    R = min([sum(sumd), R]);
    end
end
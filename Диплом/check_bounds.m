function X_checked = check_bounds(X, map_size)
    X(X <= 1) = 1;
    X(X > map_size) = map_size;
    X_checked = X;
end
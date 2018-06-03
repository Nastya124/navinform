function X_checked = check_bounds(X, map_size,index)
if index == 2
     X(X <= 0) = 0;
     X(X > map_size) = map_size;
     X_checked = X;
else
    L = length(X);
    k=0;
    try
    for i = 1:L
        i=i-k;
        
        if ((X(1,i)<=1)||(X(2,i)<=1)||(X(1,i)> map_size)||(X(2,i) > map_size))
                X(:,i)=[];
                L = L-1;
                k=k+1;
        
              
        end
        
    end
    catch ME
            disp('err');
            rethrow(ME)
   end
    X_checked = X;
end

end
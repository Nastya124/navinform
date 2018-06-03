function M_ptn = check_bounds(ptn, STN)

for j = 1:length(ptn)
    pt_len = length(ptn{j});
    k=0;
    for i = 1:pt_len
        i=i-k;
        if ((ptn{j}(i,1)<=0)||(ptn{j}(i,2)<=0)||(ptn{j}(i,1)>STN.Map_Xsize)||(ptn{j}(i,2) > STN.Map_Ysize))
            ptn{j}(i,:)=[];
            pt_len = pt_len-1;
            k=k+1;
            
        end
    end
    
end

M_ptn = ptn;





% if ind == 2
%      X(X <= 0) = 0;
%      X(X > map_size) = map_size;
%      X_checked = X;
% else
%     L = length(X);
%     k=0;
%     try
%     for i = 1:L
%         i=i-k;
%
%         if ((X(1,i)<=1)||(X(2,i)<=1)||(X(1,i)> map_size)||(X(2,i) > map_size))
%                 X(:,i)=[];
%                 L = L-1;
%                 k=k+1;
%
%
%         end
%
%     end
%     catch ME
%             disp('err');
%             rethrow(ME)
%    end
%     X_checked = X;
% end
%
% end
function P  = conditional_cov_matrix(route, Map_data, STN)

P = zeros(2,2,route.pts_num+1);
P(:,:,1) = STN.P_0;
mnt = 1;
for j = 1:route.prt_num
    for i = 1:length(route.pts{j})
        
        %рассчет по рекуррентным соотношениям
        H(1) = interp2(Map_data.X_grid, Map_data.Y_grid, Map_data.dX, route.pts{j}(i,1), route.pts{j}(i,2));
        H(2) = interp2(Map_data.X_grid, Map_data.Y_grid, Map_data.dY, route.pts{j}(i,1), route.pts{j}(i,2));
        K = P(:,:,mnt)*H'*(H*P(:,:,mnt)*H'+STN.r)^-1;
        E = eye(2);
        P(:,:,mnt+1) = (E - K*H)*P(:,:,mnt);
        mnt = mnt+1;
        
    end
    
end
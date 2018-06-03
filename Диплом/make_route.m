function route  = make_route(route_a, route_b)

route.prt_num = route_a.prt_num+route_b.prt_num;
route.pts_num = route_a.pts_num+route_b.pts_num;
route.pts = horzcat(route_a.pts,route_b.pts);
function [dx,dy]=BuildingDynamics(nx,ny,dx)
  dx=[0 0;reshape(dx(1:((nx+1)*(ny+1))),ny+1,nx+1)];
  x=0:nx;
  dy=0:(ny+1);
  [x,dy]=meshgrid(x,dy);
  z=zeros(ny+2,nx+1);
  dx=x+dx;
  colormap(1e-10*[1 1 1]);
  mesh(dx,dy,z);
  hold on;
  plot(dx(:,1),dy(:,1),'k.','markersize',15);
  plot(dx(:,2),dy(:,2),'k.','markersize',15);
  hold off;
  axis([-1 2 0 ny+1]);
  axis equal;
  grid on;
  view(2);
end
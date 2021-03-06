% Copyright (C) 2020 Fredy Vides
% function [t,x]=NLMechanicalSystem(m,k,d,T,x0)
% A mechanical system simulation

% Example: [t,x]=NLMechanicalSystem(10,50,0,10,[1,0]);

% Author: Fredy Vides <fredy@HPCLAB>
% Scientific Computing Innovation Center
% Created: 2020-05-03
function [t,x]=NLMechanicalSystem(m,k,d,T,x0)
  Fx=@(x,y)y;
  Fy=@(x,y)(1/m)*(-k*x+d*x.^3);
  f=@(t,y)[y(2);(1/m)*(-k*y(1)+d*y(1).^3)];
  opt=odeset ("RelTol", eps);
  [t,x] = ode45 (f, [0, T], x0,opt);
  cx=norm(max(abs(x)));
  [X,Y]=meshgrid(-cx:2*cx/30:cx);
  quiver(X,Y,Fx(X,Y),Fy(X,Y),'k');
  hold on;
  plot(x(:,1),x(:,2),'k','markersize',12);
  hold off;
  axis equal;
end
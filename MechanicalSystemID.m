% Copyright (C) 2020 Fredy Vides
% function [Th,Thp,C]=MechanicalSystemID(m)
% A sytem identificacion computational 
% implementation

% Example: [Th,Thp,C]=MechanicalSystemID(120)

% Author: Fredy Vides <fredy@HPCLAB>
% Scientific Computing Innovation Center
% Created: 2020-05-03
function [Th,Thp,C]=MechanicalSystemID(m)
[t,x,A,C,Th]=MechanicalSystem(10,50,0,10,[1,0]);
hold on;
[Ap,Thp,f]=TMatrixID(x,m);
N=size(x,1);
Yp=[1;0];
Y=Yp;
for k=1:3*N
    Y=[Y Th*Y(:,k)];
    Yp=[Yp Thp*Yp(:,k)+f];
end
plot(x(:,1),x(:,2),'k');
plot(Y(1,:),Y(2,:),'b.-','markersize',12);
plot(Yp(1,:),Yp(2,:),'r.-','markersize',12);
axis equal;
hold off;
end
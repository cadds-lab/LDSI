% Copyright (C) 2020 Fredy Vides
% function [Thp,f,t,x,Y]=NLMechanicalSystemID(m)
% A sytem identificacion computational 
% implementation

% Example: [Thp,f,t,x,Y]=NLMechanicalSystemID(180)

% Author: Fredy Vides <fredy@HPCLAB>
% Scientific Computing Innovation Center
% Created: 2020-05-03
function [Thp,f,t,x,Yp]=NLMechanicalSystemID(m)
subplot(211);
[t,x]=NLMechanicalSystem(2,.1,-4,30,[1,0]);
hold on;
[Ap,Thp,f]=TMatrixID(x,m);
N=size(x,1);
Yp=[1;0];
for k=1:(N-1)
    Yp=[Yp Thp*Yp(:,k)+f];
end
plot(x(:,1),x(:,2),'b.-','markersize',12);
plot(Yp(1,:),Yp(2,:),'r.-','markersize',12);
axis square;
grid on;
hold off;
subplot(212);
plot(t,x(:,1),'k',t,x(:,2),'r');
hold on;
plot(t,Yp(1,:),'k.-','markersize',12);
plot(t,Yp(2,:),'r.-','markersize',12);
legend('x','dx/dt')
axis equal;
grid on;
end
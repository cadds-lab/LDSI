% Copyright (C) 2020 Fredy Vides
% function [Th,Thp,C,T,Tp]=MechanicalSystemID(m)
% A sytem identificacion computational 
% implementation

% Example: [Th,Thp,C,T,Tp]=MechanicalSystemID(120)

% Author: Fredy Vides <fredy@HPCLAB>
% Scientific Computing Innovation Center
% Created: 2020-05-03
function [Th,Thp,C,T,Tp]=MechanicalSystemID(m)
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
th=eig(Th);
th=th(1);
thp=eig(Thp);
thp=thp(1);
fh=@(t)abs(th.^t-th);
fhp=@(t)abs(thp.^t-thp);
tt=(1+1/4):1/100:m;
m=min(fh(tt));
mp=min(fhp(tt));
f=find(fh(tt)==m);
fp=find(fhp(tt)==mp);
T=tt(f);
Tp=tt(fp);
tt=(T-.5):1/500:(T+.5);
m=min(fh(tt));
f=find(fh(tt)==m);
T=tt(f);
tt=(Tp-.5):1/500:(Tp+.5);
mp=min(fhp(tt));
fp=find(fhp(tt)==mp);
Tp=tt(fp);
T=(T-1)/2;
Tp=(Tp-1)/2;
end
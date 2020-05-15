% Example: L=7;[t,x,xp,A,Ap,Aps]=GBuildingDynamicsA(L,200,0,
% 3,20,20,.1*[1 zeros(1,L-1) 1 zeros(1,L-1)],zeros(1,2*L),0);
function [t,x,xp,A,Ap,Aps]=GBuildingDynamicsA(L,m,d,sm,ss,T,x0,v0,sp)
   [t,x,A]=LinearStructuralSystem(L,m,d,T,x0,v0);
   if sp==0
   	[Ap,Aps]=LSDITMatrixID(x,ss);
   else
   	[Ap,Aps]=HLSDITMatrixID(x,ss);
   end
   N=length(t);
   xp=[x0 v0];
   if d==0
   	Tm=Aps.';
   else
	Tm=Ap.';
   end
   for k=1:(N-1)
     xp=[xp;xp(k,:)*Tm];
     subplot(121);
     [dx,dy]=BuildingDynamics(1,L-1,x(k,:));
     subplot(122);
     [dx,dy]=BuildingDynamics(1,L-1,xp(k,:));
     pause(.1);
   end
   figure;
   subplot(411);plot(t,x(:,sm),'k.-','markersize',15);
   hold on;
   plot(t,xp(:,sm),'b.-','markersize',15);
   hold off;
   subplot(412);plot(t,abs(x(:,sm)-xp(:,sm))./abs(x(:,sm)),'r.-','markersize',15);
   subplot(413);plot(t,x(:,sm+L),'k.-','markersize',15);
   hold on;
   plot(t,xp(:,sm+L),'b.-','markersize',15);
   hold off;
   subplot(414);plot(t,abs(x(:,sm+L)-xp(:,sm+L))./abs(x(:,sm+L)),'r.-','markersize',15);
end
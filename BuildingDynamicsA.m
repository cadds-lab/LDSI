% Examples:
% L=7;[t,x,A]=StructuralDynamicalSystem(L,200,-1,...
% 20,.1*[1 zeros(1,L-1) 1 zeros(1,L-1)],zeros(1,2*L));
% csvwrite ('TXdata.csv', [t.' x]);
% [t,x,xp,Ap,Aps]=BuildingDynamicsA('TXdata',3,...
% 20,0,0);
% L=7;[t,x,A]=StructuralDynamicalSystem(L,200,0,...
% 20,.1*[1 zeros(1,L-1) 1 zeros(1,L-1)],zeros(1,2*L));
% csvwrite ('TXdata.csv', [t.' x]);
% [t,x,xp,Ap,Aps]=BuildingDynamicsA('TXdata',3,...
% 20,0,1);
% L=7;[t,x,A]=StructuralDynamicalSystem(L,200,0,...
% 20,.1*[1 zeros(1,L-1) 1 zeros(1,L-1)],zeros(1,2*L));
% csvwrite ('TXdata.csv', [t.' x]);
% [t,x,xp,Ap,Aps]=BuildingDynamicsA('TXdata',3,...
% 20,1,1);
% One can also use the csv data files in LDSI repository
% [t,x,xp,Ap,Aps]=BuildingDynamicsA('TXdataDissipative',3,...
% 20,0,0);
% [t,x,xp,Ap,Aps]=BuildingDynamicsA('TXdataConservative',3,...
% 20,1,1);
function [t,x,xp,Ap,Aps]=BuildingDynamicsA(fname,sm,ss,sp,smat)
   TXdata=csvread([fname,'.csv']);
   [N,n]=size(TXdata);
   t=TXdata(:,1);
   x=TXdata(:,2:n);
   L=(n-1)/4;
   if sp==0
   	[Ap,Aps]=LSDITMatrixID(x,ss);
   else
   	[Ap,Aps]=HLSDITMatrixID(x,ss);
   end
   xp = TXdata(1,2:n);
   if smat==1
   	Tm=Aps.';
   else
	Tm=Ap.';
   end
   for k=1:(N-1)
     xp=[xp;xp(k,:)*Tm];
     subplot(121);
     [dx,dy]=BuildingDynamics(1,L-1,x(k,:));
     title('Original system behavior')
     subplot(122);
     [dx,dy]=BuildingDynamics(1,L-1,xp(k,:));
     title('Identified system behavior')
     pause(.1);
   end
   figure;
   subplot(211);plot(t,x(:,sm),'k.-','markersize',15);
   hold on;
   plot(t,xp(:,sm),'b.-','markersize',15);
   hold off;
   grid on;
   legend('original signal','identified signal');
   subplot(212);plot(t,x(:,sm+L),'k.-','markersize',15);
   hold on;
   plot(t,xp(:,sm+L),'b.-','markersize',15);
   hold off;
   grid on;
   legend('original signal','identified signal');
end
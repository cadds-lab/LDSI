% Copyright (C) 2020 Fredy Vides
% function [t,x,A]=StructuralDynamicalSystem(N,m,d,T,x0,v0)
% A mechanical system simulation

% Example: [t,x,A]=StructuralDynamicalSystem(4,100,0,5,...
% [0,0,0,.1,0,0,0,.1],[0,0,0,0,0,0,0,0]);

% Author: Fredy Vides <fredy@HPCLAB>
% Scientific Computing Innovation Center
% Created: 2020-05-03
function [t,x,A]=StructuralDynamicalSystem(N,m,d,T,x0,v0)
  ht=T/m;
  t=0:ht:T;
  x=[x0,v0];
  A=spdiags(ones(N,1)*[10 -20 10],-1:1,N,N);
  A(N,N)=A(N,N)/2;
  Ce=abs(max(eig(A)));
  E=eye(N);
  A=[-A,-Ce*E;-Ce*E,-A];
  E=eye(2*N);
  Z=zeros(2*N);
  Z=[Z E;-E Z];
  [v,a]=eig(full(A));
  lap=diag((d+sqrt(d^2-4*diag(a)))/2);
  lam=diag((d-sqrt(d^2-4*diag(a)))/2);
  z=[v v;v*lap v*lam];
  lap=diag(lap);
  lam=diag(lam);
  A=real(z*diag([exp(ht*lap);exp(ht*lam)])/z);
  if d==0  
	A=(A-Z*inv(A).'*Z)/2;
  end
  E=A.';
  for k=1:m
    x=[x;x(k,:)*E];
  end
end
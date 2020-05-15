% Copyright (C) 2020 Fredy Vides
% function [t,x,A]=LinearStructuralSystem(N,m,T,x0,v0)
% A mechanical system simulation

% Example: [t,x,A]=LinearStructuralSystem(4,100,5,...
% [0,0,0,.1,0,0,0,.1],[0,0,0,0,0,0,0,0]);

% Author: Fredy Vides <fredy@HPCLAB>
% Scientific Computing Innovation Center
% Created: 2020-05-03
function [t,x,A]=LinearStructuralSystem(N,m,T,x0,v0)
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
  [v,a]=eig(-full(A));
  la=diag(sqrt(diag(a)));
  z=[v v;v*la -v*la];
  la=diag(la);
  A=real(z*diag([exp(ht*la);exp(-ht*la)])/z);
  A=(A-Z*inv(A).'*Z)/2;
  E=A.';
  for k=1:m
    x=[x;x(k,:)*E];
  end
end
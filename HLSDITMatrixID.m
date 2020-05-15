% Copyright (C) 2020 Fredy Vides
% function [A,Ap,f]=LSDITMatrixID(x,m)
% A universal algebraic controller  
% comptutation
% This method is based on the UAC method
% presented by F. Vides in the article: 
% "Universal algebraic controllers and 
% system identification"

% See also: MechanicalSystemID.
% Author: Fredy Vides <fredy@HPCLAB>
% Scientific Computing Innovation Center
% Created: 2020-05-03
function [Ha,A]=HLSDITMatrixID(x,m)
  [A,Ap]=LSDITMatrixID(x,m);
  [N,n]=size(A);
  Z=eye(n/2);
  Z=kron([0 1;-1 0],Z);
  Ha=logm(A);
  Ha=(Ha+Z*Ha.'*Z)/2;
  A=expm(Ha);
  A=(A-Z*((A.')\Z))/2;
  [v,a]=eig(A);
  a=diag(a);
  a=diag(a./abs(a));
  A=real(v*a/v);
  A=(A-Z*((A.')\Z))/2;
end
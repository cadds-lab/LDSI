% Copyright (C) 2020 Fredy Vides
% function [A,Ap,f]=TMatrixID(x,m)
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
function [A,Ap,f]=TMatrixID(x,m)
  N=size(x,1);
  m=min([m N-1]);
  x0=x(1:m,1);
  x1=x(2:(m+1),1);
  y0=x(1:m,2);
  y1=x(2:(m+1),2);
  E=ones(m,1);
  c1=[y0 E]\(x1-x0);
  c2=[x0 y0 E]\y1;
  A=[1 c1(1);c2(1:2).'];
  f=[c1(2);c2(3)];
  [v,a]=eig(A);
  a=diag(a);
  a=diag(a./abs(a));
  Ap=real(v*a/v);
end
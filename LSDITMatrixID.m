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
function [A,Ap]=LSDITMatrixID(x,m,sp)
  [N,n]=size(x);
  m=min([m N-1]);
  x0=x(1:m,:);
  x1=x(2:(m+1),:);
  for k=1:n/2
    C=x0\(x1(:,k));
    c(k,:)=C(1:n).';
    L=x0\x1(:,n/2+k);
    K(k,:)=L(1:n).';
  end
  A=[c;K];
  [v,a]=eig(A);
  a=diag(a);
  a=diag(a./abs(a));
  Ap=real(v*a/v);
end
function [GlobalMatrix, RHS] = applyDirichletBCs(GlobalMatrix, RHS,...
    bndry_1_val, bndry_2_val, NNodes)
% Applies boundary conditions to left and right hand sides of matrix system
%   Takes in the left hand matrix 'GlobalMatrix' and right hand side vector
%   'RHS' and applies either Dirichlet or Neumann boundary conditions.
%   bndry_1 and bndry_2 are strings that determine the boundary type
%   bndry_1_val and bndry_2_val are the numeric values of the boundary
%   condition

% Apply boundary condition at lower limit
% Set the RHS to given value
RHS(1) = bndry_1_val;
% Set diagonal entry to 1
GlobalMatrix(1, 1) = 1;
% Zero out the rest
for i = 2:NNodes
    GlobalMatrix(1,i) = 0;
end

% Apply boundary condition at upper limit
RHS(NNodes) = bndry_2_val;
for i = 1:NNodes-1
    GlobalMatrix(NNodes,i) = 0;
end
GlobalMatrix(NNodes, NNodes) = 1;


end


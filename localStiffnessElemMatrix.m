function [localStiffElemMatrix] = localStiffnessElemMatrix(D, Lmbd, eID, mesh)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
DMatrix = DiffusionElemMatrix(D, eID, mesh);
lmbdMatrix = LinearReactionElemMatrix(Lmbd, eID, mesh);

localStiffElemMatrix = DMatrix - lmbdMatrix;
end


function [localStiffElemMatrix] = localStiffnessElemMatrix(D, lmbd, eID, mesh)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
DMatrix = DiffusionElemMatrix(D, eID, mesh);
lmbdMatrix = LinearReactionElemMatrix(lmbd, eID, mesh);

localStiffElemMatrix = DMatrix-lmbdMatrix;
end


function [ psi ] = EvalBasis(lnid,xipt)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
sign = (-1)^(lnid+1);
psi = 0.5*(1 + sign*xipt);

end


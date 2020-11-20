function [elemat] = SourceElemVector(val, eID,msh, isSpatiallyVariant)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
% Preallocate size
elemat = zeros(2,1);
% Check for matrix bounds error
if(eID > msh.ne || eID < 1)
    ME = MException('Mesh:IDOutOfBounds',...
        'Element ID is beyond mesh limits');
    throw(ME);
end
% Default isSpatiallyVariant to false if not provided
if(nargin < 4)
    warning('Parameter:Missing',...
        'isSpatiallyVariant not defined, assumed to be false');
    isSpatiallyVariant = false;
end

if (isSpatiallyVariant)
    %elemat(1) = val*msh.elem(eID).x(1)*msh.elem(eID).J;
    %elemat(2) = val*msh.elem(eID).x(2)*msh.elem(eID).J;
    elemat(1) = val*msh.elem(eID).J*(2/3 * msh.elem(eID).x(1) + 1/3 * msh.elem(eID).x(2));
    elemat(2) = val*msh.elem(eID).J*(1/3 * msh.elem(eID).x(1) + 2/3 * msh.elem(eID).x(2));
else
    elemat(1) = val*msh.elem(eID).J;
    elemat(2) = elemat(1);
end


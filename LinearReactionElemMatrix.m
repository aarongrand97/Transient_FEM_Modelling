function [elemat] = LinearReactionElemMatrix(lambda, eID, msh)
% Returns the local element matrix for the linear reaction term

% Check that element ID is not out of bounds
if(eID > msh.ne || eID < 1)
    ME = MException('Mesh:IDOutOfBounds',...
        'Element ID is beyond mesh limits');
    throw(ME);
end

% Fetch Jacobian for this element from mesh
Jcbn = msh.elem(eID).J;

% Calculate local element values
elemat(1,1) = lambda * Jcbn * 2/3;
elemat(1,2) = lambda * Jcbn * 1/3;
elemat(2,1) = elemat(1,2);
elemat(2,2) = lambda * Jcbn * 2/3;
end


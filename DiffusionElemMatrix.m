function [elemat] = DiffusionElemMatrix(D,eID,msh)
% Returns the local element matrix for the diffusion term

% Check that element ID is not out of bounds
if(eID > msh.ne || eID < 1)
    ME = MException('Mesh:IDOutOfBounds',...
        'Element ID is beyond mesh limits');
    throw(ME);
end

if(msh.elem(eID).x(1) < (0.01/6))
    D = 25/(1200*3300);
elseif(msh.elem(eID).x(1) < 0.005)
    D = 40/(1200*3300);
else
    D = 20/(1200*3300);
end

% Fetch Jacobian for this element from mesh
Jcbn = msh.elem(eID).J;
% Calculate derivatives
dXi_dx = 2 / ((msh.elem(eID).x(2)) - (msh.elem(eID).x(1)));
dPsi_dx = [-0.5, 0.5];
% Calculate local element values
elemat(1,1) = D * dPsi_dx(1) * dXi_dx * dPsi_dx(1) * dXi_dx * Jcbn * 2;
elemat(1,2) = D * dPsi_dx(1) * dXi_dx * dPsi_dx(2) * dXi_dx * Jcbn * 2;
elemat(2,1) = elemat(1,2);
elemat(2,2) = D * dPsi_dx(2) * dXi_dx * dPsi_dx(2) * dXi_dx * Jcbn * 2;

end


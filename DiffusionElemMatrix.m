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
J = msh.elem(eID).J;
% Calculate derivatives
dPsi_dx = [-0.5, 0.5];

N = 2;
GQ = CreateGQScheme(N);
elemat = zeros(2);

for row = 0 : 1
    for col = 0 : 1
        sum = 0;
        for n = 1 : N
            Gauss_temp = GQ.gsw(n) * D/J * EvalBasisGrad(row) * EvalBasisGrad(col);
            sum = sum + Gauss_temp;
        end
        elemat(row+1, col+1) = sum;
    end
end

end


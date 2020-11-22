function [mesh] = addMaterialCoeffsToMesh(mesh)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for eID = 1 : mesh.ne
    if(mesh.elem(eID).x(1) < (0.01/6))
        mesh.elem(eID).D = 25/(1200*3300);
        mesh.elem(eID).lmbda = 0;
        mesh.elem(eID).f = 0;
    elseif(mesh.elem(eID).x(1) < 0.005)
        mesh.elem(eID).D = 40/(1200*3300);
        mesh.elem(eID).lmbda = -(0.0375*1060*3770)/(1200*3300);
        mesh.elem(eID).f = (0.0375*1060*3770*310.15)/(1200*3300);
    else
        mesh.elem(eID).D = 20/(1200*3300);
        mesh.elem(eID).lmbda = -(0.0375*1060*3770)/(1200*3300);
        mesh.elem(eID).f = (0.0375*1060*3770*310.15)/(1200*3300);
    end
end

end


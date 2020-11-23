T_Outer = 393.15;
%Step 1 Initialise mesh
NElem = 12;
mesh = OneDimLinearMeshGen(0,0.01,NElem);
%Step 2 Initialise time integration scheme
theta = 1; % Backwards Euler
dt = 0.1;
%Step 3 Define material coefficients
mesh = addMaterialCoeffsToMesh(mesh);
% D = 1;
Lmbd = 0;
f = 0;
%Step 4 Initialise GM, M, K, GV to Zero
GM = zeros(NElem+1);
M = zeros(NElem+1);
K = zeros(NElem+1);
GV = zeros(NElem+1, 1);
%Step 5 Define two solution variable vectors
Tcurrent = zeros(NElem+1, 1);
Tnext = zeros(NElem+1, 1);
%Step 6 Set initial conditions
Tcurrent = Tcurrent + 310.15;
Tcurrent(NElem+1) = 310.15; % Not actually needed but explicit
Tcurrent(1) = T_Outer;

%Step 7 loop over time from tstep = 1 to N
T = 50;
N = T/dt;

Ts = zeros(N+1, NElem+1);
Ts(1,:) = Tcurrent;

for tstep = 1:N
    %Loop over elements
    for elemID = 1:NElem
        D = mesh.elem(elemID).D;
        %Calculate local element mass matrix
        m = localMassElemMatrix(mesh.elem(elemID).J);
        %Add to global mass matrix
        M = addToGlobalMatrix(M, m, elemID);
        %Calculate local element stiffness matrix
        k = localStiffnessElemMatrix(D, Lmbd, elemID, mesh);
        %Add to global stiffness matrix
        K = addToGlobalMatrix(K, k, elemID);
    end
    %Calculate global matrix (GM)
    GM = M + theta*dt*K;
    %Calculate matrix to multiply previous solution
    PrevSolMat = M - (1-theta)*dt*K;
    %Multiply this matrix by previous solution and store in Global Vector
    GV = PrevSolMat*Tcurrent;
    %Loop over elements
    for elemID = 1:NElem
        %Calculate local element sources vectors
        srce = SourceElemVector(f, elemID, mesh, false);
        srce = srce*dt;
        GV = addToRHSVector(GV, srce, elemID);
        % Neumann stuff
    end
    %Set Dirichlet Boundary Conditions
    [GM, GV] = applyBCs(GM, GV, D, 'Dlet', T_Outer, 'Dlet', 310.15, NElem+1);
    %Solve the final matrix system to obtain Tnext
    Tnext = GM\GV;
    %Set Tcurrent equal to Cnext
    Tcurrent = Tnext;
    %Re-initialise zeros
    GM = zeros(NElem+1);
    M = zeros(NElem+1);
    K = zeros(NElem+1);
    GV = zeros(NElem+1, 1);
    %Plot/write to file the solution Ccurrent
    Ts(tstep+1, :) = Tcurrent;
end

figure;
hold on;
x = linspace(0, 0.01, NElem+1);
for i = 2:10:102
    plot(x, Ts(i,:));
end

%%%%%%% Part 2 %%%%%%%
ENodeIndex = (((NElem)*(0.01/6))/0.01) + 1;
DNodeIndex = (((NElem)*(0.005))/0.01) + 1;

E_Temps = Ts(:, ENodeIndex);
D_Temps = Ts(:, DNodeIndex);

burn_limit = 317.5;

E_Burn_Bool = E_Temps > burn_limit;
D_Burn_Bool = D_Temps > burn_limit;

E_Burn_Vals = E_Temps(E_Burn_Bool);
D_Burn_Vals = D_Temps(D_Burn_Bool);

Gamma_E_Eq = (2e98)*exp(-(12017)./(E_Burn_Vals-273.15));
Gamma_D_Eq = (2e98)*exp(-(12017)./(D_Burn_Vals-273.15));

Gamma_E = dt * trapz(Gamma_E_Eq);
Gamma_D = dt * trapz(Gamma_D_Eq);

if(Gamma_E > 1)
    disp("Second Degree");
    if(Gamma_D > 1)
        disp("Third Degree");
    end
else
    disp("No burn");
end

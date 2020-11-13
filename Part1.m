figure;
hold on;

%Step 1 Initialise mesh
NElem = 10;
mesh = OneDimLinearMeshGen(0,1,NElem);
%Step 2 Initialise time integration scheme
theta = 1; % Backwards Euler
dt = 0.01;
%Step 3 Define material coefficients
D = 1;
Lmbd = 0;
f = 0;
%Step 4 Initialise GM, M, K, GV to Zero
GM = zeros(NElem+1);
M = zeros(NElem+1);
K = zeros(NElem+1);
GV = zeros(NElem+1, 1);
%Step 5 Define two solution variable vectors
Ccurrent = zeros(NElem+1, 1);
Cnext = zeros(NElem+1, 1);
%Step 6 Set initial conditions
Ccurrent(NElem+1) = 1; % c(1,t) = 1
Cs(1,:) = Ccurrent;
%Step 7 loop over time from tstep = 1 to N
T = 1.0;
N = T/dt;
for tstep = 1:N
    %Loop over elements
    for elemID = 1:NElem
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
    GV = PrevSolMat*Ccurrent;
    %Loop over elements
    for elemID = 1:NElem
        %Calculate local element sources vectors
        srce = SourceElemMatrix(f, elemID, mesh, false);
        srce = srce*dt;
        GV = addToRHSVector(GV, srce, elemID);
        % Neumann stuff
    end
    %Set Dirichlet Boundary Conditions
    [GM, GV] = applyBCs(GM, GV, D, 'Dlet', 0, 'Dlet', 1, NElem+1);
    %Solve the final matrix system to obtain Cnext
    Cnext = GM\GV;
    %Set Ccurrent equal to Cnext
    Ccurrent = Cnext;
    %Re-initialise zeros
    GM = zeros(NElem+1);
    M = zeros(NElem+1);
    K = zeros(NElem+1);
    GV = zeros(NElem+1, 1);
    %Plot/write to file the solution Ccurrent
    if(mod(tstep, 10) == 0)
        plot(linspace(0,1,11), Ccurrent);
    end
end
x = linspace(0,1,11);

c_anlytc = TransientAnalyticSoln(x, 1);
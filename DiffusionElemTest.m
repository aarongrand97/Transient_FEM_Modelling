function tests = DiffusionElemTest
    tests = functiontests(localfunctions);
end

%%%% Test 1: test symmetry of the matrix
% Test that this matrix is symmetric
function testSymmetry(testCase)
    tol = 1e-14;
    D = 2; %diffusion coefficient
    eID=1; %element ID
    msh = OneDimLinearMeshGen(0,1,10);

    elemat = DiffusionElemMatrix(D,eID,msh); %THIS IS THE FUNCTION YOU MUST WRITE

    verifyLessThanOrEqual(testCase, abs(elemat(1,2) - elemat(2,1)),tol);
end

%%%% Test 2: test 2 different elements of the same size produce same matrix
% Test that for two elements of an equispaced mesh, the element matrices
% calculated are the same
function testSameElemSizeSameMatrix(testCase)
    tol = 1e-14;
    D = 5; %diffusion coefficient
    eID=1; %element ID
    msh = OneDimLinearMeshGen(0,1,10);
    elemat1 = DiffusionElemMatrix(D,eID,msh);
    eID=2; %element ID
    elemat2 = DiffusionElemMatrix(D,eID,msh);
    %calculate the difference between the two matrices
    diff = elemat1 - elemat2;
    %calculates the total squared error between the matrices
    diffnorm = sum(sum(diff.*diff));
    verifyLessThanOrEqual(testCase, abs(diffnorm), tol);
end

%%%% Test 3: test that one matrix is evaluted correctly
% Test that element 1 of a three element mesh is evaluated correctly
function testCorrectEvaluation(testCase)
    tol = 1e-14;
    D = 1; %diffusion coefficient
    eID=1; %element ID
    msh = OneDimLinearMeshGen(0,1,3);
    elemat1 = DiffusionElemMatrix(D,eID,msh);
    elemat2 = [ 3 -3; -3 3];
    %calculate the difference between the two matrices
    diff = elemat1 - elemat2;
    %calculates the total squared error between the matrices
    diffnorm = sum(sum(diff.*diff));
    verifyLessThanOrEqual(testCase, abs(diffnorm), tol);
end

%%%% Test 4 : test for error if element ID is beyond mesh limit
% Test that if eID is greater than the number of elements in the mesh
% a 'Mesh:IDOutOfBounds' error is thrown
function testIDError(testCase)
D = 1;
eID = 5; % eID greater than number of elements in msh created below
msh = OneDimLinearMeshGen(0,1,3);
verifyError(testCase, @()DiffusionElemMatrix(D, eID, msh),...
    'Mesh:IDOutOfBounds');
end
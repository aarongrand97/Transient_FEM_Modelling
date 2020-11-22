function tests = LinearReactionElemTest
    tests = functiontests(localfunctions);
end

%%%% Test 1: test symmetry of the matrix
% Test that this matrix is symmetric
function testSymmetry(testCase)
    tol = 1e-14;
    Lambda = -9;
    eID=1; %element ID
    msh = OneDimLinearMeshGen(0,1,3);    
    elemat = LinearReactionElemMatrix(Lambda,eID,msh);    
    verifyLessThanOrEqual(testCase, abs(elemat(1,2) - elemat(2,1)),tol);
end

%%%% Test 2: test 2 different elements of the same size produce same matrix
% Test that for two elements of an equispaced mesh,the element matrices 
% calculated are the same
function testSameElemSizeSameMatrix(testCase)
    tol = 1e-14;
    Lambda = -4; %diffusion coefficient
    eID=1; %element ID
    msh = OneDimLinearMeshGen(0,1,10);

    elemat1 = LinearReactionElemMatrix(Lambda,eID,msh);

    eID=2; %element ID

    elemat2 = LinearReactionElemMatrix(Lambda,eID,msh);

    diff = elemat1 - elemat2;
    diffnorm = sum(sum(diff.*diff));
    verifyLessThanOrEqual(testCase, abs(diffnorm), tol)
end

%%%% Test 3: test that one matrix is evaluted correctly
% Test that element 1 of a three element mesh is evaluated correctly
function testCorrectEvaluation(testCase)
    tol = 1e-14;
    Lambda = 9; %diffusion coefficient
    eID=1; %element ID
    msh = OneDimLinearMeshGen(0,1,3);

    elemat1 = LinearReactionElemMatrix(Lambda,eID,msh);

    elemat2 = [ 1 0.5; 0.5 1];
    %calculate the difference between the two matrices
    diff = elemat1 - elemat2;
    %calculates the total squared error between the matrices
    diffnorm = sum(sum(diff.*diff));
    verifyLessThanOrEqual(testCase, abs(diffnorm), tol);
end

%%%% Test 4: test for error if element ID is beyond mesh limit
% Test that if eID is greater than the number of elements in the mesh
% a 'Mesh:IDOutOfBounds' error is thrown
function testIDError(testCase)
Lambda = 9; %diffusion coefficient
eID = 5;
msh = OneDimLinearMeshGen(0,1,3);
verifyError(testCase, @()LinearReactionElemMatrix(Lambda, eID, msh), 'Mesh:IDOutOfBounds');
end
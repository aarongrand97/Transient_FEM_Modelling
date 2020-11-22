function tests = SourceElemTest
    tests = functiontests(localfunctions);
end

%%% SPATIALLY CONSTANT TESTS %%%%%
% Test 1 : test values are equal
function testEquality(testCase)
    tol = 1e-14;
    f = 5;
    eID = 1;
    msh = OneDimLinearMeshGen(0,1,10);    
    elemat = SourceElemVector(f, eID, msh, false);
    % Get difference betweent the elements
    diff = abs(elemat(1)-elemat(2));
    verifyLessThanOrEqual(testCase, diff, tol)
end

% Test 2 : correct evaluation
function testCorrectEvaluation(testCase)
    tol = 1e-14;
    f = 5;
    eID = 1;
    msh = OneDimLinearMeshGen(0,1,10);
    J = msh.elem(eID).J;
    % Known solution
    expectedMat = [f*J; f*J];
    elemat = SourceElemVector(f, eID, msh, false);
    
    diff = expectedMat-elemat;
    %calculates the total squared error between the matrices
    diffnorm = sum(sum(diff.*diff));
    verifyLessThanOrEqual(testCase, abs(diffnorm), tol);
end

% Test 3 : test for error if element ID is beyond mesh limit
function testIDError(testCase)
    f = 1;
    eID = 5; % Out of bounds element ID
    msh = OneDimLinearMeshGen(0,1,3);
    verifyError(testCase, @()SourceElemVector(f, eID, msh, false),...
        'Mesh:IDOutOfBounds');
end

function [globalMatrix] = addToGlobalMatrix(globalMatrix,localElemMatrix, elemID)
% Adds local elements to the global matrix
%   Updates globalMatrix by adding 'localElemMatrix' to it in the
%   'elemID' position

% Check that element ID is not out of bounds
if(elemID >= length(globalMatrix))
    ME = MException('GlobalMatrix:IDOutOfBounds',...
        'Element ID is beyond global matrix limits');
    throw(ME);
end

% Add local element values to global matrix
globalMatrix(elemID, elemID) = globalMatrix(elemID, elemID)...
    + localElemMatrix(1,1);
globalMatrix(elemID, elemID+1) = globalMatrix(elemID, elemID+1)...
    + localElemMatrix(1,2);
globalMatrix(elemID+1, elemID) = globalMatrix(elemID+1, elemID)...
    + localElemMatrix(2,1);
globalMatrix(elemID+1, elemID+1) = globalMatrix(elemID+1, elemID+1)...
    + localElemMatrix(2,2);
end


function [RHS] = addToRHSVector(RHS, sourceElemVector, elemID)
% Adds local elements to the global right hand vector
%   Adds source term local element vectors 'sourceElemVector', to the
%   global right hand vector 'RHS'

% Check that element ID is not out of bounds
if(elemID >= length(RHS))
    ME = MException('RHSMatrix:IDOutOfBounds',...
        'Element ID is beyond RHS matrix limits');
    throw(ME);
end
% Add local element values to global vector
RHS(elemID) = RHS(elemID) + sourceElemVector(1);
RHS(elemID+1) = RHS(elemID+1) + sourceElemVector(2);
end


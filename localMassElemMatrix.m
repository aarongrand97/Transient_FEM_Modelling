function [localMassElemMatrix] = localMassElemMatrix(J)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%N = 2;
%GQ = CreateGQScheme(N);
%localMassElemMatrix = zeros(2);
localMassElemMatrix = [2*J/3, J/3;
                        J/3, 2*J/3];

% for row = 0 : 1
%     for col = 0 : 1
%         sum = 0;
%         for n = 1 : N
%             Gauss_temp = GQ.gsw(n) * EvalBasis(row, GQ.xipts(n)) * EvalBasis(col,GQ.xipts(n)) * J;
%             sum = sum + Gauss_temp;
%         end
%         localMassElemMatrix(row, col) = sum;
%     end
% end


end


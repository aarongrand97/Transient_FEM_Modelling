function [ gq ] = CreateGQScheme(N)
%CreateGQScheme Creates GQ Scheme of order N
%   Creates and initialises a data structure 
    gq.npts = N;
    if (N > 0) && (N < 4)
        %order of quadrature scheme i.e. %number of Gauss points
        gq.gsw = zeros(N,1); %array of Gauss weights
        gq.xipts = zeros(N,1); %array of Gauss points
        switch N
            case 1  
              gq.gsw(1) = 2; 
              gq.xipts(1) = 0;
            case 2
              gq.gsw(1) = 1;  
              gq.gsw(2) = 1;  
              gq.xipts(1) = -sqrt(1/3);
              gq.xipts(2) =  sqrt(1/3);
            case 3
              gq.gsw(1) = 5/9;  
              gq.gsw(2) = 8/9;
              gq.gsw(3) = 5/9;
              gq.xipts(1) = -sqrt(3/5);
              gq.xipts(2) =  0;
              gq.xipts(3) = sqrt(3/5);
        end
              
    else
      fprintf('Invalid number of Gauss points specified');
    end 
end


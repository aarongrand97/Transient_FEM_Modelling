function [] = findBurnTemperatures()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

low = 311;
high = 400;

third_high = high;

% Find second degree threshold
while(high-low > 0.01)
    mid = (low+high)/2;
    mid = round(mid,2);
    burn = SolveSystem(mid);
    if(burn == "None")
        low = mid;
    elseif(burn == "Second")
        high = mid;
    else % third
        high = mid;
        third_high = mid;
    end
end
disp("Second Degree: " + high);

% Now do same for third
low = high;
high = third_high;
count = 0;
while (high-low > 0.01)
    count = count + 1;
    if(count > 20)
        break;
    end
    mid = (low+high)/2;
    mid = round(mid,2);
    burn = SolveSystem(mid);
    if(burn == "Second")
        low = mid;
    else
        high = mid;
    end
end
disp("Third degree: " + high);

end


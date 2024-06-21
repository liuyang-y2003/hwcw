function ind = HC(Ta,threshold,dy)
% Identify heat wave or cold wave days from temperature data.
%
% <Syntax>
% ind = HC(Ta, threshold, dy)
%
% <Input>
% Ta       : Daily maximum (for heat wave) or minimum (for cold wave) temperature (℃),
%            specified as an n by m by t matrix, where t is the time dimension.
% threshold: Threshold for identifying hot days.
% dy       : Day type, specified as a char string: 'HW', 'CW', 'CW1', 'CW2', or 'CW3'.
%            'HW'  - Heat wave.
%            'CW'  - Cold wave (all types).
%            'CW1' - One-day cold wave.
%            'CW2' - Two-day cold wave.
%            'CW3' - Three-day cold wave.
%
% <Output>
% ind      : Logical matrix indicating heat wave or cold wave days. It has the same size as Ta.

if strcmp(dy,'HW')
    ind = Ta>=threshold;
    ind = movsum(ind,3,3)>=3 | movsum(ind,[2 0],3)>=3 | movsum(ind,[0 2],3)>=3;
else
    iC1 = Ta(:,:,4:end)<=4 & Ta(:,:,4:end)-Ta(:,:,3:end-1)<=-8;
    
    iC2 = Ta(:,:,4:end)<=4 & Ta(:,:,4:end)-Ta(:,:,2:end-2)<=-10 & ...
        Ta(:,:,3:end-1)-Ta(:,:,2:end-2)<0 & Ta(:,:,3:end-1)-Ta(:,:,2:end-2)>-8 & ...
        Ta(:,:,4:end)-Ta(:,:,3:end-1)<0 & Ta(:,:,4:end)-Ta(:,:,3:end-1)>-8;
    iC2(:,:,1:end-1) = iC2(:,:,1:end-1) | iC2(:,:,2:end);
    
    iC3 = Ta(:,:,4:end)<=4 & Ta(:,:,4:end)-Ta(:,:,1:end-3)<=-12 & ...
        Ta(:,:,2:end-2)-Ta(:,:,1:end-3)<0 & Ta(:,:,2:end-2)-Ta(:,:,1:end-3)>-8 & ...
        Ta(:,:,3:end-1)-Ta(:,:,2:end-2)<0 & Ta(:,:,3:end-1)-Ta(:,:,2:end-2)>-8 & ...
        Ta(:,:,4:end)-Ta(:,:,3:end-1)<0 & Ta(:,:,4:end)-Ta(:,:,3:end-1)>-8 & ...
        Ta(:,:,3:end-1)-Ta(:,:,1:end-3)>-10 & Ta(:,:,4:end)-Ta(:,:,2:end-2)>-10;
    iC3(:,:,1:end-1) = iC3(:,:,1:end-1) | iC3(:,:,2:end);
    iC3(:,:,1:end-1) = iC3(:,:,1:end-1) | iC3(:,:,2:end);
    switch dy
        case 'CW1'
            ind = iC1;
        case 'CW2'
            ind = iC2;
        case 'CW3'
            ind = iC3;
        case 'CW'
            ind = iC1 | iC2 | iC3;
    end
end
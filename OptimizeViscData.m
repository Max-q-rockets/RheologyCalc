%OptimizeViscData

ex = 1.459;
for i=1:1000
    v1 = 0;
    v2 = 0;
    for i=1:13
        v1 = v1 + pen(CheckViscData(ex, i));
    end
    for i=1:13
        v2 = v2+ pen(CheckViscData(ex+.01, i));
    end
    slope = v2-v1;
    x = [ex, v1]
    ex = ex-2*slope*ex;
end    

ex

function output = CheckViscData(ex, num)
OP = TernViscPlotE3(0.60, .5, .4, ex);
%400, 200, visc
Data = [0, 70, 781;
       50, 0, 432;
       0, 50, 994;
       16.7, 40, 774;
       16.5, 46.9, 992;
       0, 63.4, 1235;
       33.5, 23.1, 1155;
       0, 56.6, 691;
       33.5, 16.5, 637;
       16.5, 33.5, 483;
       25, 35, 506;
       0, 60, 842;
       25, 25, 739];
Data(:,1) = Data(:,1)*10+1;
Data(:,2) = Data(:,2)*10+1;
normalization = Data(num,3)/OP(Data(num,1),Data(num,2));
OP = OP*normalization;
output = zeros(length(Data(:,1)), 1);
for i=1:length(Data(:,1))
    output(i) = Data(i,3)/OP(Data(i,1),Data(i,2));
end
end

function penalty = pen(Output)
penalty = sum((abs(1-Output)).^1);
end
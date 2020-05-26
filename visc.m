function viscosity = visc(SL, amounts, ratios, solid)
global ex
ex = 3;
uvmax = 0.605;
RFV = @(ratio, vliq) (1-uvmax-(1-uvmax)*vliq).*((1-ratio).^ex)+vliq+uvmax-1;
H = @(vfrac) (2*(1-vfrac)./(abs(1-vfrac)+(1-vfrac))).*(1-vfrac)^-(2.5*uvmax);
% if nargin ==3
%     sprintf('assuming composition given as fractions of overall composition');
% elseif ~strcmp(solid, 'total') || ~strcmp(solid, 'solid')
%     solid = 'total';
%     sprintf('assuming composition given as fractions of overall composition');
% elseif strcmp(solid, 'solid')
%     amounts = amounts.*SL
% end
if nargin == 4 && solid == 1
    amounts = amounts*SL;
end

vliq = 1;
viscosity = 1;
for i=1:length(amounts)
    v = amounts(i);
    viscosity = viscosity*H(v/RFV(ratio(amounts, ratios, i), vliq));
    vliq = vliq-v;
    if isinf(viscosity)
        viscosity = Inf;
    end
end
    function rat = ratio(amounts, ratios, n)
        Ratio = @(FC, FM, c, m) FM-abs((FM-FC)*(c/(m+c))^(1/ex));
        rati = [1, 1, ratios];
        amt = [1, 0, amounts];
        rat = 1;
        for i=1:n
            rat = Ratio(rat*rati(i+1), rati(i+1), amt(i), amt(i+1));
        end
    end
end
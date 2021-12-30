function viscosity = visc1(amounts, sizes) %amounts is a vector of the amount by volume of each particle size, sizes is a vector containing the particle sizes. Both should be in descending order of particle size.
ex = 3;
uvmax = 0.605;
RFV = @(ratio, vliq) (1-uvmax-(1-uvmax)*vliq).*((1-ratio).^ex)+vliq+uvmax-1;
H = @(vfrac) (2*(1-vfrac)./(abs(1-vfrac)+(1-vfrac))).*(1-vfrac)^-(2.5*uvmax);
vliq = 1;
viscosity = 1;
for j=1:length(amounts)
    v = amounts(j);
    viscosity = viscosity*H(v/RFV(ratio(amounts, sizes, j, ex), vliq));
    vliq = vliq-v;
    if isinf(viscosity)
        viscosity = Inf;
    end
end
    function rat = ratio(amounts, sizes, n, ex)
        Ratio = @(FC, FM, c, m) FM-abs((FM-FC)*(c/(m+c))^(1/(ex)));
        ratios = sizes(n)./sizes;
        rat = 1;
        for i=1:n-1
            rat = Ratio(rat, ratios(i), sum(amounts(1:i-1)), amounts(i));
        end
    end
end

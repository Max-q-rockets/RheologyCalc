function viscosity = visc2(amounts, sizes, densities, liqdens)%amounts is a vector of the amount by mass of each particle size, sizes is a vector containing the particle sizes, densities is a vector containing the densities of each particle size, and liqdens is the density of the liquid fraction. Both should be in descending order of particle size.
ex = 3;
uvmax = 0.605;
RFV = @(ratio, vliq) (1-uvmax-(1-uvmax)*vliq).*((1-ratio).^ex)+vliq+uvmax-1;
H = @(vfrac) (2*(1-vfrac)./(abs(1-vfrac)+(1-vfrac))).*(1-vfrac)^-(2.5*uvmax);
viscosity = 1;
vliq = 1;
liq = 1-sum(amounts);
vl = liq/liqdens;
a = amounts./densities;
vfracs = a./(sum(a)+vl);
sum(vfracs);
for j=1:length(amounts)
    v = vfracs(j);
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
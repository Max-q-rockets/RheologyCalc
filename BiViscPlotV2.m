function Output = BiViscPlotV2(amounts, sizes, densities, liqdens, ind, plotyn)

C = [0:.001:1];
sum = amounts(ind(1))+amounts(ind(2));
Output = 1./zeros(length(C));
for i=1:length(C)
    amounts1 = amounts;
    amounts1(ind(1)) = sum*C(i);
    amounts1(ind(2)) = sum*(1-C(i));
    Output(i) = visc2(amounts1, sizes, densities, liqdens);
end
semilogy(C, Output);
hold on
opt = min(min(Output));
ylim([1, opt*10^3]);
if plotyn == 'y'
    x = (amounts(ind(1)))/(amounts(ind(1))+amounts(ind(2)));
    y= visc2(amounts, sizes, densities, liqdens);
    semilogy(x,y, 'ro')
end
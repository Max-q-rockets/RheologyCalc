function Output = BiViscPlotV3(amounts, sizes, densities, SParams, liqdens, ind, plotyn)

C = [0:.001:1];
sum = amounts(ind(1))+amounts(ind(2));
Output = 1./zeros(length(C), 1);
for i=1:length(C)
    amounts1 = amounts;
    amounts1(ind(1)) = sum*C(i);
    amounts1(ind(2)) = sum*(1-C(i));
    Output(i) = visc3(amounts1, sizes, densities, SParams, liqdens);
end
figure();
semilogy(C, Output);
hold on
opt = min(min(Output));
ylim([1, min([opt*10^3, max(Output)])]);
xlim([0, 1]);
if plotyn == 'y'
    x = (amounts(ind(1)))/(amounts(ind(1))+amounts(ind(2)));
    y= visc3(amounts, sizes, densities, SParams, liqdens);
    semilogy(x,y, 'ro')
end
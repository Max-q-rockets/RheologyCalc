

clear all
close all

RFV = @(ratio, vliq) (.395-.395*vliq).*((1-ratio).^3)+vliq-.395;
H = @(vfrac) (2*(1-vfrac)./(abs(1-vfrac)+(1-vfrac))).*(1-vfrac).^-(2.5*0.605);

x = [0:0.01:1];
SL = [0.55:0.02:0.65];
y = zeros(length(SL), length(x));
for i=1:length(SL)
    for n=1:length(x)
        vc = .75*SL(i);
        vf = 0.25*SL(i)/RFV(x(n), 1-vc);
        y(i,n) = H(vc/RFV(1,1)).*H(vf);
    end
end
for i=1:length(SL)
    semilogy(x, y(i,:));
    hold on
end
xlim([0, 1]);
ylim([10, 1000]);
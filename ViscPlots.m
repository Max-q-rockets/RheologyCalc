sl = .75
H = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1+0.75.*((vfrac./0.605)./(1-(vfrac./0.605)))).^2;
C = [0:0.01:1];
M = [0:0.01:1];
Output = 1./zeros(length(C), length(M));
for ci=1:length(C)
    c = C(ci);
    for mi=1:(length(M)-ci+1)
        m = M(mi);
        vc = sl*c;
        vm = sl*m;
        vf = sl-vm-vc;
        liq=1-sl;
        fracf = vf/(liq+vf);
        fracm = vm/(liq+vf+vm);
        fracc = vc/(liq+vf+vm+vc);
        Output(ci, mi) = H(fracf)*H(fracm)*H(fracc);            
    end
end
Output(isinf(Output)) = Inf;

opt = min(min(Output));
levels = [opt*1.0001, opt*1.001, opt*1.01, opt*1.1, opt*1.5, opt*2, opt*3, opt*10];

figure();
contour (Output, levels);
title(['solids loading ' ,num2str(sl), ' optimal ', num2str(opt)]);
xlabel('volume fraction of medium');
ylabel('volume fraction of coarse');

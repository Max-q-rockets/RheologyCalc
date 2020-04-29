function Output = ViscPlot(vfrac, x, y)
sl = vfrac;
H = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1+0.75.*((vfrac./0.605)./(1-(vfrac./0.605)))).^2;
C = [0:0.001:1];
M = [0:0.001:1];
Output = 1./zeros(length(C), length(M));
for ci=1:length(C)
    c = C(ci);
    for mi=1:(length(M)-ci-1)
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
levels = [opt*1.0001, opt*1.001, opt*1.01, opt*1.1, opt*1.3, opt*1.5, opt*2, opt*3, opt*10, opt*100, opt*1000, opt*10000];

figure();
X = ones(length(M));
Y = ones(length(C));
for i=1:length(C)
    X(:,i) = M';
    Y(i,:) = M;
end
contour (X, Y, Output, levels);
colormap jet
caxis([opt/2 opt*100000])
set(gca, 'ColorScale', 'log')
hold on;
plot([0,1], [1,0], 'k');
title(['solids loading ' ,num2str(sl), ' optimal ', num2str(opt)]);
xlabel('volume fraction of coarse');
ylabel('volume fraction of medium');
if nargin ==3
    if (1<=x && x<=100)||(1<=y && y<=100)
        x = x/100; y=y/100;
    end
    if (0<=x && x<=1)&&(0<=y && y<=1) && (0<=x+y && x+y<=1)
        plot(x, y, 'r*');
    end
end
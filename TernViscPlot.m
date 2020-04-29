function Output = TernViscPlot(sl, x, y)
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
levels = [opt*1.0001, opt*1.001, opt*1.01, opt*1.1, opt*2, opt*10, opt*100, opt*1000, opt*10000];

figure();
X = ones(length(M));
Y = ones(length(C));
for i=1:length(C)
    X(:,i) = M'+.0005*i;
    Y(i,:) = M;
end
numdiv = 10;
for i=1:numdiv-1
    x0 = i/numdiv;
    plot([x0, .5+.5*x0], [0, 1-x0], 'color', [0.8 0.8 0.8]);
    hold on;
    plot([x0, x0/2], [0, x0], 'color', [0.8 0.8 0.8]);
    plot([x0/2, 1-x0/2], [x0, x0], 'color', [0.8 0.8 0.8]);
end
contour (X, Y, Output, levels);
colormap jet
caxis([opt/2 opt*100000])
set(gca, 'ColorScale', 'log')
set(gca, 'ytick', [], 'xtick', []);
set(gca, 'visible', 'off');
hold on;
plot([0.5,1], [1,0], 'k');
plot([0,0.5], [0,1], 'k');
plot([0, 1], [0, 0], 'k');
xlim([0,1]);
title(['solids loading ' ,num2str(sl), ' optimal ', num2str(opt)]);
%xlabel('volume fraction of coarse');
%ylabel('volume fraction of medium');
if nargin ==3
    if (1<=x && x<=100)||(1<=y && y<=100)
        x = x/100; y=y/100;
    end
    if (0<=x && x<=1)&&(0<=y && y<=1) && (0<=x+y && x+y<=1)
        plot(x+0.5*y, y, 'r*');
    end
end
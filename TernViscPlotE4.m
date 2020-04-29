function Output = TernViscPlotE4(vfrac, MC, FM, x, y)
sl = vfrac;
if (0>MC || MC>1) || (0>FM || FM > 1)
    error('out of range');
end
FC = FM*MC;
ex = 3;
RFV = @(ratio, vliq) (.395-.395*vliq).*((1-ratio).^ex)+vliq-.395;
H = @(vfrac) (2*(1-vfrac)./(abs(1-vfrac)+(1-vfrac))).*(1-vfrac)^-1.5125;
C = [0:0.001:1];
M = [0:0.001:1];
Output = 1./zeros(length(C), length(M));
for ci=1:length(C)
    c = C(ci);
    for mi=1:(length(M)-ci-1)
        V = 1;
        m = M(mi);
        vc = sl*c;
        vm = sl*m;
        vf = sl-vm-vc;
        liq=1-sl;
        RFVC = RFV(1, 1);
        fracc = vc/RFVC;
        FC = MC*FM;
        RFVM = RFV(MC, V-vc);
        fracm = vm/RFVM;
        RatioF = FM-abs((FM-FC)*(c/(m+c))^(1/ex));
        RFVF = RFV(RatioF, V-vm-vc);
        fracf = vf/RFVF;
        Output(ci, mi) = H(fracf)*H(fracm)*H(fracc);            
    end
end
Output(isinf(Output)) = Inf;

opt = min(min(Output))
for i=1:size(Output)
    if Output(i) > opt*1000
        Output(i) = Inf;
    end
end
levels = [opt*1.0001, opt*1.001, opt*1.01, opt*1.1, opt*2, opt*11, opt*101, opt*1001, opt*10001];

if nargin == 5
    levels(end+1) = Output(x*1000, y*1000);
end

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
caxis([opt/2 opt*100000]);
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
if nargin ==5
    if (1<=x && x<=100)||(1<=y && y<=100)
        x = x/100; y=y/100;
    end
    if (0<=x && x<=1)&&(0<=y && y<=1) && (0<=x+y && x+y<=1)
        plot(x+0.5*y, y, 'r*');
    end
end
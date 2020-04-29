function Output = TernViscPlotEx(vfrac, MC, FM, x, y)
sl = vfrac;
if (0>MC || MC>1) || (0>FM || FM > 1)
    error('out of range');
end
FC = FM*MC;
%H = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1+0.75.*((vfrac./0.605)./(1-(vfrac./0.605)))).^2;
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
        B2r = B2(MC, FC, vf, vm, vc);
        B1r = B1(MC, FC, vf, vm, vc);
        Output(ci, mi) = exp(log(H(B2r*(B1r*vf+vm)+vc))+log(H(B1r*vf+vm))*(1-B2r)+log(H(vf))*(1-B1r));                
    end
end
Output(isinf(Output)) = Inf;
Output = real(Output);


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
opt = min(min(Output))
levels = [opt*1.0001, opt*1.001, opt*1.01, opt*1.1, opt*1.3, opt*1.5, opt*2, opt*3, opt*10, opt*100, opt*1000, opt*10000];
contour (X, Y, Output, levels);
colormap jet
caxis([opt/2, opt*100000])
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
end

function G = G(ratio)
G = (1-(1-ratio).^0.9).^1.41;
end

function h = h(vd, vD)
h = (1.68*(vd./(vd+vD)).^2-2.01*(vd./(vd+vD))+1).*(1-(2.5.*vd./(2.5.*vd+vD)));
end

function B = B(ratio, vd, vD)
B = (G(ratio)).^h(vd, vD);
end

function as = as(MC, FC, vf, vm, vc)
as = (B(MC, vf, vc)*vm*MC+(1-B(MC, vf, vc))*vf*FC)/(B(MC, vf, vc)*vm+(1-B(MC, vf, vc))*vf);
end

function B1 = B1(MC, FC, vf, vm, vc)
A = FC/as(MC, FC, vf, vm, vc);
B1 = B(A, vf, (vm+vc));
end

function B2 = B2(MC, FC, vf, vm, vc)
v1 = vm+vf*B1(MC, FC, vf, vm, vc);
B2 = B(as(MC, FC, vf, vm, vc), v1, vc);
end

function H = H(vfrac)
H = (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1+0.75.*((vfrac./0.605)./(1-(vfrac./0.605)))).^2;
end

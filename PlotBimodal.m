%PlotBimodal

close all
clear all

uvmax = 0.605;

RFV = @(ratio, vliq) (.395-.395*vliq).*(ratio^2.5)+vliq*uvmax;
H = @(vfrac) (2*(1-vfrac)./(abs(1-vfrac)+(1-vfrac))).*(1+0.75.*((vfrac)./(1-(vfrac)))).^2;
H2 = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1+0.75.*((vfrac./0.605)./(1-(vfrac./0.605)))).^2;
H3 = @(vfrac) (2*(1-vfrac)./(abs(1-vfrac)+(1-vfrac))).*(1-vfrac)^-(2.5*.605);
H4 = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1-(vfrac/(1-((1-.605)/.605)*vfrac)))^(-2.5);
H5 = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1-vfrac/0.605)^(-2);
H6 = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1-vfrac/0.605)^(-2.5*.605);
H7 = @(vfrac) (2*(1-vfrac)./(abs(1-vfrac)+(1-vfrac))).*(1-vfrac*uvmax/(1-vfrac*uvmax*((1-uvmax)/uvmax)))^-(2.5);

xm = [0:0.001:1];
xb = [0:0.001:1];
xc = [0:0.001:1];
xd = [0:0.001:1];
x0 = [0:0.001:1];

% for i=1:length(xm)
%     SMH(i) = H7(xm(i)/RFV(1, 1));
% end
% for i=1:length(xm)
%     Maron(i) = H5(xm(i));
% end
% for i=1:length(xm)
%     KD2(i) = H6(xm(i));
% end
for i=1:length(xm)
    Hm(i) = visc(xm(i), [1, 0], 1, 1);
    %Farris(i) = RFV(xm(i), .7);
end
% for i=1:length(xm)
%     Einstein(i) = (1+2.5*xm(i));
% end
% 
% for i=1:length(xm)
%     vc  = xm(i)-.25;
%     vf = .25/RFV(1, 1-vc);
%     Hm(i) = H3(vc/RFV(1,1))*H3(vf);
% end
% for i=1:length(xm)
%     vc  = xm(i)-.25;
%     vf = .25/RFV(1, 1-vc);
%     Hm2(i) = H(vc/.54)*H(vf);
% end
% for i=1:length(xm)
%     vc  = xm(i)-.25;
%     vf = .25/RFV(1, 1-vc);
%     Hm3(i) = H3(vc, RFV(1, 1-vc))*H3(vf, RFV(1, 1-vf));
% end
% for i=1:length(xm)
%     Hu(i) = H2(xm(i));
% end
% for i=1:length(xm)
%     Hu2(i) = H3(xm(i), RFV(1, 1-xm(i)));
% end
% for i=1:length(xm)
%     Hu3(i) = H4(xm(i));
% end
for i=1:length(xb)
%     vc  = xb(i)*0.75;
%     vf = xb(i)*.25/RFV(.477, 1-vc);
%     Hb(i) = H3(vc/RFV(1,1))*H3(vf);
    Hb(i) = visc(xb(i), [0.75, 0.25], .477, 1);

end
for i=1:length(xc)
%     vc  = xc(i)*.75;
%     vf = xc(i)*.25/RFV(.313, 1-vc);
%     Hc(i) = H3(vc/RFV(1,1))*H3(vf);
    Hc(i) = visc(xc(i), [0.75, 0.25], 0.313, 1);
end
for i=1:length(xd)
%     vc  = xd(i)*.75;
%     vf = xd(i)*.25/RFV(.138, 1-vc);
%     Hd(i) = H3(vc/RFV(1,1))*H3(vf);
    Hd(i) = visc(xd(i), [0.75, 0.25], 0.138, 1);
end
for i=1:length(x0)
%     vc  = x0(i)*.75;
%     vf = x0(i)*.25/RFV(0, 1-vc);
%     H0(i) = H3(vc/RFV(1,1))*H3(vf);
    H0(i) = visc(x0(i), [.75, .25], 0, 1);
end
semilogy(xm, Hm, 'r');
hold on
semilogy(xb, Hb, 'k');
semilogy(xc, Hc, 'b');
semilogy(xd, Hd, 'm');
semilogy(x0, H0, 'g');
%semilogy(xm, Hm, 'c');
xlim([0.54, 0.78]);
ylim([10, 100000]);
% semilogy(xb, Hb);
% semilogy(xc, Hc);
% semilogy(xd, Hd);
% semilogy(x0, H0);
grid on

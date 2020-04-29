%PlotBimodal

close all
clear all

RFV = @(ratio, vliq) (.395-.395*vliq).*((1-ratio).^exp(1))+vliq-.395;
H = @(vfrac) (2*(1-vfrac)./(abs(1-vfrac)+(1-vfrac))).*(1+0.75.*((vfrac)./(1-(vfrac)))).^2;
H2 = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1+0.75.*((vfrac./0.605)./(1-(vfrac./0.605)))).^2;
H3 = @(vfrac) (2*(1-vfrac)./(abs(1-vfrac)+(1-vfrac))).*(1-vfrac)^-1.5;
H4 = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1-(vfrac/(1-((1-.605)/.605)*vfrac)))^(-2.5);
H5 = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1-vfrac/0.605)^(-2);
H6 = @(vfrac) (2*(0.605-vfrac)./(abs(0.605-vfrac)+(0.605-vfrac))).*(1-vfrac/0.605)^(-2.5*0.605);

xm = [0:0.001:.603];
xb = [0.54:0.001:.635];
xc = [0.54:0.001:.67];
xd = [0.54:0.001:.745];
x0 = [0.54:0.001:.76];

for i=1:length(xm)
    Maron(i) = H5(xm(i));
end
for i=1:length(xm)
    KD(i) = H3(xm(i)/RFV(1,1));
end
for i=1:length(xm)
    KD(i) = H6(xm(i));
end
for i=1:length(xm)
    Farris(i) = H4(xm(i));
end

for i=1:length(xm)
    vc  = xm(i)-.25;
    vf = .25/RFV(1, 1-vc);
    Hm(i) = H3(vc/RFV(1,1))*H3(vf);
end
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
% for i=1:length(xb)
%     vc  = xb(i)-.25;
%     vf = .25/RFV(.477, 1-vc);
%     Hb(i) = H(vc/RFV(1,1))*H(vf);
% end
% for i=1:length(xc)
%     vc  = xc(i)-.25;
%     vf = .25/RFV(.313, 1-vc);
%     Hc(i) = H(vc/RFV(1,1))*H(vf);
% end
% for i=1:length(xd)
%     vc  = xd(i)-.25;
%     vf = .25/RFV(.138, 1-vc);
%     Hd(i) = H(vc/RFV(1,1))*H(vf);
% end
% for i=1:length(x0)
%     vc  = x0(i)-.25;
%     vf = .25/RFV(0, 1-vc);
%     H0(i) = H(vc/RFV(1,1))*H(vf);
% end
semilogy(xm, KD, 'r');
hold on
 semilogy(xm, Hm, 'k');
 semilogy(xm, KD, 'b');
semilogy(xm, Farris, 'm');
%semilogy(xm, Hu3, 'm*');
%semilogy(xm, Hu2, 'y*');
% semilogy(xb, Hb);
% semilogy(xc, Hc);
% semilogy(xd, Hd);
% semilogy(x0, H0);
grid on

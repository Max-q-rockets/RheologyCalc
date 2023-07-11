sizes = 400*0.5.^linspace(0, 20, 100);
%sizes = flip([1:1:150,160:10:400]);
%sizes = [400, 90, 30];
vfrac = 0.9;
L = length(sizes);
amounts = 1/L*ones(L, 1);
%a = (log(sizes*100000000)).^2;
% a = 400^2-sizes.^2;
%amounts = a./(sum(a));
% amounts = .00000000000000001*ones(L, 1);
% amounts(1) = .6;
% amounts(L-floor(L/4)) = .2;
% amounts(L-floor(L/16)) = .2;
%amounts = amt;
vbest = visc1(vfrac*amounts/sum(amounts), sizes)
amountsb = amounts;
while true
    i = floor(L*rand)+1;
    d = ((randn)^3)/500;
    amountsn = amountsb;
    amountsn(i) = amountsn(i)+d;

    v = visc1(vfrac*amountsn/sum(amountsn), sizes);
    if min(amountsn) <0
        v = inf;
    end
    if v<vbest
        amountsb = amountsn;
        vbest = v
%         figure(1)
%         semilogx(sizes(2:end-1), vfrac*amountsb(2:end-1))
%         figure(2)
%         semilogx(sizes, vfrac*amountsb)
%         drawnow
    end
end
function OP = optivisc(sizes, vmax);
amounts = 0.001*ones(1, length(sizes));
%amounts = [0.5 0.25 0.125 0.062 0.031]-0.02;

for i=1:(3^length(sizes))
    D = dec2base(i+3^length(sizes)-1, 3);
    for j=1:length(sizes)
        damounts(i, j) = str2num(D(j+1));
    end
end
damounts(damounts == 2) = -1;
damounts = damounts/1000;
damounts(1,:)
    
while 1
    for i=1:(3^length(sizes))
        amounts1 = amounts+damounts(i,:);
        amounts1(amounts1<0) = 0;
        score(i) = objective(amounts1, sizes, vmax);
    end
    [a, b] = min(score)
    if b==1
        break
    end
    amounts = amounts+damounts(b,:);
    amounts
    visc1(amounts, sizes)
end
visc1(amounts, sizes)
1-sum(amounts)
OP = amounts;
end
function score = objective(amounts, sizes, vmax)
    viscosity = visc1(amounts, sizes);
    score = viscosity^(0.001)/sum(amounts);
    if viscosity>vmax
        score = 100000*viscosity;
    end
end

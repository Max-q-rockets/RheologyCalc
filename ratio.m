function rat = ratio(amounts, sizes, n, ex)
        Ratio = @(FC, FM, c, m) FM-abs((FM-FC)*(c/(m+c))^(1/(ex)));
        ratios = sizes(n)./sizes;
        rat = 1;
        for i=1:n-1
            rat = Ratio(rat, ratios(i), sum(amounts(1:i-1)), amounts(i));
        end
    end
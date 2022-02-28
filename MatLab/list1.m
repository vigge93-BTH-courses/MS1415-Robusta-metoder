data = betarnd(4,3,1000000,1);
[p, ci] = beta(data);
p
ci

function [phat, pci] = beta(data)
    [phat,pci] = betafit(data);
end
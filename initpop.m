function chrom = initpop(NIND,N)
%  初始化染色体
%   输入 染色体个数（50）基因数（城市个数为15，不含原点）
%   NIND = 50;
%   N = 15
chrom = zeros(NIND,N);
for i = 1:NIND
    chrom(i,:) = randperm(N);
end


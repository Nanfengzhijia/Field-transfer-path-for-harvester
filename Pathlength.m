function len = Pathlength(D,chrom_new)
%  pathlength 计算染色体的路线长
%   此处显示详细说明
% D;
% chrom_new;
n = size(chrom_new,2)+2;
NIND = size(chrom_new,1);
len = zeros(NIND,1);
for i = 1:NIND
    p = [0,chrom_new(i,:),0];
    len(i,1) = 0;
   for k = 1:n-1      % k代表索引（便历）
       i1 = p(k);       % i1代表p的1：end的值，即第一个农田号码，为指针
       i2 = p(k+1);
       len(i,1) = len(i,1)+D(i1+1,i2+1);   % 就是第一个值（0）原点到p第二个值的距离
   end
end


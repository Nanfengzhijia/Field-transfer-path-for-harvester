function len = Pathlength(D,chrom_new)
%  pathlength ����Ⱦɫ���·�߳�
%   �˴���ʾ��ϸ˵��
% D;
% chrom_new;
n = size(chrom_new,2)+2;
NIND = size(chrom_new,1);
len = zeros(NIND,1);
for i = 1:NIND
    p = [0,chrom_new(i,:),0];
    len(i,1) = 0;
   for k = 1:n-1      % k����������������
       i1 = p(k);       % i1����p��1��end��ֵ������һ��ũ����룬Ϊָ��
       i2 = p(k+1);
       len(i,1) = len(i,1)+D(i1+1,i2+1);   % ���ǵ�һ��ֵ��0��ԭ�㵽p�ڶ���ֵ�ľ���
   end
end


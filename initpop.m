function chrom = initpop(NIND,N)
%  ��ʼ��Ⱦɫ��
%   ���� Ⱦɫ�������50�������������и���Ϊ15������ԭ�㣩
%   NIND = 50;
%   N = 15
chrom = zeros(NIND,N);
for i = 1:NIND
    chrom(i,:) = randperm(N);
end


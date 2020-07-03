function chrom_insert = insert(chrom,N,m)
%   ��Ⱦɫ��������λ��o������ʾ�ϸ�·������ֹ����¸�·������ʼ��
%   Ҫ�� ����·���Ĺ�����������ͬ
%   ���� �����50��Ⱦɫ�壬ѡ�����ڻ���֮�����Ԫ�ء�0����ռ��һ������λ����¼�õ�Ļ���λ��
%   N = 15;
%   m = 3;
v = 1:N-1;  % ����� 
b = nchoosek(N-1,m-1); % �����
CV = nchoosek(v,m-1); % ������ѡ����������

for i = 1:50 % ��ÿ��Ⱦɫ��Ĳ������λ
    chrom_insert = [];
    Aq = Bq = Cq = [];
    for k = 1:b
        LA = LB = LC = 0;
        x1 = CV(k,1);
        x2 = CV(k,2);
        A = chrom(i,x2+1:N);
        B = chrom(i,x1+1:x2);
        C = chrom(i,1:x1);
        chrom_insert(k,:) = [C,0,B,0,A];
        for j = A(1:end)
            Aq = sum(q(j));
%             LA = LA + D(0,j);
        end
        for j = B(1:end)
            Bq = sum(q(j));
        end
        for j = C(1:end)
            Cq = sum(q(j));
        end
        if 0.8*averageq <= Aq <= 1.2*averageq && 0.8*averageq <= Bq <= 1.2*averageq && 0.8*averageq <= Cq <= 1.2*averageq
           chrom_insert(k,:) =  chrom_insert(k,:);
           Length
        else 
           chrom_insert(k,:) = [];       
        end
    end
end

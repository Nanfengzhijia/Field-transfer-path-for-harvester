function chrom_insert = insert(chrom,N,m)
%   对染色体插入基因位“o”，表示上个路径的终止点和下个路径的起始点
%   要求 各个路径的工作量大致相同
%   输入 最初的50个染色体，选择相邻基因之间插入元素“0”，占据一个基因位，记录该点的基因位置
%   N = 15;
%   m = 3;
v = 1:N-1;  % 插空数 
b = nchoosek(N-1,m-1); % 组合数
CV = nchoosek(v,m-1); % 向量及选择的组合排列

for i = 1:50 % 对每个染色体的插入基因位
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

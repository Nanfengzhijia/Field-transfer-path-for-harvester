clear
clc
close all
X = [12,92       % 原点坐标
    16.47,96.10
    16.47,94.44
    20.09,92.54
    22.39,93.37
    25.23,97.24
    22.00,96.05
    20.47,97.02
    17.20,96.29
    16.30,97.38
    14.05,98.12
    16.53,97.38
    21.52,95.59
    19.41,97.13
    20.09,92.55
    15.59,93.27];% 个城市坐标位置
Q = [1,5.0,6.5;2,6.9,8.97;3,7.8,10.14;4,6.5,8.45;5,9.9,12.87;6,7.9,10.27;7,8.8,11.44;8,10.3,13.39;9,12.3,15.99;10,6.4,8.32;11,8.6,11.18;12,5.8,7.54;13,11.4,14.82;14,7.9,10.27;15,8.4,10.92];
q = Q(:,3);       % 各农田对应产量，1:15，行数代表城市编号
averageq = 0.333*sum(q);
m = 3;           % 收割机数量或者路径数量
NIND = 50;       % 种群大小
MAXGEN = 200;
Pc = 0.9;        % 交叉概率
Pm = 0.05;       % 变异概率
GGAP = 0.9;      % 代沟(Generation gap)

D = Distanse(X); % 生成距离矩阵（16*16）
N=size(D,1)-1;     %()
%% 初始化染色体
chrom = initpop(NIND,N);
chrom_new = [];

%% 插入基因位
% chrom_insert = insert(chrom); % 并且一定满足每条路径的工作量大致相同
v = 1:N-1;  % 插空数 
b = nchoosek(N-1,m-1); % 组合数
CV = nchoosek(v,m-1); % 向量及选择的组合排列
lengthabc = inf(50,1); % 给每个染色体最优插入方法记录最优路程长度


for i = 1:50 % 对每个染色体的插入基因位
  chrom_insert = [];
   
    for k = 1:b
         LB = 0; LC = 0;
        x1 = CV(k,1);
        x2 = CV(k,2);
        A = chrom(i,x2+1:N);
        B = chrom(i,x1+1:x2);
        C = chrom(i,1:x1);
        chrom_insert(k,:) = [C,0,B,0,A];
        Aq = 0;LA = 0;x = 0;
        for j = A(1:end)
            Aq = Aq + q(j,1);
            if x == 0
               LA = LA + D(1,j+1);
               x = x + 1;
            else 
               LA = LA + D(A(x)+1,j+1); 
               x = x + 1;
            end
            LA = LA + D(j+1,1);
        end
        Bq=0;LB = 0;x = 0;
        for j = B(1:end)
            Bq = Bq+q(j);
            if x == 0
               LB = LB + D(1,j+1);
               x = x + 1;
            else 
               LB = LB + D(B(x)+1,j+1); 
               x = x + 1;
            end
            LB = LB + D(j+1,1);
        end
        Cq=0;LC = 0;x = 0;
        for j = C(1:end)
            Cq = Cq+(q(j));
            if  x == 0
               LC = LC + D(1,j+1);
               x = x + 1;
            else 
               LC = LC + D(C(x)+1,j+1); 
               x = x + 1;
            end
            LC = LC + D(j+1,1);
        end
        
        if  0.8*averageq <= Aq && Aq <= 1.2*averageq && 0.8*averageq <= Bq && Bq <= 1.2*averageq && 0.8*averageq <= Cq && Cq <= 1.2*averageq % 满足各个路径工作量大致相等
           
            chrom_insert(k,:) =  chrom_insert(k,:); % 插入法染色体（91，：）进行更新
           
           if  LA + LB + LC <= lengthabc(i,1)  
              lengthabc(i,1) = LA + LB + LC;                                  % 最终目的是输出最短路径值
%               lengthabc(i,2) = 'A';lengthabc(i,3) = 'B' ;lengthabc(i,4) = 'c';
              chrom_new(i,:) = chrom_insert(k,:);                             % 最终目的是输出最短路径（也是第i行唯一的染色体）下的染色体（1，：）,对初始种群的染色体进行更新
           else
              chrom_insert(k,:) = chrom_insert(k,:); % 符合要求的插入染色体,但是路径不是最优的
           end
           
        else
           chrom_insert(k,:) = 0;       
        end
    end
end

%% 先画出经过处理的染色体图像，随机选择一个
figure;
Drawpath(chrom_new,1,X);% 画出随机解的路线和总距离
pause(0.0001)
disp('经过处理的初始种群中一个随机路线');
% p = Outputpath(chrom_new(1,:),1);
len(1) = Pathlength(D,chrom_new(1,:));
% disp('总距离：',num2str(len(1)));
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

%% 主函数部分
  
 gen = 0;
 figure;
 hold on; box on;
 xlim([0,MAXGEN]); title('优化过程') ; xlabel('代数') ; ylabel('最优值');
 len = Pathlength(D,chrom_new);
 preobjV = min(len);
 
while gen < MAXGEN   % 计算每一代中个体适应度值
    len = Pathlength(D,chrom_new);
    line([gen-1,gen],[preobjV,min(len)]); pause(0.0001) 
    preobjV = min(len);
    Fitnv = fitness(len);
    %% 选择
    Selch = Select(chrom_new,Fitnv,GGAP);
    %% 交叉操作
    Selch = Recombin(Selch,Pc);
    %% 变异
    Selch = Mutate(Selch,Pm);
    %% 逆转操作
    Selch = Reverse(Selch,D);
    %% 重插入子代新种群
   chrom_new = Reins(chrom_new,Selch,len);
    %% 更新迭代次数
    gen = gen + 1;
end
       
 
%% 画出最优解的路线图
figure;
objv = Pathlength(D,chrom_new);
[minobjv,minind] = min(objv);
Drawpath(chrom_new,minind(1),X);
disp('最优解轨迹');
p = Outputpath(chrom_new,minind(1));
disp(['总距离:',num2str(objv(minind(1)))]);




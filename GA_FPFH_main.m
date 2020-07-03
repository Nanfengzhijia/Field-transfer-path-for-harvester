clear
clc
close all
X = [12,92       % ԭ������
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
    15.59,93.27];% ����������λ��
Q = [1,5.0,6.5;2,6.9,8.97;3,7.8,10.14;4,6.5,8.45;5,9.9,12.87;6,7.9,10.27;7,8.8,11.44;8,10.3,13.39;9,12.3,15.99;10,6.4,8.32;11,8.6,11.18;12,5.8,7.54;13,11.4,14.82;14,7.9,10.27;15,8.4,10.92];
q = Q(:,3);       % ��ũ���Ӧ������1:15������������б��
averageq = 0.333*sum(q);
m = 3;           % �ո����������·������
NIND = 50;       % ��Ⱥ��С
MAXGEN = 200;
Pc = 0.9;        % �������
Pm = 0.05;       % �������
GGAP = 0.9;      % ����(Generation gap)

D = Distanse(X); % ���ɾ������16*16��
N=size(D,1)-1;     %()
%% ��ʼ��Ⱦɫ��
chrom = initpop(NIND,N);
chrom_new = [];

%% �������λ
% chrom_insert = insert(chrom); % ����һ������ÿ��·���Ĺ�����������ͬ
v = 1:N-1;  % ����� 
b = nchoosek(N-1,m-1); % �����
CV = nchoosek(v,m-1); % ������ѡ����������
lengthabc = inf(50,1); % ��ÿ��Ⱦɫ�����Ų��뷽����¼����·�̳���


for i = 1:50 % ��ÿ��Ⱦɫ��Ĳ������λ
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
        
        if  0.8*averageq <= Aq && Aq <= 1.2*averageq && 0.8*averageq <= Bq && Bq <= 1.2*averageq && 0.8*averageq <= Cq && Cq <= 1.2*averageq % �������·���������������
           
            chrom_insert(k,:) =  chrom_insert(k,:); % ���뷨Ⱦɫ�壨91���������и���
           
           if  LA + LB + LC <= lengthabc(i,1)  
              lengthabc(i,1) = LA + LB + LC;                                  % ����Ŀ����������·��ֵ
%               lengthabc(i,2) = 'A';lengthabc(i,3) = 'B' ;lengthabc(i,4) = 'c';
              chrom_new(i,:) = chrom_insert(k,:);                             % ����Ŀ����������·����Ҳ�ǵ�i��Ψһ��Ⱦɫ�壩�µ�Ⱦɫ�壨1������,�Գ�ʼ��Ⱥ��Ⱦɫ����и���
           else
              chrom_insert(k,:) = chrom_insert(k,:); % ����Ҫ��Ĳ���Ⱦɫ��,����·���������ŵ�
           end
           
        else
           chrom_insert(k,:) = 0;       
        end
    end
end

%% �Ȼ������������Ⱦɫ��ͼ�����ѡ��һ��
figure;
Drawpath(chrom_new,1,X);% ����������·�ߺ��ܾ���
pause(0.0001)
disp('��������ĳ�ʼ��Ⱥ��һ�����·��');
% p = Outputpath(chrom_new(1,:),1);
len(1) = Pathlength(D,chrom_new(1,:));
% disp('�ܾ��룺',num2str(len(1)));
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

%% ����������
  
 gen = 0;
 figure;
 hold on; box on;
 xlim([0,MAXGEN]); title('�Ż�����') ; xlabel('����') ; ylabel('����ֵ');
 len = Pathlength(D,chrom_new);
 preobjV = min(len);
 
while gen < MAXGEN   % ����ÿһ���и�����Ӧ��ֵ
    len = Pathlength(D,chrom_new);
    line([gen-1,gen],[preobjV,min(len)]); pause(0.0001) 
    preobjV = min(len);
    Fitnv = fitness(len);
    %% ѡ��
    Selch = Select(chrom_new,Fitnv,GGAP);
    %% �������
    Selch = Recombin(Selch,Pc);
    %% ����
    Selch = Mutate(Selch,Pm);
    %% ��ת����
    Selch = Reverse(Selch,D);
    %% �ز����Ӵ�����Ⱥ
   chrom_new = Reins(chrom_new,Selch,len);
    %% ���µ�������
    gen = gen + 1;
end
       
 
%% �������Ž��·��ͼ
figure;
objv = Pathlength(D,chrom_new);
[minobjv,minind] = min(objv);
Drawpath(chrom_new,minind(1),X);
disp('���Ž�켣');
p = Outputpath(chrom_new,minind(1));
disp(['�ܾ���:',num2str(objv(minind(1)))]);




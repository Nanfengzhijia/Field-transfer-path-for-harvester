
function Selch=Reverse(Selch,D)
%% 进化逆转函数
%输入
%SelCh 被选择的个体
%D     个城市的距离矩阵
%输出
%SelCh  进化逆转后的个体
[row,col] = size(Selch);
len = Pathlength(D,Selch);  %计算路径长度
Selch1=Selch;
for i=1:row
    r1=randsrc(1,1,[1:col]);
    r2=randsrc(1,1,[1:col]);
    r1 = min([r1 r2]);
    r2 = max([r1 r2]);
   
    while all(Selch(i,r1:r2)) == 0
        a1 = randsrc(1,1,[1:col]);
        a2 = randsrc(1,1,[1:col]);
        r1 = min([a1 a2]);
        r2 = max([a1 a2]);
%       if  all(Selch(i,r1:r2)) == 0
%           continue;
%       else
%           break;
%       end
       
   end
     
    Selch1(i,r1:r2) = Selch1(i,r2:-1:r1);


    

end
len1 = Pathlength(D,Selch1);  %计算路径长度
index = len1 < len;
Selch(index,:) = Selch1(index,:);


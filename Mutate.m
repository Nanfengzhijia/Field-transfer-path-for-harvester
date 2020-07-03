
function Selch=Mutate(Selch,Pm)
%% 变异操作
%输入：
%SelCh  被选择的个体
%Pm     变异概率
%输出：
% SelCh 变异后的个体
[NSel,L]=size(Selch);
for i=1:NSel
    
    if Pm>=rand
        R = randperm(L);
        if Selch(i,R(1)) == 0 || Selch(i,R(2)) == 0 
            continue
        end
         a = Selch(i,R(1));
         b = Selch(i,R(2));
         Selch(i,R(1)) = b;
         Selch(i,R(2)) = a;        
    end
end

function Selch=Mutate(Selch,Pm)
%% �������
%���룺
%SelCh  ��ѡ��ĸ���
%Pm     �������
%�����
% SelCh �����ĸ���
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
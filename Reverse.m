
function Selch=Reverse(Selch,D)
%% ������ת����
%����
%SelCh ��ѡ��ĸ���
%D     �����еľ������
%���
%SelCh  ������ת��ĸ���
[row,col] = size(Selch);
len = Pathlength(D,Selch);  %����·������
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
len1 = Pathlength(D,Selch1);  %����·������
index = len1 < len;
Selch(index,:) = Selch1(index,:);


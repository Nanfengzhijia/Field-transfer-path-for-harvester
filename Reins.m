
function Chrom_new=Reins(Chrom_new,Selch,len)
 %% �ز����Ӵ�������Ⱥ
 %���룺
 %Chrom  ��������Ⱥ
 %SelCh  �Ӵ���Ⱥ
 %ObjV   ������Ӧ��
 %���
 % Chrom  ��ϸ������Ӵ���õ�������Ⱥ
NIND=size(Chrom_new,1);
nsel=size(Selch,1);
[TobjV,index]=sort(len);
Chrom_new=[Chrom_new(index(1:NIND-nsel),:);Selch];
function Selch = Select(chrom_new,Fitnv,GGAP)
% ѡ��
% %   �˴���ʾ��ϸ˵��
% outputArg1 = chrom_new;
% outputArg2 = Fitnv;
% GGAP
NIND = size(chrom_new,1);
nsel = max(floor(NIND*GGAP+.5),2);
NewChrIx = Sus(Fitnv,nsel);
Selch = chrom_new(NewChrIx,:);
end


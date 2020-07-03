
function p = Outputpath(chrom_new,t)
%% 输出路径函数
%p1 p2 p3 路径
oo = find(~chrom_new(t,:)); o1 = oo(1); o2 = oo(2);
path1 =[0, chrom_new(t,[1:o1])]; path2 =[chrom_new(t,[o1:o2])]; path3 = [chrom_new(t,[o2:end]),0];
row1 = size(path1,2); row2 = size(path2,2); row3 = size(path3,2);
p1='0';p2='0';p3='0';
for i=2:row1
    p1=[p1,'—>',num2str(path1(i))];
end

for i=2:row2
    p2=[p2,'—>',num2str(path2(i))];
end

for i=2:row3
    p3=[p3,'—>',num2str(path3(i))];
end
p = {p1; p2; p3};
% disp(p1)
% disp(p2)

disp(p)



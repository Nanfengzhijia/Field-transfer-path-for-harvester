function D = Distanse(a)
%   计算两城市之间的距离，包含原点
%   输入 a 各农田订单的位置坐标
%   输出 D 城市间的距离矩阵

row = size(a,1);
D = zeros(row,row);
for i = 1:row
    for j = i:row
        D(i,j) = ((a(i,1)-a(j,1))^2+(a(i,2)-a(j,2))^2)^0.5;
        D(j,i) = D(i,j);
    end
end


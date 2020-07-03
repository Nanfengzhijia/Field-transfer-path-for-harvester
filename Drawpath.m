
function Drawpath(Chrom_new,t,X)
%% 画路径函数
%输入
% Chrom-new  待画路径 t为其索引行
% figure;
% X      各城市坐标位置
R = [Chrom_new(t,:)]; %一个随机解(个体)
hold on
plot(X(:,1),X(:,2),'o','color',[0.5,0.5,0.5])
plot(X(1,1),X(1,2),'rv','MarkerSize',20)
for i=1:size(X,1)-1
    text(X(i+1,1)+0.2,X(i+1,2)+0.2,num2str(i),'color',[1,0,0]);
end
 % 因为这里r含0，在X矩阵中，原点从1开始，16表示第15个城市，所以根据城市编号找X中对应的坐标，需要编号＋1
 % A就含有了所有顺序点的坐标值,下面需要提取出三组路线
oo = find(~R); o1 = oo(1); o2 = oo(2);
path1 = [0,R(1:o1)]; path2 = [R(o1:o2)]; path3 = [R(o2:end),0];
r1 = path1(1:end); r2 = path2(1:end); r3 = path3(1:end); 
A1 = X(r1+1,:); A2 = X(r2+1,:); A3 = X(r3+1,:);
row1 = size(A1,1); row2 = size(A2,1); row3 = size(A3,1);
for i=2:row1
    [arrowx,arrowy] = dsxy2figxy(gca,A1(i-1:i,1),A1(i-1:i,2));%坐标转换
    annotation('textarrow',arrowx,arrowy,'HeadWidth',8,'color','m');
end
for i=2:row2
    [arrowx,arrowy] = dsxy2figxy(gca,A2(i-1:i,1),A2(i-1:i,2));%坐标转换
    annotation('textarrow',arrowx,arrowy,'HeadWidth',8,'color','g');
end
for i=2:row3
    [arrowx,arrowy] = dsxy2figxy(gca,A3(i-1:i,1),A3(i-1:i,2));%坐标转换
    annotation('textarrow',arrowx,arrowy,'HeadWidth',8,'color','b');
end
hold off
xlabel('横坐标')
ylabel('纵坐标')
title('轨迹图')
box on

function varargout = dsxy2figxy(varargin)
if length(varargin{1}) == 1 && ishandle(varargin{1}) ...
                            && strcmp(get(varargin{1},'type'),'axes')   
    hAx = varargin{1};
    varargin = varargin(2:end);
else
    hAx = gca;
end;
if length(varargin) == 1
    pos = varargin{1};
else
    [x,y] = deal(varargin{:});
end
axun = get(hAx,'Units');
set(hAx,'Units','normalized'); 
axpos = get(hAx,'Position');
axlim = axis(hAx);
axwidth = diff(axlim(1:2));
axheight = diff(axlim(3:4));
if exist('x','var')
    varargout{1} = (x - axlim(1)) * axpos(3) / axwidth + axpos(1);
    varargout{2} = (y - axlim(3)) * axpos(4) / axheight + axpos(2);
else
    pos(1) = (pos(1) - axlim(1)) / axwidth * axpos(3) + axpos(1);
    pos(2) = (pos(2) - axlim(3)) / axheight * axpos(4) + axpos(2);
    pos(3) = pos(3) * axpos(3) / axwidth;
    pos(4) = pos(4) * axpos(4 )/ axheight;
    varargout{1} = pos;
end
set(hAx,'Units',axun)
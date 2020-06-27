function tu_plot(rel,control)
%引用网址 http://wenku.baidu.com/link?url=KqWG5UZDy1YdapSL_rm1Tf3uJPkpkkHChMYLMm9_xLo6UI2NG4T3YC8Pp_1LjEAle25lxljyZHWV_IQuL0okgBK1xx7jmVopl9ToXESij2C
%由邻接矩阵画连接图，输入为邻接矩阵rel，必须为方阵； 
%control为控制量，0表示画出的图为无向图，1表示有向图。默认值为0 
r_size=size(rel);%a=size(x)返回的是一个行向量，该行向量第一个元素是                  
                 %x的行数，第2个元素是x的列数 
if nargin<2      %nargin是用来判断输入变量个数的函数 
    control=0;   %输入变量小于2，即只有一个，就默认control为0 
end 
if r_size(1)~=r_size(2)%行数和列数不相等，不是方阵，不予处理 
    disp('Wrong Input! The input must be a square matrix!');     
    return; 
end 
len=r_size(1); 
rho=10;%限制图尺寸的大小 
r=2/1.05^len;%点的半径 

theta=0 :(2*pi/len): 2*pi*(1-1/len); 
[pointx,pointy]=pol2cart(theta',rho);%极坐标系到笛卡尔系 
theta=0 :pi/36: 2*pi; 
[tempx,tempy]=pol2cart(theta',r);
point=[pointx,pointy]; 
hold on 
for i=1:len     
    temp=[tempx,tempy]+[point(i,1)*ones(length(tempx),1),point(i,2)*ones(length(tempx),1)]; 
    plot(temp(:,1),temp(:,2),'r'); 
    text(point(i,1)-0.3,point(i,2),num2str(i));%画点 
end 
for i=1:len     
    for j=1:len         
        if rel(i,j) 
           link_plot(point(i,:),point(j,:),r,control); %连接有关系的点          
        end
    end
end
set(gca,'XLim',[-rho-r,rho+r],'YLim',[-rho-r,rho+r]); 
axis off

function link_plot(point1,point2,r,control)%连接两点 
temp=point2-point1; 
if (~temp(1))&&(~temp(2))     
    return;%不画子回路 
end 
theta=cart2pol(temp(1),temp(2)); 
[point1_x,point1_y]=pol2cart(theta,r); 
point_1=[point1_x,point1_y]+point1; 
[point2_x,point2_y]=pol2cart(theta+(2*(theta<pi)-1)*pi,r); 
point_2=[point2_x,point2_y]+point2; 
if control 
    arrow(point_1,point_2); 
else 
    plot([point_1(1),point_2(1)],[point_1(2),point_2(2)]); 
end 

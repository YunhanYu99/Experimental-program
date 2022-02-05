%%%2019/11/16   YunhanYu
%%%求曲线和直线之间的面积，插值法求交点，分段积分
%%%修改:直线改成折线,6段面积


function [AREA]=areaforfour(AllStimulus,trace,shapetype,begin_pos) %trace为轨迹曲线，midpoint为给定中点
syms a b
syms p q
syms c d
syms e f
syms r s

l=size(trace,1);
side_num = 0;

%设置给定中点及其顺序形成midpoint矩阵4*2
if begin_pos==1
    mid_order=[2,3];
elseif begin_pos==4
    mid_order=[3,2];
end

for o=1:2
   midpoint(o,:)=AllStimulus{shapetype}(mid_order(o),:);
end
    
for o=1:2
   m(o)=find(trace(:,1)==midpoint(o,1),1); %获取轨迹中点的x坐标位置向量
   mid(o,:)=trace(m(o),1:2);%轨迹中点坐标矩阵
end

   %%%---------------求解起点到中点直线函数，中点为给定点midpoint----------
begin_x=trace(1,1);
begin_y=trace(1,2);
end_x=trace(end,1);
end_y=trace(end,2);
dis_x = abs(begin_x - midpoint(1,1));
dis_y = abs(begin_y - midpoint(1,2));
dis_xy = sqrt(dis_x^2+dis_y^2);
  % mid_x=mid(1);
  % mid_y=mid(2);
    eq1=begin_y - a * begin_x - b;
    eq2=midpoint(1,2) - a * midpoint(1,1) - b;
   [a,b]=solve(eq1,eq2,a,b); % y=a*x+b 直线函数为起点到中点给定点的直线
   
    eq3=midpoint(1,2) - c * midpoint(1,1) - d;
    eq4=midpoint(2,2) - c * midpoint(2,1) - d;
   [c,d]=solve(eq3,eq4,c,d);
 
    eq9=end_y - p * end_x - q;
    eq10=midpoint(2,2) - p * midpoint(2,1) - q;
   [p,q]=solve(eq9,eq10,p,q); % y=p*x+q 直线函数为中点到轨迹终点的直线
   
   equ=[c,d];
  
   %%%-----------------------------求第一段积分----------------------------------
    %%%获得交点坐标（包括起点）及其位置
   L_y=[];
   L_x=[];
   x_speed=0;
   y_speed=0;
xzero=zeros(1,l);
yzero=zeros(1,l);
    for i=1:m(1)
        L_y(i,1)=trace(i,1)*a+b;%直线1的y序列
        y(i)=abs(L_y(i,1)-trace(i,2));%直线1与曲线纵坐标差值
        y_speed = y_speed + abs(trace(i+1,2)-trace(i,2))/(trace(i+1,3)-trace(i,3));
        x_speed = x_speed + abs(trace(i+1,1)-trace(i,1))/(trace(i+1,3)-trace(i,3));
    end
    for i=1:m(1)-1
        if y(i)*y(i+1)==0
            if (y(i)==0) && (y(i+1)~=0)
                xzero(i)=trace(i,1);
                yzero(i)=trace(i,2);
            end
            if (y(i+1) == 0)&&(y(i)~=0)
                xzero(i+1)=trace(i+1,1);
                yzero(i+1)=trace(i+1,2);
            end
            if (y(i)==0) && (y(i+1)==0)
                xzero(i+1)=nan;
                yzero(i+1)=nan;
            end
        elseif y(i)*y(i+1)<0   %一定有交点，用一次插值
            k = abs(y(i))/(abs(y(i))+abs(y(i+1)));%交点在i与i+1之间的比例
            xzero(i)=trace(i,1);
            yzero(i)=L_y(i)+ (L_y(i+1) - L_y(i))*k;
        else %>0
             xzero(i)=nan;
             yzero(i)=nan;
             xzero(i+1)=nan;
             yzero(i+1)=nan;
        end
    end
   
    Xzero=[];
    Yzero=[];
    order=[];
    for h=1:m(1)
        if (~isnan(xzero(h)))&&(xzero(h)~=0)
          Xzero=[Xzero xzero(h)];
          Yzero=[Yzero yzero(h)];
          order=[order h];
        end
    end
  z(1)=length(order);
    if (Xzero(z(1))~=midpoint(1,1))&&(Yzero(z(1))~=midpoint(1,2))%如果中点处没有交点，把轨迹中点x值对应的轨迹点加在里面
        Xzero=[Xzero mid(1,1)];
        Yzero=[Yzero mid(1,2)];
        order=[order m(1)];
    end
      z(1)=length(order);
      
    %%%-------------------分段求积分-----------------------------
   area=[];%每段面积
   QXJF=[];%曲线积分
   ZXJF=[];%直线积分
    for w=1:z(1)-1
        QX_x=trace((order(w):order(w+1)),1);%曲线x序列
        QX_y=trace((order(w):order(w+1)),2);%曲线y序列
        ZX_y=L_y((order(w):order(w+1)),1);%直线y序列
        JF1=trapz(QX_x,QX_y); %曲线积分
        JF2=trapz(QX_x,ZX_y); %直线积分
        QXJF=[QXJF JF1];
        ZXJF=[ZXJF JF2];
        final=JF1-JF2;
        if final > 0
            side_num = side_num + 1;
        end
        area=[area abs(final)];
    end
    AREA(1)= sum(area);
    
    
    %%%----------------------------------------------------------------------------
    %%%---------------------------中间线段求积分------------------------------------
    for t=1
        for i=m(t)+1:m(t+1)
            L_y(i,1)=trace(i,1)*equ(t,1)+equ(t,2);%直线1的y序列
            y(i)=L_y(i,1)-trace(i,2);%直线1与曲线纵坐标差值
            y_speed = y_speed + abs(trace(i+1,2)-trace(i,2))/(trace(i+1,3)-trace(i,3));
            x_speed = x_speed + abs(trace(i+1,1)-trace(i,1))/(trace(i+1,3)-trace(i,3));
        end
    for i=m(t)+1:m(t+1)-1
        if y(i)*y(i+1)==0
            if (y(i)==0) && (y(i+1)~=0)
                xzero(i)=trace(i,1);
                yzero(i)=trace(i,2);
            end
            if (y(i+1) == 0)&&(y(i)~=0)
                xzero(i+1)=trace(i+1,1);
                yzero(i+1)=trace(i+1,2);
            end
            if (y(i)==0) && (y(i+1)==0)
                xzero(i+1)=nan;
                yzero(i+1)=nan;
            end
        elseif y(i)*y(i+1)<0   %一定有交点，用一次插值
            k = abs(y(i))/(abs(y(i))+abs(y(i+1)));%交点在i与i+1之间的比例
            xzero(i)=trace(i,1);
            yzero(i)=L_y(i)+ (L_y(i+1) - L_y(i))*k;
        else %>0
             xzero(i)=nan;
             yzero(i)=nan;
             xzero(i+1)=nan;
             yzero(i+1)=nan;
        end
    end
  

    for h=m(t)+1:m(t+1)
        if (~isnan(xzero(h)))&&(xzero(h)~=0)
          Xzero=[Xzero xzero(h)];
          Yzero=[Yzero yzero(h)];
          order=[order h];
        end
    end
  z(t+1)=length(order);
    if (Xzero(z(t+1))~=midpoint(t+1,1))&&(Yzero(z(t+1))~=midpoint(t+1,2))%如果中点处没有交点，把轨迹中点x值对应的轨迹点加在里面
        Xzero=[Xzero mid(t+1,1)];
        Yzero=[Yzero mid(t+1,2)];
        order=[order m(t+1)];
    end
      z(t+1)=length(order);
      
    %%%-------------------分段求积分-----------------------------

   
    for w=z(t):z(t+1)-1
        QX_x=trace((order(w):order(w+1)),1);%曲线x序列
        QX_y=trace((order(w):order(w+1)),2);%曲线y序列
        ZX_y=L_y((order(w):order(w+1)),1);%直线y序列
        JF1=trapz(QX_x,QX_y); %曲线积分
        JF2=trapz(QX_x,ZX_y); %直线积分
        QXJF=[QXJF JF1];
        ZXJF=[ZXJF JF2];
        final=JF1-JF2;
        if final > 0
            side_num = side_num + 1;
        end
        area=[area abs(final)];
    end
    AREA(t+1)=sum(area); %目前为止全体面积
    end

    

    %%%----------------------求结尾部分积分------------------------
    for i=m(2)+1:length(trace)-1
        L_y(i,1)=trace(i,1)*p+q;%直线2的y序列
        y(i)=abs(L_y(i,1)-trace(i,2));
        y_speed = y_speed + abs(trace(i+1,2)-trace(i,2))/(trace(i+1,3)-trace(i,3));
        x_speed = x_speed + abs(trace(i+1,1)-trace(i,1))/(trace(i+1,3)-trace(i,3));
    end
    for i=m(2)+1:length(trace)-2
        if y(i)*y(i+1)==0
            if (y(i)==0) && (y(i+1)~=0)
                xzero(i)=trace(i,1);
                yzero(i)=trace(i,2);
            end
            if (y(i+1) == 0)&&(y(i)~=0)
                xzero(i+1)=trace(i+1,1);
                yzero(i+1)=trace(i+1,2);
            end
            if (y(i)==0) && (y(i+1)==0)
                xzero(i+1)=nan;
                yzero(i+1)=nan;
            end
        elseif y(i)*y(i+1)<0   %一定有交点，用一次插值
            k = abs(y(i))/(abs(y(i))+abs(y(i+1)));%交点在i与i+1之间的比例
            xzero(i)=trace(i,1);
            yzero(i)=L_y(i)+ (L_y(i+1) - L_y(i))*k;
        else %>0
             xzero(i)=nan;
             yzero(i)=nan;
             xzero(i+1)=nan;
             yzero(i+1)=nan;
        end
    end
    %%%获得交点坐标（包括终点）
    for h=m(2)+1:l
        if (~isnan(xzero(h)))&&(xzero(h)~=0)
          Xzero=[Xzero xzero(h)];
          Yzero=[Yzero yzero(h)];
          order=[order h];
        end
    end
    %%%分段求积分      
    z(3)=length(order);

    for w=z(2):z(3)-1   %再次从中点开始算
        QX_x=trace((order(w):order(w+1)),1);%曲线x序列
        QX_y=trace((order(w):order(w+1)),2);%曲线y序列
        ZX_y=L_y((order(w):order(w+1)),1);%直线y序列
        JF1=trapz(QX_x,QX_y); %曲线积分
        JF2=trapz(QX_x,ZX_y); %直线积分
        QXJF=[QXJF JF1];
        ZXJF=[ZXJF JF2];
        final=JF1-JF2;
        if final > 0
            side_num = side_num + 1;
        end
        area=[area abs(final)];
    end
AREA(3)= sum(area);
AREA(4) = x_speed/dis_x; %记录x偏差距离，控制左右
AREA(5) = y_speed/dis_y; %记录y偏差距离，控制上下
AREA(6) = AREA(3)/dis_xy;
end
   
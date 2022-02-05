%%%2019/11/16   YunhanYu
%%%�����ߺ�ֱ��֮����������ֵ���󽻵㣬�ֶλ���
%%%�޸�:ֱ�߸ĳ�����,6�����


function [AREA]=areaforfour(AllStimulus,trace,shapetype,begin_pos) %traceΪ�켣���ߣ�midpointΪ�����е�
syms a b
syms p q
syms c d
syms e f
syms r s

l=size(trace,1);
side_num = 0;

%���ø����е㼰��˳���γ�midpoint����4*2
if begin_pos==1
    mid_order=[2,3];
elseif begin_pos==4
    mid_order=[3,2];
end

for o=1:2
   midpoint(o,:)=AllStimulus{shapetype}(mid_order(o),:);
end
    
for o=1:2
   m(o)=find(trace(:,1)==midpoint(o,1),1); %��ȡ�켣�е��x����λ������
   mid(o,:)=trace(m(o),1:2);%�켣�е��������
end

   %%%---------------�����㵽�е�ֱ�ߺ������е�Ϊ������midpoint----------
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
   [a,b]=solve(eq1,eq2,a,b); % y=a*x+b ֱ�ߺ���Ϊ��㵽�е�������ֱ��
   
    eq3=midpoint(1,2) - c * midpoint(1,1) - d;
    eq4=midpoint(2,2) - c * midpoint(2,1) - d;
   [c,d]=solve(eq3,eq4,c,d);
 
    eq9=end_y - p * end_x - q;
    eq10=midpoint(2,2) - p * midpoint(2,1) - q;
   [p,q]=solve(eq9,eq10,p,q); % y=p*x+q ֱ�ߺ���Ϊ�е㵽�켣�յ��ֱ��
   
   equ=[c,d];
  
   %%%-----------------------------���һ�λ���----------------------------------
    %%%��ý������꣨������㣩����λ��
   L_y=[];
   L_x=[];
   x_speed=0;
   y_speed=0;
xzero=zeros(1,l);
yzero=zeros(1,l);
    for i=1:m(1)
        L_y(i,1)=trace(i,1)*a+b;%ֱ��1��y����
        y(i)=abs(L_y(i,1)-trace(i,2));%ֱ��1�������������ֵ
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
        elseif y(i)*y(i+1)<0   %һ���н��㣬��һ�β�ֵ
            k = abs(y(i))/(abs(y(i))+abs(y(i+1)));%������i��i+1֮��ı���
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
    if (Xzero(z(1))~=midpoint(1,1))&&(Yzero(z(1))~=midpoint(1,2))%����е㴦û�н��㣬�ѹ켣�е�xֵ��Ӧ�Ĺ켣���������
        Xzero=[Xzero mid(1,1)];
        Yzero=[Yzero mid(1,2)];
        order=[order m(1)];
    end
      z(1)=length(order);
      
    %%%-------------------�ֶ������-----------------------------
   area=[];%ÿ�����
   QXJF=[];%���߻���
   ZXJF=[];%ֱ�߻���
    for w=1:z(1)-1
        QX_x=trace((order(w):order(w+1)),1);%����x����
        QX_y=trace((order(w):order(w+1)),2);%����y����
        ZX_y=L_y((order(w):order(w+1)),1);%ֱ��y����
        JF1=trapz(QX_x,QX_y); %���߻���
        JF2=trapz(QX_x,ZX_y); %ֱ�߻���
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
    %%%---------------------------�м��߶������------------------------------------
    for t=1
        for i=m(t)+1:m(t+1)
            L_y(i,1)=trace(i,1)*equ(t,1)+equ(t,2);%ֱ��1��y����
            y(i)=L_y(i,1)-trace(i,2);%ֱ��1�������������ֵ
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
        elseif y(i)*y(i+1)<0   %һ���н��㣬��һ�β�ֵ
            k = abs(y(i))/(abs(y(i))+abs(y(i+1)));%������i��i+1֮��ı���
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
    if (Xzero(z(t+1))~=midpoint(t+1,1))&&(Yzero(z(t+1))~=midpoint(t+1,2))%����е㴦û�н��㣬�ѹ켣�е�xֵ��Ӧ�Ĺ켣���������
        Xzero=[Xzero mid(t+1,1)];
        Yzero=[Yzero mid(t+1,2)];
        order=[order m(t+1)];
    end
      z(t+1)=length(order);
      
    %%%-------------------�ֶ������-----------------------------

   
    for w=z(t):z(t+1)-1
        QX_x=trace((order(w):order(w+1)),1);%����x����
        QX_y=trace((order(w):order(w+1)),2);%����y����
        ZX_y=L_y((order(w):order(w+1)),1);%ֱ��y����
        JF1=trapz(QX_x,QX_y); %���߻���
        JF2=trapz(QX_x,ZX_y); %ֱ�߻���
        QXJF=[QXJF JF1];
        ZXJF=[ZXJF JF2];
        final=JF1-JF2;
        if final > 0
            side_num = side_num + 1;
        end
        area=[area abs(final)];
    end
    AREA(t+1)=sum(area); %ĿǰΪֹȫ�����
    end

    

    %%%----------------------���β���ֻ���------------------------
    for i=m(2)+1:length(trace)-1
        L_y(i,1)=trace(i,1)*p+q;%ֱ��2��y����
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
        elseif y(i)*y(i+1)<0   %һ���н��㣬��һ�β�ֵ
            k = abs(y(i))/(abs(y(i))+abs(y(i+1)));%������i��i+1֮��ı���
            xzero(i)=trace(i,1);
            yzero(i)=L_y(i)+ (L_y(i+1) - L_y(i))*k;
        else %>0
             xzero(i)=nan;
             yzero(i)=nan;
             xzero(i+1)=nan;
             yzero(i+1)=nan;
        end
    end
    %%%��ý������꣨�����յ㣩
    for h=m(2)+1:l
        if (~isnan(xzero(h)))&&(xzero(h)~=0)
          Xzero=[Xzero xzero(h)];
          Yzero=[Yzero yzero(h)];
          order=[order h];
        end
    end
    %%%�ֶ������      
    z(3)=length(order);

    for w=z(2):z(3)-1   %�ٴδ��е㿪ʼ��
        QX_x=trace((order(w):order(w+1)),1);%����x����
        QX_y=trace((order(w):order(w+1)),2);%����y����
        ZX_y=L_y((order(w):order(w+1)),1);%ֱ��y����
        JF1=trapz(QX_x,QX_y); %���߻���
        JF2=trapz(QX_x,ZX_y); %ֱ�߻���
        QXJF=[QXJF JF1];
        ZXJF=[ZXJF JF2];
        final=JF1-JF2;
        if final > 0
            side_num = side_num + 1;
        end
        area=[area abs(final)];
    end
AREA(3)= sum(area);
AREA(4) = x_speed/dis_x; %��¼xƫ����룬��������
AREA(5) = y_speed/dis_y; %��¼yƫ����룬��������
AREA(6) = AREA(3)/dis_xy;
end
   
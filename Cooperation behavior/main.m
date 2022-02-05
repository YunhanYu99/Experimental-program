% 2017-5-27 
%2017-11-22 修改：添加新图形至10个
 % YuanDi  
 %修改 2017-7-23 双人合作，图形为多折折线，无面积和时间反馈，试次前提示双方速度
 
 %YuYunhan2019-11 双人合作，加入冰水惩罚端口COM19，无速度差别，分为个别惩罚和集体惩罚
 
clear; 
global mainfilename;
mainfilename=mfilename;

%-----------------初始化各种值和参数------------------------------------
KbName('UnifyKeyNames')
subinfo = getSubInfo;

%初始化参数
block = 1;   %block个数
shuuu=100+38;
%onemove = 2;   %每按一次键移动的距离（像素）
onemov=[2,2;2,2;2,2;2,2;2,2;2,2;2,2;2,2;2,2;2,2;2,2;2,2]; %均匀移动
onemove=zeros(12,2);
m=[1,2,3,4,5,6,7,8,9,10,11,12];
shu=0;
while shu<shuuu %%%%%%%%%%
    m=Shuffle(m);
    shu=shu+1;
end
    
for i=1:12
    onemove(i,1)=onemov(m(i),1);
    onemove(i,2)=onemov(m(i),2);
end

d_bluedots = 40;   %红球的直径
trialnum = 0;  %当前trial累计计数，初始为0
shapenum = 10;
tasknum=22; %双人合作
%tasknum=[11;22]  % 11为单人任务，22为双人任务
%tasknum = Shuffle(tasknum,2)%随机

%所有标准的图形T1~T(shapenum)的坐标(X,Y)，从某个顶点，按顺时针排列
%T1 = [460,300;730,550;970,300;] %   长宽比2:1,up
%T2 = [500,50;620,650;710,50;] %   长宽比1:3,up
%T3 = [300,650;600,50;900,650;]  %  长宽比1:1,down
%T4 = [460,550;730,300;970,550;]  % 长宽比2:1down
%T5 = [500,650;620,100;710,650;]  %  长宽比1:3,down

T1 = [350,580;590,400;830,580;1070,400];%4;3   T1 = [30,580;270,400;510,580;750,400;990,580;1230,400] 300
T2 = [520,300;700,540;880,300;1060,540]; %3:4   T2 = [200,300;380,540;560,300;740,540;920,300;1100,540];
T3 = [350,400;590,580;830,400;1070,580];%4:3   T3 = [30,400;270,580;510,400;750,580;990,400;1230,580];
T4 = [520,540;700,300;880,540;1060,300]; %3:4  T4 = [200,540;380,300;560,540;740,300;920,540;1100,300];
T5 = [350,535;590,445;830,535;1070,445]; %8:3
T6 = [350,445;590,535;830,445;1070,535]; %8:3
T7 = [745,300;835,660;925,300;1015,660]; %3:8
T8 = [745,660;835,300;925,660;1015,300]; %3:8
T9 = [350,450;550,750;750,450;950,750]; %1:1
T10 = [350,750;550,450;750,750;950,450];%1:1



for i = 1:shapenum
    eval(['AllStimulus{' num2str(i) '} = T' num2str(i)])%建立shapenum个cell,每个cell是Tn的坐标
end
A = [1,2,3,4,5,6,7,8,9,10];

shu2=0;
while shu2<shuuu
    A=Shuffle(A);
    shu2=shu2+1;
end

%设定被试进行移动时的按键
mleft = KbName('a');
mright = KbName('d');
mup = KbName('uparrow');
mdown = KbName('downarrow');
endmove = KbName('return');
closewin = KbName('space');

 %装实验结果的结构变量
conditions = struct([]);
 

%-------------获取被试信息并检测信息是否重复-----------------------------
if isempty(subinfo)
    return;
else
    if exist(['Sub' num2str(subinfo{1})])
        resp=questdlg({['The file ' '"Sub' subinfo{1} '.mat" or "Sub' subinfo{1} ...
            '.xls" already exists']; 'do you want to overwrite it?'},...
            'duplicate warning','Cancel','Ok','Ok');%重复警告对话框
        if ~strcmp(resp,'Ok')%反应与ok是否完全匹配，如果不是ok的话…
            clc;
            disp('Experiment aborted!')
            return
        end
    end
end
HideCursor;%隐藏鼠标指针

if exist(['Sub' num2str(subinfo{1})])==0  %判断是否已经存在名为outputData的文件夹，如果不存在
    eval(['system(''mkdir Sub' num2str(subinfo{1}) ''')'])%建立sub的文件夹
end

%------------------------实验开始----------------------------------
try
    Screen('Preference', 'SkipSyncTests', 1);%add 
    Screen('Preference','TextEncodingLocale','UTF-8')%add to fix the text
    Screen('Preference', 'TextRenderer', 1)%用来解决字体问题
    [wPtr,wRect] = Screen('OpenWindow',0,255);   %打开主窗口,wptr当前窗口号码，wRect1*4矩阵的像素
    [x,y] = WindowCenter(wPtr);%Returns a window's center point.
    text1 = double('欢迎来到实验\n\n 请确保您已经了解实验内容。\n\n 如果没有问题，\n\n 即将进入练习阶段');
    Mywords(wPtr,text1,30,1)
    pause(2);    %缓冲2s

    
    %     %打开冰水仪器
%     COM_ice = serial('COM19');
%     fopen(COM_ice);
   %/////////// Open MATLAB Serial Port //////////////
%      COM4 = serial('COM4','BaudRate',9600,'DataBits',8,'Parity','none','StopBits',1);%端口号码
%      fopen(COM4);
%      
%      st   = sprintf('ST\r\n');%Start
%      baseline = sprintf('F7\r\n');%baseline
%      ja = sprintf('F8\r\n');%Mark F8
%      sa = sprintf('F9\r\n');%Mark F9
%      mark1 = sprintf('F1\r\n');%Mark F1
%      mark2 = sprintf('F2\r\n');%Mark F2
%      mark3 = sprintf('F3\r\n');%Mark F3
%      ed   = sprintf('ED\r\n');%End
% %     
%      fwrite(COM4,st)
% 
%     Mywords(wPtr,'预扫描\n\n 请安静休息\n\n 保持头部不动 \n\n',30)
%     pause(15) %预留ETG预扫描的时间15
%     
%      fwrite(COM4,baseline)
%     %Mywords(wPtr,'请休息\n\n 保持头部不动 \n\n 实验将在2分钟后开始',30)
%     %pause(60) %预留ETG预扫描的时间
%     Mywords(wPtr,'请休息\n\n 保持头部不动 \n\n 实验将在1分钟后开始',30)
%     pause(50) %预留ETG预扫描的时间50
%     Mywords(wPtr,'请休息\n\n 保持头部不动 \n\n 实验将在10秒后开始',30)
%     pause(7) %预留ETG预扫描的时间7
%     
%     
%     %----------block开始------------------------
% 
         %Mywords(wPtr,double('双人任务 \n\n 两名被试联合操作 \n\n\n\n 实验将在3秒后开始'),30)
%     fwrite(COM4,ja)
         %pause(3)
     

       %-------------trial开始--------------------------- 
  
       B = Shuffle(A);
       for i = 1%:10  %block1是i1~5，block2是i6~10
           trace_xy=[];
           trace=[];
           rect_xy=[];
           shapetype = B(1,i);%形状编号
           trialnum  = trialnum+1;  %初始trailnum=0
           PointList = AllStimulus{shapetype} ;   %获取图形4个顶点坐标
           d = [1,4];
           d=Shuffle(d);
           d=d(1);%随机1或4
           VertexList=PointList(d,:);  %以其中一个顶点作为起点，获取该点坐标
           if d ==1
               endpoint=PointList(4,:);
               begin_pos = 1;
           elseif d==4
               endpoint=PointList(1,:);
               begin_pos = 4;
           end
           rx1 = VertexList(1,1)-2;%画笔边缘
           ry1 = VertexList(1,2)-2;%画笔边缘
           rx2 = VertexList(1,1)+2;%画笔边缘
           ry2 = VertexList(1,2)+2;%画笔边缘
           trace_xy(1,1) = rx1;
           trace_xy(1,2) = ry1;
           trace_xy(1,3) = rx2;
           trace_xy(1,4) = ry2;
           punish = 0;
           x_speed = 0;
           y_speed = 0;
           area_more = 0;
           punish_way = subinfo{2}; %惩罚方式
           
           
           conditions(trialnum,1).sub = str2double(char(subinfo{1}));  %写入被试编号信息
           %conditions(trialnum,1).task = task %for task=1:2(task是tasknum的第一个，第二个）
           %conditions(trialnum,1).tasktype = tasknum(task,1)
           %conditions(trialnum,1).block = bnumber;    %写入block序号
           conditions(trialnum,1).trial = i;   %写入trial序号
           conditions(trialnum,1).shapetype = shapetype;   %写入trial中图形类型
           conditions(trialnum,1).begin_pos = d;   %写入起始位置
           conditions(trialnum,1).move = onemove(i,:) ;%写入两名被试移动速度
           conditions(trialnum,1).punish = punish;   %写入punish
           conditions(trialnum,1).x_speed = x_speed;   %写入x速度
           conditions(trialnum,1).y_speed = y_speed ;%写入y速度
           conditions(trialnum,1).area_more = area_more ;%写入总偏差面积
           conditions(trialnum,1).punish_way = punish_way;%写入惩罚方式
           
           % ----------trial正式开始-----------------------------
           k = 0;
           tt=0;
           
           Screen('DrawText',wPtr,' ')  %空屏1s
           Screen('Flip',wPtr)
           pause(2);
           
           Mywords(wPtr,'+')  %注视点1s
           pause(1);
           
           %Mywords(wPtr,['水平方向速度为：' num2str(onemove(i,1)) '\n\n 竖直方向速度为:' num2str(onemove(i,2))],30)
           %pause(2)
           
           % fwrite(COM4,mark1);
           % 目标图形出现
           Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
           Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
           Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
           Screen('Flip',wPtr)
           pause(1);
           
           % fwrite(COM4,mark2);
           starttime = GetSecs;  % 获取trial开始的时间
           %开始不断刷屏记录轨迹
           while 1
               [kb,secs,kc] = KbCheck;
               if kb && kc(mleft) && kc(mup)%左上坐标为（0,0）
                   rx1 = rx1-onemove(i,1);
                   rx2 = rx2-onemove(i,1);
                   ry1 = ry1-onemove(i,2);
                   ry2 = ry2-onemove(i,2);
               elseif kb && kc(mleft) && kc(mdown)
                   rx1 = rx1-onemove(i,1);
                   rx2 = rx2-onemove(i,1);
                   ry1 = ry1+onemove(i,2);
                   ry2 = ry2+onemove(i,2);
               elseif kb && kc(mright) && kc(mup)
                   rx1 = rx1+onemove(i,1);
                   rx2 = rx2+onemove(i,1);
                   ry1 = ry1-onemove(i,2);
                   ry2 = ry2-onemove(i,2);
               elseif kb && kc(mright) && kc(mdown)
                   rx1 = rx1+onemove(i,1);
                   rx2 = rx2+onemove(i,1);
                   ry1 = ry1+onemove(i,2);
                   ry2 = ry2+onemove(i,2);
               elseif kb&& kc(mleft)
                   rx1 = rx1-onemove(i,1);
                   rx2 = rx2-onemove(i,1);
               elseif kb&&kc(mright)
                   rx1 = rx1+onemove(i,1);
                   rx2 = rx2+onemove(i,1);
               elseif kb&&kc(mup)
                   ry1 = ry1-onemove(i,2);
                   ry2 = ry2-onemove(i,2);
               elseif kb&&kc(mdown)
                   ry1 = ry1+onemove(i,2);
                   ry2 = ry2+onemove(i,2);
               end
               Nowtime = GetSecs;
               k=k+1;
               trace(k,1) = (rx1+rx2)/2; % xpos圆心走过的x坐标
               trace(k,2) = (ry1+ry2)/2; % ypos圆心走过的y坐标
               trace(k,3) = Nowtime-starttime; % time
               if k>1
                   if (trace(k-1,1)==trace(k,1))&&(trace(k-1,2)==trace(k,2))%x轴不变，y轴不变
                       tt=tt+0;
                   else
                       tt=tt+1;%从第一行改写，tt初始值为0
                       trace_xy(tt+1,1) = rx1;
                       trace_xy(tt+1,2) = ry1;
                       trace_xy(tt+1,3) = rx2;
                       trace_xy(tt+1,4) = ry2;
                   end
               end
               
               rect_xy = trace_xy';%矩阵的转置
               Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
               Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
               Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
               Screen('FrameOval',wPtr,[0,0,0],[(endpoint(1,1)-5);(endpoint(1,2)-5);(endpoint(1,1)+5);(endpoint(1,2)+5)],2)%终点位置的椭圆
               Screen('FrameOval',wPtr,[255,0,0],[(VertexList(1,1)-5);(VertexList(1,2)-5);(VertexList(1,1)+5);(VertexList(1,2)+5)],2)%起点位置的椭圆
               Screen('FillOval',wPtr,[0,0,255],rect_xy,4)%做出轨迹线
               Screen('Flip',wPtr)
               
               
               if kb&&kc(endmove)%按键并且按的是return
                   conditions(trialnum,1).movingtime = trace(k,3);
                   break
               end
               
               mtoabegin = ((trace(k,1)-VertexList(1,1))^2 + (trace(k,2)-VertexList(1,2))^2)^(1/2);%每一次按键到达位置和原始位置的直线距离
               mtoaend =((trace(k,1)-endpoint(1,1))^2 + (trace(k,2)-endpoint(1,2))^2)^(1/2);%每一次按键到达位置和终点位置的直线距离
               %if (trace(k,1)>15)&&(mtoaend <=8)%15秒还停留在8像素以内的位置(回到原点）
               if mtoaend <=8  %   停留在8像素以内的位置
                   conditions(trialnum,1).movingtime = trace(k,3);%记录总体游戏时间
                   break
               end
               
               if trace(k,3)>60 %限时
                   Screen('DrawText',wPtr,' ')
                   [AREA] = areaforfour(AllStimulus,trace,shapetype,begin_pos);
                   break
               end
           end
           %                     fwrite(COM4,mark3);
           [AREA] = areaforfour(AllStimulus,trace,shapetype,begin_pos); %计算每条直线的偏离面积
           area_more = AREA(6); %总偏差面积
           x_speed = AREA(4); %x偏差
           y_speed = AREA(5); %y偏差
           punish = 0;
           conditions(trialnum,1).move = onemove(i,:) ;%写入惩罚情况
           if area_more > 8 %设置惩罚偏差面积
               Screen('DrawText',wPtr,' ')
               punish = 1;
               finish_pun = 1;
               if subinfo{2} == '1' %判断惩罚类型
                   if x_speed >= y_speed
                       Mywords(wPtr,double('面积偏差过大\n\n请负责左右的人接受惩罚'),30) %显示惩罚文字
                       %                         fprintf(COM_ice,'a0005z');
                       %                         while finish_pun == 1
                       %                             finish_pun = fread(COM_ice,1);
                       %                         end
                       pause(5)
                   else
                       Mywords(wPtr,double('面积偏差过大\n\n请负责上下的人接受惩罚'),30) %显示惩罚文字
                       %                         fprintf(COM_ice,'a0500z');
                       %                         while finish_pun == 1
                       %                             finish_pun = fread(COM_ice,1);
                       %                         end
                       pause(5)
                   end
               else
                   Mywords(wPtr,double('面积偏差过大\n\n请共同接受惩罚'),30) %显示惩罚文字
                   %                     fprintf(COM_ice,'a0505z');
                   %                     while finish_pun == 1
                   %                         finish_pun = fread(COM_ice,1);
                   %                     end
                   pause(5)
               end
           end
           
       end
       text1 = double('练习阶段结束 \n\n 实验马上开始 \n\n 请两名被试做好准备');
       Mywords(wPtr,text1,30,1)
       %Mywords(wPtr,double('练习阶段结束 \n\n 实验马上开始 \n\n 请两名被试做好准备 '),30) %提示任务即将开始
       pause(5);    %缓冲2s
       B = Shuffle(A);
       for i = 1:10  %block1是i1~5，block2是i6~10
           trace_xy=[];
           trace=[];
           rect_xy=[];
            shapetype = B(1,i);%形状编号
            trialnum  = trialnum+1;  %初始trailnum=0
            PointList = AllStimulus{shapetype} ;   %获取图形4个顶点坐标
            d = [1,4];   
            d=Shuffle(d);
            d=d(1);%随机1或4
            VertexList=PointList(d,:);  %以其中一个顶点作为起点，获取该点坐标
            if d ==1
                endpoint=PointList(4,:);
                begin_pos = 1;
            elseif d==4
                endpoint=PointList(1,:);
                begin_pos = 4;
            end
            rx1 = VertexList(1,1)-2;%画笔边缘
            ry1 = VertexList(1,2)-2;%画笔边缘
            rx2 = VertexList(1,1)+2;%画笔边缘
            ry2 = VertexList(1,2)+2;%画笔边缘
            trace_xy(1,1) = rx1;
            trace_xy(1,2) = ry1;
            trace_xy(1,3) = rx2;
            trace_xy(1,4) = ry2;
            punish = 0;
            x_speed = 0;
            y_speed = 0;
            area_more = 0;
            punish_way = subinfo{2};

            
            
            conditions(trialnum,1).sub = str2double(char(subinfo{1}));  %写入被试编号信息
            %conditions(trialnum,1).task = task %for task=1:2(task是tasknum的第一个，第二个）
            %conditions(trialnum,1).tasktype = tasknum(task,1)
            %conditions(trialnum,1).block = bnumber;    %写入block序号
            conditions(trialnum,1).trial = i;   %写入trial序号
            conditions(trialnum,1).shapetype = shapetype;   %写入trial中图形类型
            conditions(trialnum,1).begin_pos = d;   %写入起始位置
            conditions(trialnum,1).move = onemove(i,:) ;%写入两名被试移动速度
            conditions(trialnum,1).punish = punish;   %写入punish
            conditions(trialnum,1).x_speed = x_speed;   %写入x速度
            conditions(trialnum,1).y_speed = y_speed ;%写入y速度            
            conditions(trialnum,1).area_more = area_more ;%写入总偏差面积
            conditions(trialnum,1).punish_way = punish_way;%写入惩罚方式
            
             % ----------trial正式开始-----------------------------
            k = 0; 
            tt=0;
            
            Screen('DrawText',wPtr,' ')  %空屏1s
            Screen('Flip',wPtr)
            pause(2);

            Mywords(wPtr,'+')  %注视点1s
            pause(1);
            
            %Mywords(wPtr,['水平方向速度为：' num2str(onemove(i,1)) '\n\n 竖直方向速度为:' num2str(onemove(i,2))],30)
            %pause(2)
            
            % fwrite(COM4,mark1);
            % 目标图形出现
            Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
            Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
            Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
            Screen('Flip',wPtr)
            pause(1);
       
            % fwrite(COM4,mark2);
            starttime = GetSecs;  % 获取trial开始的时间
            %开始不断刷屏记录轨迹
            while 1
                [kb,secs,kc] = KbCheck;
                if kb && kc(mleft) && kc(mup)%左上坐标为（0,0）
                    rx1 = rx1-onemove(i,1);
                    rx2 = rx2-onemove(i,1);
                    ry1 = ry1-onemove(i,2);
                    ry2 = ry2-onemove(i,2);
                elseif kb && kc(mleft) && kc(mdown)
                    rx1 = rx1-onemove(i,1);
                    rx2 = rx2-onemove(i,1);
                    ry1 = ry1+onemove(i,2);
                    ry2 = ry2+onemove(i,2);
                elseif kb && kc(mright) && kc(mup)
                    rx1 = rx1+onemove(i,1);
                    rx2 = rx2+onemove(i,1);
                    ry1 = ry1-onemove(i,2);
                    ry2 = ry2-onemove(i,2);
                elseif kb && kc(mright) && kc(mdown)
                    rx1 = rx1+onemove(i,1);
                    rx2 = rx2+onemove(i,1);
                    ry1 = ry1+onemove(i,2);
                    ry2 = ry2+onemove(i,2);
                elseif kb&& kc(mleft)
                    rx1 = rx1-onemove(i,1);
                    rx2 = rx2-onemove(i,1);
                elseif kb&&kc(mright)
                    rx1 = rx1+onemove(i,1);
                    rx2 = rx2+onemove(i,1);
                elseif kb&&kc(mup)
                    ry1 = ry1-onemove(i,2);
                    ry2 = ry2-onemove(i,2);
                elseif kb&&kc(mdown)
                    ry1 = ry1+onemove(i,2);
                    ry2 = ry2+onemove(i,2);
                end
                Nowtime = GetSecs;
                k=k+1;
                trace(k,1) = (rx1+rx2)/2; % xpos圆心走过的x坐标
                trace(k,2) = (ry1+ry2)/2; % ypos圆心走过的y坐标
                trace(k,3) = Nowtime-starttime; % time
                if k>1
                    if (trace(k-1,1)==trace(k,1))&&(trace(k-1,2)==trace(k,2))%x轴不变，y轴不变
                        tt=tt+0;
                    else
                        tt=tt+1;%从第一行改写，tt初始值为0
                        trace_xy(tt+1,1) = rx1;
                        trace_xy(tt+1,2) = ry1;
                        trace_xy(tt+1,3) = rx2;
                        trace_xy(tt+1,4) = ry2;
                    end
                end
         
                rect_xy = trace_xy';%矩阵的转置
                Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
                Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
                Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
                Screen('FrameOval',wPtr,[0,0,0],[(endpoint(1,1)-5);(endpoint(1,2)-5);(endpoint(1,1)+5);(endpoint(1,2)+5)],2)%终点位置的椭圆
                Screen('FrameOval',wPtr,[255,0,0],[(VertexList(1,1)-5);(VertexList(1,2)-5);(VertexList(1,1)+5);(VertexList(1,2)+5)],2)%起点位置的椭圆
                Screen('FillOval',wPtr,[0,0,255],rect_xy,4)%做出轨迹线
                Screen('Flip',wPtr)
              
                
                if kb&&kc(endmove)%按键并且按的是return
                    conditions(trialnum,1).movingtime = trace(k,3);
                    break
                end

                mtoabegin = ((trace(k,1)-VertexList(1,1))^2 + (trace(k,2)-VertexList(1,2))^2)^(1/2);%每一次按键到达位置和原始位置的直线距离
                mtoaend =((trace(k,1)-endpoint(1,1))^2 + (trace(k,2)-endpoint(1,2))^2)^(1/2);%每一次按键到达位置和终点位置的直线距离
                %if (trace(k,1)>15)&&(mtoaend <=8)%15秒还停留在8像素以内的位置(回到原点）
                if mtoaend <=8  %   停留在8像素以内的位置
                    conditions(trialnum,1).movingtime = trace(k,3);%记录总体游戏时间
                    break
                end

                if trace(k,3)>60 %限时
                    Screen('DrawText',wPtr,' ')
                    [AREA] = areaforfour(AllStimulus,trace,shapetype,begin_pos);
                    break
                end
            end
        %                     fwrite(COM4,mark3);
            [AREA] = areaforfour(AllStimulus,trace,shapetype,begin_pos); %计算每条直线的偏离面积
            area_more = AREA(6); %总偏差面积
            x_speed = AREA(4); %x偏差
            y_speed = AREA(5); %y偏差
            punish = 0;
            conditions(trialnum,1).move = onemove(i,:) ;%写入惩罚情况
            if area_more > 8 %设置惩罚偏差面积
                Screen('DrawText',wPtr,' ')
                punish = 1;
                finish_pun = 1;
                if subinfo{2} == '1' %判断惩罚类型
                    if x_speed >= y_speed
                        Mywords(wPtr,double('面积偏差过大\n\n请负责左右的人接受惩罚'),30) %显示惩罚文字
                        %                         fprintf(COM_ice,'a0005z');
                        %                         while finish_pun == 1
                        %                             finish_pun = fread(COM_ice,1);
                        %                         end
                        pause(5)
                    else
                        Mywords(wPtr,double('面积偏差过大\n\n请负责上下的人接受惩罚'),30) %显示惩罚文字
                        %                         fprintf(COM_ice,'a0500z');
                        %                         while finish_pun == 1
                        %                             finish_pun = fread(COM_ice,1);
                        %                         end
                        pause(5)
                    end
                else
                    Mywords(wPtr,double('面积偏差过大\n\n请共同接受惩罚'),30) %显示惩罚文字
                    %                     fprintf(COM_ice,'a0505z');
                    %                     while finish_pun == 1
                    %                         finish_pun = fread(COM_ice,1);
                    %                     end
                    pause(5)
                end
            end
            conditions(trialnum,1).punish = punish ;%写入惩罚情况        
            conditions(trialnum,1).x_speed = x_speed ;%写入x,左右速度
            conditions(trialnum,1).y_speed = y_speed ;%写入y,上下速度
            conditions(trialnum,1).area_more = area_more ;%写入偏差面积
            conditions(trialnum,1).punish_way = punish_way;%惩罚方式

        
            save([['.\Sub' num2str(subinfo{1}) '\'],['coordination_all_trace' num2str(trialnum) '_shapetype' num2str(shapetype) '.mat']],'trace')
            save([['.\Sub' num2str(subinfo{1}) '\'],['coordination_selected_trace' num2str(trialnum) '_shapetype' num2str(shapetype) '.mat']],'trace_xy')
      
       end
       for i = 1:10
           AllStimulus{i} = [AllStimulus{i}(:,2),AllStimulus{i}(:,1)];
       end
       for i = 1:10  %block1是i1~5，block2是i6~10
           trace_xy=[];
           trace=[];
           rect_xy=[];
           shapetype = B(1,i);%形状编号
           trialnum  = trialnum+1;  %初始trailnum=0
           PointList = AllStimulus{shapetype} ;  %获取图形4个顶点坐标
           d = [1,4];
           d=Shuffle(d);
           d=d(1);%随机1或4起点
           VertexList=PointList(d,:);  %以其中一个顶点作为起点，获取该点坐标
           if d ==1
               endpoint=PointList(4,:);
               begin_pos = 1;
           elseif d==4
               endpoint=PointList(1,:);
               begin_pos = 4;
           end
           rx1 = VertexList(1,1)-2;%画笔边缘
           ry1 = VertexList(1,2)-2;%画笔边缘
           rx2 = VertexList(1,1)+2;%画笔边缘
           ry2 = VertexList(1,2)+2;%画笔边缘
           trace_xy(1,1) = rx1;
           trace_xy(1,2) = ry1;
           trace_xy(1,3) = rx2;
           trace_xy(1,4) = ry2;
           punish = 0;
           x_speed = 0;
           y_speed = 0;
           area_more = 0;
           punish_way = subinfo{2};

           
           conditions(trialnum,1).sub = str2double(char(subinfo{1}));  %写入被试编号信息
           %conditions(trialnum,1).task = task %for task=1:2(task是tasknum的第一个，第二个）
           %conditions(trialnum,1).tasktype = tasknum(task,1)
           %conditions(trialnum,1).block = bnumber;    %写入block序号
           conditions(trialnum,1).trial = i;   %写入trial序号
           conditions(trialnum,1).shapetype = shapetype;   %写入trial中图形类型
           conditions(trialnum,1).begin_pos = d;   %写入起始位置
           conditions(trialnum,1).move = onemove(i,:) ;%写入两名被试移动速度
           conditions(trialnum,1).punish = punish;   %写入punish
           conditions(trialnum,1).x_speed = x_speed;   %写入x速度
           conditions(trialnum,1).y_speed = y_speed ;%写入y速度
           conditions(trialnum,1).area_more = area_more ;%写入总偏差面积
           conditions(trialnum,1).punish_way = punish_way;%写入惩罚方式
           
           % ----------trial正式开始-----------------------------
           k = 0;
           tt=0;
           
           Screen('DrawText',wPtr,' ')  %空屏1s
           Screen('Flip',wPtr)
           pause(2);
           
           Mywords(wPtr,'+')  %注视点1s
           pause(1);
           
           %Mywords(wPtr,['水平方向速度为：' num2str(onemove(i,1)) '\n\n 竖直方向速度为:' num2str(onemove(i,2))],30)
           %pause(2)
           
           % fwrite(COM4,mark1);
           % 目标图形出现
           Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
           Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
           Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
           Screen('Flip',wPtr)
           pause(1);
           
           % fwrite(COM4,mark2);
           starttime = GetSecs;  % 获取trial开始的时间
           %开始不断刷屏记录轨迹
           while 1
               [kb,secs,kc] = KbCheck;
               if kb && kc(mleft) && kc(mup)%左上坐标为（0,0）
                   rx1 = rx1-onemove(i,1);
                   rx2 = rx2-onemove(i,1);
                   ry1 = ry1-onemove(i,2);
                   ry2 = ry2-onemove(i,2);
               elseif kb && kc(mleft) && kc(mdown)
                   rx1 = rx1-onemove(i,1);
                   rx2 = rx2-onemove(i,1);
                   ry1 = ry1+onemove(i,2);
                   ry2 = ry2+onemove(i,2);
               elseif kb && kc(mright) && kc(mup)
                   rx1 = rx1+onemove(i,1);
                   rx2 = rx2+onemove(i,1);
                   ry1 = ry1-onemove(i,2);
                   ry2 = ry2-onemove(i,2);
               elseif kb && kc(mright) && kc(mdown)
                   rx1 = rx1+onemove(i,1);
                   rx2 = rx2+onemove(i,1);
                   ry1 = ry1+onemove(i,2);
                   ry2 = ry2+onemove(i,2);
               elseif kb&& kc(mleft)
                   rx1 = rx1-onemove(i,1);
                   rx2 = rx2-onemove(i,1);
               elseif kb&&kc(mright)
                   rx1 = rx1+onemove(i,1);
                   rx2 = rx2+onemove(i,1);
               elseif kb&&kc(mup)
                   ry1 = ry1-onemove(i,2);
                   ry2 = ry2-onemove(i,2);
               elseif kb&&kc(mdown)
                   ry1 = ry1+onemove(i,2);
                   ry2 = ry2+onemove(i,2);
               end
               Nowtime = GetSecs;
               k=k+1;
               trace(k,1) = (rx1+rx2)/2; % xpos圆心走过的x坐标
               trace(k,2) = (ry1+ry2)/2; % ypos圆心走过的y坐标
               trace(k,3) = Nowtime-starttime; % time
               if k>1
                   if (trace(k-1,1)==trace(k,1))&&(trace(k-1,2)==trace(k,2))%x轴不变，y轴不变
                       tt=tt+0;
                   else
                       tt=tt+1;%从第一行改写，tt初始值为0
                       trace_xy(tt+1,1) = rx1;
                       trace_xy(tt+1,2) = ry1;
                       trace_xy(tt+1,3) = rx2;
                       trace_xy(tt+1,4) = ry2;
                   end
               end
               
               rect_xy = trace_xy';%矩阵的转置
               Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
               Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
               Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
               Screen('FrameOval',wPtr,[0,0,0],[(endpoint(1,1)-5);(endpoint(1,2)-5);(endpoint(1,1)+5);(endpoint(1,2)+5)],2)%终点位置的椭圆
               Screen('FrameOval',wPtr,[255,0,0],[(VertexList(1,1)-5);(VertexList(1,2)-5);(VertexList(1,1)+5);(VertexList(1,2)+5)],2)%起点位置的椭圆
               Screen('FillOval',wPtr,[0,0,255],rect_xy,4)%做出轨迹线
               Screen('Flip',wPtr)
               
               
               if kb&&kc(endmove)%按键并且按的是return
                   conditions(trialnum,1).movingtime = trace(k,3);
                   break
               end
               
               mtoabegin = ((trace(k,1)-VertexList(1,1))^2 + (trace(k,2)-VertexList(1,2))^2)^(1/2);%每一次按键到达位置和原始位置的直线距离
               mtoaend =((trace(k,1)-endpoint(1,1))^2 + (trace(k,2)-endpoint(1,2))^2)^(1/2);%每一次按键到达位置和终点位置的直线距离
               %if (trace(k,1)>15)&&(mtoaend <=8)%15秒还停留在8像素以内的位置(回到原点）
               if mtoaend <=8  %   停留在8像素以内的位置
                   conditions(trialnum,1).movingtime = trace(k,3);%记录总体游戏时间
                   break
               end
               
               if trace(k,3)>60 %限时
                   Screen('DrawText',wPtr,' ')
                   [AREA] = areayforfour(AllStimulus,trace,shapetype,begin_pos);
                   break
               end
           end
           %                     fwrite(COM4,mark3);
           [AREA] = areayforfour(AllStimulus,trace,shapetype,begin_pos); %计算每条直线的偏离面积
           area_more = AREA(6); %总偏差面积
           x_speed = AREA(4); %x偏差
           y_speed = AREA(5); %y偏差
           punish = 0;
           conditions(trialnum,1).move = onemove(i,:) ;%写入惩罚情况
           if area_more > 8 %设置惩罚偏差面积
               Screen('DrawText',wPtr,' ')
               punish = 1;
               finish_pun = 1;
               if subinfo{2} == '1' %判断惩罚类型
                   if x_speed >= y_speed
                       Mywords(wPtr,double('面积偏差过大\n\n请负责左右的人接受惩罚'),30) %显示惩罚文字
                       %                         fprintf(COM_ice,'a0005z');
                       %                         while finish_pun == 1
                       %                             finish_pun = fread(COM_ice,1);
                       %                         end
                       pause(5)
                   else
                       Mywords(wPtr,double('面积偏差过大\n\n请负责上下的人接受惩罚'),30) %显示惩罚文字
                       %                         fprintf(COM_ice,'a0500z');
                       %                         while finish_pun == 1
                       %                             finish_pun = fread(COM_ice,1);
                       %                         end
                       pause(5)
                   end
               else
                   Mywords(wPtr,double('面积偏差过大\n\n请共同接受惩罚'),30) %显示惩罚文字
                   %                     fprintf(COM_ice,'a0505z');
                   %                     while finish_pun == 1
                   %                         finish_pun = fread(COM_ice,1);
                   %                     end
                   pause(5)
               end
           end
           conditions(trialnum,1).punish = punish ;%写入惩罚情况
           conditions(trialnum,1).x_speed = x_speed ;%写入x,左右速度
           conditions(trialnum,1).y_speed = y_speed ;%写入y,上下速度
           conditions(trialnum,1).area_more = area_more ;%写入偏差面积
           conditions(trialnum,1).punish_way = punish_way;%惩罚方式
           
           
           save([['.\Sub' num2str(subinfo{1}) '\'],['coordination_all_trace' num2str(trialnum) '_shapetype' num2str(shapetype) '.mat']],'trace')
           save([['.\Sub' num2str(subinfo{1}) '\'],['coordination_selected_trace' num2str(trialnum) '_shapetype' num2str(shapetype) '.mat']],'trace_xy')
           
       end

    columnheader = {'sub','trial','shapetype','begin_pos','move','punish','x_speed','y_speed','area_more','punish_way','movingtime'};
    conditions = orderfields(conditions,columnheader);
    ret = [columnheader;struct2cell(conditions)'];
    %xlswrite([['.\Sub' num2str(subinfo{1}) '\'],['Sub' char(subinfo{1}) '.xls']],ret);
    save([['.\Result' '\'],['Sub' char(subinfo{1}) '.mat']],'ret');
    save([['.\Sub' num2str(subinfo{1}) '\'],['Subconditions' char(subinfo{1}) '.mat']],'conditions');
            
    %% 实验结束
    Mywords(wPtr,'实验结束！')
    pause(4);
    %fwrite(COM4,ed);
    %fclose(COM4);
    %clear COM4;clear st;clear ed;
    %fclose(COM_ice);
    Screen('CloseALL') 
    sca;
catch
    psychrethrow(psychlasterror);
    sca;
end
return

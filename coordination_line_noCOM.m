% 2017-5-27 
%2017-11-22 �޸ģ������ͼ����10��
 % YuanDi  
 %�޸� 2017-7-23 ˫�˺�����ͼ��Ϊ�������ߣ��������ʱ�䷴�����Դ�ǰ��ʾ˫���ٶ�
 
 %YuYunhan2019-11 ˫�˺����������ˮ�ͷ��˿�COM19�����ٶȲ�𣬷�Ϊ����ͷ��ͼ���ͷ�
 
clear; 
global mainfilename;
mainfilename=mfilename;

%-----------------��ʼ������ֵ�Ͳ���------------------------------------
KbName('UnifyKeyNames')
subinfo = getSubInfo;

%��ʼ������
block = 1;   %block����
shuuu=100+38;
%onemove = 2;   %ÿ��һ�μ��ƶ��ľ��루���أ�
onemov=[2,2;2,2;2,2;2,2;2,2;2,2;2,2;2,2;2,2;2,2;2,2;2,2]; %�����ƶ�
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

d_bluedots = 40;   %�����ֱ��
trialnum = 0;  %��ǰtrial�ۼƼ�������ʼΪ0
shapenum = 10;
tasknum=22; %˫�˺���
%tasknum=[11;22]  % 11Ϊ��������22Ϊ˫������
%tasknum = Shuffle(tasknum,2)%���

%���б�׼��ͼ��T1~T(shapenum)������(X,Y)����ĳ�����㣬��˳ʱ������
%T1 = [460,300;730,550;970,300;] %   �����2:1,up
%T2 = [500,50;620,650;710,50;] %   �����1:3,up
%T3 = [300,650;600,50;900,650;]  %  �����1:1,down
%T4 = [460,550;730,300;970,550;]  % �����2:1down
%T5 = [500,650;620,100;710,650;]  %  �����1:3,down

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
    eval(['AllStimulus{' num2str(i) '} = T' num2str(i)])%����shapenum��cell,ÿ��cell��Tn������
end
A = [1,2,3,4,5,6,7,8,9,10];

shu2=0;
while shu2<shuuu
    A=Shuffle(A);
    shu2=shu2+1;
end

%�趨���Խ����ƶ�ʱ�İ���
mleft = KbName('a');
mright = KbName('d');
mup = KbName('uparrow');
mdown = KbName('downarrow');
endmove = KbName('return');
closewin = KbName('space');

 %װʵ�����Ľṹ����
conditions = struct([]);
 

%-------------��ȡ������Ϣ�������Ϣ�Ƿ��ظ�-----------------------------
if isempty(subinfo)
    return;
else
    if exist(['Sub' num2str(subinfo{1})])
        resp=questdlg({['The file ' '"Sub' subinfo{1} '.mat" or "Sub' subinfo{1} ...
            '.xls" already exists']; 'do you want to overwrite it?'},...
            'duplicate warning','Cancel','Ok','Ok');%�ظ�����Ի���
        if ~strcmp(resp,'Ok')%��Ӧ��ok�Ƿ���ȫƥ�䣬�������ok�Ļ���
            clc;
            disp('Experiment aborted!')
            return
        end
    end
end
HideCursor;%�������ָ��

if exist(['Sub' num2str(subinfo{1})])==0  %�ж��Ƿ��Ѿ�������ΪoutputData���ļ��У����������
    eval(['system(''mkdir Sub' num2str(subinfo{1}) ''')'])%����sub���ļ���
end

%------------------------ʵ�鿪ʼ----------------------------------
try
    Screen('Preference', 'SkipSyncTests', 1);%add 
    Screen('Preference','TextEncodingLocale','UTF-8')%add to fix the text
    Screen('Preference', 'TextRenderer', 1)%���������������
    [wPtr,wRect] = Screen('OpenWindow',0,255);   %��������,wptr��ǰ���ں��룬wRect1*4���������
    [x,y] = WindowCenter(wPtr);%Returns a window's center point.
    text1 = double('��ӭ����ʵ��\n\n ��ȷ�����Ѿ��˽�ʵ�����ݡ�\n\n ���û�����⣬\n\n ����������ϰ�׶�');
    Mywords(wPtr,text1,30,1)
    pause(2);    %����2s

    
    %     %�򿪱�ˮ����
%     COM_ice = serial('COM19');
%     fopen(COM_ice);
   %/////////// Open MATLAB Serial Port //////////////
%      COM4 = serial('COM4','BaudRate',9600,'DataBits',8,'Parity','none','StopBits',1);%�˿ں���
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
%     Mywords(wPtr,'Ԥɨ��\n\n �밲����Ϣ\n\n ����ͷ������ \n\n',30)
%     pause(15) %Ԥ��ETGԤɨ���ʱ��15
%     
%      fwrite(COM4,baseline)
%     %Mywords(wPtr,'����Ϣ\n\n ����ͷ������ \n\n ʵ�齫��2���Ӻ�ʼ',30)
%     %pause(60) %Ԥ��ETGԤɨ���ʱ��
%     Mywords(wPtr,'����Ϣ\n\n ����ͷ������ \n\n ʵ�齫��1���Ӻ�ʼ',30)
%     pause(50) %Ԥ��ETGԤɨ���ʱ��50
%     Mywords(wPtr,'����Ϣ\n\n ����ͷ������ \n\n ʵ�齫��10���ʼ',30)
%     pause(7) %Ԥ��ETGԤɨ���ʱ��7
%     
%     
%     %----------block��ʼ------------------------
% 
         %Mywords(wPtr,double('˫������ \n\n �����������ϲ��� \n\n\n\n ʵ�齫��3���ʼ'),30)
%     fwrite(COM4,ja)
         %pause(3)
     

       %-------------trial��ʼ--------------------------- 
  
       B = Shuffle(A);
       for i = 1%:10  %block1��i1~5��block2��i6~10
           trace_xy=[];
           trace=[];
           rect_xy=[];
           shapetype = B(1,i);%��״���
           trialnum  = trialnum+1;  %��ʼtrailnum=0
           PointList = AllStimulus{shapetype} ;   %��ȡͼ��4����������
           d = [1,4];
           d=Shuffle(d);
           d=d(1);%���1��4
           VertexList=PointList(d,:);  %������һ��������Ϊ��㣬��ȡ�õ�����
           if d ==1
               endpoint=PointList(4,:);
               begin_pos = 1;
           elseif d==4
               endpoint=PointList(1,:);
               begin_pos = 4;
           end
           rx1 = VertexList(1,1)-2;%���ʱ�Ե
           ry1 = VertexList(1,2)-2;%���ʱ�Ե
           rx2 = VertexList(1,1)+2;%���ʱ�Ե
           ry2 = VertexList(1,2)+2;%���ʱ�Ե
           trace_xy(1,1) = rx1;
           trace_xy(1,2) = ry1;
           trace_xy(1,3) = rx2;
           trace_xy(1,4) = ry2;
           punish = 0;
           x_speed = 0;
           y_speed = 0;
           area_more = 0;
           punish_way = subinfo{2}; %�ͷ���ʽ
           
           
           conditions(trialnum,1).sub = str2double(char(subinfo{1}));  %д�뱻�Ա����Ϣ
           %conditions(trialnum,1).task = task %for task=1:2(task��tasknum�ĵ�һ�����ڶ�����
           %conditions(trialnum,1).tasktype = tasknum(task,1)
           %conditions(trialnum,1).block = bnumber;    %д��block���
           conditions(trialnum,1).trial = i;   %д��trial���
           conditions(trialnum,1).shapetype = shapetype;   %д��trial��ͼ������
           conditions(trialnum,1).begin_pos = d;   %д����ʼλ��
           conditions(trialnum,1).move = onemove(i,:) ;%д�����������ƶ��ٶ�
           conditions(trialnum,1).punish = punish;   %д��punish
           conditions(trialnum,1).x_speed = x_speed;   %д��x�ٶ�
           conditions(trialnum,1).y_speed = y_speed ;%д��y�ٶ�
           conditions(trialnum,1).area_more = area_more ;%д����ƫ�����
           conditions(trialnum,1).punish_way = punish_way;%д��ͷ���ʽ
           
           % ----------trial��ʽ��ʼ-----------------------------
           k = 0;
           tt=0;
           
           Screen('DrawText',wPtr,' ')  %����1s
           Screen('Flip',wPtr)
           pause(2);
           
           Mywords(wPtr,'+')  %ע�ӵ�1s
           pause(1);
           
           %Mywords(wPtr,['ˮƽ�����ٶ�Ϊ��' num2str(onemove(i,1)) '\n\n ��ֱ�����ٶ�Ϊ:' num2str(onemove(i,2))],30)
           %pause(2)
           
           % fwrite(COM4,mark1);
           % Ŀ��ͼ�γ���
           Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
           Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
           Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
           Screen('Flip',wPtr)
           pause(1);
           
           % fwrite(COM4,mark2);
           starttime = GetSecs;  % ��ȡtrial��ʼ��ʱ��
           %��ʼ����ˢ����¼�켣
           while 1
               [kb,secs,kc] = KbCheck;
               if kb && kc(mleft) && kc(mup)%��������Ϊ��0,0��
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
               trace(k,1) = (rx1+rx2)/2; % xposԲ���߹���x����
               trace(k,2) = (ry1+ry2)/2; % yposԲ���߹���y����
               trace(k,3) = Nowtime-starttime; % time
               if k>1
                   if (trace(k-1,1)==trace(k,1))&&(trace(k-1,2)==trace(k,2))%x�᲻�䣬y�᲻��
                       tt=tt+0;
                   else
                       tt=tt+1;%�ӵ�һ�и�д��tt��ʼֵΪ0
                       trace_xy(tt+1,1) = rx1;
                       trace_xy(tt+1,2) = ry1;
                       trace_xy(tt+1,3) = rx2;
                       trace_xy(tt+1,4) = ry2;
                   end
               end
               
               rect_xy = trace_xy';%�����ת��
               Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
               Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
               Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
               Screen('FrameOval',wPtr,[0,0,0],[(endpoint(1,1)-5);(endpoint(1,2)-5);(endpoint(1,1)+5);(endpoint(1,2)+5)],2)%�յ�λ�õ���Բ
               Screen('FrameOval',wPtr,[255,0,0],[(VertexList(1,1)-5);(VertexList(1,2)-5);(VertexList(1,1)+5);(VertexList(1,2)+5)],2)%���λ�õ���Բ
               Screen('FillOval',wPtr,[0,0,255],rect_xy,4)%�����켣��
               Screen('Flip',wPtr)
               
               
               if kb&&kc(endmove)%�������Ұ�����return
                   conditions(trialnum,1).movingtime = trace(k,3);
                   break
               end
               
               mtoabegin = ((trace(k,1)-VertexList(1,1))^2 + (trace(k,2)-VertexList(1,2))^2)^(1/2);%ÿһ�ΰ�������λ�ú�ԭʼλ�õ�ֱ�߾���
               mtoaend =((trace(k,1)-endpoint(1,1))^2 + (trace(k,2)-endpoint(1,2))^2)^(1/2);%ÿһ�ΰ�������λ�ú��յ�λ�õ�ֱ�߾���
               %if (trace(k,1)>15)&&(mtoaend <=8)%15�뻹ͣ����8�������ڵ�λ��(�ص�ԭ�㣩
               if mtoaend <=8  %   ͣ����8�������ڵ�λ��
                   conditions(trialnum,1).movingtime = trace(k,3);%��¼������Ϸʱ��
                   break
               end
               
               if trace(k,3)>60 %��ʱ
                   Screen('DrawText',wPtr,' ')
                   [AREA] = areaforfour(AllStimulus,trace,shapetype,begin_pos);
                   break
               end
           end
           %                     fwrite(COM4,mark3);
           [AREA] = areaforfour(AllStimulus,trace,shapetype,begin_pos); %����ÿ��ֱ�ߵ�ƫ�����
           area_more = AREA(6); %��ƫ�����
           x_speed = AREA(4); %xƫ��
           y_speed = AREA(5); %yƫ��
           punish = 0;
           conditions(trialnum,1).move = onemove(i,:) ;%д��ͷ����
           if area_more > 8 %���óͷ�ƫ�����
               Screen('DrawText',wPtr,' ')
               punish = 1;
               finish_pun = 1;
               if subinfo{2} == '1' %�жϳͷ�����
                   if x_speed >= y_speed
                       Mywords(wPtr,double('���ƫ�����\n\n�븺�����ҵ��˽��ܳͷ�'),30) %��ʾ�ͷ�����
                       %                         fprintf(COM_ice,'a0005z');
                       %                         while finish_pun == 1
                       %                             finish_pun = fread(COM_ice,1);
                       %                         end
                       pause(5)
                   else
                       Mywords(wPtr,double('���ƫ�����\n\n�븺�����µ��˽��ܳͷ�'),30) %��ʾ�ͷ�����
                       %                         fprintf(COM_ice,'a0500z');
                       %                         while finish_pun == 1
                       %                             finish_pun = fread(COM_ice,1);
                       %                         end
                       pause(5)
                   end
               else
                   Mywords(wPtr,double('���ƫ�����\n\n�빲ͬ���ܳͷ�'),30) %��ʾ�ͷ�����
                   %                     fprintf(COM_ice,'a0505z');
                   %                     while finish_pun == 1
                   %                         finish_pun = fread(COM_ice,1);
                   %                     end
                   pause(5)
               end
           end
           
       end
       text1 = double('��ϰ�׶ν��� \n\n ʵ�����Ͽ�ʼ \n\n ��������������׼��');
       Mywords(wPtr,text1,30,1)
       %Mywords(wPtr,double('��ϰ�׶ν��� \n\n ʵ�����Ͽ�ʼ \n\n ��������������׼�� '),30) %��ʾ���񼴽���ʼ
       pause(5);    %����2s
       B = Shuffle(A);
       for i = 1:10  %block1��i1~5��block2��i6~10
           trace_xy=[];
           trace=[];
           rect_xy=[];
            shapetype = B(1,i);%��״���
            trialnum  = trialnum+1;  %��ʼtrailnum=0
            PointList = AllStimulus{shapetype} ;   %��ȡͼ��4����������
            d = [1,4];   
            d=Shuffle(d);
            d=d(1);%���1��4
            VertexList=PointList(d,:);  %������һ��������Ϊ��㣬��ȡ�õ�����
            if d ==1
                endpoint=PointList(4,:);
                begin_pos = 1;
            elseif d==4
                endpoint=PointList(1,:);
                begin_pos = 4;
            end
            rx1 = VertexList(1,1)-2;%���ʱ�Ե
            ry1 = VertexList(1,2)-2;%���ʱ�Ե
            rx2 = VertexList(1,1)+2;%���ʱ�Ե
            ry2 = VertexList(1,2)+2;%���ʱ�Ե
            trace_xy(1,1) = rx1;
            trace_xy(1,2) = ry1;
            trace_xy(1,3) = rx2;
            trace_xy(1,4) = ry2;
            punish = 0;
            x_speed = 0;
            y_speed = 0;
            area_more = 0;
            punish_way = subinfo{2};

            
            
            conditions(trialnum,1).sub = str2double(char(subinfo{1}));  %д�뱻�Ա����Ϣ
            %conditions(trialnum,1).task = task %for task=1:2(task��tasknum�ĵ�һ�����ڶ�����
            %conditions(trialnum,1).tasktype = tasknum(task,1)
            %conditions(trialnum,1).block = bnumber;    %д��block���
            conditions(trialnum,1).trial = i;   %д��trial���
            conditions(trialnum,1).shapetype = shapetype;   %д��trial��ͼ������
            conditions(trialnum,1).begin_pos = d;   %д����ʼλ��
            conditions(trialnum,1).move = onemove(i,:) ;%д�����������ƶ��ٶ�
            conditions(trialnum,1).punish = punish;   %д��punish
            conditions(trialnum,1).x_speed = x_speed;   %д��x�ٶ�
            conditions(trialnum,1).y_speed = y_speed ;%д��y�ٶ�            
            conditions(trialnum,1).area_more = area_more ;%д����ƫ�����
            conditions(trialnum,1).punish_way = punish_way;%д��ͷ���ʽ
            
             % ----------trial��ʽ��ʼ-----------------------------
            k = 0; 
            tt=0;
            
            Screen('DrawText',wPtr,' ')  %����1s
            Screen('Flip',wPtr)
            pause(2);

            Mywords(wPtr,'+')  %ע�ӵ�1s
            pause(1);
            
            %Mywords(wPtr,['ˮƽ�����ٶ�Ϊ��' num2str(onemove(i,1)) '\n\n ��ֱ�����ٶ�Ϊ:' num2str(onemove(i,2))],30)
            %pause(2)
            
            % fwrite(COM4,mark1);
            % Ŀ��ͼ�γ���
            Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
            Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
            Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
            Screen('Flip',wPtr)
            pause(1);
       
            % fwrite(COM4,mark2);
            starttime = GetSecs;  % ��ȡtrial��ʼ��ʱ��
            %��ʼ����ˢ����¼�켣
            while 1
                [kb,secs,kc] = KbCheck;
                if kb && kc(mleft) && kc(mup)%��������Ϊ��0,0��
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
                trace(k,1) = (rx1+rx2)/2; % xposԲ���߹���x����
                trace(k,2) = (ry1+ry2)/2; % yposԲ���߹���y����
                trace(k,3) = Nowtime-starttime; % time
                if k>1
                    if (trace(k-1,1)==trace(k,1))&&(trace(k-1,2)==trace(k,2))%x�᲻�䣬y�᲻��
                        tt=tt+0;
                    else
                        tt=tt+1;%�ӵ�һ�и�д��tt��ʼֵΪ0
                        trace_xy(tt+1,1) = rx1;
                        trace_xy(tt+1,2) = ry1;
                        trace_xy(tt+1,3) = rx2;
                        trace_xy(tt+1,4) = ry2;
                    end
                end
         
                rect_xy = trace_xy';%�����ת��
                Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
                Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
                Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
                Screen('FrameOval',wPtr,[0,0,0],[(endpoint(1,1)-5);(endpoint(1,2)-5);(endpoint(1,1)+5);(endpoint(1,2)+5)],2)%�յ�λ�õ���Բ
                Screen('FrameOval',wPtr,[255,0,0],[(VertexList(1,1)-5);(VertexList(1,2)-5);(VertexList(1,1)+5);(VertexList(1,2)+5)],2)%���λ�õ���Բ
                Screen('FillOval',wPtr,[0,0,255],rect_xy,4)%�����켣��
                Screen('Flip',wPtr)
              
                
                if kb&&kc(endmove)%�������Ұ�����return
                    conditions(trialnum,1).movingtime = trace(k,3);
                    break
                end

                mtoabegin = ((trace(k,1)-VertexList(1,1))^2 + (trace(k,2)-VertexList(1,2))^2)^(1/2);%ÿһ�ΰ�������λ�ú�ԭʼλ�õ�ֱ�߾���
                mtoaend =((trace(k,1)-endpoint(1,1))^2 + (trace(k,2)-endpoint(1,2))^2)^(1/2);%ÿһ�ΰ�������λ�ú��յ�λ�õ�ֱ�߾���
                %if (trace(k,1)>15)&&(mtoaend <=8)%15�뻹ͣ����8�������ڵ�λ��(�ص�ԭ�㣩
                if mtoaend <=8  %   ͣ����8�������ڵ�λ��
                    conditions(trialnum,1).movingtime = trace(k,3);%��¼������Ϸʱ��
                    break
                end

                if trace(k,3)>60 %��ʱ
                    Screen('DrawText',wPtr,' ')
                    [AREA] = areaforfour(AllStimulus,trace,shapetype,begin_pos);
                    break
                end
            end
        %                     fwrite(COM4,mark3);
            [AREA] = areaforfour(AllStimulus,trace,shapetype,begin_pos); %����ÿ��ֱ�ߵ�ƫ�����
            area_more = AREA(6); %��ƫ�����
            x_speed = AREA(4); %xƫ��
            y_speed = AREA(5); %yƫ��
            punish = 0;
            conditions(trialnum,1).move = onemove(i,:) ;%д��ͷ����
            if area_more > 8 %���óͷ�ƫ�����
                Screen('DrawText',wPtr,' ')
                punish = 1;
                finish_pun = 1;
                if subinfo{2} == '1' %�жϳͷ�����
                    if x_speed >= y_speed
                        Mywords(wPtr,double('���ƫ�����\n\n�븺�����ҵ��˽��ܳͷ�'),30) %��ʾ�ͷ�����
                        %                         fprintf(COM_ice,'a0005z');
                        %                         while finish_pun == 1
                        %                             finish_pun = fread(COM_ice,1);
                        %                         end
                        pause(5)
                    else
                        Mywords(wPtr,double('���ƫ�����\n\n�븺�����µ��˽��ܳͷ�'),30) %��ʾ�ͷ�����
                        %                         fprintf(COM_ice,'a0500z');
                        %                         while finish_pun == 1
                        %                             finish_pun = fread(COM_ice,1);
                        %                         end
                        pause(5)
                    end
                else
                    Mywords(wPtr,double('���ƫ�����\n\n�빲ͬ���ܳͷ�'),30) %��ʾ�ͷ�����
                    %                     fprintf(COM_ice,'a0505z');
                    %                     while finish_pun == 1
                    %                         finish_pun = fread(COM_ice,1);
                    %                     end
                    pause(5)
                end
            end
            conditions(trialnum,1).punish = punish ;%д��ͷ����        
            conditions(trialnum,1).x_speed = x_speed ;%д��x,�����ٶ�
            conditions(trialnum,1).y_speed = y_speed ;%д��y,�����ٶ�
            conditions(trialnum,1).area_more = area_more ;%д��ƫ�����
            conditions(trialnum,1).punish_way = punish_way;%�ͷ���ʽ

        
            save([['.\Sub' num2str(subinfo{1}) '\'],['coordination_all_trace' num2str(trialnum) '_shapetype' num2str(shapetype) '.mat']],'trace')
            save([['.\Sub' num2str(subinfo{1}) '\'],['coordination_selected_trace' num2str(trialnum) '_shapetype' num2str(shapetype) '.mat']],'trace_xy')
      
       end
       for i = 1:10
           AllStimulus{i} = [AllStimulus{i}(:,2),AllStimulus{i}(:,1)];
       end
       for i = 1:10  %block1��i1~5��block2��i6~10
           trace_xy=[];
           trace=[];
           rect_xy=[];
           shapetype = B(1,i);%��״���
           trialnum  = trialnum+1;  %��ʼtrailnum=0
           PointList = AllStimulus{shapetype} ;  %��ȡͼ��4����������
           d = [1,4];
           d=Shuffle(d);
           d=d(1);%���1��4���
           VertexList=PointList(d,:);  %������һ��������Ϊ��㣬��ȡ�õ�����
           if d ==1
               endpoint=PointList(4,:);
               begin_pos = 1;
           elseif d==4
               endpoint=PointList(1,:);
               begin_pos = 4;
           end
           rx1 = VertexList(1,1)-2;%���ʱ�Ե
           ry1 = VertexList(1,2)-2;%���ʱ�Ե
           rx2 = VertexList(1,1)+2;%���ʱ�Ե
           ry2 = VertexList(1,2)+2;%���ʱ�Ե
           trace_xy(1,1) = rx1;
           trace_xy(1,2) = ry1;
           trace_xy(1,3) = rx2;
           trace_xy(1,4) = ry2;
           punish = 0;
           x_speed = 0;
           y_speed = 0;
           area_more = 0;
           punish_way = subinfo{2};

           
           conditions(trialnum,1).sub = str2double(char(subinfo{1}));  %д�뱻�Ա����Ϣ
           %conditions(trialnum,1).task = task %for task=1:2(task��tasknum�ĵ�һ�����ڶ�����
           %conditions(trialnum,1).tasktype = tasknum(task,1)
           %conditions(trialnum,1).block = bnumber;    %д��block���
           conditions(trialnum,1).trial = i;   %д��trial���
           conditions(trialnum,1).shapetype = shapetype;   %д��trial��ͼ������
           conditions(trialnum,1).begin_pos = d;   %д����ʼλ��
           conditions(trialnum,1).move = onemove(i,:) ;%д�����������ƶ��ٶ�
           conditions(trialnum,1).punish = punish;   %д��punish
           conditions(trialnum,1).x_speed = x_speed;   %д��x�ٶ�
           conditions(trialnum,1).y_speed = y_speed ;%д��y�ٶ�
           conditions(trialnum,1).area_more = area_more ;%д����ƫ�����
           conditions(trialnum,1).punish_way = punish_way;%д��ͷ���ʽ
           
           % ----------trial��ʽ��ʼ-----------------------------
           k = 0;
           tt=0;
           
           Screen('DrawText',wPtr,' ')  %����1s
           Screen('Flip',wPtr)
           pause(2);
           
           Mywords(wPtr,'+')  %ע�ӵ�1s
           pause(1);
           
           %Mywords(wPtr,['ˮƽ�����ٶ�Ϊ��' num2str(onemove(i,1)) '\n\n ��ֱ�����ٶ�Ϊ:' num2str(onemove(i,2))],30)
           %pause(2)
           
           % fwrite(COM4,mark1);
           % Ŀ��ͼ�γ���
           Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
           Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
           Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
           Screen('Flip',wPtr)
           pause(1);
           
           % fwrite(COM4,mark2);
           starttime = GetSecs;  % ��ȡtrial��ʼ��ʱ��
           %��ʼ����ˢ����¼�켣
           while 1
               [kb,secs,kc] = KbCheck;
               if kb && kc(mleft) && kc(mup)%��������Ϊ��0,0��
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
               trace(k,1) = (rx1+rx2)/2; % xposԲ���߹���x����
               trace(k,2) = (ry1+ry2)/2; % yposԲ���߹���y����
               trace(k,3) = Nowtime-starttime; % time
               if k>1
                   if (trace(k-1,1)==trace(k,1))&&(trace(k-1,2)==trace(k,2))%x�᲻�䣬y�᲻��
                       tt=tt+0;
                   else
                       tt=tt+1;%�ӵ�һ�и�д��tt��ʼֵΪ0
                       trace_xy(tt+1,1) = rx1;
                       trace_xy(tt+1,2) = ry1;
                       trace_xy(tt+1,3) = rx2;
                       trace_xy(tt+1,4) = ry2;
                   end
               end
               
               rect_xy = trace_xy';%�����ת��
               Screen('DrawLine',wPtr,[255,0,0],PointList(1,1),PointList(1,2),PointList(2,1),PointList(2,2),2)
               Screen('DrawLine',wPtr,[255,0,0],PointList(2,1),PointList(2,2),PointList(3,1),PointList(3,2),2)
               Screen('DrawLine',wPtr,[255,0,0],PointList(3,1),PointList(3,2),PointList(4,1),PointList(4,2),2)
               Screen('FrameOval',wPtr,[0,0,0],[(endpoint(1,1)-5);(endpoint(1,2)-5);(endpoint(1,1)+5);(endpoint(1,2)+5)],2)%�յ�λ�õ���Բ
               Screen('FrameOval',wPtr,[255,0,0],[(VertexList(1,1)-5);(VertexList(1,2)-5);(VertexList(1,1)+5);(VertexList(1,2)+5)],2)%���λ�õ���Բ
               Screen('FillOval',wPtr,[0,0,255],rect_xy,4)%�����켣��
               Screen('Flip',wPtr)
               
               
               if kb&&kc(endmove)%�������Ұ�����return
                   conditions(trialnum,1).movingtime = trace(k,3);
                   break
               end
               
               mtoabegin = ((trace(k,1)-VertexList(1,1))^2 + (trace(k,2)-VertexList(1,2))^2)^(1/2);%ÿһ�ΰ�������λ�ú�ԭʼλ�õ�ֱ�߾���
               mtoaend =((trace(k,1)-endpoint(1,1))^2 + (trace(k,2)-endpoint(1,2))^2)^(1/2);%ÿһ�ΰ�������λ�ú��յ�λ�õ�ֱ�߾���
               %if (trace(k,1)>15)&&(mtoaend <=8)%15�뻹ͣ����8�������ڵ�λ��(�ص�ԭ�㣩
               if mtoaend <=8  %   ͣ����8�������ڵ�λ��
                   conditions(trialnum,1).movingtime = trace(k,3);%��¼������Ϸʱ��
                   break
               end
               
               if trace(k,3)>60 %��ʱ
                   Screen('DrawText',wPtr,' ')
                   [AREA] = areayforfour(AllStimulus,trace,shapetype,begin_pos);
                   break
               end
           end
           %                     fwrite(COM4,mark3);
           [AREA] = areayforfour(AllStimulus,trace,shapetype,begin_pos); %����ÿ��ֱ�ߵ�ƫ�����
           area_more = AREA(6); %��ƫ�����
           x_speed = AREA(4); %xƫ��
           y_speed = AREA(5); %yƫ��
           punish = 0;
           conditions(trialnum,1).move = onemove(i,:) ;%д��ͷ����
           if area_more > 8 %���óͷ�ƫ�����
               Screen('DrawText',wPtr,' ')
               punish = 1;
               finish_pun = 1;
               if subinfo{2} == '1' %�жϳͷ�����
                   if x_speed >= y_speed
                       Mywords(wPtr,double('���ƫ�����\n\n�븺�����ҵ��˽��ܳͷ�'),30) %��ʾ�ͷ�����
                       %                         fprintf(COM_ice,'a0005z');
                       %                         while finish_pun == 1
                       %                             finish_pun = fread(COM_ice,1);
                       %                         end
                       pause(5)
                   else
                       Mywords(wPtr,double('���ƫ�����\n\n�븺�����µ��˽��ܳͷ�'),30) %��ʾ�ͷ�����
                       %                         fprintf(COM_ice,'a0500z');
                       %                         while finish_pun == 1
                       %                             finish_pun = fread(COM_ice,1);
                       %                         end
                       pause(5)
                   end
               else
                   Mywords(wPtr,double('���ƫ�����\n\n�빲ͬ���ܳͷ�'),30) %��ʾ�ͷ�����
                   %                     fprintf(COM_ice,'a0505z');
                   %                     while finish_pun == 1
                   %                         finish_pun = fread(COM_ice,1);
                   %                     end
                   pause(5)
               end
           end
           conditions(trialnum,1).punish = punish ;%д��ͷ����
           conditions(trialnum,1).x_speed = x_speed ;%д��x,�����ٶ�
           conditions(trialnum,1).y_speed = y_speed ;%д��y,�����ٶ�
           conditions(trialnum,1).area_more = area_more ;%д��ƫ�����
           conditions(trialnum,1).punish_way = punish_way;%�ͷ���ʽ
           
           
           save([['.\Sub' num2str(subinfo{1}) '\'],['coordination_all_trace' num2str(trialnum) '_shapetype' num2str(shapetype) '.mat']],'trace')
           save([['.\Sub' num2str(subinfo{1}) '\'],['coordination_selected_trace' num2str(trialnum) '_shapetype' num2str(shapetype) '.mat']],'trace_xy')
           
       end

    columnheader = {'sub','trial','shapetype','begin_pos','move','punish','x_speed','y_speed','area_more','punish_way','movingtime'};
    conditions = orderfields(conditions,columnheader);
    ret = [columnheader;struct2cell(conditions)'];
    %xlswrite([['.\Sub' num2str(subinfo{1}) '\'],['Sub' char(subinfo{1}) '.xls']],ret);
    save([['.\Result' '\'],['Sub' char(subinfo{1}) '.mat']],'ret');
    save([['.\Sub' num2str(subinfo{1}) '\'],['Subconditions' char(subinfo{1}) '.mat']],'conditions');
            
    %% ʵ�����
    Mywords(wPtr,'ʵ�������')
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

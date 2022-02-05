%--------------Dec.13,2020,YuYunhan-----------------------
function varargout = word_produce(varargin)
% WORD_PRODUCE MATLAB code for word_produce.fig
%      WORD_PRODUCE, by itself, creates a new WORD_PRODUCE or raises the existing
%      singleton*.
%
%      H = WORD_PRODUCE returns the handle to a new WORD_PRODUCE or the handle to
%      the existing singleton*.
%
%      WORD_PRODUCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WORD_PRODUCE.M with the given input arguments.
%
%      WORD_PRODUCE('Property','Value',...) creates a new WORD_PRODUCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before word_produce_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to word_produce_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help word_produce

% Last Modified by GUIDE v2.5 17-Dec-2020 16:14:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @word_produce_OpeningFcn, ...
                   'gui_OutputFcn',  @word_produce_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before word_produce is made visible.
function word_produce_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to word_produce (see VARARGIN)

% Choose default command line output for word_produce
handles.output = hObject;

handles.free_hint_word = {
    '龙虾'	'台球'	'民谣'	'账单'	'恒星'	'刑罚'	'舅妈'	'绵羊'    '黄油'	'举重'	'长笛'	'支票'	'星座'	'牢狱'	'哥们'	'河马'    '麦片'	'田径'	'乐团'	'证券'	'火星'	'拘留'	'同居'	'鸵鸟'    '果冻'	'球场'	'口琴'	'美金'	'银河'	'非法'	'好友'	'骆驼'
    }; %自由联想提示词
handles.meta_hint_word = {
    '风度'	'信用'	'温室'	'情人节'	'赌博'	'季节'	'亲吻'	'财富'	'泥土'
    }; %隐喻提示词
handles.AUT_hint_word = {'罐头'   '砖'};
% Update handles structure
guidata(hObject, handles);




% UIWAIT makes word_produce wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = word_produce_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function ans_word_Callback(hObject, eventdata, handles)
% hObject    handle to ans_word (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ans_word as text
%        str2double(get(hObject,'String')) returns contents of ans_word as a double


% --- Executes during object creation, after setting all properties.
function ans_word_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ans_word (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in next_button.
function next_button_Callback(hObject, eventdata, handles)
% hObject    handle to next_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if toc < handles.trial_time
    ans_word_get = get(handles.ans_word,'String');
    handles.subdata(handles.word_num).word = cellstr(get(handles.word_show,'String'));
    handles.subdata(handles.word_num).ans(handles.trial_num).trial = cellstr(ans_word_get);
    handles.subdata(handles.word_num).ans(handles.trial_num).RT = toc;
    disp(ans_word_get)
    set(handles.ans_word,'String','')
    handles.trial_num = handles.trial_num + 1;
    guidata(hObject, handles);
else
    if handles.word_num < handles.trial
        ans_word_get = get(handles.ans_word,'String');
        handles.subdata(handles.word_num).word = cellstr(get(handles.word_show,'String'));
        handles.subdata(handles.word_num).ans(handles.trial_num).trial = cellstr(ans_word_get);
        handles.subdata(handles.word_num).ans(handles.trial_num).RT = toc;
        tic
        hint_word_num = handles.trial_order(1);
        hint_word = handles.hint_word(hint_word_num);
        set(handles.word_show,'String',hint_word)
        handles.trial_order(1) = [];
        set(handles.ans_word,'String','')
        set(handles.disptime,'String','')
        handles.trial_num = 1;
        handles.word_num = handles.word_num + 1;
        guidata(hObject, handles);
        disp('下一个词')
        disp(ans_word_get)
        pause(handles.trial_time)
        set(handles.disptime,'String','时间到了')
    else
        set(handles.disptime,'String','实验结束！谢谢！')
        ans_word_get = get(handles.ans_word,'String');
        handles.subdata(handles.word_num).word = cellstr(get(handles.word_show,'String'));
        handles.subdata(handles.word_num).ans(handles.trial_num).trial = cellstr(ans_word_get);
        handles.subdata(handles.word_num).ans(handles.trial_num).RT = toc;
        disp(ans_word_get)
        data = handles.subdata;
        save(handles.subnum,'data')
    end
end



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over guide_word.
function guide_word_Callback(hObject, eventdata, handles)
% hObject    handle to guide_word (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.subnum = {}; %被试编号
type = get(handles.type_choose,'Value');
if type == 1 %自由联想
    handles.hint_word = handles.free_hint_word;
    handles.trial_time = 60; %每个试次时间
    handles.subnum = ['Sub',get(handles.sub_num,'String'),'free','.mat'];
elseif type == 2 %隐喻
    handles.hint_word = handles.meta_hint_word;
    handles.trial_time = 120; %每个试次时间
    handles.subnum = ['Sub',get(handles.sub_num,'String'),'meta','.mat'];
    set(handles.Exp_type,'String','是')
elseif type == 3 %AUT
    handles.hint_word = handles.AUT_hint_word;
    handles.trial_time = 120;
    handles.subnum = ['Sub',get(handles.sub_num,'String'),'AUT','.mat'];
    set(handles.Exp_type,'String','可以用来')
end
handles.trial = length(handles.hint_word); %提示词数
handles.trial_num = 1; %每个词已进行试次数
handles.word_num = 1; %已完成提示词数量
handles.trial_order = randperm(handles.trial,handles.trial) %随机提示词顺序
handles.subdata = struct('word',cell(handles.trial,1),'ans',struct('trial',[],'RT',[]));
set(hObject,'Visible','off')
set(handles.type_choose,'Visible','off')
tic
hint_word_num = handles.trial_order(1);
hint_word = handles.hint_word(hint_word_num);
set(handles.word_show,'String',hint_word)
handles.trial_order(1) = [];
set(handles.sub_num,'Visible','off')
set(handles.text5,'Visible','off')
guidata(hObject, handles)
pause(handles.trial_time)
set(handles.disptime,'String','时间到了')



function sub_num_Callback(hObject, eventdata, handles)
% hObject    handle to sub_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sub_num as text
%        str2double(get(hObject,'String')) returns contents of sub_num as a double


% --- Executes during object creation, after setting all properties.
function sub_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sub_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in type_choose.
function type_choose_Callback(hObject, eventdata, handles)
% hObject    handle to type_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns type_choose contents as cell array
%        contents{get(hObject,'Value')} returns selected item from type_choose


% --- Executes during object creation, after setting all properties.
function type_choose_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

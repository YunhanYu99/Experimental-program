function subinfo=getSubInfo()
%getSubInfo.m
%2016-4-7
%jane.xjcheng@gmail.com
prompt = {'���Ա��','�ͷ�����[1=���˳ͷ�,2=˫�˳ͷ�]'};
dlg_title = '������Ϣ';
num_lines = 1;
defautanswer = {'1','1'};
subinfo = inputdlg(prompt,dlg_title,num_lines,defautanswer);
end

function subinfo=getSubInfo()
%getSubInfo.m
%2016-4-7
%jane.xjcheng@gmail.com
prompt = {'被试编号','惩罚类型[1=个人惩罚,2=双人惩罚]'};
dlg_title = '被试信息';
num_lines = 1;
defautanswer = {'1','1'};
subinfo = inputdlg(prompt,dlg_title,num_lines,defautanswer);
end

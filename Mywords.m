function Mywords(wPtr,something,size,waitornot,color)

if nargin<3
    size=Screen('TextSize',wPtr);
    waitornot=0;
    color=0;
elseif nargin<4
    waitornot=0;
    color=0;
elseif nargin<5
    color=0;
end

Screen('TextSize',wPtr,size)
oldtxtcolor=Screen('TextColor',wPtr);
%DrawFormattedText(wPtr,something,'center','center',color);
DrawFormattedText(wPtr,double(something),'center','center',color);
Screen('Flip',wPtr);
Screen('TextColor',wPtr,oldtxtcolor);
while KbCheck;end
if waitornot
	KbWait;
end
end
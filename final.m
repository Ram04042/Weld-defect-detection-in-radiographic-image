function varargout = final(varargin)
% FINAL MATLAB code for final.fig
%      FINAL, by itself, creates a new FINAL or raises the existing
%      singleton*.
%
%      H = FINAL returns the handle to a new FINAL or the handle to
%      the existing singleton*.
%
%      FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL.M with the given input arguments.
%
%      FINAL('Property','Value',...) creates a new FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help final

% Last Modified by GUIDE v2.5 08-Jan-2019 14:52:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @final_OpeningFcn, ...
                   'gui_OutputFcn',  @final_OutputFcn, ...
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


% --- Executes just before final is made visible.
function final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to final (see VARARGIN)

% Choose default command line output for final
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = final_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [filename, pathname] = uigetfile('*.jpg', 'Pick a MATLAB code file');
 image=strcat(pathname,filename);
 
 a=imread(image);
 
 handles.og=a;
 a=rgb2gray(a);
 
 handles.cursor=0;
 handles.tophat=20;
 handles.cursor=handles.cursor+1;
 handles.imagelist{handles.cursor}=a;
 handles.end=handles.cursor;
 handles.end;
 axes(handles.axes1);
 imshow(a);
 handles.a=a;
 guidata(hObject,handles);
 
 


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;

b=get(hObject,'Value');
c=imadd(a,b);
axes(handles.axes1);
imshow(c);
handles.bright=c;
guidata(hObject,handles);



% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d=get(hObject,'Value');
a=handles.a;
[row col]=size(a);

LT=128-d;
UT=128+d;

for x=1:1:row
    for y=1:1:col
        if a(x,y)<=LT
           b(x,y)=1*a(x,y);
        else if a(x,y)<=UT
           b(x,y)=2*(a(x,y)-LT)+1*LT;
        else b(x,y)=1*(a(x,y)-UT)+1*LT+2*(UT-LT);
            end  
        end
    end
end

axes(handles.axes1);
imshow(b);
handles.contrast=b;
guidata(hObject,handles);




% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in histogram.
function histogram_Callback(hObject, eventdata, handles)
% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
[row col]=size(a);

for x=1:row
    for y=1:col
        if a(x,y)==0
            a(x,y)=1;
        end
    end
end

h=zeros(1,300);

for x=1:row
    for y=1:col
        t=a(x,y);
        h(t)=h(t)+1;
    end
end
T=0;
for i=1:255
    T=T+h(i);
end

sum=0;
c=zeros(1,300);
for g=1:255
    p(g)=h(g)/T;
    sum=sum+p(g);
    if(g==1)
        c(g)=p(g);
    else
        c(g)=c(g-1)+p(g);
    end
    
    l(g)=255*c(g);
    l(g)=round(l(g));
end

b=a;
for x=1:row
    for y=1:col
        t=a(x,y);
        b(x,y)=l(t);
    end
end


axes(handles.axes1);
imshow(uint8(b));
handles.a=b;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;

guidata(hObject,handles);







% --- Executes on button press in Negative.
function Negative_Callback(hObject, eventdata, handles)
% hObject    handle to Negative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
b=a;
[row col]=size(a);

for x=1:1:row
    for y=1:1:col
        b(x,y)=255-a(x,y);
    end
end
axes(handles.axes1);
imshow(b);
handles.a=b;
handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);


% --- Executes on button press in Highpassfilter.
function Highpassfilter_Callback(hObject, eventdata, handles)
% hObject    handle to Highpassfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
a=double(a);
b=a;
[row col]=size(a);

w=[-1 -1 -1; -1 8 -1; -1 -1 -1]; 
for x=2:row-1
    for y=2:col-1
        b(x,y)=w(1,1)*a(x-1,y+1) + w(1,2)*a(x,y+1) + w(1,3)*a(x+1,y+1) + w(2,1)*a(x-1,y) + w(2,2)*a(x,y) + w(2,3)*a(x+1,y) + w(3,1)*a(x-1,y-1) + w(3,2)*a(x,y-1) + w(3,3)*a(x+1,y-1);
    end
end
axes(handles.axes1);
imshow(uint8(b));
handles.a=b;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);



% --- Executes on button press in inoiseremoval.
function inoiseremoval_Callback(hObject, eventdata, handles)
% hObject    handle to inoiseremoval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
immed=medfilt2(a,[7 7]);
axes(handles.axes1);
imshow(immed);
handles.a=immed;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);




% --- Executes on button press in gaussiannoiseremoval.
function gaussiannoiseremoval_Callback(hObject, eventdata, handles)
% hObject    handle to gaussiannoiseremoval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
f=fspecial('gaussian',[3 3],0.9);
imnrem=imfilter(a,f);
axes(handles.axes1);
imshow(imnrem);
handles.a=imnrem;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);


% --- Executes on button press in edgedetection.
function edgedetection_Callback(hObject, eventdata, handles)
% hObject    handle to edgedetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
ecanny=edge(a,'canny');
axes(handles.axes1);
imshow(ecanny);
handles.a=ecanny;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);




% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function thresholdslider_Callback(hObject, eventdata, handles)
% hObject    handle to thresholdslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;

[row col]=size(a);
p=a;
T=get(hObject,'Value');
for i=1:1:row
    for j=1:1:col
        if (p(i,j)<T)
            a(i,j)=0;
        else
            a(i,j)=255;
        end
    end
end
axes(handles.axes1);
imshow(uint8(a));
handles.thres=a;;
guidata(hObject,handles);


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function thresholdslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresholdslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in brightsave.
function brightsave_Callback(hObject, eventdata, handles)
% hObject    handle to brightsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.a=handles.bright;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);


% --- Executes on button press in contrastsave.
function contrastsave_Callback(hObject, eventdata, handles)
% hObject    handle to contrastsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.a=handles.contrast;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);



% --- Executes on button press in thresholdsave.
function thresholdsave_Callback(hObject, eventdata, handles)
% hObject    handle to thresholdsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.a=handles.thres;
handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);


% --- Executes on button press in tophat.
function tophat_Callback(hObject, eventdata, handles)
% hObject    handle to tophat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;


val=handles.tophat;
b=imtophat(a, strel('disk',val ));

c=imadjust(b);
axes(handles.axes1);
imshow(c);
handles.a=c;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);


% --- Executes on button press in defthres.
function defthres_Callback(hObject, eventdata, handles)
% hObject    handle to defthres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
level=graythresh(a);
bw=im2bw(a,level);
axes(handles.axes1);
imshow(bw);
handles.a=bw;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);


% --- Executes on button press in watershed.
function watershed_Callback(hObject, eventdata, handles)
% hObject    handle to watershed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
c=imadjust(a);


level=graythresh(c);
bw=im2bw(c,level);



c=~bw;

d=-bwdist(c);

d(c)=-Inf;
l=watershed(d);

wi=label2rgb(l,'hot','w');

axes(handles.axes1);
imshow(wi);
handles.a=wi;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);


% --- Executes on button press in roi.
function roi_Callback(hObject, eventdata, handles)
% hObject    handle to roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
[r c]=ginput(4);
bw=roipoly(a,r,c);

[R C]=size(bw);

for i=1:R
    for j=1:C
        if(bw(i,j)==1)
            out(i,j)=a(i,j);
        else
            out(i,j)=0;
        end
    end
end
axes(handles.axes1);
imshow(out,[]);
handles.a=out;
handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=handles.a;

[filename, ext, user_canceled] = imputfile;
f=strcat(filename,'.',ext);
 
imwrite(uint8(a),f);



% --- Executes on button press in Outline.
function Outline_Callback(hObject, eventdata, handles)
% hObject    handle to Outline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
og=handles.og;
BWoutline = bwperim(a);
Segout = og;
Segout(BWoutline) = 575;

axes(handles.axes1);
imshow(Segout);
handles.a=Segout;

handles.cursor=handles.cursor+1;
handles.imagelist{handles.cursor}=handles.a;
handles.end=handles.cursor;
guidata(hObject,handles);


% --- Executes on button press in undo.
function undo_Callback(hObject, eventdata, handles)
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.cursor=handles.cursor-1;
image=handles.imagelist{handles.cursor};
axes(handles.axes1);
imshow(image);
handles.a=image;
guidata(hObject,handles);

% --- Executes on button press in redo.
function redo_Callback(hObject, eventdata, handles)
% hObject    handle to redo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if(handles.cursor<handles.end)
    handles.cursor=handles.cursor+1;
    image=handles.imagelist{handles.cursor};
    axes(handles.axes1);
    imshow(image);
    handles.a=image;
    guidata(hObject,handles);
end



% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
d=get(hObject,'Value');
a=handles.a;
b=imtophat(a, strel('disk', d));

c=imadjust(b);
axes(handles.axes1);
imshow(c);
handles.a=c;
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.tophat=str2double(get(hObject,'String'));
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in feature.
function feature_Callback(hObject, eventdata, handles)
% hObject    handle to feature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=handles.a;
r=bwconncomp(a,8);
handles.n=r.NumObjects;
handles.n
handles.area=zeros(handles.n,1);
handles.perimeter=zeros(handles.n,1);
handles.Majoraxis=zeros(handles.n,1);
handles.Minoraxis=zeros(handles.n,1);

k=regionprops(r,'Area','Perimeter','MajorAxisLength','MinorAxisLength');
for i= 1:handles.n
    handles.area(i)=k(i).Area;
    handles.perimeter(i)=k(i).Perimeter;
    handles.Majoraxis(i)=k(i).MajorAxisLength;
    handles.Minoraxis(i)=k(i).MinorAxisLength;
end

handles.area
handles.perimeter
handles.Majoraxis
handles.Minoraxis

guidata(hObject,handles);
%w=regionprops

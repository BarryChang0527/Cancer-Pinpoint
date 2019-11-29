function varargout = App(varargin)
% APP MATLAB code for App.fig
%      APP, by itself, creates a new APP or raises the existing
%      singleton*.
%
%      H = APP returns the handle to a new APP or the handle to
%      the existing singleton*.
%
%      APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APP.M with the given input arguments.
%
%      APP('Property','Value',...) creates a new APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before App_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to App_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help App

% Last Modified by GUIDE v2.5 28-Jul-2017 09:54:01

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @App_OpeningFcn, ...
                   'gui_OutputFcn',  @App_OutputFcn, ...
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


% --- Executes just before App is made visible.
function App_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to App (see VARARGIN)

% Choose default command line output for App
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes App wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = App_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Picture_Callback(hObject, eventdata, handles)
% hObject    handle to Picture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Picture as text
%        str2double(get(hObject,'String')) returns contents of Picture as a double


% --- Executes during object creation, after setting all properties.
function Picture_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Picture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show.
function show_Callback(hObject, eventdata, handles)
%%This function is used to load the picture and plot the annotated coordinate.

% hObject    handle to show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num =str2num(get(handles.Picture,'String'));
guidata(hObject,handles);
ImagePath = [handles.PicFolderPath,num2str(num),'.png'];
csvMatrix=csvread(handles.CSVFilePath);

x=csvMatrix(num,1);
y=csvMatrix(num,2);
I = imread(ImagePath);
axes(handles.axes5);
imshow(I);
hold on;
plot(x,y,'r+','MarkerSize',5);
display = ['File Path: ', ImagePath];
title(display, 'interpreter','none')
hold off;

        
               
        
        
             
        
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
%%This function is used to load the next picture.

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
P=str2num(get(handles.Picture,'String'))+1;
set(handles.Picture,'String',P);
ImagePath = [handles.PicFolderPath,num2str(P),'.png'];
csvMatrix=csvread(handles.CSVFilePath);


x=csvMatrix(P,1);
y=csvMatrix(P,2);

I = imread(ImagePath);
axes(handles.axes5);
imshow(I);
hold on;
plot(x,y,'r+','MarkerSize',5);
display = ['File Path: ', ImagePath];
title(display, 'interpreter','none')
hold off;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
%%This function is used to load the last picture.

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
D=str2num(get(handles.Picture,'String'))-1;
set(handles.Picture,'String',D);
set(handles.Picture,'String',D);
ImagePath = [handles.PicFolderPath,num2str(D),'.png'];
csvMatrix=csvread(handles.CSVFilePath);

x=csvMatrix(D,1);
y=csvMatrix(D,2);

I = imread(ImagePath);
axes(handles.axes5);
imshow(I);
hold on;
plot(x,y,'r+','MarkerSize',5);
display = ['File Path: ', ImagePath];
title(display, 'interpreter','none')
hold off;


% --- Executes on button press in pushbuttonX.
function pushbuttonX_Callback(hObject, eventdata, handles)
%%This function is used to plot all the annoatated x-coordinates of one
%%patient

% hObject    handle to pushbuttonX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
csvMatrix=csvread(handles.CSVFilePath);
x=csvMatrix(:,1);
y=csvMatrix(:,2);
axes(handles.axes5);
plot(x);
title(handles.CSVFilePath);

% --- Executes on button press in pushbuttonY.
function pushbuttonY_Callback(hObject, eventdata, handles)
%%This function is used to plot all the annoatated y-coordinates of one
%%patient

% hObject    handle to pushbuttonY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
csvMatrix=csvread(handles.CSVFilePath);
x=csvMatrix(:,1);
y=csvMatrix(:,2);
axes(handles.axes5);
plot(y);
title(handles.CSVFilePath);


% --- Executes on button press in pushbuttonMark.
function pushbuttonMark_Callback(hObject, eventdata, handles)
%%This function is used to mark and save the coordinates as well as show
%%the marked coordinates in the edit texts.

% hObject    handle to pushbuttonMark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Z=ginput(1);
x1=Z(1,1);
y1=Z(1,2);

set(handles.X,'String',x1);
set(handles.Y,'String',y1);


N=str2num(get(handles.Picture,'string'));

csvMatrix=csvread(handles.CSVFilePath);
csvMatrix(N,1) = x1;
csvMatrix(N,2) = y1;

csvwrite(handles.CSVFilePath, csvMatrix);

ImagePath = [handles.PicFolderPath,num2str(N),'.png'];
csvMatrix=csvread(handles.CSVFilePath);

x=csvMatrix(N,1);
y=csvMatrix(N,2);
I = imread(ImagePath);
axes(handles.axes5)
imshow(I);
hold on;
plot(x,y,'r+','MarkerSize',5);
display = ['File Path: ', ImagePath];
title(display, 'interpreter','none')
hold off;

yr_half = 40;
xr_half = 40;
xcent(1) = round(x);
ycent(1) = round(y);
im1 = double(I);

%im_roi = im(ycent(1)-yr_half:ycent(1)+yr_half,xcent(1)-xr_half:xcent(1)+xr_half);
im_nt = im1(ycent(1)-yr_half:ycent(1)+yr_half,xcent(1)-xr_half:xcent(1)+xr_half);
%imshow(im_nt), caxis auto;
im_roi=handles.im_roi;
C = template_matching2(im_roi,im_nt);
K=num2str(C(xr_half,yr_half));
set(handles.edit4,'String',K);

function X_Callback(hObject, eventdata, handles)
% hObject    handle to X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X as text
%        str2double(get(hObject,'String')) returns contents of X as a double


% --- Executes during object creation, after setting all properties.
function X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_Callback(hObject, eventdata, handles)
% hObject    handle to Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y as text
%        str2double(get(hObject,'String')) returns contents of Y as a double


% --- Executes during object creation, after setting all properties.
function Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton9.

function pushbutton9_Callback(hObject, eventdata, handles)
%%This function is used to create a new .csv file.

num =str2num(get(handles.Picture,'String'));
[file, path] = uiputfile('*.csv');
name = fullfile(path,file);

emptyMatrix = zeros(num,2);
csvwrite(name,emptyMatrix);

% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
%%This function is used to choose the file path as well as the image path.

%this function is to load csv first and then the pic to get the file path
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num =1;
[file,path, index]=uigetfile('*.csv');
handles.CSVFilePath = fullfile(path,file);

[file,path, index]=uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'mytitle',...
          'C:\Work\setpos1.png');
handles.PicFolderPath = path;

guidata(hObject,handles);
display = ['Pic Path: ', handles.PicFolderPath, '\n', 'CSV Path', handles.CSVFilePath];


% --- Executes on button press in button_template.
function button_template_Callback(hObject, eventdata, handles)
%%This function is used to select the template.
% hObject    handle to button_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yr_half = 40;
xr_half = 40;
D=str2num(get(handles.Picture,'String'));
ImagePath = [handles.PicFolderPath,num2str(D),'.png'];
[x,y] = ginput(1); % read in coordinates of POI
xcent(1) = round(x);
ycent(1) = round(y);
%I = imread(ImagePath);
im = double(imread(ImagePath));

%im1 = double(I);
im_roi = im(ycent(1)-yr_half:ycent(1)+yr_half,xcent(1)-xr_half:xcent(1)+xr_half);

handles.im_roi = im_roi;
guidata(hObject,handles);

axes(handles.axes4);
imshow(handles.im_roi), caxis auto;



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

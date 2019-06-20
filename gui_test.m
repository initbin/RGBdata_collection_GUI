%{
* ---------文件名：tlb_design.m
* ---------作者： init_bin
* ---------描述： 采集图像（舌头）上的RGB数据，存储到excel中
* ---------修改人： init_bin
* ---------修改时间：2019-6-18
* ---------修改内容：调整数据存储到excel的格式。加上文件名和规定存放顺序,并实现标记后图片的保存
 %}
function varargout = gui_test(varargin)
% GUI_TEST MATLAB code for gui_test.fig
%      GUI_TEST, by itself, creates a new GUI_TEST or raises the existing
%      singleton*.
%
%      H = GUI_TEST returns the handle to a new GUI_TEST or the handle to
%      the existing singleton*.
%
%      GUI_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TEST.M with the given input arguments.
%
%      GUI_TEST('Property','Value',...) creates a new GUI_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_test

% Last Modified by GUIDE v2.5 18-Jun-2019 15:00:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_test_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_test_OutputFcn, ...
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


% --- Executes just before gui_test is made visible.
function gui_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_test (see VARARGIN)

%set(hObject,'toolbar','figure') % 在菜单栏显示figure工具条的内容 
global img_src                 %打开图片的全局变量
global pointXY                 %存放点坐标的全局变量
pointXY=[];
global data_RGB              %存放每幅图像选取的所有点数据
data_RGB = [];
global i                            %计算每幅图像点的变量
i = 0;
global filename_copy       %拷贝一份文件名
first_row = {'Name','R1','G1','B1','R2','G2','B2','R3','G3','B3','R4','G4','B4','R5','G5','B5','R6','G6','B6',...
    'R7','G7','B7','R8','G8','B8','R9','G9','B9','R10','G10','B10','Rz','Gz','Bz'};    %第一行的存放数据
xlswrite('1.xls',first_row,1,'A1');                                                                 %存入第一行数据
% Choose default command line output for gui_test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_test wait for user response (see UIRESUME)
% uiwait(handles.figure_image);


% --- Outputs from this function are returned to the command line.
function varargout = gui_test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_file.
function open_file_Callback(hObject, eventdata, handles)
% hObject    handle to open_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_src
global filename_copy 
global data_RGB
[filename, pathname] = uigetfile({'*.bmp;*.jpg;*.png;*jpeg', 'Image Files(*.bmp,*.jpg,*.png,*jpeg)';...
    '*.*','All Files (*.*)'},'pick an image');            %打开一个对话框
set(handles.figure_name,'string',filename);    %给静态文本赋值，显示当前图片文件名
filename_copy = filename;                           %拷贝一份文件名
data_RGB = [filename];                                 %将文件名放在数据前，一起存入excel
if isequal(filename,0) || isequal(pathname,0)  %点击取消的响应
    return;
end
axes(handles.axes1);        %用axes命令设定当前操作的坐标轴是axes1
fpath = [pathname,filename];%将文件名和目录名组合成一个完整的路径
img_src = imread(fpath);    %用imread读入图片
imshow(img_src);            %imshow在axes1上显示


% --- Executes on button press in collect_RGB.
function collect_RGB_Callback(hObject, eventdata, handles)
% hObject    handle to collect_RGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global pointXY
% global img_src
% global data_RGB
% global i
% i = i + 1;    %点一次采集按钮 i加1
% r = img_src(pointXY(1),pointXY(2),1);            %取某一点坐标处的RGB数据
% g = img_src(pointXY(1),pointXY(2),2);
% b = img_src(pointXY(1),pointXY(2),3);
% RGB = [r g b];                                              %一个点的RGB数据
% %将数值阵列转换成异质阵列，为了和文件名字能一起存储到excel,不写不能正常储存。
% RGB_cell = num2cell(RGB);                   
% data_RGB = [data_RGB,RGB_cell];                 %将文件名和所有点数据放在一个矩阵  

% --- Executes on button press in finish_collect.
function finish_collect_Callback(hObject, eventdata, handles)
% hObject    handle to finish_collect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data_RGB
global filename_copy
global img_src
global i
path = 'F:\code\matlab\tlb_design\sign_save\';   %标记后图片的存放路径
name_path = strcat(path,filename_copy);          %路径加上名字
frame = getframe(gca);                                     %捕获坐标区图像作为影片帧
sign_image = frame2im(frame);                         %将捕获的影片帧转换为图像数据
imwrite(sign_image,name_path);                        %保存图像，这个会降低图像的分辨率
position = strfind(filename_copy,'-');                  %根据图片命名特点找到字符-的位置，为了提取前面的数字
fig_number = filename_copy(1:position-1);        %得到文件名的前几个数字，作为记录第几张图片
fig_number = str2num(fig_number);
xls_pos = strcat('A', num2str(fig_number+1));    %设定excel存放位置,加1是因为从第二行开始
if i == 10 || i == 11
    xlswrite('1.xls',data_RGB,1,xls_pos);                 %点击完成采集，那么一副图像的数据就存到excel中
    msgbox('数据存储完成！')                               %储存完毕后弹出对话框
    i = 0;                                                             %此时点计数清零
    data_RGB = [];                                               %存完以后，data_RGB数据清空，为下次数据从头开始存

else
    msgbox('采集信息未完成，请继续采集');
end
                                         

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure_image_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pointXY
%global hText
global circle
global img_src
global data_RGB
global i
axis on 
if strcmp(get(hObject,'SelectionType'),'normal')  %点击鼠标左键
    pt = get(gca,'CurrentPoint');           %这个得到就是当前鼠标点击的位置，以图片左上角为零点
    x = round(pt(1,1));
    y = round(pt(1,2));
    hold on                                         %保持在当前图像上操作，防止覆盖
    circle = plot(x,y,'bo','MarkerSize',3);  %在点击的地方，画出圆圈。
%     str = sprintf('x = %.3f, y = %.3f', x, y);
%     hText=text(x, y, str,'color',[1 0 0])
    pointXY=[x y];                                %存放当前的坐标
    i = i + 1;                                         %点一次按钮 i加1
    r = img_src(pointXY(1),pointXY(2),1);            %取某一点坐标处的RGB数据
    g = img_src(pointXY(1),pointXY(2),2);
    b = img_src(pointXY(1),pointXY(2),3);
    RGB = [r g b];                                              %一个点的RGB数据
    %将数值阵列转换成异质阵列，为了和文件名字能一起存储到excel,不写不能正常储存。
    RGB_cell = num2cell(RGB);                   
    data_RGB = [data_RGB,RGB_cell];                  %将文件名和所有点数据放在一个矩阵  
elseif strcmp(get(hObject,'SelectionType'),'alt')  %点击鼠标右键，消除刚点的那一点
    if ishandle(circle)
        delete(circle);                                            %删除圆圈
        pointXY(end,:)=[];                                     %删除记录的坐标
        data_RGB(end-2:end) = [];                        %删除刚采集的RGB值，即最后三个数据
    end
end

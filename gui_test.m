%{
* ---------�ļ�����tlb_design.m
* ---------���ߣ� init_bin
* ---------������ �ɼ�ͼ����ͷ���ϵ�RGB���ݣ��洢��excel��
* ---------�޸��ˣ� init_bin
* ---------�޸�ʱ�䣺2019-6-18
* ---------�޸����ݣ��������ݴ洢��excel�ĸ�ʽ�������ļ����͹涨���˳��,��ʵ�ֱ�Ǻ�ͼƬ�ı���
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

%set(hObject,'toolbar','figure') % �ڲ˵�����ʾfigure������������ 
global img_src                 %��ͼƬ��ȫ�ֱ���
global pointXY                 %��ŵ������ȫ�ֱ���
pointXY=[];
global data_RGB              %���ÿ��ͼ��ѡȡ�����е�����
data_RGB = [];
global i                            %����ÿ��ͼ���ı���
i = 0;
global filename_copy       %����һ���ļ���
first_row = {'Name','R1','G1','B1','R2','G2','B2','R3','G3','B3','R4','G4','B4','R5','G5','B5','R6','G6','B6',...
    'R7','G7','B7','R8','G8','B8','R9','G9','B9','R10','G10','B10','Rz','Gz','Bz'};    %��һ�еĴ������
xlswrite('1.xls',first_row,1,'A1');                                                                 %�����һ������
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
    '*.*','All Files (*.*)'},'pick an image');            %��һ���Ի���
set(handles.figure_name,'string',filename);    %����̬�ı���ֵ����ʾ��ǰͼƬ�ļ���
filename_copy = filename;                           %����һ���ļ���
data_RGB = [filename];                                 %���ļ�����������ǰ��һ�����excel
if isequal(filename,0) || isequal(pathname,0)  %���ȡ������Ӧ
    return;
end
axes(handles.axes1);        %��axes�����趨��ǰ��������������axes1
fpath = [pathname,filename];%���ļ�����Ŀ¼����ϳ�һ��������·��
img_src = imread(fpath);    %��imread����ͼƬ
imshow(img_src);            %imshow��axes1����ʾ


% --- Executes on button press in collect_RGB.
function collect_RGB_Callback(hObject, eventdata, handles)
% hObject    handle to collect_RGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global pointXY
% global img_src
% global data_RGB
% global i
% i = i + 1;    %��һ�βɼ���ť i��1
% r = img_src(pointXY(1),pointXY(2),1);            %ȡĳһ�����괦��RGB����
% g = img_src(pointXY(1),pointXY(2),2);
% b = img_src(pointXY(1),pointXY(2),3);
% RGB = [r g b];                                              %һ�����RGB����
% %����ֵ����ת�����������У�Ϊ�˺��ļ�������һ��洢��excel,��д�����������档
% RGB_cell = num2cell(RGB);                   
% data_RGB = [data_RGB,RGB_cell];                 %���ļ��������е����ݷ���һ������  

% --- Executes on button press in finish_collect.
function finish_collect_Callback(hObject, eventdata, handles)
% hObject    handle to finish_collect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data_RGB
global filename_copy
global img_src
global i
path = 'F:\code\matlab\tlb_design\sign_save\';   %��Ǻ�ͼƬ�Ĵ��·��
name_path = strcat(path,filename_copy);          %·����������
frame = getframe(gca);                                     %����������ͼ����ΪӰƬ֡
sign_image = frame2im(frame);                         %�������ӰƬ֡ת��Ϊͼ������
imwrite(sign_image,name_path);                        %����ͼ������ή��ͼ��ķֱ���
position = strfind(filename_copy,'-');                  %����ͼƬ�����ص��ҵ��ַ�-��λ�ã�Ϊ����ȡǰ�������
fig_number = filename_copy(1:position-1);        %�õ��ļ�����ǰ�������֣���Ϊ��¼�ڼ���ͼƬ
fig_number = str2num(fig_number);
xls_pos = strcat('A', num2str(fig_number+1));    %�趨excel���λ��,��1����Ϊ�ӵڶ��п�ʼ
if i == 10 || i == 11
    xlswrite('1.xls',data_RGB,1,xls_pos);                 %�����ɲɼ�����ôһ��ͼ������ݾʹ浽excel��
    msgbox('���ݴ洢��ɣ�')                               %������Ϻ󵯳��Ի���
    i = 0;                                                             %��ʱ���������
    data_RGB = [];                                               %�����Ժ�data_RGB������գ�Ϊ�´����ݴ�ͷ��ʼ��

else
    msgbox('�ɼ���Ϣδ��ɣ�������ɼ�');
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
if strcmp(get(hObject,'SelectionType'),'normal')  %���������
    pt = get(gca,'CurrentPoint');           %����õ����ǵ�ǰ�������λ�ã���ͼƬ���Ͻ�Ϊ���
    x = round(pt(1,1));
    y = round(pt(1,2));
    hold on                                         %�����ڵ�ǰͼ���ϲ�������ֹ����
    circle = plot(x,y,'bo','MarkerSize',3);  %�ڵ���ĵط�������ԲȦ��
%     str = sprintf('x = %.3f, y = %.3f', x, y);
%     hText=text(x, y, str,'color',[1 0 0])
    pointXY=[x y];                                %��ŵ�ǰ������
    i = i + 1;                                         %��һ�ΰ�ť i��1
    r = img_src(pointXY(1),pointXY(2),1);            %ȡĳһ�����괦��RGB����
    g = img_src(pointXY(1),pointXY(2),2);
    b = img_src(pointXY(1),pointXY(2),3);
    RGB = [r g b];                                              %һ�����RGB����
    %����ֵ����ת�����������У�Ϊ�˺��ļ�������һ��洢��excel,��д�����������档
    RGB_cell = num2cell(RGB);                   
    data_RGB = [data_RGB,RGB_cell];                  %���ļ��������е����ݷ���һ������  
elseif strcmp(get(hObject,'SelectionType'),'alt')  %�������Ҽ��������յ����һ��
    if ishandle(circle)
        delete(circle);                                            %ɾ��ԲȦ
        pointXY(end,:)=[];                                     %ɾ����¼������
        data_RGB(end-2:end) = [];                        %ɾ���ղɼ���RGBֵ���������������
    end
end

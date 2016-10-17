function varargout = Number_Plate_Reader(varargin)
clc;
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Number_Plate_Reader_OpeningFcn, ...
                   'gui_OutputFcn',  @Number_Plate_Reader_OutputFcn, ...
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

%-------------------------------------------------------

function Number_Plate_Reader_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

initialize_gui(hObject, handles, false);
%----------------------------------------------------------------
function varargout = Number_Plate_Reader_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
function initialize_gui(fig_handle, handles, isreset)
if isfield(handles, 'metricdata') && ~isreset
    return;
end
%-----------------------------------
guidata(handles.figure1, handles);


% -------------------------------------
    function[text1]= pushbutton10_Callback(hObject, eventdata, handles)
    [baseFileName,folder]=uigetfile('*.*','samples','on');
    fullimageFileName = fullfile(folder,baseFileName);
    axes1=imread(fullimageFileName);
    axes(handles.axes1);
    image(axes1)
    prompt={'Enter the number of charcters to read:'};
    dlg_title = 'Number of Characters in the image';
    num_lines = 1;
    def = {'0'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);
    no = str2num(answer{1});

    text1 = final(fullimageFileName,6);
    msgbox(text1,'Output');
 

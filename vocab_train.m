function varargout = vocab_train(varargin)
% VOCAB_TRAIN MATLAB code for vocab_train.fig
%      VOCAB_TRAIN, by itself, creates a new VOCAB_TRAIN or raises the existing
%      singleton*.
%
%      H = VOCAB_TRAIN returns the handle to a new VOCAB_TRAIN or the handle to
%      the existing singleton*.
%
%      VOCAB_TRAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOCAB_TRAIN.M with the given input arguments.
%
%      VOCAB_TRAIN('Property','Value',...) creates a new VOCAB_TRAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vocab_train_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vocab_train_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vocab_train

% Last Modified by GUIDE v2.5 13-Dec-2015 19:01:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vocab_train_OpeningFcn, ...
                   'gui_OutputFcn',  @vocab_train_OutputFcn, ...
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


% --- Executes just before vocab_train is made visible.
function vocab_train_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vocab_train (see VARARGIN)

% Choose default command line output for vocab_train
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vocab_train wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vocab_train_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in mode_hiragana_btn.
function mode_hiragana_btn_Callback(hObject, eventdata, handles)
% hObject    handle to mode_hiragana_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.mode = 'hiragana';
set(handles.mode_kanji_btn,'value',0);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in mode_kanji_btn.
function mode_kanji_btn_Callback(hObject, eventdata, handles)
% hObject    handle to mode_kanji_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.mode = 'kanji';
set(handles.mode_hiragana_btn,'value',0);

% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in vocab_browser.
function vocab_browser_Callback(hObject, eventdata, handles)
% hObject    handle to vocab_browser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns vocab_browser contents as cell array
%        contents{get(hObject,'Value')} returns selected item from vocab_browser


% --- Executes during object creation, after setting all properties.
function vocab_browser_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vocab_browser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ger_vocab_txt_Callback(hObject, eventdata, handles)
% hObject    handle to ger_vocab_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ger_vocab_txt as text
%        str2double(get(hObject,'String')) returns contents of ger_vocab_txt as a double


% --- Executes during object creation, after setting all properties.
function ger_vocab_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ger_vocab_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in next_vocab_btn.
function next_vocab_btn_Callback(hObject, eventdata, handles)
% hObject    handle to next_vocab_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function roma_vocab_text_Callback(hObject, eventdata, handles)
% hObject    handle to roma_vocab_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roma_vocab_text as text
%        str2double(get(hObject,'String')) returns contents of roma_vocab_text as a double


% --- Executes during object creation, after setting all properties.
function roma_vocab_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roma_vocab_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sym_vocab_text_Callback(hObject, eventdata, handles)
% hObject    handle to sym_vocab_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sym_vocab_text as text
%        str2double(get(hObject,'String')) returns contents of sym_vocab_text as a double


% --- Executes during object creation, after setting all properties.
function sym_vocab_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sym_vocab_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filename_input_txt_Callback(hObject, eventdata, handles)
% hObject    handle to filename_input_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_input_txt as text
%        str2double(get(hObject,'String')) returns contents of filename_input_txt as a double


% --- Executes during object creation, after setting all properties.
function filename_input_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_input_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_btn.
function load_btn_Callback(hObject, eventdata, handles)
% hObject    handle to load_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.mode_hiragana_btn,'value')
    VOCAB_FIELDNAME = 'vocab_hiragana';
elseif get(handles.mode_kanji_btn,'value')
    VOCAB_FIELDNAME = 'vocab_kanji';
else
    set(handles.load_status_info,'string','Specify mode first, please! (Hiragana / Kanji)');
    return
end

filepath = get(handles.filename_input_txt,'String');
if (exist(filepath, 'file') == 2 && any(regexp(filepath,'.mat$')))  %check if valid file path
    
    vars = whos('-file',filepath);
    if ismember(VOCAB_FIELDNAME, {vars.name})
        reset_GUI();
        handles.vocab = load(filepath, VOCAB_FIELDNAME);
        handles = fill_vocab_browser(handles);
        set(handles.load_status_info,'string','Load finished successfully!');
    else
        set(handles.load_status_info,'string',['File contains no field of name "', ...
            VOCAB_FIELDNAME, '", please choose a different file!']);
    end
    
else
    set(handles.load_status_info,'string','Load failed, please enter full .mat-file path!');
end

% Update handles structure
guidata(hObject, handles);

function reset_GUI()
% resets GUI elements before loading new file

% TODO

function handles = fill_vocab_browser(handles)
% fills vocabulary browser object with vocab data fieldnames
temp_names = fieldnames(handles.vocab);
vocab_list = fieldnames(handles.vocab.(temp_names{1}));

set(handles.vocab_browser,'string',vocab_list);

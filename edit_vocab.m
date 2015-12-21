function varargout = edit_vocab(varargin)
% EDIT_VOCAB MATLAB code for edit_vocab.fig
%      EDIT_VOCAB, by itself, creates a new EDIT_VOCAB or raises the existing
%      singleton*.
%
%      H = EDIT_VOCAB returns the handle to a new EDIT_VOCAB or the handle to
%      the existing singleton*.
%
%      EDIT_VOCAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDIT_VOCAB.M with the given input arguments.
%
%      EDIT_VOCAB('Property','Value',...) creates a new EDIT_VOCAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before edit_vocab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to edit_vocab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help edit_vocab

% Last Modified by GUIDE v2.5 21-Dec-2015 14:16:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @edit_vocab_OpeningFcn, ...
                   'gui_OutputFcn',  @edit_vocab_OutputFcn, ...
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


% --- Executes just before edit_vocab is made visible.
function edit_vocab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to edit_vocab (see VARARGIN)

% Choose default command line output for edit_vocab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

if(numel(varargin) < 1 || ~iscellstr(varargin))
    assert(false, 'No filepath specified!');
elseif(~(exist(varargin{1}, 'file') == 2 && any(regexp(varargin{1},'.mat$'))))
    assert(false, 'First input argument was no full path to .mat file!');
else
    handles.filepath = varargin{1};
end

if(numel(varargin) == 2)
    switch varargin{2}
        case 'hiragana'
            handles = set_hira_mode(handles);
        case 'kanji'
            set(handles.kanji_mode_btn,'value',1);
            kanji_mode_btn_Callback(handles.kanji_mode_btn,[],handles);
        otherwise
            assert(false,'No valid vocab mode specified as second input argument!');
    end
else
    disp('No vocab mode specified, choosing default: hiragana!');
    handles = set_hira_mode(handles);
end


% UIWAIT makes edit_vocab wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function handles = set_hira_mode(handles)

set(handles.hira_mode_btn,'value',1);
hira_mode_btn_Callback(handles.hira_mode_btn,[],handles);


function handles = load_vocab_data(mode, filepath, handles)
%loads vocabulary data for mode from vocab file

switch mode
    case 'hiragana'
        VOCAB_FIELDNAME = 'vocab_hiragana';
    case 'kanji'
        VOCAB_FIELDNAME = 'vocab_kanji';
    otherwise
        assert(false,'No mode specified before loading vocab data!');
end

vars = whos('-file',filepath);
if ismember(VOCAB_FIELDNAME, {vars.name})
    handles.vocab = load(filepath, VOCAB_FIELDNAME);
else
    assert(false,'Not yet implemented! File should contain field!');    %TODO: impl. create new file
end

handles = fill_set_browser(VOCAB_FIELDNAME, handles);



function handles = fill_set_browser(fieldname, handles)
%fills field names in set browser

vocab_sets = fieldnames(handles.vocab.(fieldname));
set(handles.vocab_set_list,'string',vocab_sets);

% --- Outputs from this function are returned to the command line.
function varargout = edit_vocab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in vocab_listbox.
function vocab_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to vocab_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns vocab_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from vocab_listbox


% --- Executes during object creation, after setting all properties.
function vocab_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vocab_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_btn.
function add_btn_Callback(hObject, eventdata, handles)
% hObject    handle to add_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in remove_btn.
function remove_btn_Callback(hObject, eventdata, handles)
% hObject    handle to remove_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in vocab_set_list.
function vocab_set_list_Callback(hObject, eventdata, handles)
% hObject    handle to vocab_set_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns vocab_set_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from vocab_set_list

contents = cellstr(get(hObject,'String'));
indices = get(hObject,'Value');

temp_names = fieldnames(handles.vocab);
vocab_str = [];
for it = 1:numel(indices)
    vocab_list = contents{indices(it)};
    vocab = handles.vocab.(temp_names{1}).(vocab_list);
    for i=1:numel(vocab(:,1))
        vocab_str = [vocab_str; {strjoin([vocab(i,1),{' : '},vocab(i,2)])}];
    end
end

set(handles.vocab_listbox,'string',cellstr(vocab_str));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function vocab_set_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vocab_set_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in hira_mode_btn.
function hira_mode_btn_Callback(hObject, eventdata, handles)
% hObject    handle to hira_mode_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hira_mode_btn

set(handles.kanji_mode_btn,'value',0);
handles.mode = 'hiragana';

handles = reset_GUI(handles);
handles = load_vocab_data('hiragana', handles.filepath, handles);

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in kanji_mode_btn.
function kanji_mode_btn_Callback(hObject, eventdata, handles)
% hObject    handle to kanji_mode_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of kanji_mode_btn

set(handles.hira_mode_btn,'value',0);
handles.mode = 'kanji';

handles = reset_GUI(handles);
handles = load_vocab_data('kanji', handles.filepath, handles);

% Update handles structure
guidata(hObject, handles);


function handles = reset_GUI(handles)
%resets all GUI elements after mode change

set(handles.ger_edit_txt,'enable','inactive','string','German',...
    'ForegroundColor',[0.5,0.5,0.5]);
set(handles.roma_edit_txt,'enable','inactive','string','Japanese (Romaji)',...
    'ForegroundColor',[0.5,0.5,0.5]);

set(handles.vocab_listbox,'String','No Vocabulary Set Chosen!');



function ger_edit_txt_Callback(hObject, eventdata, handles)
% hObject    handle to ger_edit_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ger_edit_txt as text
%        str2double(get(hObject,'String')) returns contents of ger_edit_txt as a double


% --- Executes during object creation, after setting all properties.
function ger_edit_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ger_edit_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roma_edit_txt_Callback(hObject, eventdata, handles)
% hObject    handle to roma_edit_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roma_edit_txt as text
%        str2double(get(hObject,'String')) returns contents of roma_edit_txt as a double


% --- Executes during object creation, after setting all properties.
function roma_edit_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roma_edit_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

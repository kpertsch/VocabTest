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

% Last Modified by GUIDE v2.5 18-Dec-2015 18:21:49

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

% Create look-up map for hiragana unicodes from prog_dat
lookup_table = load('prog_dat.mat', 'hiragana_unicode');

keySet={}; valueSet={};
for i=1:numel(lookup_table.hiragana_unicode(:,1))
    keySet = [keySet, lookup_table.hiragana_unicode(i,1)];
    valueSet = [valueSet, lookup_table.hiragana_unicode(i,2)];
end
handles.hira_unicode_map = containers.Map(keySet, valueSet);

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

contents = cellstr(get(hObject,'String'));
indices = get(hObject,'Value');

temp_names = fieldnames(handles.vocab);
vocab = [];
for it = 1:numel(indices)
    vocab_list = contents{indices(it)};
    vocab = [vocab; handles.vocab.(temp_names{1}).(vocab_list)];
end

% check for empty elements, TODO: create warning dialogue instead of assert
emptyCells = cellfun('isempty',vocab);
assert(~any(any(emptyCells)),'At least one element of vocabulary matrix is empty!');

handles.vocab_matrix = vocab;
handles = reset_train_panel(handles);
set(handles.next_vocab_btn,'Enable','on');

% Update handles structure
guidata(hObject, handles);


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

if ~handles.train_panel_prepared
    handles = prepare_train_panel(handles); 
end

switch(handles.train_mode)
    case 'next'
        handles.train_mode = 'solve';
        handles.current_vocab = get_next_vocab(handles);
        temp_cell = handles.current_vocab(1);
        set(handles.ger_vocab_txt,'String',temp_cell{1});
        set(handles.next_vocab_btn,'String','Solve!');
        
    case 'solve'
        handles.train_mode = 'next';
        temp_cell = handles.current_vocab(2);
        set(handles.roma_vocab_txt,'String',temp_cell{1});
        set(handles.next_vocab_btn,'String','Next!');
        handles = set_symbol(handles, temp_cell{1});
        handles.train_panel_prepared = false;
        
    otherwise
        assert(false, sprintf('Train mode "%s" was not specified!', handles.train_mode));
end

% Update handles structure
guidata(hObject, handles);
    

function roma_vocab_txt_Callback(hObject, eventdata, handles)
% hObject    handle to roma_vocab_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roma_vocab_txt as text
%        str2double(get(hObject,'String')) returns contents of roma_vocab_txt as a double


% --- Executes during object creation, after setting all properties.
function roma_vocab_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roma_vocab_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sym_vocab_txt_Callback(hObject, eventdata, handles)
% hObject    handle to sym_vocab_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sym_vocab_txt as text
%        str2double(get(hObject,'String')) returns contents of sym_vocab_txt as a double
%handles.sym_txt_obj = hObject;





% --- Executes during object creation, after setting all properties.
function sym_vocab_txt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sym_vocab_txt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% customize to make button look like textbox
jEdit = findjobj(hObject);
lineColor = java.awt.Color(0.7,0.7,0.7);
thickness = 1;  % pixels
roundedCorners = false;
newBorder = javax.swing.border.LineBorder(lineColor,thickness,roundedCorners);
jEdit.Border = newBorder;
jEdit.repaint;  % redraw the modified control


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

function handles = reset_train_panel(handles)
%erases train panel entries, sets btn string to 'Start!'

set(handles.next_vocab_btn,'String','Start!');
set(handles.next_vocab_btn,'Enable','off');

set(handles.ger_vocab_txt,'String','German');
set(handles.ger_vocab_txt,'ForegroundColor',[0.5,0.5,0.5]);
set(handles.ger_vocab_txt,'FontSize',8.0);

set(handles.roma_vocab_txt,'String','Japanese (Romaji)');
set(handles.roma_vocab_txt,'ForegroundColor',[0.5,0.5,0.5]);
set(handles.roma_vocab_txt,'FontSize',8.0);

set(handles.sym_vocab_txt,'String','Japanese (Symbols)');
set(handles.sym_vocab_txt,'ForegroundColor',[0.5,0.5,0.5]);
set(handles.sym_vocab_txt,'FontSize',8.0);

jh = findjobj(handles.sym_vocab_txt);
jh.setVerticalAlignment( javax.swing.SwingConstants.CENTER );
jh.repaint

handles.current_vocab = {};
handles.train_mode = '';
handles.train_panel_prepared = false;


function handles = prepare_train_panel(handles)
%empties text boxes and sets color to black

set(handles.ger_vocab_txt,'String','');
set(handles.ger_vocab_txt,'ForegroundColor',[0,0,0]);
set(handles.ger_vocab_txt,'FontSize',14.0);

set(handles.roma_vocab_txt,'String','');
set(handles.roma_vocab_txt,'ForegroundColor',[0,0,0]);
set(handles.roma_vocab_txt,'FontSize',14.0);

set(handles.sym_vocab_txt,'String','');
set(handles.sym_vocab_txt,'ForegroundColor',[0,0,0]);
set(handles.sym_vocab_txt,'FontSize',14.0);

jh = findjobj(handles.sym_vocab_txt);
jh.setVerticalAlignment( javax.swing.SwingConstants.BOTTOM );
jh.repaint

handles.current_vocab = {};
handles.train_mode = 'next';
handles.train_panel_prepared = true;


% --- Executes during object creation, after setting all properties.
function train_pan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to train_pan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.train_panel_prepared = false;
handles.train_mode = '';
handles.current_vocab = {};

% Update handles structure
guidata(hObject, handles);


function next_vocab = get_next_vocab(handles)
%randomly chooses vocab from vocab matrix

index = floor(rand * numel(handles.vocab_matrix(:,1))) + 1;
next_vocab = {handles.vocab_matrix(index,1), handles.vocab_matrix(index,2)};    %TODO add 3rd property

function handles = set_symbol(handles, vocab)
%sets symbol in symbol text box

switch handles.mode 
    case 'hiragana'
        unicode_str = str2hiragana(vocab{1}, handles);
        
    case 'kanji'
        unicode_str = str2kanji(vocab{1}, handles);
        
    otherwise
        assert(false,'GUI is in undefined mode!');
end

set(handles.sym_vocab_txt,'String',sprintf('<HTML><FONT SIZE=14>%s</HTML>', unicode_str));

function unicode_str = str2hiragana(vocab, handles)
%converts romaji string to hiragana unicode characters

lookup_map = handles.hira_unicode_map;

unicode_str=[];
while ~isempty(vocab)
    sub_str = vocab(1:(min(numel(vocab),4)));       % longest hiragana romaji snippet is 4 char long
    while(1)
       if isempty(sub_str)
          assert(false, sprintf('symbol not found while converting %s to hiragana unicode', handles.current_vocab));
       end
       
       if isKey(lookup_map, sub_str)
           unicode_str = [unicode_str, lookup_map(sub_str)];
           break;
       else
           sub_str = sub_str(1:(end-1));
       end
    end
    vocab = vocab((numel(sub_str)+1):end);
end


function unicode_str = str2kanji(vocab, handles)
%converts romaji string to kanji unicode characters via lookup-table


% --- Executes on button press in edit_vocab_file_btn.
function edit_vocab_file_btn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vocab_file_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filepath = get(handles.edit_vocab_filepath,'String');
if (exist(filepath, 'file') == 2 && any(regexp(filepath,'.mat$')))  %check if valid file path
    
    vars = whos('-file',filepath);
    if ismember('vocab_hiragana', {vars.name}) || ismember('vocab_kanji', {vars.name})
        set(handles.edit_status_info,'string','Start vocabulary editor GUI!');
        % TODO: write vocab editor GUI
    else
        set(handles.edit_status_info,'string',['File contains no field of name "vocab_hiragana"'...
            ' or "vocab_kanji", please choose a different file!']);
    end
    
else
    set(handles.edit_status_info,'string','Edit failed, please enter full .mat-file path!');
end

% Update handles structure
guidata(hObject, handles);


function edit_vocab_filepath_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vocab_filepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vocab_filepath as text
%        str2double(get(hObject,'String')) returns contents of edit_vocab_filepath as a double


% --- Executes during object creation, after setting all properties.
function edit_vocab_filepath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vocab_filepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

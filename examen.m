
function varargout = examen(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @examen_OpeningFcn, ...
                   'gui_OutputFcn',  @examen_OutputFcn, ...
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


% --- Executes just before examen is made visible.
function examen_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = examen_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function entradax_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function entradax_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function salidadeseada_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function salidadeseada_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbuttonagregar.
function pushbuttonagregar_Callback(hObject, eventdata, handles)
numneuronas=[];
funciones={};
prom={'Ingrese # de capas'};
titulocapas = 'Capas';
numerolineas=1;
predefinido = {'1'};
pregunta=inputdlg(prom,titulocapas,numerolineas,predefinido); %para guardar el valor ingresado en un arreglo
n=str2num(pregunta{1,1});
for m=1:n
prompt = {'Número de neuronas','FA: satlins o satlin'};
dlg_title = 'Entradas';
num_lines = 1; 
def = {'1','satlin'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
str1 = answer{1,1};
numneuronas(m)=str2num(str1);
str2=answer{2,1};
funciones{m}=str2;
end
%handles.pushbuttonagregar=numneuronas;
setappdata(handles.pushbuttonagregar,'numero',numneuronas);
setappdata(handles.pushbuttonagregar,'funciones',funciones);


function numneurona_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function numneurona_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupfuncion_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function popupfuncion_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonClasificar.
function pushbuttonClasificar_Callback(hObject, eventdata, handles)
%se guada la cadena de entrada
cadena=get(handles.entradax,'String');
entrada = strcat('[',cadena,']'); % concatenamos con los corchetes
ventrada = str2num(entrada); % transformamos el texto en numero y se cra la matriz
minimomaximo=minmax(ventrada);        %guardamos en a elvector con los valores mínimos y maximo de entrada
ventrada

entraday= get(handles.salidadeseada,'String');
entraday = strcat('[',entraday,']'); % concatenamos con los corchetes
ventraday = str2num(entraday);
ventraday
aprendizaje= get(handles.popupmenuentrenamiento,'Value');
switch aprendizaje
    case 1
        taprendizaje='trainrp';
    case 2
        taprendizaje='trainlm';
    case 3
        taprendizaje='trainr';
end

funciones=getappdata(handles.pushbuttonagregar,'funciones');
funciones
numero=getappdata(handles.pushbuttonagregar,'numero');
numero
minimomaximo
numero

if(isempty(ventrada)||isempty(ventraday)||isnumerictype(ventrada)||isnumerictype(ventraday))% para comprobar campos de entrada vacios
    helpdlg('Campos vacíos o inválidos, ingrese matriz');
    return;
end

if(isempty(funciones)||isempty(numero)) % si no se ha elegido capas asigna valores por defecto
    funciones={'satlins'};
    numero=[1];
end
net = newff(minimomaximo,numero,funciones,taprendizaje);

tamanio=size(ventrada);
tamanio(1)
net.IW{1,1}=rand(numero(1),tamanio(1));
net.b{1}=rand(numero(1),1);
net.IW{1}
net.b{1}

output=sim(net,ventrada)
plotpv (ventrada,ventraday); %grafica
plotpc(net.IW{1},net.b{1});
net = train (net,ventrada,ventraday)
net.IW{1}
net.b{1}
hold on;
output=sim(net,ventrada)
plotpv (ventrada,ventraday); %grafica
plotpc(net.IW{1},net.b{1});
%plot(ventrada,ventraday,ventrada,output,'x')

function pushbutton3_Callback(hObject, eventdata, handles)
clear
cla reset;
blanco=char(' ');
set(handles.Res,'String',blanco);

% --- Executes on selection change in popupmenuentrenamiento.
function popupmenuentrenamiento_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenuentrenamiento (see GCBO)

% --- Executes during object creation, after setting all properties.
function popupmenuentrenamiento_CreateFcn(hObject, eventdata, handles)
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
set(handles.salidadeseada,'string',' ');
set(handles.entradax,'string',' ');
clear
cla reset;
clear
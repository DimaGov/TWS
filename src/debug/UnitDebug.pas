unit UnitDebug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, BASS, ComCtrls, SAVP, ExtraUtils;

type
  TFormDebug = class(TForm)
    Panel3: TPanel;
    Label23: TLabel;
    Label_Speed: TLabel;
    Label_Track: TLabel;
    Label3: TLabel;
    Label15: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label_KM1: TLabel;
    Label_OP: TLabel;
    Label_Route: TLabel;
    Label_Loco: TLabel;
    Label_395: TLabel;
    Label_254: TLabel;
    Label8: TLabel;
    Label_Svetofor: TLabel;
    Label17: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label_Reversor: TLabel;
    Label_TrVstr: TLabel;
    Label_KlKLUB: TLabel;
    Label31: TLabel;
    Label_Acceleration: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label_FTP: TLabel;
    Label_BTP: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Label34: TLabel;
    Label_Fazan: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label18: TLabel;
    Label_Op_Deg: TLabel;
    Label26: TLabel;
    Label42: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label64: TLabel;
    Label74: TLabel;
    Label55: TLabel;
    Label61: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label127: TLabel;
    Panel2: TPanel;
    Label73: TLabel;
    Label45: TLabel;
    Label63: TLabel;
    Label_Freight: TLabel;
    Label13: TLabel;
    Label35: TLabel;
    Label24: TLabel;
    Label41: TLabel;
    Label39: TLabel;
    Label_BV: TLabel;
    Label9: TLabel;
    Label56: TLabel;
    Label44: TLabel;
    Label62: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label49: TLabel;
    Label48: TLabel;
    Label47: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label77: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label91: TLabel;
    Label92: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label128: TLabel;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label_TrackTail: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label12: TLabel;
    Label43: TLabel;
    Label46: TLabel;
    Label50: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    ListView1: TListView;
    btnStationsBorder: TButton;
    Memo1: TMemo;
    Label90: TLabel;
    Memo2: TMemo;
    Label93: TLabel;
    Memo3: TMemo;
    Label94: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure ListView1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure FormCreate(Sender: TObject);
    procedure btnStationsBorderClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDebug: TFormDebug;

implementation

uses UnitMain, SoundManager, UnitSoundRRS;

{$R *.dfm}

procedure AddNewLineToDebugger(Wname: String; Wariant: Variant; groupp: String);
var
   ListItem: TListItem;
   basicType: Integer;
   typeString: String;
begin
   With FormDebug do begin
      ListItem := ListView1.Items.Add;
      ListItem.Caption := IntToStr(ListView1.Items.Count);
      ListItem.SubItems.Add(Wname);

      basicType := VarType(Wariant) and VarTypeMask;

      case basicType of
         varEmpty     : typeString := 'Empty';
         varNull      : typeString := 'Null';
         varSmallInt  : typeString := 'SmallInt';
         varInteger   : typeString := 'Integer';
         varSingle    : typeString := 'Single';
         varDouble    : typeString := 'Double';
         varCurrency  : typeString := 'Currency';
         varDate      : typeString := 'Date';
         varOleStr    : typeString := 'OleStr';
         varDispatch  : typeString := 'Dispatch';
         varError     : typeString := 'Error';
         varBoolean   : typeString := 'Boolean';
         varVariant   : typeString := 'Variant';
         varUnknown   : typeString := 'Unknown';
         varByte      : typeString := 'Byte';
         varWord      : typeString := 'Word';
         varLongWord  : typeString := 'LongWord';
         varInt64     : typeString := 'Int64';
         varStrArg    : typeString := 'StrArg';
         varString    : typeString := 'String';
         varAny       : typeString := 'Any';
         varTypeMask  : typeString := 'TypeMask';
      end;

      ListItem.SubItems.Add(typeString);
      ListItem.SubItems.Add(groupp);
      ListItem.SubItems.Add(Wariant);
   end;
end;

procedure RefreshDebugger();
begin
	FormDebug.ListView1.Items.Clear();
	With FormMain do begin
           AddNewLineToDebugger('Скорость', Speed, 'ZDS переменная');
           AddNewLineToDebugger('Ускорение', Acceleretion, 'ZDS переменная');
           AddNewLineToDebugger('Трек головы', Track, 'ZDS переменная');
           AddNewLineToDebugger('Трек хвоста', TrackTail, 'ZDS переменная');
           AddNewLineToDebugger('Контроллер позиция [1-я секция]', KM_Pos_1, 'ZDS переменная');
           AddNewLineToDebugger('Контроллер позиция [2-я секция]', KM_Pos_2, 'ZDS переменная');
           AddNewLineToDebugger('Кран №395(394) положение', KM_395, 'ZDS переменная');
           AddNewLineToDebugger('Кран №254(локомотивный) положение', KM_294, 'ZDS переменная');
           AddNewLineToDebugger('Ослабление поля (шунты) позиция', KM_OP, 'ZDS переменная');
           AddNewLineToDebugger('Сцепка с составом', CoupleStat, 'ZDS переменная'); (*ID=10*)
           AddNewLineToDebugger('Показание АЛС', Svetofor, 'ZDS переменная');
           AddNewLineToDebugger('Ограничение скорости', OgrSpeed, 'ZDS переменная');
           AddNewLineToDebugger('Расстояние до светофора', SvetoforDist, 'ZDS переменная');
           AddNewLineToDebugger('Номер вида', Camera, 'ZDS переменная');
           AddNewLineToDebugger('Положение камеры в кабине', CameraX, 'ZDS переменная');
           AddNewLineToDebugger('Дождь', Rain, 'ZDS переменная');
           AddNewLineToDebugger('Проверка бдительности', VCheck, 'ZDS переменная');
           AddNewLineToDebugger('Клавиатура КЛУБ-у', KLUBOpen, 'ZDS переменная');
           AddNewLineToDebugger('Ток ТЭД', TEDAmperage, 'ZDS переменная');
           AddNewLineToDebugger('Ток ЭДТ', EDTAmperage, 'ZDS переменная'); (*ID=20*)
           AddNewLineToDebugger('ТЦ', BrakeCylinders, 'ZDS переменная');
           AddNewLineToDebugger('Трек встречного поезда', VstrTrack, 'ZDS переменная');
           AddNewLineToDebugger('Скорость встречного поезда', Vstr_Speed, 'ZDS переменная');
           AddNewLineToDebugger('Кол-во вагонов встречного поезда', WagNum_Vstr, 'ZDS переменная');
           AddNewLineToDebugger('Общая длина встречного поезда', Vstrecha_dlina, 'TWS переменная');
           AddNewLineToDebugger('Статус встречного поезда(из ОЗУ)', VstrechStatus, 'ZDS переменная');
           AddNewLineToDebugger('Статус встречного поезда', isVstrechDrive, 'TWS переменная');
           AddNewLineToDebugger('Длина нашего состава', ConsistLength, 'TWS переменная');
           AddNewLineToDebugger('Длина одного трека', TrackLength, 'TWS переменная');
           AddNewLineToDebugger('Боксование', Boks_Stat, 'ZDS переменная'); (*ID=30*)
           AddNewLineToDebugger('Вентилятор №1', Vent, 'ZDS переменная');
           AddNewLineToDebugger('Вентилятор №2', Vent2, 'ZDS переменная');
           AddNewLineToDebugger('Вентилятор №3', Vent3, 'ZDS переменная');
           AddNewLineToDebugger('Вентилятор №4', Vent4, 'ZDS переменная');
           AddNewLineToDebugger('Компрессора', Compressor, 'ZDS переменная');
           AddNewLineToDebugger('БВ(ГВ/Статус дизеля)', BV, 'ZDS переменная');
           AddNewLineToDebugger('Дизель №2', diesel2, 'ZDS переменная');
           AddNewLineToDebugger('ФР(Фазорасщепитель)', Fazan, 'ZDS переменная');
           AddNewLineToDebugger('Передний токоприёмник', FrontTP, 'ZDS переменная');
           AddNewLineToDebugger('Задний токоприёмник', BackTP, 'ZDS переменная'); (*ID=40*)
           AddNewLineToDebugger('Реверсор', ReversorPos, 'ZDS переменная');
           AddNewLineToDebugger('Стеклоочиститель', Stochist, 'ZDS переменная');
           AddNewLineToDebugger('Стеклоочиститель угол поворота', StochistDGR, 'ZDS переменная');
           AddNewLineToDebugger('Напряжение на эл-возе', Voltage, 'ZDS переменная');
           AddNewLineToDebugger('Статус реостатного торможения', Reostat, 'ZDS переменная');
           AddNewLineToDebugger('ЭПТ статус', EPT, 'ZDS переменная');
           AddNewLineToDebugger('Левые двери(МВПС)', LDOOR, 'ZDS переменная');
           AddNewLineToDebugger('Правые двери(МВПС)', RDOOR, 'ZDS переменная');
           AddNewLineToDebugger('Следующее ограничение скорости', NextOgrSpeed, 'ZDS переменная');
           AddNewLineToDebugger('РБ', RB, 'ZDS переменная'); (*ID=50*)
           AddNewLineToDebugger('РБС', RBS, 'ZDS переменная');
           AddNewLineToDebugger('Зарядка АБ №1', AB_ZB_1, 'ZDS переменная');
           AddNewLineToDebugger('Зарядка АБ №2', AB_ZB_2, 'ZDS переменная');
           AddNewLineToDebugger('Прожектора', Highlights, 'ZDS переменная');
           AddNewLineToDebugger('Перестук на станции', Highlights, 'TWS переменная');
           //AddNewLineToDebugger('Кол-во дорожек САВП', SAVPBaseObjectsCount, 'TWS переменная');
           AddNewLineToDebugger('Файл сценария', SceneryName, 'ZDS переменная');
           //AddNewLineToDebugger('Кол-во дорожек лок. ЭК сценария', scBaseInfoCount, 'TWS переменная');
           //AddNewLineToDebugger('УСАВП Enable', USAVPEnabled, 'TWS переменная');
           //AddNewLineToDebugger('SAVPE File Prefix', SAVPEFilePrefiks, 'TWS переменная');
           AddNewLineToDebugger('scSAVPOverrideRouteEK', scSAVPOverrideRouteEK, 'TWS переменная');
           AddNewLineToDebugger('headTrainEndOfTrain', HeadTrainEndOfTrain, 'TWS переменная');
           AddNewLineToDebugger('isConnectedMemory', isConnectedMemory, 'TWS переменная'); (*ID=60*)
           AddNewLineToDebugger('isGameOnPause', isGameOnPause, 'TWS переменная');
           AddNewLineToDebugger('Ордината', Ordinata, 'ZDS переменная');
           AddNewLineToDebugger('VentTDPitch', VentTDPitch, 'TWS переменная');
           AddNewLineToDebugger('VentTDVol', VentTDVol, 'TWS переменная');
           AddNewLineToDebugger('Ордината рассчёт', OrdinataEstimate, 'TWS переменная');
           AddNewLineToDebugger('Зона переезда', PereezdZone, 'TWS переменная');
           AddNewLineToDebugger('Переезд звонок громкость', ZvonokVolume, 'TWS переменная');
           AddNewLineToDebugger('Переезд звонок частота', ZvonokFreq, 'TWS переменная');
           AddNewLineToDebugger('VentSingleVolume', VentSingleVolume, 'TWS переменная');
           AddNewLineToDebugger('VentSingleVolumeIncrementer', VentSingleVolumeIncrementer, 'TWS переменная');
           AddNewLineToDebugger('VentPitch', VentPitch, 'TWS переменная');
           AddNewLineToDebugger('TEDVlm', TEDVlm, 'TWS переменная');
           AddNewLineToDebugger('TEDPitch', TEDPitch, 'TWS переменная');
           AddNewLineToDebugger('Speed_RRS', UnitSoundRRS.speed, 'RRS переменная');
           AddNewLineToDebugger('CameraManipulator', UnitSoundRRS.cameraManipulatorView, 'RRS переменная');
           AddNewLineToDebugger('ReduktorVolume', ReduktorVolume, 'TWS переменная');
           AddNewLineToDebugger('ReduktorPitch', ReduktorPitch, 'TWS переменная');
           AddNewLineToDebugger('GR', GR, 'ZDS переменная');
           AddNewLineToDebugger('TC', TC, 'ZDS переменная');
           AddNewLineToDebugger('TC2', Abs(TC - PrevTC)*400000, 'ZDS переменная');
           AddNewLineToDebugger('DNoisePitch', DNoisePitch, 'TWS переменная');
           AddNewLineToDebugger('DNoisePitchDest', DNoisePitchDest, 'TWS переменная');
           AddNewLineToDebugger('LocoWitchDNoisePitch', LocoWithDNoisePitch, 'TWS переменная');
           AddNewLineToDebugger('Камера в кабине?', isCameraInCabin, 'TWS переменная');
           AddNewLineToDebugger('TEDVlmDest', TEDVlmDest, 'TWS переменная');
           AddNewLineToDebugger('VR242', VR242, 'ZDS переменная');
           AddNewLineToDebugger('GRIncrementer', GRIncrementer, 'TWS переменная');
           AddNewLineToDebugger('Reductor Channel is Active', BASS_ChannelIsActive(ReduktorChannel_FX), 'TWS переменная');
           AddNewLineToDebugger('UnipulsFaktPos', CHS8__.UnipulsFaktPos, 'TWS переменная');
           AddNewLineToDebugger('UnipulsTargetPos', CHS8__.UnipulsTargetPos, 'TWS переменная');
           AddNewLineToDebugger('Unipuls_1 Channel is Active', BASS_ChannelIsActive(Unipuls_Channel[0]), 'TWS переменная');
           AddNewLineToDebugger('Unipuls_2 Channel is Active', BASS_ChannelIsActive(Unipuls_Channel[1]), 'TWS переменная');
           AddNewLineToDebugger('Unipuls2secWait', CHS8__.Unipuls2SecWait, 'TWS переменная');
           AddNewLineToDebugger('CHS4T Compressor GR Difference', CHS4T__.CompressorGRDifference, 'TWS переменная');
           AddNewLineToDebugger('CHS4KVR Compressor GR Difference', CHS4KVR__.CompressorGRDifference, 'TWS переменная');
           AddNewLineToDebugger('Vent [VU][FX] Channel Is Active', BASS_ChannelIsActive(Vent_Channel_FX), 'TWS переменная');
           AddNewLineToDebugger('CycleVent [VU][FX] Channel Is Active', BASS_ChannelIsActive(VentCycle_Channel_FX), 'TWS переменная');
           AddNewLineToDebugger('VentTD Remaind Time', GetChannelRemaindPlayTime2Sec(VentTD_Channel_FX), 'TWS переменная');
           AddNewLineToDebugger('Brake_scr VolumeDestination', Brake_scrDestVolume, 'TWS переменная');
           AddNewLineToDebugger('Brake_scr Volume Fact', Brake_scrVolume, 'TWS переменная');
           AddNewLineToDebugger('Brake_scr Volume Incrementer (%)', Brake_scrVolumeIncrementer, 'TWS переменная');
           AddNewLineToDebugger('Brake_slipp Volume', Brake_slipp_Volume, 'TWS переменная');
           AddNewLineToDebugger('Пакетник БВ/ГВ (Управление) на ЧС-ах', BV_Paketnik, 'TWS переменная');
           AddNewLineToDebugger('CompoundPercent', CompoundPercent, 'ZDS переменная');
           AddNewLineToDebugger('IsUPU', isUPU, 'TWS переменная');
           AddNewLineToDebugger('Номер локомотива', LocoNum, 'ZDS переменная');
           AddNewLineToDebugger('CameraLastWagonOffset', CameraLastWagonOffset, 'ZDS переменная');
           AddNewLineToDebugger('Количество вагонов', WagsNum, 'ZDS переменная');
           AddNewLineToDebugger('CameraSelectedWagon', Camera__.SelectedWagon, 'TWS переменная');
           AddNewLineToDebugger('Camera.isCon', Camera__.isCon, 'TWS переменная');
        end;
end;

procedure TFormDebug.Timer1Timer(Sender: TObject);
var
	I, J: Integer;
        ListItem: TListItem;
begin
	try
        Label94.Caption := floatToStr(Abs(TC - PrevTC) * 4000);
        With FormMain do begin
        for I:=0 to ListView1.Items.Count do begin
           ListItem := ListView1.Items[I];
           J := StrToInt(ListView1.Items[I].Caption);
           //BASS_ChannelGetAttribute(VentTD_Channel, BASS_ATTRIB_FREQ, VentPTRFreq);
           //BASS_ChannelGetAttribute(VentTD_Channel, BASS_ATTRIB_VOL, VentPTRVol);
           Case J Of
              1: ListItem.SubItems[3] := IntToStr(UnitMain.Speed);
              2: ListItem.SubItems[3] := FloatToStr(Acceleretion);
              3: ListItem.SubItems[3] := IntToStr(Track);
              4: ListItem.SubItems[3] := IntToStr(TrackTail);
              5: ListItem.SubItems[3] := IntToStr(KM_Pos_1);
              6: ListItem.SubItems[3] := IntToStr(KM_Pos_2);
              7: ListItem.SubItems[3] := IntToStr(KM_395);
              8: ListItem.SubItems[3] := FloatToStr(KM_294);
              9: ListItem.SubItems[3] := FloatToStr(KM_OP);
              10: ListItem.SubItems[3] := IntToStr(CoupleStat);
              11: ListItem.SubItems[3] := IntToStr(Svetofor);
              12: ListItem.SubItems[3] := IntToStr(OgrSpeed);
              13: ListItem.SubItems[3] := IntToStr(SvetoforDist);
              14: ListItem.SubItems[3] := IntToStr(Camera);
              15: ListItem.SubItems[3] := IntToStr(CameraX);
              16: ListItem.SubItems[3] := IntToStr(Rain);
              17: ListItem.SubItems[3] := IntToStr(VCheck);
              18: ListItem.SubItems[3] := IntToStr(KLUBOpen);
              19: ListItem.SubItems[3] := FloatToStr(TEDAmperage);
              20: ListItem.SubItems[3] := FloatToStr(EDTAmperage);
              21: ListItem.SubItems[3] := FloatToStr(BrakeCylinders);
              22: ListItem.SubItems[3] := IntToStr(VstrTrack);
              23: ListItem.SubItems[3] := IntToStr(Vstr_Speed);
              24: ListItem.SubItems[3] := IntToStr(WagNum_Vstr);
              25: ListItem.SubItems[3] := IntToStr(Vstrecha_dlina);
              26: ListItem.SubItems[3] := IntToStr(VstrechStatus);
              27: ListItem.SubItems[3] := BoolToStr(isVstrechDrive);
              28: ListItem.SubItems[3] := FloatToStr(ConsistLength);
              29: ListItem.SubItems[3] := FloatToStr(TrackLength);
              30: ListItem.SubItems[3] := IntToStr(Boks_Stat);
              31: ListItem.SubItems[3] := IntToStr(Vent);
              32: ListItem.SubItems[3] := FloatToStr(Vent2);
              33: ListItem.SubItems[3] := FloatToStr(Vent3);
              34: ListItem.SubItems[3] := FloatToStr(Vent4);
              35: ListItem.SubItems[3] := FloatToStr(Compressor);
              36: ListItem.SubItems[3] := IntToStr(BV);
              37: ListItem.SubItems[3] := FloatToStr(diesel2);
              38: ListItem.SubItems[3] := IntToStr(Fazan);
              39: ListItem.SubItems[3] := IntToStr(FrontTP);
              40: ListItem.SubItems[3] := IntToStr(BackTP);
              41: ListItem.SubItems[3] := IntToStr(ReversorPos);
              42: ListItem.SubItems[3] := FloatToStr(Stochist);
              43: ListItem.SubItems[3] := FloatToStr(StochistDGR);
              44: ListItem.SubItems[3] := FloatToStr(Voltage);
              45: ListItem.SubItems[3] := IntToStr(Reostat);
              46: ListItem.SubItems[3] := IntToStr(EPT);
              47: ListItem.SubItems[3] := IntToStr(LDOOR);
              48: ListItem.SubItems[3] := IntToStr(RDOOR);
              49: ListItem.SubItems[3] := IntToStr(NextOgrSpeed);
              50: ListItem.SubItems[3] := IntToStr(RB);
              51: ListItem.SubItems[3] := IntToStr(RBS);
              52: ListItem.SubItems[3] := IntToStr(AB_ZB_1);
              53: ListItem.SubItems[3] := IntToStr(AB_ZB_2);
              54: ListItem.SubItems[3] := IntToStr(Highlights);
              55: ListItem.SubItems[3] := BoolToStr(isPlayPerestuk_OnStation);
              //56: ListItem.SubItems[3] := IntToStr(SAVP_l.SAVPBaseObjectsCount);
              56: ListItem.SubItems[3] := SceneryName;
              //57: ListItem.SubItems[3] := IntToStr(SAVP_l.scBaseInfoCount);
              //57: ListItem.SubItems[3] := BoolToStr(USAVPEnabled);
              //58: ListItem.SubItems[3] := SAVP_l.SAVPEFilePrefiks;
              57: ListItem.SubItems[3] := BoolToStr(scSAVPOverrideRouteEK);
              58: ListItem.SubItems[3] := BoolToStr(HeadTrainEndOfTrain);
              59: ListItem.SubItems[3] := BoolToStr(isConnectedMemory);
              60: ListItem.SubItems[3] := BoolToStr(isGameOnPause);
              61: ListItem.SubItems[3] := FloatToStr(Ordinata);
              62: ListItem.SubItems[3] := FloatToStr(VentTDPitch);
              63: ListItem.SubItems[3] := FloatToStr(VentTDVol);
              64: ListItem.SubItems[3] := FloatToStr(OrdinataEstimate);
              65: ListItem.SubItems[3] := BoolToStr(PereezdZone);
              66: ListItem.SubItems[3] := FloatToStr(ZvonokVolume);
              67: ListItem.SubItems[3] := FloatToStr(ZvonokFreq);
              68: ListItem.SubItems[3] := FloatToStr(VentSingleVolume);
              69: ListItem.SubItems[3] := FloatToStr(VentSingleVolumeIncrementer);
              70: ListItem.SubItems[3] := FloatToStr(VentPitch);
              71: ListItem.SubItems[3] := FloatToStr(TEDVlm);
              72: ListItem.SubItems[3] := FloatToStr(TEDPitch);
              73: ListItem.SubItems[3] := FloatToStr(UnitSoundRRS.speed);
              74: ListItem.SubItems[3] := UnitSoundRRS.cameraManipulatorView;
              75: ListItem.SubItems[3] := FloatToStr(ReduktorVolume);
              76: ListItem.SubItems[3] := FloatToStr(ReduktorPitch);
              77: ListItem.SubItems[3] := FloatToStr(GR);
              78: ListItem.SubItems[3] := FloatToStr(TC);
              79: ListItem.SubItems[3] := FloatToStr(Abs(TC - PrevTC)*400000);
              80: ListItem.SubItems[3] := FloatToStr(DNoisePitch);
              81: ListItem.SubItems[3] := FloatToStr(DNoisePitchDest);
              82: ListItem.SubItems[3] := BoolToStr(LocoWithDNoisePitch);
              83: ListItem.SubItems[3] := BoolToStr(isCameraInCabin);
              84: ListItem.SubItems[3] := FloatToStr(TEDVlmDest);
              85: ListItem.SubItems[3] := FloatToStr(VR242);
              86: ListItem.SubItems[3] := IntToStr(GRIncrementer);
              87: ListItem.SubItems[3] := IntToStr(BASS_ChannelIsActive(ReduktorChannel_FX));
              88: ListItem.SubItems[3] := IntToStr(CHS8__.UnipulsFaktPos);
              89: ListItem.SubItems[3] := IntToStr(CHS8__.UnipulsTargetPos);
              90: ListItem.SubItems[3] := IntToStr(BASS_ChannelIsActive(Unipuls_Channel[0]));
              91: ListItem.SubItems[3] := IntToStr(BASS_ChannelIsActive(Unipuls_Channel[1]));
              92: ListItem.SubItems[3] := BoolToStr(CHS8__.Unipuls2SecWait);
              93: ListItem.SubItems[3] := FloatToStr(CHS4T__.CompressorGRDifference);
              94: ListItem.SubItems[3] := FloatToStr(CHS4KVR__.CompressorGRDifference);
              95: ListItem.SubItems[3] := IntToStr(BASS_ChannelIsActive(Vent_Channel_FX));
              96: ListItem.SubItems[3] := IntToStr(BASS_ChannelIsActive(VentCycle_Channel_FX));
              97: ListItem.SubItems[3] := FloatToStr(GetChannelRemaindPlayTime2Sec(VentTD_Channel_FX));
              98: ListItem.SubItems[3] := FloatToStr(Brake_scrDestVolume);
              99: ListItem.SubItems[3] := FloatToStr(Brake_scrVolume);
              100: ListItem.SubItems[3] := FloatToStr(Brake_scrVolumeIncrementer);
              101: ListItem.SubItems[3] := FloatToStr(Brake_slipp_Volume);
              102: ListItem.SubItems[3] := IntToStr(BV_Paketnik);
              103: ListItem.SubItems[3] := FloatToStr(CompoundPercent);
              104: ListItem.SubItems[3] := BoolToStr(isUPU);
              105: ListItem.SubItems[3] := IntToStr(LocoNum);
              106: ListItem.SubItems[3] := FloatToStr(CameraLastWagonOffset);
              107: ListItem.SubItems[3] := IntToStr(WagsNum);
              108: ListItem.SubItems[3] := IntToStr(Camera__.SelectedWagon);
              109: ListItem.SubItems[3] := BoolToStr(Camera__.isCon);
           end;
        end;
        end;
	// ***** БЛОК ОБНОВЛЕНИЯ ДАННЫХ ***** //
        Label_Route.Caption        := UnitMain.Route + ' | ' +  UnitMain.naprav;
        Label_Loco.Caption         := UnitMain.LocoGlobal + ' | ' + UnitMain.Loco;
        Label19.Caption            := IntToStr(UnitMain.Svistok);
        Label20.Caption            := IntToStr(UnitMain.Tifon);
        Label_Freight.Caption := IntToStr(UnitMain.Freight);
        //Label_Op_Deg.Caption := IntToStr(UnitMain.KM_OP_Deg);
        if isPlayPerestuk_OnStation=True then Label41.Caption:='1' else Label41.Caption:='0';
        Label45.Caption := FloatToStr(UnitMain.TEDVlm);
        Label49.Caption := IntToStr(FormMain.timerPRSswitcher.Interval);
        Label48.Caption := IntToStr(FormMain.TimerPlayPerestuk.Interval);
        Label56.Caption := IntToStr(UnitMain.KME_ED);
        Label35.Caption := IntToStr(UnitMain.MP);
        Label43.Caption := IntToStr(UnitMain.WagsNum);
        Label83.Caption := IntToStr(UnitMain.TedNow);
        Label91.Caption := IntToStr(UnitMain.CHS8__.UnipulsFaktPos);
        Label92.Caption := IntToStr(UnitMain.CHS8__.UnipulsTargetPos);
        //Label87.Caption := IntToStr(UnitMain.PrevVersionID);
        if FormMain.TimerPlayPerestuk.Enabled = True then
           Label89.Caption := 'True'
        else
           Label89.Caption := 'False';
        if UnitMain.isVstrechDrive = True then
           Label50.Caption := 'TRUE'
        else
           Label50.Caption := 'FALSE';
        Label121.Caption:= IntToStr(UnitMain.UltimateTEDAmperage);
        UnitMain.Voltage:=0; BASS_ChannelGetAttribute(DizChannel, BASS_ATTRIB_VOL, UnitMain.Voltage);
        Label80.Caption := FloatToStr(UnitMain.Voltage);
        Label92.Caption := IntToStr(UnitMain.CHS8__.UnipulsTargetPos);
        UnitMain.Voltage:=0; BASS_ChannelGetAttribute(DizChannel2, BASS_ATTRIB_VOL, UnitMain.Voltage);
        Label81.Caption := FloatToStr(UnitMain.Voltage);
        UnitMain.Voltage:=0; BASS_ChannelGetAttribute(TEDChannel, BASS_ATTRIB_VOL, UnitMain.Voltage);
        Label101.Caption := FloatToStr(UnitMain.Voltage);
        UnitMain.Voltage:=0; BASS_ChannelGetAttribute(TEDChannel2, BASS_ATTRIB_VOL, UnitMain.Voltage);
        Label102.Caption := FloatToStr(UnitMain.Voltage);
        UnitMain.Voltage:=0; BASS_ChannelGetAttribute(LocoChannel[0], BASS_ATTRIB_VOL, UnitMain.Voltage);
        Label105.Caption := FloatToStr(UnitMain.Voltage);
        UnitMain.Voltage:=0; BASS_ChannelGetAttribute(LocoChannel[1], BASS_ATTRIB_VOL, UnitMain.Voltage);
        Label107.Caption := FloatToStr(UnitMain.Voltage);
        UnitMain.Voltage:=0; BASS_ChannelGetAttribute(Vent_Channel, BASS_ATTRIB_VOL, UnitMain.Voltage);
        Label114.Caption := FloatToStr(UnitMain.Voltage);
        UnitMain.Voltage:=0; BASS_ChannelGetAttribute(VentCycle_Channel, BASS_ATTRIB_VOL, UnitMain.Voltage);
        Label115.Caption := FloatToStr(UnitMain.Voltage);
        UnitMain.Voltage:=0; BASS_ChannelGetAttribute(XVent_Channel, BASS_ATTRIB_VOL, UnitMain.Voltage);
        Label116.Caption := FloatToStr(UnitMain.Voltage);
        UnitMain.Voltage:=0; BASS_ChannelGetAttribute(XVentCycle_Channel, BASS_ATTRIB_VOL, UnitMain.Voltage);
        Label117.Caption := FloatToStr(UnitMain.Voltage);
        if UnitMain.isConnectedMemory=True then Label67.Caption := 'True' else Label67.Caption := 'False';
        if UnitMain.PerehodTED = True then Label77.Caption := 'True' else Label77.Caption := 'False';
        label109.Caption := IntToStr(UnitMain.LocoNum);
        except end;
  // ********************************** //
end;

function CustomDateSortProc(Item1, Item2: TListItem; ParamSort: integer):
 integer; stdcall;
begin
 result := 0;
 if strtodatetime(item1.SubItems[0]) > strtodatetime(item2.SubItems[0]) then
   Result := 1
 else if strtodatetime(item1.SubItems[0]) < strtodatetime(item2.SubItems[0])
   then
   Result := -1;
end;

function CustomValueSortProc(Item1, Item2: TListItem; ParamSort: integer):
 integer; stdcall;
begin
 result := 0;
 if item1.SubItems[ParamSort] > item2.SubItems[ParamSort] then
   Result := 1
 else if item1.SubItems[ParamSort] < item2.SubItems[ParamSort]
   then
   Result := -1;
end;

function CustomNameSortProc(Item1, Item2: TListItem; ParamSort: integer): Integer; stdcall;
var
 i1, i2 : Integer;
begin
 i1 := StrToIntDef(item1.SubItems[ParamSort], 0);
 i2 := StrToIntDef(item2.SubItems[ParamSort], 0);
 Result := i1 - i2
end;

procedure TFormDebug.ListView1ColumnClick(Sender: TObject;
  Column: TListColumn);
begin
	if Column = ListView1.Columns[0] then
	   RefreshDebugger();
        if Column = ListView1.Columns[1] then
	   ListView1.CustomSort(@CustomValueSortProc, 0);
        if Column = ListView1.Columns[2] then
	   ListView1.CustomSort(@CustomValueSortProc, 1);
        if Column = ListView1.Columns[3] then
	   ListView1.CustomSort(@CustomValueSortProc, 2);
        if Column = ListView1.Columns[4] then
	   ListView1.CustomSort(@CustomValueSortProc, 3);
end;

procedure TFormDebug.FormCreate(Sender: TObject);
begin
	Timer1.Enabled := True;
	RefreshDebugger();
end;

procedure TFormDebug.btnStationsBorderClick(Sender: TObject);
var
	I: Integer;
        Str: String;
begin
        for I := 0 to UnitMain.StationCount - 1 do begin
           Str := Str + IntToStr(UnitMain.StationTrack1[I]) + #9 +
           	  IntToStr(UnitMain.StationTrack2[I]) + #12 + #13;
        end;
        ShowMessage(Str);
end;

procedure TFormDebug.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Timer1.Enabled := False;
end;

end.

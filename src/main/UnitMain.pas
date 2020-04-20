(*     +-------------------------------------------------------------------+
      /                  TTTTTT   W       W    SSSSS                      /|
     /                     T     W       W    S                          / |
    /                     T       W  W  W    SSSSS                      /  |
   /                     T         WW WW        S                      /   |
  /                     T          W  W    SSSSS                      /    |
 +-------------------------------------------------------------------+     |
 |                                                                   |     |
 |    Brief:      TWS (Train Wagon Sound)                            |     |
 |    Copyright:  Dmitry Govorukha a.k.a DimaGVRH                    |     |
 |    Author:     Dmitry Govorukha a.k.a DimaGVRH                    |     |
 |                                                                   |     +
 |    UKRAINE, DNEPR CITY, 2017-2020 (C)                             |    /
 |                                                                   |   /
 |    zdsimulator.com.ua                                             |  /
 |    forum.zdsimulator.com.ua                                       | /
 |                                                                   |/
 +-------------------------------------------------------------------+
*)
unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Graphics, Forms, Dialogs, StdCtrls, ComCtrls,
  Menus, IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME, ExtCtrls,
  Controls, Classes, Bass, inifiles, UnitAuthors, TlHelp32, ShellApi, Grids,
  ValEdit, jpeg, UnitSAVPEHelp, UnitSettings, UnitDebug, Math, UnitUSAVP,
  EncdDecd, SAVP, RAMMemModule, FileManager, ExtraUtils, SoundManager, Debug,
  bass_fx, UnitSOVIHelp, UnitSoundRRS, CHS8;

type
  TFormMain = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    Memo7: TMemo;
    Memo8: TMemo;
    btnSOVIHelp: TButton;
    btnSAVPEHelp: TButton;
    ClockMain: TTimer;
    timer3SL2m_3Sec: TTimer;
    timerSoundSlider: TTimer;
    timerPRSswitcher: TTimer;
    timerPlayPerestuk: TTimer;
    timerDoorCloseDelay: TTimer;
    timerPerehodDizSwitch: TTimer;
    timerVigilanceUSAVPDelay: TTimer;
    timerPerehodUnipulsSwitch: TTimer;
    timerSearchSimulatorWindow: TTimer;
    trcBarPRSVol: TTrackBar;
    trcBarWagsVol: TTrackBar;
    trcBarSAVPVol: TTrackBar;
    trcBarTedsVol: TTrackBar;
    trcBarNatureVol: TTrackBar;
    trcBarDieselVol: TTrackBar;
    trcBarSignalsVol: TTrackBar;
    trcBarVspomMahVol: TTrackBar;
    trcBarLocoClicksVol: TTrackBar;
    trcBarLocoPerestukVol: TTrackBar;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    cbTEDs: TCheckBox;
    cbPRS_UZ: TCheckBox;
    cbPRS_RZD: TCheckBox;
    cbTPSounds: TCheckBox;
    cbVspomMash: TCheckBox;
    cbEPL2TBlock: TCheckBox;
    cbKLUBSounds: TCheckBox;
    cbSAUTSounds: TCheckBox;
    cbLocPerestuk: TCheckBox;
    cbWagPerestuk: TCheckBox;
    cb3SL2mSounds: TCheckBox;
    cbCabinClicks: TCheckBox;
    cbUSAVPSounds: TCheckBox;
    cbSAVPESounds: TCheckBox;
    cbGSAUTSounds: TCheckBox;
    cbExtIntSounds: TCheckBox;
    cbNatureSounds: TCheckBox;
    cbBrakingSounds: TCheckBox;
    cbSignalsSounds: TCheckBox;
    cbHeadTrainSound: TCheckBox;
    cbSAVPE_Marketing: TCheckBox;
    Label5: TLabel;
    Label46: TLabel;
    Label50: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label124: TLabel;
    lblPRSVolume: TLabel;
    lblSAVPvolume: TLabel;
    lblHornVolume: TLabel;
    lblTEDsVolume: TLabel;
    lblVspomVolume: TLabel;
    lblDieselVolume: TLabel;
    lblClicksVolume: TLabel;
    lblSOVIselectEK: TLabel;
    lblPasswagVolume: TLabel;
    lblSOVIrouteSelect: TLabel;
    lblSAVPECommertion: TLabel;
    lblLocoTappingVolume: TLabel;
    lblSAVPE_selectRoute: TLabel;
    lblSOVImessagesCounter: TLabel;
    lblSAVPE_StationsCounter: TLabel;
    lblSimulatorVersionLaunched: TLabel;
    panelPasswagSounds: TPanel;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    groupBoxSAVPEbox: TGroupBox;
    groupBoxPRSCheckboxes: TGroupBox;
    groupBoxSAVPE_HandMode: TGroupBox;
    groupBoxSAVPCheckboxes: TGroupBox;
    groupBoxSOVIDescription: TGroupBox;
    groupBoxSpeedometerType: TGroupBox;
    groupBoxLocoSndCheckboxes: TGroupBox;
    groupBoxSOVI_EKdescription: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RB_HandEKMode: TRadioButton;
    RB_AutoEKMode: TRadioButton;
    Image1: TImage;
    Image2: TImage;
    IdDecoderMIME1: TIdDecoderMIME;
    Edit1: TEdit;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    ReadME1: TMenuItem;
    
    procedure ChangeVolume(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClockMainTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbWagPerestukClick(Sender: TObject);
    procedure timerSoundSliderTimer(Sender: TObject);
    procedure cbLocPerestukClick(Sender: TObject);
    procedure RB_HandEKModeClick(Sender: TObject);
    procedure cbSAUTSoundsClick(Sender: TObject);
    procedure cbPRS_RZDClick(Sender: TObject);
    procedure timerPRSswitcherTimer(Sender: TObject);
    procedure cbUSAVPSoundsClick(Sender: TObject);
    procedure cbGSAUTSoundsClick(Sender: TObject);
    procedure timerSearchSimulatorWindowTimer(Sender: TObject);
    procedure cbKLUBSoundsClick(Sender: TObject);
    procedure cb3SL2mSoundsClick(Sender: TObject);
    procedure cbHeadTrainSoundClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure timerPlayPerestukTimer(Sender: TObject);
    procedure cbNatureSoundsClick(Sender: TObject);
    procedure cbTEDsClick(Sender: TObject);
    procedure cbBrakingSoundsClick(Sender: TObject);
    procedure cbSAVPESoundsClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure btnSAVPEHelpClick(Sender: TObject);
    procedure cbVspomMashClick(Sender: TObject);
    procedure timerPerehodUnipulsSwitchTimer(Sender: TObject);
    procedure timerPerehodDizSwitchTimer(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure timerDoorCloseDelayTimer(Sender: TObject);
    procedure RB_AutoEKModeClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
    function  CheckInstallation(): Boolean;
    procedure timer3SL2m_3SecTimer(Sender: TObject);
    procedure UpdateInfoName();
    procedure TWS_PlaySvistok(FileName: String);
    procedure TWS_PlaySvistokCycle(FileName: String);
    procedure TWS_PlayTifon(FileName: String);
    procedure TWS_PlayTifonCycle(FileName: String);
    procedure N5Click(Sender: TObject);
    procedure ReadME1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure cbSignalsSoundsClick(Sender: TObject);
    procedure trcBarSignalsVolChange(Sender: TObject);
    procedure cbEPL2TBlockClick(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure timerVigilanceUSAVPDelayTimer(Sender: TObject);
    procedure btnSOVIHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  // ************************ ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ ******************************
type
   ProcReadDataMemoryType = procedure() of object; // Прцедурный тип, для того чтобы получать информацию из ОЗУ для нужного локомотива

var
  FormMain: TFormMain;			   // Главная форма программы

  MainCycleFreq:               Integer;    // Частота работы программы [ms]

  ResPotok:                    TMemoryStream; // Поток данных для RES-декодера

  VersionID:                   Byte;	   // ID версии симулятора (определяется автоматически)

  Log_: log;				   // Лог программы (ОТКЛЮЧЕН)
  RRS_: soundrrs;                          // Звуки RRS (РАБОТАЮТ 1.0.4)

  CHS8__: chs8_; 			   // Экземпляр ЧС8

  // ДАННЫЕ ПОЛУЧАЕМЫЕ С ФАЛЙА settings.ini (С 2.6 из ОЗУ) //
  Route:                       String;	   // Переменная для хранения имени маршрута
  Naprav:		       String;	   // Переменная для хранения направления движения (Tuda && Obratno)
  NapravOrdinata:              String;     // Переменная для хранения направления движения (для ординат)
  Freight:                     Byte;	   // Переменная для типа поезда (1 - грузовой; 0 - пассажирский)
  MP:                          Byte;       // Переменная для того чтобы понять одинчка или МП
  Winter:                      Byte;	   // Переменная-флаг зима в игре, или нет [0, 1]
  ConsistLength:               Single;     // Длинна нашего состава в метрах
  WagsNum:                     Byte;       // Кол-во вагонов в нашем составе
  ConName:                     String;     // Имя файла состава, или имя используемых вагонов
  TrackLength:                 Single;     // Длина одного трэка в метрах
  SceneryName:                 String;     // Имя текущего сценария
  LocoNum:                     Integer;    // Номер перекраски локомотива
  LocoPowerVoltage:            Integer;    // -3/~25kV
  // ----------------------------------------------------- //

  // Границы станций из файла start_kilometers.dat //
  StationTrack1:               array[0..75] Of Integer; // 1-ая граница станции
  StationTrack2:               array[0..75] Of Integer; // 2-ая граница станции
  StationCount:                Byte = 0;   // Общее количество станций
  // --------------------------------------------- //

  Loco, LocoGlobal:            String;	   // Переменная для хранения имени локомотива
  LocoSectionsNum:             Byte;       // Количество секций на локомотиве
  LocoWithTED:                 Boolean;    // Переменная для определения, есть-ли на данный локомотив звук ТЭД-ов
  LocoWithReductor:            Boolean;
  LocoWithDIZ:                 Boolean;
  LocoWithSndReversor:         Boolean;
  LocoWithSndKM:               Boolean;    // Переменная для определения, есть-ли на данный локомотив звук щелчка котнроллера
  LocoWithSndKM_OP:            Boolean;    // Переменная для определения, есть-ли на данный локомотив звук постановки ОП
  LocoWithSndTP:               Boolean;    // Переменная для определения, есть-ли на данный локомотив звуки ТП
  LocoWithExtMVSound:          Boolean;    // Переменная для определения, есть-ли на данный локомотив внешние звуки МВ
  LocoWithExtMKSound:          Boolean;    // Переменная для определения, есть-ли на данный локомотив внешние звуки МК
  LocoWithMVPitch:             Boolean;
  LocoWithMVTDPitch:           Boolean;
  LocoSndReversorType:         Byte;       // Тип звуков реверсора на локомотиве (0 - читаем состояние с памяти, 1 - по нажатию соответствующих клавиш
  LocoTEDNamePrefiks:          String;
  LocoReductorNamePrefiks:     String;
  LocoDIZNamePrefiks:          String;
  LocoSvistokF:                String;
  LocoHornF:                   String;
  LocoWorkDir:                 String;     // Рабочая директория локомотива
  VentStartF, XVentStartF:     PChar;
  VentCycleF, XVentCycleF:     PChar;
  VentStopF,  XVentStopF:      PChar;
  VentTDStartF, XVentTDStartF: PChar;
  VentTDCycleF, XVentTDCycleF: PChar;
  VentTDStopF,  XVentTDStopF:  PChar;

  // Переменные для клавиш клавиатуры //
  PrevKeyA, PrevKeyD:	       Byte;         // Переменная для пред. нажатия клавиш <<A>> и <<D>>
  PrevKeyE, PrevKeyQ:	       Byte;         // Переменная для пред. нажатия клавиш <<E>> и <<Q>>
  PrevKeyZ, PrevKeyLKM:	       Byte;         // Переменная для пред. нажатия клавиш <<Z>> и <<LKM>>
  PrevKeyW, PrevKeyS:	       Byte;         // Переменная для пред. нажатия клавиш <<W>> и <<S>>
  PrevKeyM, PrevKeyEPK:        Byte;         // Переменная для пред. нажатия клавиш <<M>> и <<N или SHIFT+N>>
  PrevKeyEPKS:                 Byte;
  PrevKeyTAB, PrevKeyKKR:      Byte;
  PrevKeyNum0:                 Integer;
  PrevKeyNum1:                 Integer;
  PrevKeyNum2:                 Integer;
  PrevKeyNum3:                 Integer;
  PrevKeyNum4:                 Integer;
  PrevKeyNum5:                 Integer;
  PrevKeyNum6:                 Integer;
  PrevKeyNum7:                 Integer;
  PrevKeyNum8:                 Integer;
  PrevKeyNum9:                 Integer;
  PrevKeyNumPoint:             Integer;
  PrevKeyNumZvezda:            Integer;
  KMPrevKey:                   String;
  // ********************************* //

  GRIncrementer:               Byte;
  TCIncrementer:               Byte;

  sDecodeString:	       String;

  CycleVentVolume:             Byte;	     // Громкость цикла работы вентиляторов (ВЛ80т)
  VentVolume:                  Byte;	     // Громкость работы вентиляторов (ВЛ80т)
  ZvonVolume:                  Extended;
  ZvonTrack:                   Integer;      // Переменные для звонка переезда
  Vstrecha_dlina:              Integer;      // Длинна встречки (в метрах)
  PrevSpeed_Fakt:              Integer;      // Фактическая предыдущая скорость
  Prev_KMAbs:                  Integer;      // Фактическая предыдущая позиция
  Prev_VentLocal:              Integer;	     // Для ЧС4 квр

  // ----------------------------------------------------------------------- //
  // === ДАЛЕЕ - ПЕРЕМЕННЫЕ ДЛЯ ХРАНЕНИЯ ДАННЫХ КОТОРЫЕ ПОЛУЧАЮТСЯ С ОЗУ === //
  // ----------------------------------------------------------------------- //
  KM_395,            PrevKM_395:      Byte;	    // Положение крана №395
  KM_294,            PrevKM_294:      Single;       // Положение крана №254 (локомотивный)
  Svetofor,          PrevSvetofor:    Byte;	    // Показания светофора (код сигнала)
  CoupleStat,        PrevCoupleStat:  Byte;
  Highlights,        PrevHighLights:  Byte;         // Состояние прожекторов
  VstrechStatus,     PrevVstrechStatus:Byte;
  PickKLUB,          PrevPickKLUB:    Integer;
  Reostat,           PrevReostat:     Byte;         // Переменная включения ЭДТ на ЧС8, для звука защелки
  Fazan,             PrevFazan:       Byte;         // Фазорасщепитель для ВЛ80т
  Rain,              PrevRain:        Byte;         // Переменные интенсивности дождя
  Camera,            PrevCamera:      Byte;         // Переменные для определения типа камеры
  RB,                PrevRB:          Byte;         // Переменные для РБ (ПИКУРОВ)
  RBS,               PrevRBS:         Byte;         // Переменные для РБC (ПИКУРОВ)
  EPT,               PrevEPT:         Byte;         // Переменная состояния ЭПТ (для тумблера ЭД-шэк)
  BV,                PrevBV:          Byte;         // БВ, ЭД4(9)м, ЧС7 чтобы сделать щелчок тумблера и вентиляторы на ЧС7
  Voltage,           PrevVoltage:     Single;       // Напряжение на электровозе ЧС7
  CameraX,           PrevCameraX:     WORD;         // Переменные для определения положения головы в кабине
  KME_ED,            PrevKME_ED:      Integer;
  Zhaluzi,           PrevZhaluzi:     Byte;         // Состояние жалюзей [ЧС7]
  Compressor,        Prev_Compressor: Single;       // Состояние компрессоров
  Stochist,          Prev_Stochist:   Single;       // Состояние дворников
  StochistDGR,       Prev_StchstDGR:  Double;       // Угол поворота дворников
  Vent,              Prev_Vent:       Integer;      // Состояние Вентиляторов [1]
  Vent2,             Prev_Vent2:      Single;       // Состояние Вентиляторов [2] (ВЛ80т, ЭП1м)
  Vent3,             Prev_Vent3:      Single;       // Состояние Вентиляторов [3] (ВЛ80т, ЭП1м)
  Vent4,             Prev_Vent4:      Single;       // Состояние Вентиляторов [4] (ВЛ80т)
  VCheck,            PrevVCheck:      Byte;         // Состояние проверки бдительности, для звука пиканья на КЛУБ-У
  SvetoforDist,    Prev_SvetoforDist: WORD;         // Расстояние до свотофора
  FrontTP,           PrevFrontTP:     Integer;	    // Состояние переднего ТП
  BackTP,            PrevBackTP:      Integer;      // Состояние заднего ТП
  LDOOR,             PrevLDOOR:       Byte;
  RDOOR,             PrevRDOOR:       Byte;
  diesel2,           PrevDiesel2:     Single;       // Состояное дизеля второй секции
  VstrTrack,         PrevVstrTrack:   WORD;         // Переменные ординаты встречки
  Track_Vstrechi:                     Integer;      // Трэк на котором произошла встреча нашего состава с встречным
  Acceleretion,      PrevAcceleretion:Double;       // Ускорение м/(с^2)
  ReversorPos,       PrevReversorPos: Integer;      // Позиция реверсора [255(-1); 0; 1]
  Speed,             PrevSpeed:       Integer;	    // Скорость
  OgrSpeed,          PrevOgrSpeed:    WORD;         // Ограничение скорости
  NextOgrSpeed,      PrevNextOgrSpeed:Byte;         // Следующее ограничение скорости (желтая точка на КЛУБ-е)
  NextOgrPeekStatus:                  Byte;	    // Статус для пиканья про снижение ограничения [0-нет снижения 1-в процессе]
  PrevPRS:                            Integer;
  BrakeCylinders,    PrevBrkCyl:      Single;       // Давление в тормозных цилиндрах
  Svistok,           PrevSvistok:     Byte;         // Данные про работу свистка
  Tifon,             PrevTifon:       Byte;         // Данные про работу тифона
  KLUBOpen:                           Byte;	    // Переменная-флаг открыта-ли в игре клавиатура КЛУБ
  TrackTail:                          Integer;      // Номер трэка хвоста нашего поезда
  VstrechStatusCounter:               Integer;
  isVstrechDrive:                     Boolean;
  Ordinata,          PrevOrdinata:    Double;
  OrdinataEstimate,PrevOrdinataEstimate: Double;
  OutsideLocoStatus:                  WORD;
  GR,                PrevGR:          Double;
  TC,                PrevTC:          Double;

  DebugFile: TextFile;

  // ------------------------------------------------------------------------------- //
  // ================ ДАЛЕЕ - ПЕРЕМЕННЫЕ ДЛЯ ХРАНЕНИЯ ПУТИ К ЗВУКАМ ================ //
  // ------------------------------------------------------------------------------- //
  ChannelNum, Track, PrevTrack, ChannelNumTED:Integer;
  ChannelNumDiz:               Byte;    // Номер канала для звуков дизеля
  Ini:                         TIniFile;// Ini файл настроек
  LocoVolume, LocoVolume2:     Integer; // Громкости дорожек перестука локомотива, нужны только для перехода
  DizVolume, DizVolume2:       Single;  // Громкость дорожки дизеля, нужно для разделения звуков на внешние и внутренние
  PerehodDIZ:                  Boolean;
  DIZVlm:                      Single;
  PerehodDIZStep:              Single;
  EDTAmperage, PrevEDTAmperage:Single;
  VstrVolume:                  Integer;
  TEDAmperage, PrevTEDAmperage:Single;
  UltimateTEDAmperage:         Integer; // Предельный ток нагрузки на ТЭД-ы
  TrackVstrechi:	       Integer; // Номер трэка где встретились состав игрока со встречкой
  WagNum_Vstr:	       	       Byte;
  TEDVlm:                      Extended;// Громкость ТЭД-ов
  TEDVolume, TEDVolume2:       Single;  // Громкости дорожек ТЭД-ов локомотива, нужны только для переходов
  PerehodTEDStep:              Single;  // Шаг инкремента-декремента громкости дорожек ТЭД-ов при переходе сэмплов
  AB_ZB_1, AB_ZB_2:            Byte;
  PrevAB_ZB_1, PrevAB_ZB_2:    Byte;
  PrevBoks_Stat, Boks_Stat:    Byte;
  // ------------------------------------------------------ //
  // ******* ФЛАГИ ******* //
  SAVPENextMessage:            Boolean = False;
  HeadTrainEndOfTrain:         Boolean;
  isCameraInCabin:             Boolean; // Флаг для понимания, в кабине-ли камера?
  isRefreshLocalData:          Boolean; // флаг для перезагрузки в скрипт всех данных необходимых для работы
  perestukPLAY:                Boolean; // Флаг для провоцирования звука перестука тележек локомотива в случайные промежутки времени
  PrevPerestukStation:         Boolean; // Флаги для перестука локомотива на станции
  isPlayWag:                   Boolean; // Флаг для включения звука перестука вагонов
  SAUTOff:                     Boolean; // Фалг для воспроизведения финального звука выключения САУТ
  isConnectedMemory,PrevConMem:Boolean; // Флаг для определения: удалось ли подключиться к памяти?
  isGameOnPause:               Boolean; // Флаг для состояния паузы игры (сворочивание)
  VstrZat:		       Boolean; // Флаг для велючения затухания звука встречного поезда
  isPlayRB:	               Boolean; // Флаг для воспроизведения нажатия на кнопки РБ и РБС
  PlayRESFlag:                 Boolean;
  PereezdZatuh:                Boolean;
  isSpeedLimitRouteLoad:       Boolean;
  Brake:                       Boolean;
  StopVent:                    Boolean;
  StopVentTD:                  Boolean;
  RefreshSnd:                  Boolean;
  isNatureNowPlay:array[0..4]of Boolean;// Флаг для понимания играет-ли текущая дорожка природы
  NatureOrd1: array [0..4] of  Integer; // Ордината начала играния дорожки природы
  NatureOrd2: array [0..4] of  Integer; // Ордината конца играния дорожки природы
  NatureKoefZatuh:array[0..4]of Integer;// Длина затухания
  Brake_Counter:               Integer;
  Prev_KME:                    Integer;
  PerestukBase: Array[0..100] of Integer;
  PerestukBaseNumElem:         Integer;
  TEDBase: Array[0..600] of    Integer;
  TEDBaseNumElem:              Integer;
  VIPBase: Array[0..600] of    Integer; // Данные о границах дорожек для ВИП (ЭП1м и 2ЭС5к)
  VIPBaseNumElem:              Integer; // Количество дорожек ВИП (ЭП1м и 2ЭС5к)
  TedFound:                    Boolean;
  isPlayTrog:                  Boolean; // Удар сцепки на МВПС
  TedNow:		       Integer;
  PerehodTED:                  Boolean; // Флаг для включения перехода дорожек ТЭД-ов
  PerehodLoco:                 Boolean; // Флаг для включения перехода дорожек катания
  StartVentVU:                 Boolean;
  DizNow:                      Byte;
  // ****************************************** //
  GameScreen:                  HWND;    // Дескриптор окна игры
  GameWindowName:              String;
  wHandle:                     Integer;
  tHandle, ProcessID, pHandle: Cardinal;
  temp:                        Cardinal;
  KM_Pos_1, Prev_KM:           Integer;
  KM_Pos_2, Prev_KM_2:         Byte;
  Prev_Diz:                    Integer;
  Vstr_Speed:                  Integer;
  Prev_KM_OP, KM_OP:           Single;  // Фактическая позиция ОП и предыдущая позиция ОП

  VentTDPitch:                 Single = -20;  // Вентиляторы ТД (ПТР) тональность
  VentTDPitchDest:             Single = -20;  // Желаемая тональность вентов ТД (ПТР) для плавного увеличения/уменьшения
  VentTDPitchIncrementer:      Single;  // Инкрементер тональности для МВ ТД
  VentTDVol:                   Single = 0;  // Вентиляторы ТД (ПТР) громкость
  VentTDVolDest:               Single = 0;
  VentPitch:                   Single = 0;
  VentPitchDest:               Single;
  VentPitchIncrementer:        Single;  // Инкрементер тональности для МВ
  ZvonokVolume:                Single;  // Громкость звонка на переезде
  ZvonokVolumeDest:            Single;
  ZvonokFreq:                  Integer; // Частота дискретизации звука звонка на переезде
  PereezdZone:                 Boolean; // Флаг - поезд в зоне (30м) переезда

  TEDNewSystem:                Boolean = True;
  CHS4tVentNewSystemOnAllLocos:Boolean = False;
  CHS8VentStarted:             Boolean;
  VentSingleVolume: Single;
  VentSingleVolumeIncrementer: Extended;
  TEDPitch, TEDPitchDest:      Single;
  ReduktorPitch:               Single;
  ReduktorVolume:              Single;
  ReduktorVolumeDest:          Single;

implementation

uses StrUtils, Variants;

{$R *.dfm}

//------------------------------------------------------------------------------//
//                   Нажатие на чекбокс перестука локомотива                    //
//------------------------------------------------------------------------------//
procedure TFormMain.cbLocPerestukClick(Sender: TObject);      // Нажатие на "Перестук локомотива"
begin
  if cbLocPerestuk.Checked=True then begin
    PrevSpeed  := 0;
    ChannelNum := 0;
  end else begin
    BASS_ChannelStop(LocoChannel[0]); BASS_ChannelStop(LocoChannel[1]);
    BASS_ChannelStop(LocoChannelPerestuk);
    BASS_StreamFree(LocoChannel[0]); BASS_StreamFree(LocoChannel[1]);
    BASS_StreamFree(LocoChannelPerestuk);
  end;
end;

//------------------------------------------------------------------------------//
//                     Нажатие на чекбокс перестука вагонов                     //
//------------------------------------------------------------------------------//
procedure TFormMain.cbWagPerestukClick(Sender: TObject);
begin
  if cbWagPerestuk.Checked = True then begin
    panelPasswagSounds.Enabled := True;
    WagF := '';
    FormMain.ClientHeight := FormMain.ClientHeight + panelPasswagSounds.Height;
  end else begin
    panelPasswagSounds.Enabled := False;
    WagF := '';
    BASS_ChannelStop(WagChannel);
    isPlayWag := False;
    FormMain.ClientHeight := FormMain.ClientHeight - panelPasswagSounds.Height;
  end;
end;

//------------------------------------------------------------------------------//
//                  Нажатие на чекбокс "Звуки ТЭД-ов и дизеля"                  //
//------------------------------------------------------------------------------//
procedure TFormMain.cbTEDsClick(Sender: TObject);
begin
	if cbTEDs.Checked=False then begin
            BASS_ChannelStop(TEDChannel ); BASS_StreamFree(TEDChannel );
            BASS_ChannelStop(TEDChannel2); BASS_StreamFree(TEDChannel2);
            BASS_ChannelStop(DizChannel ); BASS_StreamFree(DIZChannel );
            BASS_ChannelStop(DizChannel2); BASS_StreamFree(DIZChannel2);
        end else begin
            PrevTEDAmperage:=0; Prev_KM:=0;
        end;
end;

//------------------------------------------------------------------------------//
//             Подпрограмма для обновления имени используемой САВП              //
//------------------------------------------------------------------------------//
procedure TFormMain.UpdateInfoName();
begin
    if (cbSAUTSounds.Checked=False) and (cbSAVPESounds.Checked=False) and
       (cbUSAVPSounds.Checked=False)and (cbGSAUTSounds.Checked=False) then
          SAVPName := '';
end;

//------------------------------------------------------------------------------//
//             Подпрограмма для обработки нажатия на чекбокс "САУТ"             //
//------------------------------------------------------------------------------//
procedure TFormMain.cbSAUTSoundsClick(Sender: TObject);
begin
  if cbSAUTSounds.Checked=True then begin
     cbSAVPESounds.Checked:=False;cbUSAVPSounds.Checked:=False;cbGSAUTSounds.Checked:=False;cbEPL2TBlock.Checked:=False;
     DecodeResAndPlay('TWS/SAVP/USAVP/575.res', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
     //SAUTOFFF:=; SAUTOff:=True;
     isSpeedLimitRouteLoad:=False;
     SAVPName := 'SAUT';
     Load_TWS_SAVP_EK();
  end else begin
     BASS_ChannelStop(SAUTChannelObjects); BASS_StreamFree(SAUTChannelObjects);
     BASS_ChannelStop(SAUTChannelObjects2); BASS_StreamFree(SAUTChannelObjects2);
     BASS_ChannelStop(SAUTChannelZvonok); BASS_StreamFree(SAUTChannelZvonok);
     SAUTOFFF:='TWS/SAVP/SAUT/Off.mp3'; SAUTOff:=True; // Проигруем звук выключения САУТ
     UpdateInfoName;
  end;
end;

//------------------------------------------------------------------------------//
//           Подпрограмма для обработки нажатия на чекбокс "ПРС РЖД"            //
//------------------------------------------------------------------------------//
procedure TFormMain.cbPRS_RZDClick(Sender: TObject);
begin
  if (cbPRS_RZD.Checked=False) and (cbPRS_UZ.Checked=False) then begin
     BASS_ChannelStop(PRSChannel);
     BASS_StreamFree(PRSChannel);
     timerPRSswitcher.Enabled:=False;
  end;
  if (cbPRS_RZD.Checked=True) or (cbPRS_UZ.Checked=True) then timerPRSswitcher.Enabled:=True;
end;

//------------------------------------------------------------------------------//
//            Подпрограмма для обработки нажатия на чекбокс "УСАВПП"            //
//------------------------------------------------------------------------------//
procedure TFormMain.cbUSAVPSoundsClick(Sender: TObject);
begin
  if cbUSAVPSounds.Checked=True then begin
     cbSAUTSounds.Checked:=False;cbGSAUTSounds.Checked:=False;
     cbSAVPESounds.Checked:=False;
     cbEPL2TBlock.Checked:=False;
     DecodeResAndPlay('TWS/SAVP/USAVP/575.res', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
     //SAUTOFFF:='TWS/SAVP/USAVP/575.mp3';SAUTOff:=True;
     isSpeedLimitRouteLoad:=False;
     SAVPName := 'USAVPP';
     Load_TWS_SAVP_EK();
  end else begin
    FormUSAVP.Close;
    BASS_ChannelStop(SAUTChannelObjects); BASS_StreamFree(SAUTChannelObjects);
    BASS_ChannelStop(SAUTChannelObjects2); BASS_StreamFree(SAUTChannelObjects2);
    BASS_ChannelStop(SAUTChannelZvonok); BASS_StreamFree(SAUTChannelZvonok);
    UpdateInfoName;
  end;
end;

//------------------------------------------------------------------------------//
//         Подпрограмма для обработки нажатия на чекбокс "Грузовой САУТ"        //
//------------------------------------------------------------------------------//
procedure TFormMain.cbGSAUTSoundsClick(Sender: TObject);
begin
  if cbGSAUTSounds.Checked=True then begin
     cbSAVPESounds.Checked := False;cbSAUTSounds.Checked:=False;cbUSAVPSounds.Checked:=False;cbEPL2TBlock.Checked:=False;
     DecodeResAndPlay('TWS/SAVP/USAVP/575.res', isPlaySAVPEInfo, SAVPEInfoF, SAVPE_INFO_Channel, ResPotok, PlayRESFlag);
     //SAUTOFFF:='TWS/SAVP/USAVP/575.mp3'; SAUTOff:=True;
     isSpeedLimitRouteLoad:=False;
     SAVPName := 'SAUT_G';
     Load_TWS_SAVP_EK();
  end else begin
    BASS_ChannelStop(SAUTChannelObjects); BASS_StreamFree(SAUTChannelObjects);
    BASS_ChannelStop(SAUTChannelObjects2); BASS_StreamFree(SAUTChannelObjects2);
    BASS_ChannelStop(SAUTChannelZvonok); BASS_StreamFree(SAUTChannelZvonok);
    SAUTOFFF:='TWS/SAVP/SAUT/Off.mp3';
    SAUTOff:=True;      // Проигруем звук выключения САУТ
    UpdateInfoName;
  end;
end;

//------------------------------------------------------------------------------//
//                       Подпрограмма Закрытие программы                        //
//------------------------------------------------------------------------------//
procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log_.DebugFreeLog();
  try SaveTWSParams('TWS\settings_TWS.ini');  except end;   // Автосохранение всех параметров
  try Bass_Stop();               // Останавливаем проигрывание
     Bass_Free;                  // Освобождаем ресурсы используемые Bass
  except end;
end;

//------------------------------------------------------------------------------//
//                       Подпрограмма Открытие программы                        //
//------------------------------------------------------------------------------//
procedure TFormMain.FormCreate(Sender: TObject);
begin
  //if CheckInstallation=False then Application.Terminate; // Проверка правильно-ли установлена программа
  BASS_Init(-1, 44100, 0, application.Handle, nil);      // Инициализация BASS
  LoadTWSParams('TWS\settings_TWS.ini');   		 // Делаем загрузку параметров TWS

  CHS8__ := chs8_.Create;

  isGameOnPause := True;

  MainCycleFreq := ClockMain.Interval;

  SAVP.InitializeSAVP;

  SAUTOff           :=  False;    // Запрещаем проигрывание звука выключения САУТ
  isPlayPRS         :=  True;     // Запрещаем проигрывать поездную радиостанцию
  isPlayRain        :=  True;
  isPlayClock       :=  True;     // Запрещаем играть Тиканье часов при запуске скрипта
  isPlayCabinClicks :=  True;
  isSpeedLimitRouteLoad:=False;
  isPlayCompressorCycle:=True;
  isRefreshLocalData:=  True;	  // При запуске обновляем все данные нужные для функционирования программы
  isPlaySAVPEZvonok :=  True;
  isPlayStochist    :=  True;
  isPlayBeltPool    :=  True;

  Log_.DebugLogStart(Self);
  Log_.DebugWriteErrorToErrorList('TWS started');

  PerehodDIZStep:=0.01;
end;

//------------------------------------------------------------------------------//
//      Подпрограмма для обработки нажатия на чекбокс "Ручной режим" САВПЭ      //
//------------------------------------------------------------------------------//
procedure TFormMain.RB_HandEKModeClick(Sender: TObject);
begin
  WagF:='';
  cbSAVPE_Marketing.Enabled := False;
  GroupBox5.Enabled := False;
  Edit1.Enabled := False;
  Edit1.Color := clInactiveCaption;
  ComboBox2Change(FormMain);
end;

function FindTask(ExeFileName: string): Boolean;
var
  FSnapshotHandle: HWND;
  ContinueLoop: BOOL;
  FProcessEntry32: TProcessEntry32;
begin
  Result := False;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while integer(ContinueLoop) <> 0 do begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName))
     or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName)))
      then Result := True;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function GetFileCount(Dir: string):integer;
var
  fs: TSearchRec;
  pics: integer;
begin
  pics:=0;
  if FindFirst(Dir+'/*.res', faAnyFile, fs) = 0
    then
    repeat
      inc(pics);
    until
      FindNext(fs) <> 0;
  FindClose(fs);

Result := Pics-1;
end;

function TFormMain.CheckInstallation(): Boolean;
begin
    if FileExists('Launcher.exe') = False then begin
        if FileExists('ZLauncher.exe') = False then begin
           MessageDLG('Ошибка программа установлена не правильно! Установите програму в корень ZDSimulator!', mterror, mbOKCancel, 0);
           Result:=False;
        end else Result:=True;
    end else Result:=True;
end;

procedure PlayMemoryStreamFromFile(SoundFileName: String; var ChannelName: Cardinal;
				   var MemoryStreamName: TMemoryStream; StopChannel: Boolean);
var
   FS: TFileStream;
begin
   if StopChannel=True then begin
      BASS_ChannelStop(ChannelName); BASS_StreamFree(ChannelName);
   end;
   try MemoryStreamName.Free; except end;
   MemoryStreamName:=TMemoryStream.Create;
   FS := TFileStream.Create(SoundFileName, fmShareDenyNone);
   MemoryStreamName.LoadFromStream(FS);
   FS.Free;
   MemoryStreamName.Free;
end;

function CameraInCabinCheck(CameraX: Integer; Camera: Byte) : Boolean;
begin
    Result := False;
    if Camera = 0 then
       if ((CameraX<=49130) and (CameraX>=32000)) or (CameraX<16384) or (CameraX=0) then Result:=True;
end;

// === Процедура для получения границ станций из файла start_kilometers === //
procedure GetStationsBordersFromFile(fileName: String);
var
   FS: TFileStream;
   FileText: String;
   FileLinesList: TStringList;
   StationsList: TStringList;
   I: Integer;
begin
   FS := TFileStream.Create(fileName, fmShareDenyNone);
   FileText := GetStringFromFileStream(FS);
   FS.Free();
   FileLinesList := ExtractWord(FileText, #13);
   isPlayPerestuk_OnStation:=False;
   StationCount := FileLinesList.Count;
   for I := 0 to StationCount - 1 do begin
      StationsList := ExtractWord(FileLinesList[I], ' ');
      if StationsList.Count >= 3 then begin
         try
            StationTrack1[I] := StrToInt(StationsList[1]);
            StationTrack2[I] := StrToInt(StationsList[2]);
         except end;
      end;
   end;
   StationsList.Free();
   FileLinesList.Free();
end;

//------------------------------------------------------------------------------//
//                                Основной цикл                                 //
//------------------------------------------------------------------------------//
procedure TFormMain.ClockMainTimer(Sender: TObject);
var
  St: String;
  sl: TStringList;
  I, J: Integer;
  Station1, Station2: String;
  SR: TSearchRec;
  VentTimeLeft: Single;
  XVentTimeLeft: Single;
  VentTDTimeLeft: Single;
  XVentTDTimeLeft: Single;
  CompTimeLeft: Single;
  XCompTimeLeft: Single;
  Brake254TimeLeft: Single;
  singleTemp1: Single;
  singleTemp2: Single;
label
  Next1;
begin
try
   // Проверка обновления статуса открытого симулятора
   if (isConnectedMemory <> PrevConMem) Or (LocoGlobal = '') then begin
      isRefreshLocalData := True;
      LocoGlobal := '';
      if isConnectedMemory = True then
         BASS_Start
      else
         BASS_Stop;
   end;

   if isGameOnPause=False then begin
      if isConnectedMemory=True then
         ReadVarsFromRAM();

      // БЛОК ПОЛУЧЕНИЯ ДАННЫХ С ФАЙЛА Settings.ini //
      if isRefreshLocalData = True then begin
         isSpeedLimitRouteLoad := False;

         try GetStartSettingParamsFromRAM(); except end;

         // --- Грузим локальную ЭК из сценария --- //
         if SceneryName <> '' then begin
            try GetLocalEKFromScenery('routes/' + Route + '/scenaries/' + SceneryName); except end;
         end;

         try
            if Route <> '' then
               GetStationsBordersFromFile('routes/' + Route + '/start_kilometers.dat');
         except end;
      try

         ConsistLength := 0;
         if Pos('.con', ConName)>0 then begin
            Memo1.Lines.LoadFromFile('data\consists\'+ConName);
            sl := TStringList.Create;
            for I:=0 to Memo1.Lines.Count-1 do begin
               try
                  St := Memo1.Lines[I];
                  if St[1]<>';' then begin
                     ExtractStrings([#9], [' '], PChar(St), sl);
                     ConsistLength := ConsistLength + StrToFloat(sl[2]);
                  end;
               except end;
            end;
            sl.Free;
            ConsistLength := ConsistLength + 18*LocoSectionsNum;
         end else begin
            if Freight=1 then begin
               ConsistLength := 14*WagsNum+18*LocoSectionsNum;
            end else begin
               ConsistLength := 25*WagsNum+18*LocoSectionsNum;
            end;
         end;

         if Freight=1 then RadioButton2.Checked:=True else RadioButton1.Checked:=True;	// Автовыбор типа вагонов для их перестука
         if naprav='1' then naprav:='Tuda' else naprav:='Obratno';
         if LocoGlobal='3154' then LocoGlobal:='ED4M';
         if LocoGlobal='3159' then LocoGlobal:='ED9M';
         if LocoGlobal='23152' then LocoGlobal:='2ES5K';
         if LocoGlobal='31714' then LocoGlobal:='EP1m';
         if LocoGlobal='343' then LocoGlobal:='CHS2K';
         if LocoGlobal='523' then LocoGlobal:='CHS4';
         if LocoGlobal='621' then LocoGlobal:='CHS4t';
         if LocoGlobal='524' then LocoGlobal:='CHS4 KVR';
         if LocoGlobal='812' then LocoGlobal:='CHS8';
         if LocoGlobal='822' then LocoGlobal:='CHS7';
         if LocoGlobal='811' then LocoGlobal:='VL11m';
         if LocoGlobal='882' then LocoGlobal:='VL82m';
         if LocoGlobal='880' then LocoGlobal:='VL80t';
         if LocoGlobal='885' then LocoGlobal:='VL85';
         if LocoGlobal='201318' then LocoGlobal:='TEM18dm';
         if LocoGlobal='2070' then LocoGlobal:='TEP70';
         if LocoGlobal='2071' then LocoGlobal:='TEP70bs';
         if LocoGlobal='21014' then LocoGlobal:='2TE10U';
         if LocoGlobal='1462' then LocoGlobal:='M62';
         Loco:=LocoGlobal;

         RefreshMVPSType();

         InitializeStartParams(VersionID);		// Обновляем адреса и данные по локомотивам

         // Сверяем локомотивы и приравниваем их звуки
       	 if Loco='ED9M' then Loco:='ED4M';
       	 if Loco='M62' then Loco:='2TE10U';
  	 if Loco='CHS8' then Loco:='CHS7_8';
  	 if Loco='CHS7' then Loco:='CHS7_8';
  	 if Loco='CHS4' then Loco:='CHS4T';
  	 if Loco='CHS4 KVR' then Loco:='CHS4T';
         if Loco='TEP70bs' then Loco:='TEP70';

      except end;

      if scSAVPOverrideRouteEK = False then
         Load_TWS_SAVP_EK();
   end;

   isCameraInCabin := CameraInCabinCheck(CameraX, Camera);

   if NapravOrdinata = 'Tuda' then
      OrdinataEstimate := OrdinataEstimate + (Speed / 3600 * MainCycleFreq)
   else
      OrdinataEstimate := OrdinataEstimate - (Speed / 3600 * MainCycleFreq);

  // ************************************************ //
  // ********* БЛОК ОБРАБОТКИ ЗВУКОВ ТЭД-ов ********* //
  if cbTEDs.Checked=True then begin
     if LocoWithTED=True then begin
        // ------/------ ЧС и ВЛ ТЭД-ы ------/------ //
        if TEDNewSystem = False then begin
           J:=0; TedFound:=False;
           for I:=0 to TEDBaseNumElem do begin
              if (TEDBase[J]<=Speed) and (TEDBase[J+1]>Speed) then begin
                 if TEDBase[J+1]<>10000 then TEDF:=PChar('TWS/'+LocoTEDNamePrefiks+'/ted '+IntToStr(TEDBase[J])+'-'+IntToStr(TEDBase[J+1])+'.wav');
                 if TEDBase[J+1]=10000 then TEDF:=PChar('TWS/'+LocoTEDNamePrefiks+'/ted '+IntToStr(TEDBase[J])+'-~.wav');
                 TedNow := TEDBase[J]; TedFound:=True; Break;
              end;
              Inc(J, 2);
           end;
           if TEDFound=False then begin TEDF:=PChar('');BASS_ChannelStop(TEDChannel);BASS_ChannelStop(TEDChannel2);end;	// Если ничего не нашли - то тормозим воспроизведение дорожек ТЭД
           if PerehodTED = False then begin
              try
                 if TEDAmperage<>0 then TEDvlm := TEDAmperage / (UltimateTEDAmperage/140) else
                 if EDTAmperage<>0 then TEDvlm := EDTAmperage / (UltimateTEDAmperage/140) else
                    TEDVlm := 0.0;

                 // Меняем громкость ТЭД-ов в зависимости от того какая выбрана камера
                 if isCameraInCabin=True then TEDVlm:=TEDVlm/130 else TEDVlm:=TEDVlm/100;
                 PerehodTEDStep := 0.01;
              except end;
           end;
           // Делаем затухание
           if TEDAmperage+EDTAmperage=0 then begin
              TEDF := PChar(' ');
              BASS_ChannelSetAttribute(TEDChannel, BASS_ATTRIB_VOL, 0);
              BASS_ChannelSetAttribute(TEDChannel2, BASS_ATTRIB_VOL, 0);
           end;
        end else begin
           // Новая система прогрывания звуков ТЭД-ов
           TEDF := PChar('TWS/'+LocoTEDNamePrefiks+'/ted.wav');
           if BASS_ChannelIsActive(TEDChannel_FX)=0 then begin ChannelNumTED:=0; isPlayTED:=False; end;
           // Задаём громкость звуков ТЭД
           if Speed > 7 then begin
              if LocoTEDNamePrefiks <> 'ED4m' then begin
                 if TEDAmperage<>0 then TEDvlm := (TEDAmperage / (UltimateTEDAmperage*0.75)) * (trcBarTedsVol.Position/100) else
                 if EDTAmperage<>0 then TEDvlm := (EDTAmperage / (UltimateTEDAmperage*0.75)) * (trcBarTedsVol.Position/100) else
                    TEDVlm := 0.0;
              end else begin
                 if KME_ED <> 0 then begin
                    TEDVlm := (TEDPitch+35) / 35;
                 end else begin
                    if TEDVlm > 0 then TEDVlm := TEDVlm - 0.05;
                 end;
              end;
           end else TEDVlm := 0.0;

           if LocoTEDNamePrefiks = 'CHS_TED' then TEDPitchDest := power(Speed * 2350, 0.3) - 35;
           if LocoTEDNamePrefiks = 'EP_TED' then begin
              TEDPitchDest := power(Speed * 2350, 0.3) - 35;
              ReduktorPitch := (power(Speed*100, 0.3) - 30) * 2 + 30;
              ReduktorVolume := (3-(Speed/50))*power((TEDAmperage / (UltimateTEDAmperage * 0.8)),2);
              BASS_ChannelSetAttribute(ReduktorChannel_FX, BASS_ATTRIB_Vol, ReduktorVolume * trcBarTedsVol.Position / 100);
              BASS_ChannelSetAttribute(ReduktorChannel_FX, BASS_ATTRIB_TEMPO_PITCH, ReduktorPitch);
              if BASS_ChannelIsActive(ReduktorChannel_FX) = 0 then begin
                 ReduktorF := PChar('TWS/'+LocoReductorNamePrefiks+'/ted_2.wav');
                 isPlayReduktor := False;
              end;
           end;
           if LocoTEDNamePrefiks = 'VL_TED'  then begin
              if Speed <= 65 then TEDPitchDest := power(Speed*18.8, 0.5) - 35;
              if Speed >  65 then TEDPitchDest := (Speed - 65) / 8;
           end;
           if LocoTEDNamePrefiks = 'ED4m' then TEDPitchDest := power(Speed * 2350, 0.3) - 35;

           if TEDPitch > TEDPitchDest then TEDPitch := TEDPitch - 0.005 * MainCycleFreq;
           if TEDPitch < TEDPitchDest then TEDPitch := TEDPitch + 0.005 * MainCycleFreq;

           BASS_ChannelSetAttribute(TEDChannel_FX, BASS_ATTRIB_TEMPO_PITCH, TEDPitch);
        end;
     end;
     // ------/------ ЧС и ВЛ ТЭД-ы [Конец блока] ------/------ //

     // -----/----- Звуки дизелей -----/----- //
     if LocoWithDIZ=True then begin
        // Условие проверки запуска дизеля
        if (BV<>0) or ((diesel2<>0) and (LocoSectionsNum=2)) then begin
           if PerehodDIZ = False then begin
              if ((BV<>0) and (PrevBV=0)) or ((diesel2<>0) and (PrevDiesel2=0)) then Prev_Diz:=-1;	// Запуск дизеля
              if (BV<>0) and (diesel2=0) then begin
                 if DizNow>KM_Pos_1 then Dec(DizNow);
                 if DizNow<KM_Pos_1 then Inc(DizNow);
              end else begin
                 if diesel2<>0 then begin
                    if DizNow>KM_Pos_2 then Dec(DizNow);
                    if DizNow<KM_Pos_2 then Inc(DizNow);
                 end;
              end;
              dizF := PChar('TWS/'+LocoDIZNamePrefiks+'/diesel/x'+IntToStr(DizNow)+'.wav');
              // Условие запуска нового/первого звука дизеля
              if (DizNow<>Prev_Diz) or
                 ((BV+diesel2<>0) and (BASS_ChannelIsActive(DizChannel)+BASS_ChannelIsActive(DizChannel2) = 0))
              then begin
                 isPlayDiz:=False; Prev_Diz:=DizNow; TimerPerehodDizSwitch.Enabled:=True;
              end;
           end;
        end;

        // Остановка звуков дизеля, если он заглушен в симуляторе
        if BV+diesel2=0 then begin
           if BASS_ChannelIsActive(TEDChannel_FX)<>0 then begin
              BASS_ChannelStop(TEDChannel);  BASS_StreamFree(TEDChannel);
              BASS_ChannelStop(TEDChannel_FX);  BASS_StreamFree(TEDChannel_FX);
           end;
           if BASS_ChannelIsActive(TEDChannel2)<>0 then begin
              BASS_ChannelStop(TEDChannel2); BASS_StreamFree(TEDChannel2);
           end;
           if BASS_ChannelIsActive(DizChannel)<>0 then begin
              BASS_ChannelStop(DizChannel);  BASS_StreamFree(DizChannel);
           end;
           if BASS_ChannelIsActive(DizChannel2)<>0 then begin
              BASS_ChannelStop(DizChannel2); BASS_StreamFree(DizChannel2);
           end;
        end;
     end;
     // -----/----- Конец блока звуков дизелей -----/----- //

     if TEDvlm > trcBarTedsVol.Position/100 then TEDvlm := trcBarTedsVol.Position/100;

     // Блок задачи громкости ТЭД-ам и дизелям
     if (PerehodTED=False) and (Camera<>2) then begin
        if ChannelNumTED=1 then BASS_ChannelSetAttribute(TEDChannel_FX , BASS_ATTRIB_VOL, TEDvlm)
           else BASS_ChannelSetAttribute(TEDChannel2, BASS_ATTRIB_VOL, TEDvlm);
     end else begin
        if Camera=2 then begin
           BASS_ChannelSetAttribute(TEDChannel_FX, BASS_ATTRIB_VOL, 0);
           BASS_ChannelSetAttribute(TEDChannel2, BASS_ATTRIB_VOL, 0);
        end;
     end;

     if TedNow<>Prev_KM then begin
        isPlayTED:=False; Prev_KM := TedNow;
     end;
  end;
  // ********************************************** //
  // БЛОК ЗВУКОВ ОКРУЖЕНИЯ //
  if cbNatureSounds.Checked = True then begin
     if Winter = 0 then begin
  	if Rain>=80 then Rain:=Trunc(Rain/80) else if Rain>0 then Rain:=1;
        if Rain<>PrevRain then begin
           Case Rain Of
              1: RainF:=PChar('TWS/storm.wav');
              2: RainF:=PChar('TWS/storm1.wav');
              3: RainF:=PChar('TWS/storm2.wav');
           end;
           isPlayRain:=False;
        end;
        if Track=0 then Rain:=0;
        if Rain=0 then begin BASS_ChannelStop(Rain_Channel); BASS_StreamFree(Rain_Channel); end;
     end else begin
        if OutsideLocoStatus <> 0 then begin
           if GetAsyncKeyState(37) + GetAsyncKeyState(39) <> 0 then begin
              WalkSoundF := PChar('TWS/snow_walk.wav');
              isPlayWalkSound := True;
           end else begin
              if BASS_ChannelIsActive(WalkSoundChannel) <> 0 then begin
                 BASS_ChannelStop(WalkSoundChannel); BASS_StreamFree(WalkSoundChannel);
              end;
           end;
        end;
     end;

     // Стеклоочистители, звуки
     if Stochist<>Prev_Stochist then begin
            if Stochist=4 then begin StochistF:=PChar('TWS/stochist.wav'); isPlayStochist:=False end else begin
            if Stochist=8 then begin StochistF:=PChar('TWS/stochist2.wav'); isPlayStochist:=False end
            else begin BASS_ChannelStop(Stochist_Channel); BASS_StreamFree(Stochist_Channel) end;
         end;
     end;
     // Если скорость стеклоочестителей 2-ая, то делаем звук удара об края стекла
     if Stochist=8 then begin
         if ((StochistDGR>120) and (Prev_StchstDGR<=120)) or
            ((StochistDGR<55) and (Prev_StchstDGR>=55)) then isPlayStochistUdar:=False;
     end;
  end;
  // ***************** //
  // БЛОК ЗАПУСКА И ОСТАНОВКИ ФАЗОРАСЩЕПИТЕЛЯ НА ВЛ80т //
  if (LocoGlobal='VL80t') and (cbVspomMash.Checked=True) then begin
     if Fazan <> PrevFazan then begin
        if Fazan =0 then LocoPowerEquipmentF:=PChar('TWS/VL80t/FR-stop.wav');
        if Fazan<>0 then LocoPowerEquipmentF:=PChar('TWS/VL80t/FR-pusk.wav');
        isPlayLocoPowerEquipment:=False;
     end;
  end;
  // ************************************************* //
  // БЛОК ЗВУКОВ ЩЕЛЧКОВ НА ЛОКОМОТИВАХ //
  if cbCabinClicks.Checked=True then begin
     // Щелчки кранов машиниста //
     if (KM_395<>PrevKM_395) and (KM_395<>1) and (KM_395<>6) then begin
        CabinClicksF:=PChar('TWS/stuk395.wav'); isPlayCabinClicks:=False;
     end;
     if (KM_294<>PrevKM_294) then begin
        if (KM_294<>-1) and (PrevKM_294<>-1) and (Loco<>'ED4M') then begin
           CabinClicksF:=PChar('TWS/stuk254.wav'); isPlayCabinClicks:=False;
        end;
     end;
     PrevKM_395 := KM_395;
     PrevKM_294 := KM_294;

     // Щелчок ключа ЭПК //
     if (GetAsyncKeyState(78)<>0) and (PrevKeyEPK=0) then
        if (GetAsyncKeyState(16)<>0) or (GetAsyncKeyState(16)=0) then begin
              IMRZashelka:=PChar('TWS/epk.wav'); isPlayIMRZachelka:=False; PrevKeyEPK:=1;
        end;
     if GetAsyncKeyState(16)+GetAsyncKeyState(78)=0 then PrevKeyEPK:=0;

     // Звук защелки
     if (Pos('CHS', Loco)>0) and (Loco<>'CHS2K') then begin
        if ((Prev_KMAbs=0) and (KM_Pos_1>0)) or ((KM_Pos_1=0) and (Prev_KMAbs>0)) then begin
           IMRZashelka:=PChar('TWS/EM_zashelka.wav'); isPlayIMRZachelka:=False;
        end;
        if PrevReostat + Reostat = 1 then begin
           IMRZashelka:=PChar('TWS/EM_zashelka.wav'); isPlayIMRZachelka:=False;
        end;
     end;
     // БЛОК ЩЕЛЧКА КОНТРОЛЛЕРА //
     if LocoWithSndKM = True then begin
        if LocoSndReversorType = 1 then ReversorPos := 1;	// Локомотивы на которых не удалось отследить положение реверсора
        if ReversorPos<>0 then begin
           if (LocoWithSndKM_OP = True) and (LocoGlobal <> 'CHS8') then begin
              if KM_OP<>Prev_KM_OP then begin
                 CabinClicksF:=PChar('TWS/stukKM_sunty.wav'); isPlayCabinClicks:=False;
                 PrevKeyA:=1; PrevKeyD:=1; PrevKeyE:=1; PrevKeyQ:=1;
              end;
           end;

           if KM_Pos_1 <> Prev_KMAbs then begin
              if LocoGlobal = 'M62' then begin
                 CabinClicksF:=PChar('TWS/M62/throttle.wav'); isPlayCabinClicks:=False;
              end;
              if Loco = 'ED4M' then begin
                 if (LocoNum < 160) and (LocoGlobal = 'ED4M') then
                    CabinClicksF:=PChar('TWS/ED4m/stukKM.wav')
                 else
                    CabinClicksF:=PChar('TWS/ED4m/CPPK_stukKM.wav');
                 try
                    if ((KM_Pos_1 - Prev_KMAbs) mod 256=0) Or (LocoGlobal = 'ED9M') then
                       isPlayCabinClicks:=False;
                 except end;
              end;
           end;

           if (KM_OP+getasynckeystate(16)=0) and (Loco <> 'ED4M') and (LocoGlobal<>'M62') and
              (LocoGlobal <> 'CHS8') then begin
              // -/- A -/- //
              if (getasynckeystate(65)<>0) and (PrevKeyA=0) then begin
                 if KMPrevKey<>'E' then CabinClicksF:=PChar('TWS/stukKM.wav') else CabinClicksF:=PChar('TWS/stukKM_-A-0.wav');
                 isPlayCabinClicks:=False;
                 PrevKeyA:=1; KMPrevKey:='A';
              end;
              // -/- D -/- //
              if (getasynckeystate(68)<>0) and (PrevKeyD=0) then begin
                    if KMPrevKey<>'E' then
                       CabinClicksF:=PChar('TWS/stukKM.wav')
                    else
                       CabinClicksF:=PChar('TWS/stukKM_-A-0.wav');
                 isPlayCabinClicks:=False;
                 PrevKeyD:=1; KMPrevKey:='D';
              end;
              if Loco<>'ED4M' then begin
                 // -/- E -/- //
                 if (getasynckeystate(69)<>0) and (PrevKeyE=0) then begin
                    if KMPrevKey<>'E' then
                       CabinClicksF:=PChar('TWS/stukKM_0_-A.wav');
                    isPlayCabinClicks:=False;
                    PrevKeyE:=1; KMPrevKey:='E';
                 end;
                 // -/- Q -/- //
                 if (getasynckeystate(81)<>0) and (PrevKeyQ=0) then begin
                    if KMPrevKey<>'E' then
                       CabinClicksF:=PChar('TWS/stukKM.wav')
                    else
                       CabinClicksF:=PChar('TWS/stukKM_-A-0.wav');
                    isPlayCabinClicks:=False;
                    PrevKeyQ:=1; KMPrevKey:='Q';
                 end;
              end;
           end;
        end;

        if LocoGlobal = 'CHS8' then
           CHS8__.kr21_step();

        if getasynckeystate(65)=0 then PrevKeyA:=0; if getasynckeystate(68)=0 then PrevKeyD:=0;
        if getasynckeystate(69)=0 then PrevKeyE:=0; if getasynckeystate(81)=0 then PrevKeyQ:=0;
     end;
     // БЛОК ЩЕЛЧКА РЕВЕРСИВКИ //
     if LocoWithSndReversor=True then begin
        if LocoSndReversorType = 1 then begin
           if KM_Pos_1=0 then begin
              if (PrevKeyW=0) and (GetAsyncKeyState(87)<>0) then begin
                 CabinClicksF:=RevPosF; isPlayCabinClicks:=False; PrevKeyW:=1;
              end;

              if (PrevKeyS=0) and (GetAsyncKeyState(83)<>0) then begin
                 CabinClicksF:=RevPosF; isPlayCabinClicks:=False; PrevKeyS:=1;
              end;
           end;

           if GetAsyncKeyState(83)=0 then PrevKeyS:=0; if GetAsyncKeyState(87)=0 then PrevKeyW:=0;
        end;

        if LocoSndReversorType = 0 then
           if ReversorPos<>PrevReversorPos then begin
              CabinClicksF:=RevPosF;
              isPlayCabinClicks:=False;
           end;
     end;
     // --- Включение прожектора(тумблер) --- //
     if Highlights<>PrevHighLights then begin
        if Loco = 'ED4M' then begin
           LocoPowerEquipmentF := PChar('TWS/ED4m/vkl.wav');
           isPlayLocoPowerEquipment := False;
        end;
        if LocoGlobal = 'CHS2K' then begin
           LocoPowerEquipmentF := PChar('sound/chs7/tumbler.wav');
           isPlayLocoPowerEquipment := False;
        end;
     end;
     // --- ЭПТ(тумблер) --- //
     if EPT <> PrevEPT then begin
        if Loco = 'ED4M' then begin
           LocoPowerEquipmentF := PChar('TWS/ED4m/tumbler.wav');
           isPlayLocoPowerEquipment:=False;
        end;
        if LocoGlobal = 'CHS2K' then begin
           LocoPowerEquipmentF := PChar('sound/chs7/tumbler.wav');
           isPlayLocoPowerEquipment := False;
        end;
     end;
     // ЗВУК ВКЛЮЧЕНИЯ БВ //
     if Loco='ED4M' then begin
  	if (BV<>PrevBV) Or (FrontTP<>PrevFrontTP) then begin
           LocoPowerEquipmentF := PChar('TWS/ED4m/tumbler.wav');
           isPlayLocoPowerEquipment:=False;
        end;
        // БЛОК ОТКРЫТИЯ РАЗОБЩИТЕЛЬНОГО КРАНА //
        if PrevKeyKKR = 0 then begin
           if GetAsyncKeyState(76) <> 0 then begin
              IMRZashelka:=PChar('TWS/TM_Kran.wav'); isPlayIMRZachelka:=False; PrevKeyKKR:=1;
           end;
        end else begin
           if (GetAsyncKeyState(16)=0) and (GetAsyncKeyState(76)=0) then PrevKeyKKR:=0;
        end;
     end;
  end;
  // ***************** //
  // БЛОК ЗВУКОВ ПОДНЯТИЯ ОПУСКАНИЯ ТП //
  if cbTPSounds.Checked=True then begin
     if LocoWithSndTP = True then begin
        if Loco<>'ED4M' then begin
           if (FrontTP=63) and (FrontTP<>PrevFrontTP) then begin isPlayFTP:=False; FTPF:=PChar('TWS/TPUp.wav'); end;
           if (FrontTP<>63) and (PrevFrontTP=63) and (PrevFrontTP<>188) then begin isPlayFTP:=False; FTPF:=PChar('TWS/TPDown.wav'); end;
           if (BackTP=63) and (BackTP<>PrevBackTP) then begin isPlayBTP:=False; BTPF:=PChar('TWS/TPUp.wav'); end;
           if (BackTP<>63) and (PrevBackTP=63) and (PrevBackTP<>188) then begin isPlayBTP:=False; BTPF:=PChar('TWS/TPDown.wav'); end;
        end else begin
           if FrontTP<>PrevFrontTP then begin
              if FrontTP=1 then FTPF:=PChar('TWS/ED4m/TPUp.wav');
              if FrontTP=0 then FTPF:=PChar('TWS/ED4m/TPDown.wav');
              isPlayFTP:=False;
           end;
        end;
     end;
  end;
  // ********************************* //
  // ИГРАЕМ ПЕРЕСТУК ЕСЛИ МЫ НА СТАНЦИИ //
  if cbLocPerestuk.Checked=True then begin
     if StationCount > 0 then begin
        isPlayPerestuk_OnStation := False;
        for I := 0 to StationCount - 1 do begin
           if (Track <= StationTrack1[I] + 10) and
              (Track >= StationTrack2[I] - 10)
           then begin
              isPlayPerestuk_OnStation := True;

              if PrevPerestukStation = False then begin
                 PrevSpeed := 0;
                 TimerPlayPerestukTimer(FormMain);
              end;
           end;
        end;
     end;
  end;
  // ************************ //
  // БЛОК ЗВУКОВ КЛУБ и 3сл2м //
  if (isConnectedMemory=True) then begin
     if cbKLUBSounds.Checked=True then begin	// КЛУБ
        // Нажатие РБ и РБС
        if RB<>PrevRB then begin
           if RB=1 then begin RBF:=PChar('TWS/KLUB_pick.wav'); isPlayRB:=False; end;
           if RB=0 then begin RBF:=PChar('TWS/KLUB_pick.wav'); isPlayRB:=False; end;
        end;

        if RBS<>PrevRBS then begin
           if RBS=1 then begin RBF:=PChar('TWS/KLUB_pick.wav'); isPlayRB:=False; end;
           if RBS=0 then begin RBF:=PChar('TWS/KLUB_pick.wav'); isPlayRB:=False; end;
        end;
        // Пиканья при ограничении
        if(OgrSpeed-Speed<=3) and (isPlayOgrSpKlub=0) and (OgrSpeed<>0) and (Svetofor<>0) then isPlayOgrSpKlub:=1;
        if((OgrSpeed-Speed>3) and (isPlayOgrSpKlub=-1)) or ((OgrSpeed=0) and (isPlayOgrSpKlub=-1)) then begin
           BASS_ChannelStop(Ogr_Speed_KLUB); BASS_StreamFree(Ogr_Speed_KLUB); isPlayOgrSpKlub:=0; end;
        if ((getasynckeystate(9)<>0) and (PrevKeyTAB=0)) then begin isPlayBeltPool:=False; PrevKeyTAB := 1; end;
        if getasynckeystate(9)=0 then begin
           PrevKeyTAB:=0;
           BASS_SampleStop(BeltPool_Channel); BASS_StreamFree(BeltPool_Channel);
        end;
        // Проверка бдительности
        if (PrevVCheck<>VCheck) and (VCheck=1) then isPlayVcheck:=False;

        if NextOgrPeekStatus = 0 then begin
           if PrevOgrSpeed > OgrSpeed then begin
              if NextOgrSpeed <> 0 then begin
                 isPlayVcheck := False; NextOgrPeekStatus := 1;
              end;
           end;
        end;
        if NextOgrPeekStatus = 1 then begin
           if NextOgrSpeed <> PrevNextOgrSpeed then NextOgrPeekStatus := 0;
           if NextOgrSpeed = 0 then NextOgrPeekStatus := 0;
        end;

        //end;
     end;
     if cb3SL2mSounds.Checked=True then begin	// 3сл2м
        // Нажатие РБ и РБС
        if RB<>PrevRB then begin
           if RB=1 then begin RBF:=PChar('TWS/RB_MexDown.wav'); isPlayRB:=False; end;
           if RB=0 then begin RBF:=PChar('TWS/RB_MexUp.wav'); isPlayRB:=False; end;
        end;

        if RBS<>PrevRBS then begin
           if RBS=1 then begin RBF:=PChar('TWS/RB_MexDown.wav'); isPlayRB:=False; end;
           if RBS=0 then begin RBF:=PChar('TWS/RB_MexUp.wav'); isPlayRB:=False; end;
        end;

        // Звук протяжки ленты по нажатию кл. <TAB>
        if getasynckeystate(9)<>0 then begin
           if (PrevKeyTAB=0) and (GetAsyncKeyState(56)=0) then begin
              isPlayBeltPool:=False;
              PrevKeyTAB := 1;
           end;
        end else begin
           PrevKeyTAB:=0;
           BASS_SampleStop(BeltPool_Channel); BASS_StreamFree(BeltPool_Channel);
        end;

        // Звук тиканья часового механизма 3СЛ2м на стоянке
        if ((Speed<=0) and (PrevSpeed_Fakt>0)) or ((Speed>2) and (PrevSpeed_Fakt<=2)) then Timer3SL2m_3Sec.Enabled := True;
        if BASS_ChannelIsActive(ClockChannel)=0 then isPlayClock:=False;
        if (PrevConMem=True) and (isConnectedMemory=False) then begin BASS_ChannelStop(ClockChannel); BASS_StreamFree(ClockChannel); end;
     end;
  end;
  // ********************** //
  // БЛОК ПРОИГРЫВАНИЯ УДАРА СЦЕПКИ НА МВПС //
  if (Loco='ED4M') and (cbLocPerestuk.Checked=True) and (isUPU=False) then begin
      if (Acceleretion>0) and (PrevAcceleretion=0) and (Speed<1) then begin
         J:=Random(9);
         TrogF := PChar('TWS/ED4m/Stuk-Trog/Stuk-Trog-I-'+IntToStr(J)+'.wav');
         isPlayTrog:=False;
      end;
      if (Speed=0) and (PrevSpeed_Fakt<>0) and (Acceleretion<=-0.6) then begin
         TrogF := PChar('TWS/ED4m/prib.wav');
         isPlayTrog:=False;
      end;
  end;
  // ************************************** //
  // БЛОК МНОГОСТРАДАЛЬНОГО ВСТРЕЧНОГО ПОЕЗДА //
  if (cbHeadTrainSound.Checked = True) and (VstrTrack<>0) then begin
     try
        if VstrechStatus<>PrevVstrechStatus then begin
           isVstrechDrive := True; VstrechStatusCounter := 0;
        end;
        if isVstrechDrive = True then begin
           if ((Track-VstrTrack>Trunc((WagNum_Vstr/TrackLength*(Vstrecha_dlina/WagNum_Vstr)))) and (Naprav='Tuda')) then
              isVstrechDrive := False;
           if ((VstrTrack-Track>Trunc((WagNum_Vstr/TrackLength*(Vstrecha_dlina/WagNum_Vstr)))) and (Naprav='Obratno')) then
              isVstrechDrive := False;

           if (VstrechStatus = PrevVstrechStatus) then
              Inc(VstrechStatusCounter);
           if (VstrechStatusCounter >= 40) then
              isVstrechDrive := False;
        end;
        if ((naprav = 'Tuda') and (PrevVstrTrack < VstrTrack)) Or
           ((naprav = 'Obratno') and (PrevVstrTrack > VstrTrack)) then
           HeadTrainEndOfTrain := False;
        if (BASS_ChannelIsActive(Vstrech) = 0) and (isVstrechDrive = True) and (HeadTrainEndOfTrain = False) then begin
           if ((Track>=VstrTrack) and (naprav='Tuda') and (MP<>1)) or
              ((Track<=VstrTrack) and (naprav='Obratno') and (MP<>1)) or
              ((Track>=VstrTrack) and (naprav='Tuda') and (MP=1) and (Vstr_Speed>40)) or
              ((Track<=VstrTrack) and (naprav='Obratno') and (MP=1) and (Vstr_Speed>40)) then begin
                 isPlayVstrech := False; Track_Vstrechi := Track;
                 if WagNum_Vstr<=23 then VstrechF:=PChar('TWS/Pass_vstrech.wav');
                 if WagNum_Vstr>23 then VstrechF:=PChar('TWS/Freight_vstrech.wav');
           end;
        end;

        if BASS_ChannelIsActive(Vstrech) <> 0 then begin
           if VstrZat = False then begin
              if ((Track-VstrTrack>Trunc((WagNum_Vstr/TrackLength*(Vstrecha_dlina/WagNum_Vstr)))) and (Naprav='Tuda'))
              Or ((isVstrechDrive=False)) then begin
                 VstrZat := True; VstrVolume:=100; HeadTrainEndOfTrain := True;
              end;
              if ((VstrTrack-Track>Trunc((WagNum_Vstr/TrackLength*(Vstrecha_dlina/WagNum_Vstr)))) and (Naprav='Obratno'))
              Or ((isVstrechDrive=False)) then begin
                 VstrZat := True;VstrVolume:=100; HeadTrainEndOfTrain := True;
              end;
              if (MP=1) and (Vstr_Speed<=40) then begin
                 VstrZat := True; VstrVolume:=100; HeadTrainEndOfTrain := True;
              end;
           end;
        end;
     except end;
  end;
  // **** КОНЕЦ БЛОКА ВСТРЕЧНОГО ПОЕЗДА **** //
  // БЛОК СВИСТКОВ-ТИФОНОВ //
  if (cbSignalsSounds.Checked = True) and (Track <> 0) then begin
     // СВИСТКИ
     if Svistok<>0 then begin
         if BASS_ChannelIsActive(SvistokCycleChannel) = 0 then begin
            if FileExists(LocoWorkDir + LocoSvistokF + '_start.wav') then begin
               if isCameraInCabin=True then begin
                  TWS_PlaySvistok(LocoWorkDir + LocoSvistokF + '_start.wav');
                  TWS_PlaySvistokCycle(LocoWorkDir + LocoSvistokF + '_loop.wav');
               end else begin
                  TWS_PlaySvistok(LocoWorkDir + 'x_' + LocoSvistokF + '_start.wav');
                  TWS_PlaySvistokCycle(LocoWorkDir + 'x_' + LocoSvistokF + '_loop.wav');
               end;
            end;
         end;
     end else begin
         if BASS_ChannelIsActive(SvistokCycleChannel) <> 0 then begin
            if FileExists(LocoWorkDir + LocoSvistokF + '_stop.wav') then begin
               BASS_ChannelStop(SvistokCycleChannel); BASS_StreamFree(SvistokCycleChannel);
               if isCameraInCabin=True then begin
                  TWS_PlaySvistok(LocoWorkDir + LocoSvistokF + '_stop.wav');
               end else begin
                  TWS_PlaySvistok(LocoWorkDir + 'x_' + LocoSvistokF + '_stop.wav');
               end;
            end;
         end;
     end;
     // ТИФОНЫ
     if Tifon<>0 then begin
         if BASS_ChannelIsActive(TifonCycleChannel) = 0 then begin
            if FileExists(LocoWorkDir + LocoHornF + '_start.wav') then begin
               if isCameraInCabin=True then begin
                  TWS_PlayTifon(LocoWorkDir + LocoHornF + '_start.wav');
                  TWS_PlayTifonCycle(LocoWorkDir + LocoHornF + '_loop.wav');
               end else begin
                  TWS_PlayTifon(LocoWorkDir + 'x_' + LocoHornF + '_start.wav');
                  TWS_PlayTifonCycle(LocoWorkDir + 'x_' + LocoHornF + '_loop.wav');
               end;
            end;
         end;
     end else begin
         if BASS_ChannelIsActive(TifonCycleChannel) <> 0 then begin
            if FileExists(LocoWorkDir + LocoHornF + '_stop.wav') then begin
               BASS_ChannelStop(TifonCycleChannel); BASS_StreamFree(TifonCycleChannel);
               if isCameraInCabin=True then TWS_PlayTifon(LocoWorkDir + LocoHornF + '_stop.wav')
                  else TWS_PlayTifon(LocoWorkDir + 'x_' + LocoHornF + '_stop.wav');
            end;
         end;
     end;
  end;
  // ********************* //
  // БЛОК ВСПОМ-МАШИН //
  if cbVspomMash.Checked=True then begin
      if StopBrake254 = False then begin
         if BASS_ChannelIsActive(Brake254_Channel_FX[0]) <> 0 then begin
            Brake254TimeLeft := BASS_ChannelBytes2Seconds(Brake254_Channel_FX[0], BASS_ChannelGetLength(Brake254_Channel_FX[0], BASS_POS_BYTE) - BASS_ChannelGetPosition(Brake254_Channel_FX[0], BASS_POS_BYTE));
            if (Brake254TimeLeft <= 0.2) and (BASS_ChannelIsActive(Brake254_Channel_FX[1])=0) then isPlayCycleBrake254:=False;
         end;
      end;

      //if StopBrake254 = False then begin
         singleTemp1 := TC - PrevTC;
         singleTemp2 := Abs(singleTemp1) * 400000;
         if Abs(singleTemp2) > 30 then begin
            TCIncrementer := 0;
            if (singleTemp1) < 0 then begin
               Brake254F := PChar('TWS\254_vypusk_start.wav');
               CycleBrake254F := PChar('TWS\254_vypusk_loop.wav');
            end else begin
               Brake254F := PChar('TWS\254_vpusk_start.wav');
               CycleBrake254F := PChar('TWS\254_vpusk_loop.wav');
            end;

            if (BASS_ChannelIsActive(Brake254_Channel_FX[1]) = 0) then begin
               if (BASS_ChannelIsActive(Brake254_Channel_FX[0]) = 0) Or
                  ((BASS_ChannelIsActive(Brake254_Channel_FX[0])<> 0)And(StopBrake254=True)) then
               begin
                  isPlayBrake254 := False;
                  StopBrake254 := False;
               end;
            end;

            BASS_ChannelSetAttribute(Brake254_Channel_FX[0], BASS_ATTRIB_VOL, singleTemp2/100);
            BASS_ChannelSetAttribute(Brake254_Channel_FX[1], BASS_ATTRIB_VOL, singleTemp2/100);
         end else begin
            if singleTemp2 <= 30 then begin
               Inc(TCIncrementer);
               if TCIncrementer > Trunc(MainCycleFreq/5) then begin
                  if (singleTemp1) < 0 then begin
                     Brake254F := PChar('TWS\254_vypusk_stop.wav');
                     CycleBrake254F := PChar('');
                  end else begin
                     Brake254F := PChar('TWS\254_vpusk_stop');
                     CycleBrake254F := PChar('');
                  end;
                  StopBrake254 := True;
               end;
            end;

         end;
      //end;

      // Остаток времени для запуска вентиляторов ВУ
      if StopVent = False then begin
         if BASS_ChannelIsActive(Vent_Channel_FX) <> 0 then begin
            VentTimeLeft := BASS_ChannelBytes2Seconds(Vent_Channel_FX, BASS_ChannelGetLength(Vent_Channel_FX, BASS_POS_BYTE) - BASS_ChannelGetPosition(Vent_Channel_FX, BASS_POS_BYTE));
            if (VentTimeLeft <= 0.2) and (BASS_ChannelIsActive(VentCycle_Channel_FX)=0) then isPlayCycleVent:=False;
         end;
         if BASS_ChannelIsActive(XVent_Channel_FX) <> 0 then begin
            XVentTimeLeft := BASS_ChannelBytes2Seconds(XVent_Channel_FX, BASS_ChannelGetLength(XVent_Channel_FX, BASS_POS_BYTE) - BASS_ChannelGetPosition(XVent_Channel_FX, BASS_POS_BYTE));
            if (XVentTimeLeft <= 0.2) and (BASS_ChannelIsActive(XVentCycle_Channel_FX)=0) then isPlayCycleVentX:=False;
         end;
      end;

      // -=- Остановка цикла работы вентиляторов при полной остановке работы вентиляторов -=- //
      if (StopVent=True)AND(LocoGlobal<>'VL80t')AND(LocoGlobal<>'EP1m')AND(LocoGlobal<>'2ES5K') then begin
         if BASS_ChannelIsActive(VentCycle_Channel_FX)<>0 then begin
            VentTimeLeft := BASS_ChannelBytes2Seconds(Vent_Channel_FX, BASS_ChannelGetPosition(Vent_Channel_FX, BASS_POS_BYTE));
            if (VentTimeLeft >= 0.3) and (BASS_ChannelIsActive(VentCycle_Channel_FX)<>0) then begin BASS_ChannelStop(VentCycle_Channel_FX); BASS_StreamFree(VentCycle_Channel_FX); end;
         end;
         if BASS_ChannelIsActive(XVentCycle_Channel_FX)<>0 then begin
            XVentTimeLeft := BASS_ChannelBytes2Seconds(XVent_Channel_FX, BASS_ChannelGetPosition(XVent_Channel_FX, BASS_POS_BYTE));
            if (XVentTimeLeft >= 0.3) and (BASS_ChannelIsActive(XVentCycle_Channel_FX)<>0) then begin BASS_ChannelStop(XVentCycle_Channel_FX); BASS_StreamFree(XVentCycle_Channel_FX); end;
         end;
      end;
      // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= //

      // Остаток времени для запуска вентиляторов ТД
      if AnsiCompareText(VentCycleTDF, '')<>0 then begin
          try VentTDTimeLeft := BASS_ChannelBytes2Seconds(VentTD_Channel_FX, BASS_ChannelGetLength(VentTD_Channel_FX, BASS_POS_BYTE) - BASS_ChannelGetPosition(VentTD_Channel_FX, BASS_POS_BYTE)); except end;
          if (VentTDTimeLeft <= 0.8) and (BASS_ChannelIsActive(VentCycleTD_Channel_FX)=0) then isPlayCycleVentTD:=False;
      end;
      if AnsiCompareText(XVentCycleTDF, '')<>0 then begin
          try XVentTDTimeLeft := BASS_ChannelBytes2Seconds(XVentTD_Channel_FX, BASS_ChannelGetLength(XVentTD_Channel_FX, BASS_POS_BYTE) - BASS_ChannelGetPosition(XVentTD_Channel_FX, BASS_POS_BYTE)); except end;
          if (XVentTDTimeLeft <= 0.8) and (BASS_ChannelIsActive(XVentCycleTD_Channel_FX)=0) then isPlayCycleVentTDX:=False;
      end;

      // -=- Остановка цикла работы вентиляторов при полной остановке работы вентиляторов -=- //
      if (AnsiCompareText(VentCycleTDF, '')=0) and (LocoGlobal<>'VL80t') then begin
          try VentTDTimeLeft := BASS_ChannelBytes2Seconds(VentTD_Channel_FX, BASS_ChannelGetPosition(VentTD_Channel_FX, BASS_POS_BYTE)); except end;
          if (VentTDTimeLeft >= 0.3) and (BASS_ChannelIsActive(VentCycleTD_Channel_FX)<>0) then begin BASS_ChannelStop(VentCycleTD_Channel_FX); BASS_StreamFree(VentCycleTD_Channel_FX); end;
      end;
      if (AnsiCompareText(XVentCycleTDF, '')=0) and (LocoGlobal<>'VL80t') then begin
          try XVentTDTimeLeft := BASS_ChannelBytes2Seconds(XVentTD_Channel_FX, BASS_ChannelGetPosition(XVentTD_Channel_FX, BASS_POS_BYTE)); except end;
          if (XVentTDTimeLeft >= 0.3) and (BASS_ChannelIsActive(XVentCycleTD_Channel_FX)<>0) then begin BASS_ChannelStop(XVentCycleTD_Channel_FX); BASS_StreamFree(XVentCycleTD_Channel_FX); end;
      end;
      // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= //

      // Жалюзи на ЧС7 и набор/сброс
      if LocoGlobal='CHS7' then begin
         // Реле напряжения
         if (PrevVoltage=0) and (Voltage<>0) then begin
            IMRZashelka:=PChar('TWS\CHS7_8\rn.wav'); isPlayIMRZachelka:=False;
         end;
         // БВ на ЧС7
         if (BV<>0) and (PrevBV=0) then begin
            LocoPowerEquipmentF := PChar('TWS\CHS7_8\bv_on.wav'); isPlayLocoPowerEquipment := False;
         end;
         if (BV=0) and (PrevBV<>0) then begin
            LocoPowerEquipmentF := PChar('TWS\CHS7_8\bv_off.wav'); isPlayLocoPowerEquipment := False;
         end;
         // Жалюзи на ЧС7 (открытие)
         if (Zhaluzi<>0) and (PrevZhaluzi=0) then begin
            if isCameraInCabin=True then begin
               LocoPowerEquipmentF := PChar('TWS\CHS7_8\zhalusi_on.wav');
            end else begin
               if (Camera<>2) or (CoupleStat=0) then begin
                  LocoPowerEquipmentF := PChar('TWS\CHS7_8\x_zhalusi_on.wav');
               end;
            end;
            isPlayLocoPowerEquipment := False;
         end;
         // Жалюзи на ЧС7 (закрытие)
         if (Zhaluzi=0) and (PrevZhaluzi<>0) then begin
            if isCameraInCabin=True then begin
               LocoPowerEquipmentF := PChar('TWS\CHS7_8\zhalusi_off.wav');
            end else begin
               if (Camera<>2) or (CoupleStat=0) then begin
                  LocoPowerEquipmentF := PChar('TWS\CHS7_8\x_zhalusi_off.wav');
               end;
            end;
            isPlayLocoPowerEquipment := False;
         end;
      end;

      if LocoGlobal = 'CHS8' then begin
         // ГВ на ЧС8
         if (BV<>0) and (PrevBV=0) then begin
            if (LocoNum > 2) And (LocoNum < 33) then
               LocoPowerEquipmentF := PChar('TWS\CHS8\E1\gv_on.wav')
            else
               LocoPowerEquipmentF := PChar('TWS\CHS8\E2\gv_on.wav');
            isPlayLocoPowerEquipment := False;
         end;
         if (BV=0) and (PrevBV<>0) then begin
            if (LocoNum > 2) And (LocoNum < 33) then
               LocoPowerEquipmentF := PChar('TWS\CHS8\E1\gv_off.wav')
            else
               LocoPowerEquipmentF := PChar('TWS\CHS8\E2\gv_off.wav');
            isPlayLocoPowerEquipment := False;
         end;
         CHS8__.np22_step();
      end;

      if (LocoGlobal='CHS7') Or (LocoGlobal='CHS8') Or (LocoGlobal='CHS4t') then begin
         // Вентиляторы ПТР на ЧС7
         if LocoGlobal='CHS7' then begin
            try VentTDVol := power((TEDAmperage/UltimateTEDAmperage*1.2), 0.5) * (trcBarVspomMahVol.Position/100); except end;
         end;
         if LocoGlobal='CHS4t' then VentTDVol := 1 * (trcBarVspomMahVol.Position/100);;
         try
         if (LocoGlobal='CHS7') and ((KM_Pos_1 <> Prev_KMAbs) Or (BV <> PrevBV) Or (Voltage <> PrevVoltage)) then begin
            I := BASS_ChannelIsActive(VentTD_Channel) + BASS_ChannelIsActive(VentCycleTD_Channel);
            if ((I = 0) Or (StopVentTD = True)) and (BV <> 0) and (Voltage <> 0) then begin
               if (KM_Pos_1 in [1..17]) Or (KM_Pos_1 in [21..35]) Or (KM_Pos_1 in [39..53]) then begin
                  VentTDF := PChar('TWS\CHS7\mvPTR_start.wav'); VentCycleTDF := PChar('TWS\CHS7\mvPTR_loop.wav');
                  XVentTDF:= PChar('TWS\CHS7\x_mvPTR_start.wav');XVentCycleTDF:=PChar('TWS\CHS7\x_mvPTR_loop.wav');
                  isPlayVentTD := False; isPlayVentTDX := False; StopVentTD:=False;
               end;
            end;
            if (I <> 0) and (StopVentTD = False) then begin
               if (KM_Pos_1 = 0)         Or (KM_Pos_1 in [18..20]) Or
                  (KM_Pos_1 in [36..38]) Or (KM_Pos_1 in [54..56]) Or
                  ((BV = 0) and (PrevBV <> 0)) Or ((Voltage = 0) and (PrevVoltage <> 0))
               then begin
                  VentTDF := PChar('TWS\CHS7\mvPTR_stop.wav'); VentCycleTDF := PChar('');
                  XVentTDF:= PChar('TWS\CHS7\x_mvPTR_stop.wav');XVentCycleTDF:=PChar('');
                  isPlayVentTD := False; isPlayVentTDX := False; StopVentTD:=True;
               end;
            end;
         end;
         if (Vent<>0) and (Prev_Vent=0) then begin
            if (LocoGlobal='CHS4t') then begin
               VentTDF :=PChar('TWS/CHS4t/ventTD-start.wav'); VentCycleTDF:=PChar('TWS/CHS4t/ventTD-loop.wav');
               XVentTDF:=PChar('TWS/CHS4t/x_ventTD-start.wav'); XVentCycleTDF:=PChar('TWS/CHS4t/x_ventTD-loop.wav');
               isPlayVentTD := False; isPlayVentTDX := False; StopVentTD:=False;
            end;
         end;
         if (LocoGlobal='CHS8') and (CHS8VentStarted = False) then begin
            VentTDF := PChar('TWS\CHS8\vent.wav'); VentCycleTDF := PChar('TWS\CHS8\vent.wav');
            XVentTDF := PChar('TWS\CHS8\x_vent.wav');XVentCycleTDF:=PChar('TWS\CHS8\x_vent.wav');
            isPlayVentTD := False; isPlayVentTDX := False; StopVentTD:=False; CHS8VentStarted := True;
         end;
         if (LocoGlobal='CHS4t') and (Vent=0) and (Prev_Vent<>0) then begin
            VentTDF:=PChar('TWS/CHS4t/ventTD-stop.wav'); VentCycleTDF:=PChar('');
            XVentTDF:=PChar('TWS/CHS4t/x_ventTD-stop.wav'); XVentCycleTDF:=PChar('');
            isPlayVentTD := False; isPlayVentTDX := False; StopVentTD:=True;
         end;
         except end;
         if LocoGlobal = 'CHS7' then VentTDPitch := -7 + TEDAmperage * 10 / UltimateTEDAmperage;
         if LocoGlobal = 'CHS8' then begin
            if Vent = 5 then begin VentTDPitchDest := 0; end;
            if Vent = 4 then begin VentTDPitchDest := 0; end;
            if Vent = 3 then begin VentTDPitchDest := -7; end;
            if Vent = 2 then begin VentTDPitchDest := -15; end;
            if Vent = 1 then begin
               if TEDAmperage>0 then VentTDPitchDest := power(TEDAmperage * 200 / UltimateTEDAmperage,0.6) - 20;
               if EDTAmperage>0 then VentTDPitchDest := power(EDTAmperage * 200 / UltimateTEDAmperage,0.6) - 20;
            end;
            if Vent = 0 then begin VentTDPitchDest := -20; end;
            VentTDVolDest := power((VentTDPitch+20)/20, 0.5) * (trcBarVspomMahVol.Position/100);
            if VentTDVol > VentTDVolDest then VentTDVol := VentTDVol - 0.001 * MainCycleFreq;
            if VentTDVol < VentTDVolDest then VentTDVol := VentTDVol + 0.001 * MainCycleFreq;
         end;
         if LocoGlobal = 'CHS4t' then begin
            if TEDAmperage<700 then
               VentTDPitchDest := 0
            else
               if (LocoNum >= 608) Or (CHS4tVentNewSystemOnAllLocos = True) then
                  VentTDPitchDest := 3
               else
                  VentTDPitchDest := 0;
         end;
         if VentTDVol > trcBarVspomMahVol.Position / 100 then VentTDVol := trcBarVspomMahVol.Position / 100;
         if VentTDVol < 0 then VentTDVol := 0;
         // Задаём громкость звуков работы вентиляторов (ПТР) //
         if (isCameraInCabin = True) and (Camera = 0) then begin
            BASS_ChannelSetAttribute(VentTD_Channel_FX, BASS_ATTRIB_VOL, VentTDVol);
            BASS_ChannelSetAttribute(VentCycleTD_Channel_FX, BASS_ATTRIB_VOL, VentTDVol);
            BASS_ChannelSetAttribute(XVentTD_Channel_FX, BASS_ATTRIB_VOL, 0);
            BASS_ChannelSetAttribute(XVentCycleTD_Channel_FX, BASS_ATTRIB_VOL, 0);
         end else begin
            BASS_ChannelSetAttribute(VentTD_Channel, BASS_ATTRIB_VOL, 0);
            BASS_ChannelSetAttribute(VentCycleTD_Channel, BASS_ATTRIB_VOL, 0);
            BASS_ChannelSetAttribute(XVentTD_Channel, BASS_ATTRIB_VOL, VentTDVol);
            BASS_ChannelSetAttribute(XVentCycleTD_Channel, BASS_ATTRIB_VOL, VentTDVol);
         end;
      end;

      // ДВЕРИ МВПС //
      if Loco='ED4M' then begin
         if LocoNum >= 400 then St := 'CPPK_' else St:='';
         if LDOOR<>PrevLDOOR then begin
            if LDOOR=0 then TWS_PlayLDOOR(PChar('TWS\ED4m\'+St+'doors_open.wav'));
            if LDOOR<>0 then TWS_PlayLDOOR(PChar('TWS\ED4m\'+St+'doors_close.wav'));
         end;
         if RDOOR<>PrevRDOOR then begin
            if RDOOR=0 then TWS_PlayRDOOR(PChar('TWS\ED4m\'+St+'doors_open.wav'));
            if RDOOR<>0 then TWS_PlayRDOOR(PChar('TWS\ED4m\'+St+'doors_close.wav'));
         end;
      end;

      if AnsiCompareStr(CompressorCycleF, '') <> 0 then begin
          try CompTimeLeft := BASS_ChannelBytes2Seconds(Compressor_Channel, BASS_ChannelGetLength(Compressor_Channel, BASS_POS_BYTE) - BASS_ChannelGetPosition(Compressor_Channel, BASS_POS_BYTE)); except end;
          if (CompTimeLeft<=0.8) and (BASS_ChannelIsActive(CompressorCycleChannel)=0) then isPlayCompressorCycle:=False;
      end;
      if AnsiCompareStr(XCompressorCycleF, '')<> 0 then begin
          try XCompTimeLeft := BASS_ChannelBytes2Seconds(XCompressor_Channel, BASS_ChannelGetLength(XCompressor_Channel, BASS_POS_BYTE) - BASS_ChannelGetPosition(XCompressor_Channel, BASS_POS_BYTE)); except end;
          if (XCompTimeLeft<=0.8) and (BASS_ChannelIsActive(XCompressorCycleChannel)=0) then isPlayXCompressorCycle:=False;
      end;
      if Loco='ED4M' then begin
         if BV+FrontTP+Compressor>2 then Compressor:=1 else Compressor:=0;
      end;
      if (LocoGlobal='CHS4 KVR') Or (LocoGlobal='CHS4t') then begin
         if GR > PrevGR then begin
            GRIncrementer := 0;
            Compressor := 1;
         end else begin
            Inc(GRIncrementer);
            if GRIncrementer > 2 then Compressor := 0;
         end;
      end;
      // Звуки запуска компрессора
      if Compressor<>Prev_Compressor then begin
         if Compressor<>0 then begin
            if LocoGlobal='CHS7' then begin
               CompressorF:=PChar('TWS/CHS7/mk-start.wav'); CompressorCycleF:=PChar('TWS/CHS7/mk-loop.wav');
               XCompressorF:=PChar('TWS/CHS7/x_mk-start.wav'); XCompressorCycleF:=PChar('TWS/CHS7/x_mk-loop.wav');
            end;
            if LocoGlobal='CHS8' then begin
               CompressorF:=PChar('TWS/CHS8/mk-start.wav'); CompressorCycleF:=PChar('TWS/CHS8/mk-loop.wav');
               XCompressorF:=PChar('TWS/CHS8/x_mk-start.wav'); XCompressorCycleF:=PChar('TWS/CHS8/x_mk-loop.wav');
            end;
            if LocoGlobal='CHS2K' then begin CompressorF:=PChar('TWS/CHS2K/mk-start.wav'); CompressorCycleF:=PChar('TWS/CHS2K/mk-loop.wav'); end;
            if LocoGlobal='VL80t' then begin CompressorF:=PChar('TWS/VL80t/MK-start.wav'); CompressorCycleF:=PChar('TWS/VL80t/MK-loop.wav'); end;
            if LocoGlobal='EP1m' then begin CompressorF:=PChar('TWS/EP1m/mk-start.wav'); CompressorCycleF:=PChar('TWS/EP1m/mk-loop.wav'); end;
            if LocoGlobal='2ES5K' then begin CompressorF:=PChar('TWS/2ES5K/mk-start.wav'); CompressorCycleF:=PChar('TWS/2ES5K/mk-loop.wav'); end;
            if Loco='ED4M' then begin CompressorF:=PChar('TWS/ED4m/compr_start.wav'); CompressorCycleF:=PChar('TWS/ED4m/compr_loop.wav'); end;
            if LocoGlobal='VL11m' then begin
               CompressorF:=PChar('TWS/VL11m/MK-start.wav'); CompressorCycleF:=PChar('TWS/VL11m/MK-loop.wav');
               XCompressorF:=PChar('TWS/VL11m/x_MK-start.wav'); XCompressorCycleF:=PChar('TWS/VL11m/x_MK-loop.wav');
            end;
            if LocoGlobal='CHS4 KVR' then begin
               CompressorF:=PChar('TWS/CHS4KVR/mk_start.wav'); CompressorCycleF:=PChar('TWS/CHS4KVR/mk_loop.wav');
               XCompressorF:=PChar('TWS/CHS4KVR/x_mk_start.wav'); XCompressorCycleF:=PChar('TWS/CHS4KVR/x_mk_loop.wav');
            end;
            if LocoGlobal='CHS4t' then begin
               CompressorF:=PChar('TWS/CHS4t/mk_start.wav'); CompressorCycleF:=PChar('TWS/CHS4t/mk_loop.wav');
               XCompressorF:=PChar('TWS/CHS4t/x_mk_start.wav'); XCompressorCycleF:=PChar('TWS/CHS4t/x_mk_loop.wav');
            end;
            isPlayCompressor:=False; isPlayXCompressor:=False;
         end;
         // Звуки остановки компрессора
         if Compressor=0 then begin
            if LocoGlobal='CHS7' then begin
               CompressorF:=PChar('TWS/CHS7/mk-stop.wav');
               XCompressorF:=PChar('TWS/CHS7/x_mk-stop.wav');
            end;
            if LocoGlobal='CHS8' then begin
               CompressorF:=PChar('TWS/CHS8/mk-stop.wav');
               XCompressorF:=PChar('TWS/CHS8/x_mk-stop.wav');
            end;
            if LocoGlobal='CHS2K' then begin CompressorF:=PChar('TWS/CHS2K/mk-stop.wav'); end;
            if LocoGlobal='VL80t' then begin CompressorF:=PChar('TWS/VL80t/MK-stop.wav'); end;
            if LocoGlobal='EP1m' then begin CompressorF:=PChar('TWS/EP1m/mk-stop.wav'); end;
            if LocoGlobal='2ES5K' then begin CompressorF:=PChar('TWS/2ES5K/mk-stop.wav'); end;
            if LocoGlobal='VL11m' then begin
               CompressorF:=PChar('TWS/VL11m/MK-stop.wav');
               XCompressorF:=PChar('TWS/VL11m/x_MK-stop.wav');
            end;
            if Loco='ED4M' then begin CompressorF:=PChar('TWS/ED4m/compr_stop.wav'); end;
            if LocoGlobal='CHS4 KVR' then begin
               CompressorF:=PChar('TWS/CHS4KVR/mk_stop.wav');
               XCompressorF:=PChar('TWS/CHS4KVR/x_mk_stop.wav');
            end;
            if LocoGlobal='CHS4t' then begin
               CompressorF:=PChar('TWS/CHS4KVR/mk_stop.wav');
               XCompressorF:=PChar('TWS/CHS4KVR/x_mk_stop.wav');
            end;
            CompressorCycleF:=PChar(''); XCompressorCycleF:=PChar('');
            isPlayCompressor:=False; isPlayXCompressor:=False;
         end;
      end;
      // **************** //
      // БЛОК ВЕНТИЛЯТОРОВ //
      // ВЕНТИЛЯТОРЫ НА ЭП1м и 2ЭС5к //
      if (LocoGlobal = 'EP1m') Or (LocoGlobal = '2ES5K') then begin
         if LocoGlobal = '2ES5K' then Voltage := BV * 25;
         if (GetAsyncKeyState(16) <> 0) then begin
            if GetAsyncKeyState(70)<>0 then begin Vent := 1;if LocoGlobal='EP1m'then VentVolume:=60 else VentVolume:=100;end;
            if GetAsyncKeyState(82)<>0 then begin Vent2:= 1;if LocoGlobal='EP1m'then VentVolume:=75 else VentVolume:=50;end;
            if (GetAsyncKeyState(55)<>0)and(LocoGlobal='EP1m') then begin Vent3:= 1; VentVolume := 100;end;
         end else begin
            if GetAsyncKeyState(70)<>0 then begin Vent := 0;if LocoGlobal='EP1m'then VentVolume:=60 else VentVolume:=100;end;
            if GetAsyncKeyState(82)<>0 then begin Vent2:= 0;if LocoGlobal='EP1m'then VentVolume:=75 else VentVolume:=50;end;
            if (GetAsyncKeyState(55)<>0)and(LocoGlobal='EP1m') then begin Vent3:= 0; VentVolume := 100;end;
         end;
         if (Vent + Vent2 + Vent3 > 0) and (Voltage > 20) then begin
            if ((BASS_ChannelIsActive(Vent_Channel_FX) = 0) And (BASS_ChannelIsActive(VentCycle_Channel_FX) = 0)) Or
               ((Vent = 1) and (Prev_Vent = 0)) Or ((Vent2 = 1) and (Prev_Vent2 = 0)) Or ((Vent3 = 1) and (Prev_Vent3 = 0)) then begin
               isPlayVent := False; StopVent := False;
            end;

            if Vent3=1 then CycleVentVolume:=100 else begin
              if Vent2=1 then if LocoGlobal='EP1m'then CycleVentVolume:=75 else CycleVentVolume:=50 else begin
                  if Vent=1 then if LocoGlobal='EP1m'then CycleVentVolume:=60 else CycleVentVolume:=100 else CycleVentVolume:=0;
              end;
            end;
         end;
         if (Voltage < 20) then begin
            Vent := 0; Vent2 := 0; Vent3 := 0;
         end;
         if (Vent + Vent2 + Vent3 = 0) Or (Vent + Vent2 + Vent3 < Prev_Vent + Prev_Vent2 + Prev_Vent3) then begin
            if ((Vent = 0) and (Prev_Vent = 1) and (Voltage > 20)) Or
               ((Vent2 = 0) and (Prev_Vent2 = 1) and (Voltage > 20)) Or
               ((Vent3 = 0) and (Prev_Vent3 = 1) and (Voltage > 20)) Or
               ((Vent + Vent2 + Vent3 = 0) AND (BASS_ChannelIsActive(VentCycle_Channel_FX) <> 0)) then begin
               if (Vent3<>Prev_Vent3)and(LocoGlobal='EP1m') then VentVolume:=100;
               if Vent2<>Prev_Vent2 then if LocoGlobal='EP1m' then VentVolume:=75 else VentVolume:=50;
               if Vent <> Prev_Vent then if LocoGlobal='EP1m' then VentVolume:=60 else VentVolume:=100;

               isPlayVent := False; StopVent := True;
            end;
         end;
      end;
      // ВЕНТИЛЯТОРЫ ДЛЯ ВСЕХ ЭЛ-ВОЗОВ, КРОМЕ ЧС4, ВЛ80т, ЭП1м И 2ЭС5К
      if (LocoGlobal<>'CHS4 KVR') and (LocoGlobal<>'VL80t') and (LocoGlobal<>'EP1m') and (LocoGlobal<>'2ES5K') then begin
         if (Vent<>0) and (Prev_Vent=0) then begin
             if (LocoGlobal='CHS7') Or (LocoGlobal='CHS2K') then begin
                if (BASS_ChannelIsActive(Vent_Channel_FX)<>0) and (StopVent = True) then begin
                    BASS_ChannelStop(Vent_Channel_FX); BASS_StreamFree(Vent_Channel_FX);
                    BASS_ChannelStop(XVent_Channel_FX); BASS_StreamFree(XVent_Channel_FX);
                    isPlayCycleVent := False; isPlayCycleVentX := False;
                end;
                if Vent = 255 then VentPitchDest := 5 else VentPitchDest := 0;
             end;
             StopVent:=False;
             isPlayVent:=False; isPlayVentX:=False;
         end;
         if ((Vent=0) and (Prev_Vent<>0) and (LocoGlobal<>'CHS4 KVR')) then begin
             StopVent:=True;
             isPlayVent:=False; isPlayVentX:=False;
         end;
      end;
      // ВЕНТИЛЯТОРЫ НА ВЛ80т
      if LocoGlobal='VL80t' then begin
          // ЗАПУСК
          if Vent+Vent2+Vent3+Vent4 > Prev_Vent+Prev_Vent2+Prev_Vent3+Prev_Vent4 then begin
             if Vent<>Prev_Vent then VentVolume:=100;
             if Vent2<>Prev_Vent2 then VentVolume:=70;
             if Vent3<>Prev_Vent3 then VentVolume:=25;
             if Vent4<>Prev_Vent4 then VentVolume:=25;
             StopVent := False; isPlayVent := False; isPlayVentX := False;
          end;
          // ОСТАНОВКА
          if Vent+Vent2+Vent3+Vent4 < Prev_Vent+Prev_Vent2+Prev_Vent3+Prev_Vent4 then begin
             if Vent<>Prev_Vent then VentVolume:=100;
             if Vent2<>Prev_Vent2 then VentVolume:=70;
             if Vent3<>Prev_Vent3 then VentVolume:=25;
             if Vent4<>Prev_Vent4 then VentVolume:=25;
             StopVent := True; isPlayVent := False; isPlayVentX := False;
          end;
          // ЗАДАЕМ ГРОМКОСТЬ РАБОТЫ ЗВУКА ЦИКЛА ВЕНТИЛЯТОРОВ ВЛ80т
          if Vent=1 then CycleVentVolume:=100 else begin
              if Vent2=1 then CycleVentVolume:=70 else begin
                  if Vent3=1 then CycleVentVolume:=25 else begin
                      if Vent4=1 then CycleVentVolume:=25 else CycleVentVolume:=0;
                  end;
              end;
          end;
      end else begin
          if LocoGlobal <> 'EP1m' then begin
             VentVolume:=100;
             CycleVentVolume:=100;
          end;
      end;
      // ЗВУКИ ВЕНТИЛЯТОРОВ НА ЧС4квр
      if (LocoGlobal='CHS4 KVR') then begin
        if (Vent<>Prev_Vent) and (Vent=Prev_VentLocal) then begin
          VentTDVol := trcBarVspomMahVol.Position / 100;
          if (Vent=4113039) and (Prev_Vent=0) then begin // Запуск ВУ
             StopVent:=False; VentPitchDest:=0; isPlayVent:=False; isPlayVentX:=False; end;
          if (Vent=4126146) and (Prev_Vent=0) then begin // Запуск ВУ и ТД (2-ая позиция)
             StopVent:=False; isPlayVent:=False; isPlayVentX:=False; VentPitchDest:=-1.5;
             VentTDF:=PChar('TWS/CHS4KVR/ventTD-start.wav'); VentCycleTDF:=PChar('TWS/CHS4KVR/ventTD.wav'); isPlayVentTD:=False;	// Звук в кабине
             XVentTDF:=PChar('TWS/CHS4KVR/x_ventTD-start.wav'); XVentCycleTDF:=PChar('TWS/CHS4KVR/x_ventTD.wav'); isPlayVentTDX:=False;
          end;
          if (Vent=4050124) and (Prev_Vent=0) then begin // Запуск ТД (1->2 позиция)
             VentTDF:=PChar('TWS/CHS4KVR/ventTD-start.wav'); VentCycleTDF:=PChar('TWS/CHS4KVR/ventTD.wav'); isPlayVentTD:=False;	// Звук в кабине
             XVentTDF:=PChar('TWS/CHS4KVR/x_ventTD-start.wav'); XVentCycleTDF:=PChar('TWS/CHS4KVR/x_ventTD.wav'); isPlayVentTDX:=False;
             if KM_Pos_1 >= 2 then VentPitchDest:=-1.5 else VentPitchDest:=0;
          end;
          if Vent=0 then begin // ВЫКЛ
             if (BASS_ChannelIsActive(Vent_Channel_FX)<>0) or (BASS_ChannelIsActive(VentCycle_Channel_FX)<>0) then begin
                StopVent:=True; isPlayVent:=False; isPlayVentX:=False; VentPitchDest:=0;
             end;
             if (BASS_ChannelIsActive(VentTD_Channel)<>0) or (BASS_ChannelIsActive(VentCycleTD_Channel)<>0) then begin
                VentTDF:=PChar('TWS/CHS4KVR/ventTD-stop.wav'); VentCycleTDF:=PChar(''); isPlayVentTD:=False;	// Звук в кабине
                XVentTDF:=PChar('TWS/CHS4KVR/x_ventTD-stop.wav'); XVentCycleTDF:=PChar(''); isPlayVentTDX:=False; end;
             end;
          if (Vent=4113039) and (Prev_Vent=4126146) then begin // Остановка ТД
             VentTDF:=PChar('TWS/CHS4KVR/ventTD-stop.wav'); VentCycleTDF:=PChar(''); isPlayVentTD:=False;    // Звук в кабине
             XVentTDF:=PChar('TWS/CHS4KVR/x_ventTD-stop.wav'); XVentCycleTDF:=PChar(''); isPlayVentTDX:=False; end;
          if (Vent=4113039) and (Prev_Vent=4050124) then begin // Запуск ВУ, остановка ТД
             StopVent:=False; isPlayVent:=False; isPlayVentX:=False; VentPitchDest:=0;
             VentTDF:=PChar('TWS/CHS4KVR/ventTD-stop.wav'); VentCycleTDF:=PChar(''); isPlayVentTD:=False;
             XVentTDF:=PChar('TWS/CHS4KVR/x_ventTD-stop.wav'); XVentCycleTDF:=PChar(''); isPlayVentTDX:=False;
          end;
          if (Vent=4126146) and (Prev_Vent=4113039) then begin // Запуск ТД, после запуска ВУ
             VentTDF:=PChar('TWS/CHS4KVR/ventTD-start.wav'); VentCycleTDF:=PChar('TWS/CHS4KVR/ventTD.wav'); isPlayVentTD:=False;
             XVentTDF:=PChar('TWS/CHS4KVR/x_ventTD-start.wav'); XVentCycleTDF:=PChar('TWS/CHS4KVR/x_ventTD.wav'); isPlayVentTDX:=False;
             VentPitchDest:=-1.5; end;
          if (Vent=4126146) and (Prev_Vent=4050124) then begin // Запуск ВУ (2-ая позиция)
             StopVent:=False; VentPitchDest:=-1.5; isPlayVent:=False; isPlayVentX:=False;
          end;
          if (Vent=4050124) and (Prev_Vent=4113039) then begin // Остановка ВУ, запуск ТД
             StopVent:=True; ventPitchDest:=0; isPlayVent:=False; isPlayVentX:=False;
             VentTDF:=PChar('TWS/CHS4KVR/ventTD-start.wav'); VentCycleTDF:=PChar('TWS/CHS4KVR/ventTD.wav'); isPlayVentTD:=False;
             XVentTDF:=PChar('TWS/CHS4KVR/x_ventTD-start.wav'); XVentCycleTDF:=PChar('TWS/CHS4KVR/x_ventTD.wav'); isPlayVentTDX:=False;
          end;
          if (Vent=4050124) and (Prev_Vent=4126146) then begin // Остановка ВУ
             StopVent:=True; VentPitchDest:=0; isPlayVent:=False; isPlayVentX:=False;
          end;
        end;
      end;
      if ((Vent+Vent2+Vent3+Vent4=0) and (LocoGlobal='VL80t')) //or ((Vent=0) and (LocoGlobal<>'VL80t'))
      then begin
         BASS_ChannelStop(VentCycleTD_Channel); BASS_StreamFree(VentCycleTD_Channel);
         BASS_ChannelStop(VentCycleTD_Channel_FX); BASS_StreamFree(VentCycleTD_Channel_FX);
         BASS_ChannelStop(VentCycle_Channel); BASS_StreamFree(VentCycle_Channel);
         BASS_ChannelStop(VentCycle_Channel_FX); BASS_StreamFree(VentCycle_Channel_FX);
         BASS_ChannelStop(XVentCycleTD_Channel); BASS_StreamFree(XVentCycleTD_Channel);
         BASS_ChannelStop(XVentCycleTD_Channel_FX); BASS_StreamFree(XVentCycleTD_Channel_FX);
         BASS_ChannelStop(XVentCycle_Channel); BASS_StreamFree(XVentCycle_Channel);
         BASS_ChannelStop(XVentCycle_Channel_FX); BASS_StreamFree(XVentCycle_Channel_FX);
      end;
      // Перерегулирование тональности вентиляторов
      TWS_MVPitchRegulation();
      // БЛОК ЗВУКОВ УНИПУЛЬСА //
      if (LocoGlobal='CHS8') and (Vent <> 5) then begin
         CHS8__.unipuls_step();
      end;
      // ********************* //
  end;
  // **************** //
  // БЛОК ЗВУКА ТРЕНИЯ КОЛОДОК ПРИ ТОРМОЖЕНИИ //
  if cbBrakingSounds.Checked=True then begin
      if (BrakeCylinders>0) and (PrevBrkCyl=0) and (Speed<>0) and (Brake=False) then Begin Brake_Counter:=0; BrakeF:=PChar('TWS/brake_slipp.wav'); isPlayBrake:=False; Brake:=True; end;
      if (Brake=True) then begin
           if isCameraInCabin=True then begin
              if EDTAmperage=0 then
      	         BASS_ChannelSetAttribute(Brake_Channel[0], BASS_ATTRIB_VOL, ((BrakeCylinders/36)*(Speed/40))*(trcBarLocoPerestukVol.Position/100)) else
                 BASS_ChannelSetAttribute(Brake_Channel[0], BASS_ATTRIB_VOL, (((BrakeCylinders/36)*(Speed/40))*(trcBarLocoPerestukVol.Position/100))/4);
              BASS_ChannelSetAttribute(Brake_Channel[1], BASS_ATTRIB_VOL, 0);
           end else begin
              BASS_ChannelSetAttribute(Brake_Channel[0], BASS_ATTRIB_VOL, 0);
              if EDTAmperage=0 then
      	         BASS_ChannelSetAttribute(Brake_Channel[1], BASS_ATTRIB_VOL, ((BrakeCylinders/36)*(Speed/40))*(trcBarLocoPerestukVol.Position/100)/2) else
                 BASS_ChannelSetAttribute(Brake_Channel[1], BASS_ATTRIB_VOL, (((BrakeCylinders/36)*(Speed/40))*(trcBarLocoPerestukVol.Position/100))/8);
           end;
        end;
      if ((BrakeCylinders=0) and (Brake_Counter>10)) or (Speed=0) then begin BASS_ChannelStop(Brake_Channel[0]); BASS_StreamFree(Brake_Channel[0]); BASS_ChannelStop(Brake_Channel[1]); BASS_StreamFree(Brake_Channel[1]); Brake:=False; end;
      if (BrakeCylinders=0) then Inc(Brake_Counter);
  end;
  // **************************************** //

  // Проверяем менялись-ли показания камеры?
  if (Camera<>PrevCamera) or (CameraX<>PrevCameraX) then
     VolumeMaster_RefreshVolume();

  // -/- Блок загрузки сэмплов, содержащих в имени границы -/- //
  if isRefreshLocalData = True then begin
     // (1) Загружаем данные по сэмплам перестука (1) //
     I:=0; PerestukBaseNumElem:=0;
     if FindFirst('TWS/'+Loco+'/*.wav',faAnyFile,SR) = 0 then
        repeat
           try
              St:=Copy(SR.Name,1,Pos('-', SR.Name)-1);
              Station1:=Copy(SR.Name, Length(St)+2, Length(SR.Name));
              Station1:=StringReplace(Station1,'.wav', '', [rfReplaceAll]);
              if Station1='~' then Station1:='10000';
              PerestukBase[I]:=StrToInt(St);
              PerestukBase[I+1]:=StrToInt(Station1);
              Inc(I,2); Inc(PerestukBaseNumElem);
           except end;
     until FindNext(SR) <> 0;
     FindClose(SR);

     // (2) Загружаем данные по сэмплам ТЭД-ов (2) //
     if LocoWithTED = True then begin
        I:=0; TEDBaseNumElem:=0;
        if FindFirst('TWS/'+LocoTEDNamePrefiks+'/*.wav',faAnyFile,SR) = 0 then
           repeat
              try
                 Station2 := StringReplace(SR.Name, 'ted'+#32, '', [rfReplaceAll]);
                 St:=Copy(Station2,1,Pos('-',Station2)-1);
                 Station1:=Copy(Station2, Length(St)+2, Length(Station2));
                 Station1:=StringReplace(Station1,'.wav', '', [rfReplaceAll]);
                 if Station1='~' then Station1:='10000';
                 TEDBase[I]:=StrToInt(St);
                 TEDBase[I+1]:=StrToInt(Station1);
                 Inc(I,2); Inc(TEDBaseNumElem);
              except end;
           until FindNext(SR) <> 0;
        FindClose(SR);
     end;

     isRefreshLocalData := False;
  end;
  // *************************************************************** //
  if cbLocPerestuk.Checked=True then begin
     // Звук шума езды (в старых версиях перестука)
     if (Speed<>PrevSpeed) and (RefreshSnd=True) then begin
        J:=0;
        for I:=0 to PerestukBaseNumElem do begin
           if (Speed>=PerestukBase[J]) and (Speed<PerestukBase[J+1]) then begin
              if (PrevSpeed<PerestukBase[J])or(PrevSpeed>=PerestukBase[J+1])or(PrevSpeed=0) then begin
                 if PerestukBase[J+1]<>10000 then
                    TWS_PlayDrivingNoise(PChar('TWS/'+Loco+'/'+IntToStr(PerestukBase[J])+'-'+IntToStr(PerestukBase[J+1])+'.wav')) else
                    TWS_PlayDrivingNoise(PChar('TWS/'+Loco+'/'+IntToStr(PerestukBase[J])+'-~.wav'));
                 Break;
              end;
           end;
           Inc(J, 2);
        end;
     RefreshSnd:=False;
     end;

     // Блок перестука тележек локомотива на светофорах
     if ((SvetoforDist<=(Speed/1.8)+4) and (Prev_SvetoforDist>(Speed/1.8)+4))
        Or (perestukPLAY=True) then begin
        perestukPLAY:=False;
        if BASS_ChannelIsActive(LocoChannelPerestuk)=0 then begin
           PrevSpeed:=0;
           if Speed in[3..5] then begin
              if (PrevSpeed>5)or(PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/3-5.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[6..10] then begin
              if (PrevSpeed<=5) or (PrevSpeed>10) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/5-10.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[11..20] then begin
              if (PrevSpeed<=10) or (PrevSpeed>20) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/10-20.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[21..30] then begin
              if (PrevSpeed<=20) or (PrevSpeed>30) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/20-30.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[31..40] then begin
              if (PrevSpeed<=30) or (PrevSpeed>40) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/30-40.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[41..50] then begin
              if (PrevSpeed<=40) or (PrevSpeed>50) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/40-50.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[51..60] then begin
              if (PrevSpeed<=50) or (PrevSpeed>60) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/50-60.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[61..70] then begin
              if (PrevSpeed<=60) or (PrevSpeed>70) or (PrevSpeed=0)
    	         then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/60-70.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[71..80] then begin
              if (PrevSpeed<=70) or (PrevSpeed>80) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/70-80.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[81..90] then begin
              if (PrevSpeed<=80) or (PrevSpeed>90) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/80-90.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[91..100] then begin
              if (PrevSpeed<=90) or (PrevSpeed>100) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/90-100.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[101..110] then begin
              if (PrevSpeed<=100) or (PrevSpeed>110) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/100-110.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[111..120] then begin
              if (PrevSpeed<=110) or (PrevSpeed>120) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/110-120.wav'); isPlayPerestuk:=False; end; end;
           if Speed in[121..130] then begin
              if (PrevSpeed<=120) or (PrevSpeed>130) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/120-130.wav'); isPlayPerestuk:=False; end; end;
           if Speed > 130 then begin
              if (PrevSpeed<=130) or (PrevSpeed=0)
                 then begin LocoPerestukF:=PChar('TWS/'+Loco+'/Perestuk/130-140.wav'); isPlayPerestuk:=False; end;
           end;
           PrevSpeed:=Speed;
        end;
     end;
  end;

    // Блок проверки изменений скорости локомотива для перестука грузовых вагонов
    if (cbWagPerestuk.Checked=True) and (CoupleStat<>0) then begin
       if RadioButton2.Checked = True then begin
          if (Acceleretion>0.03) and (Speed>0) and (PrevSpeed_Fakt=0) then begin
             TrogF := PChar('TWS/Freight/departure.wav');
             isPlayTrog:=False;
          end;
          if (Speed in [4..10]) and (StrComp(WagF, PChar('TWS/Freight/4-10.wav')) <> 0) then begin
             WagF:=PChar('TWS/Freight/4-10.wav'); isPlayWag:=False; end;
          if (Speed in [11..20])and (StrComp(WagF, PChar('TWS/Freight/10-20.wav')) <> 0)then begin
             WagF:=PChar('TWS/Freight/10-20.wav'); isPlayWag:=False;end;
          if (Speed in [21..30]) and(StrComp(WagF, PChar('TWS/Freight/20-30.wav')) <> 0)then begin
             WagF:=PChar('TWS/Freight/20-30.wav'); isPlayWag:=False;end;
          if (Speed in [31..40]) and(StrComp(WagF, PChar('TWS/Freight/30-40.wav')) <> 0)then begin
             WagF:=PChar('TWS/Freight/30-40.wav'); isPlayWag:=False;end;
          if (Speed in [41..50]) and(StrComp(WagF, PChar('TWS/Freight/40-50.wav')) <> 0)then begin
             WagF:=PChar('TWS/Freight/40-50.wav'); isPlayWag:=False;end;
          if (Speed in [51..60]) and(StrComp(WagF, PChar('TWS/Freight/50-60.wav')) <> 0)then begin
             WagF:=PChar('TWS/Freight/50-60.wav'); isPlayWag:=False;end;
          if (Speed in [61..70]) and(StrComp(WagF, PChar('TWS/Freight/60-70.wav')) <> 0)then begin
             WagF:=PChar('TWS/Freight/60-70.wav'); isPlayWag:=False;end;
          if (Speed > 70) and (StrComp(WagF, PChar('TWS/Freight/70-80.wav')) <> 0) then begin
             WagF:=PChar('TWS/Freight/70-80.wav'); isPlayWag:=False;end;

          if Speed<1 then begin WagF:=''; BASS_ChannelStop(WagChannel); end;
       end;

       // Блок проверки изменений скорости локомотива для перестука пассажирских вагонов
       if RadioButton1.Checked = True then begin
          if (Speed in [5..10]) and (StrComp(WagF, PChar('TWS/Pass/5-10.wav')) <> 0) then begin
                WagF:= PChar('TWS/Pass/5-10.wav'); isPlayWag:=False; end;
          if (Speed in [11..15]) and (StrComp(WagF, PChar('TWS/Pass/10-15.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/10-15.wav'); isPlayWag:=False; end;
          if (Speed in [16..20]) and (StrComp(WagF, PChar('TWS/Pass/15-20.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/15-20.wav'); isPlayWag:=False; end;
          if (Speed in [21..30]) and (StrComp(WagF, PChar('TWS/Pass/20-30.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/20-30.wav'); isPlayWag:=False; end;
          if (Speed in [31..40]) and (StrComp(WagF, PChar('TWS/Pass/30-40.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/30-40.wav'); isPlayWag:=False; end;
          if (Speed in [41..50]) and (StrComp(WagF, PChar('TWS/Pass/40-50.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/40-50.wav'); isPlayWag:=False; end;
          if (Speed in [51..60]) and (StrComp(WagF, PChar('TWS/Pass/50-60.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/50-60.wav'); isPlayWag:=False; end;
          if (Speed in [61..70]) and (StrComp(WagF, PChar('TWS/Pass/60-70.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/60-70.wav'); isPlayWag:=False; end;
          if (Speed in [71..80]) and (StrComp(WagF, PChar('TWS/Pass/70-80.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/70-80.wav'); isPlayWag:=False; end;
          if (Speed in [81..90]) and (StrComp(WagF, PChar('TWS/Pass/80-90.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/80-90.wav'); isPlayWag:=False; end;
          if (Speed in [91..100])and (StrComp(WagF, PChar('TWS/Pass/90-100.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/90-100.wav'); isPlayWag:=False;end;
          if (Speed in[101..120])and (StrComp(WagF, PChar('TWS/Pass/100-120.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/100-120.wav');isPlayWag:=False;end;
          if (Speed>120) and (StrComp(WagF, PChar('TWS/Pass/120-140.wav')) <> 0) then begin
                WagF:=PChar('TWS/Pass/120-140.wav');isPlayWag:=False;end;

          if Speed<5 then begin WagF:=''; BASS_ChannelStop(WagChannel); BASS_StreamFree(WagChannel); end;
       end;
    end;

    if (Speed<3) then begin
       BASS_ChannelStop(LocoChannel[0]); BASS_ChannelStop(LocoChannel[1]);
    end else begin
       if PrevSpeed_Fakt < 3 then
          TimerPlayPerestuk.Enabled := True;
    end;

    // --- Обращение к модулю САВП, делаем "проход" --- //
    SAVPTick();

    SoundManagerTick();

    PrevSpeed:=Speed;
    PrevOgrSpeed:=OgrSpeed;
    PrevNextOgrSpeed:=NextOgrSpeed;
    PrevAcceleretion:=Acceleretion;
    PrevCoupleStat:=CoupleStat;
    PrevTrack:=Track;
    PrevSvetofor:=Svetofor;
    PrevFrontTP:=FrontTP;
    PrevBackTP:=BackTP;
    PrevBV:=BV;
    PrevDiesel2:=diesel2;
    PrevReostat:=Reostat;
    Prev_SvetoforDist:=SvetoforDist;
    PrevReversorPos := ReversorPos;
    PrevFazan:=Fazan;
    //Prev_KM_OP_Deg := KM_OP_Deg;
    Prev_KM_OP := KM_OP;
    PrevPerestukStation := isPlayPerestuk_OnStation;
    PrevRain := Rain;
    PrevVstrechStatus := VstrechStatus;
    PrevCamera := Camera;
    PrevSpeed_Fakt:=Speed;
    PrevKME_ED := KME_ED;
    PrevVCheck := VCheck;
    PrevCameraX := CameraX;
    PrevTEDAmperage := TEDAmperage;
    PrevEDTAmperage := EDTAmperage;
    Prev_Compressor := Compressor;
    PrevBrkCyl := BrakeCylinders;
    PrevVoltage := Voltage;
    Prev_KMAbs := KM_Pos_1;
    Prev_Stochist := Stochist;
    Prev_StchstDGR:= StochistDGR;
    PrevAB_ZB_1 := AB_ZB_1;
    PrevAB_ZB_2 := AB_ZB_2;
    PrevBoks_Stat := Boks_Stat;
    PrevEPT := EPT;
    PrevRDOOR:=RDOOR;
    PrevLDOOR:=LDOOR;
    PrevZhaluzi:=Zhaluzi;
    PrevHighLights:=Highlights;
    PrevVstrTrack:=VstrTrack;
    if LocoGlobal<>'CHS4 KVR' then
    Prev_Vent := Vent else begin
       //if (Vent=0) or (Vent=143) or (Vent=194) or (Vent=204) then begin
       if (Vent=0) or (Vent=4113039) or (Vent=4126146) or (Vent=4050124) then begin
          if (Prev_VentLocal=Vent) then Prev_Vent:=Vent;
       end;
       Prev_VentLocal:=Vent;
    end;
    Prev_Vent2 := Vent2;
    Prev_Vent3 := Vent3;
    Prev_Vent4 := Vent4;
    PrevRB:=RB;
    PrevRBS:=RBS;
    PrevSvistok:=Svistok;
    PrevTifon:=Tifon;
    if PrevOrdinata < Ordinata then NapravOrdinata := 'Tuda';
    if PrevOrdinata > Ordinata then NapravOrdinata := 'Obratno';
    PrevOrdinata:=Ordinata;
    PrevTC := TC;
    PrevGR := GR;
end;	// Конец блока если игра не на паузе!!!!!

PrevConMem:=isConnectedMemory;
except
   // НИЧЕГО
end;
end;

procedure PlaySvistokIsEnd(vHandle, vStream, vData: Cardinal; vUser: Pointer); stdcall;
begin
     if BASS_ChannelIsActive(SvistokCycleChannel) <> 0 then
        if Camera <> 2 then
           BASS_ChannelSetAttribute(SvistokCycleChannel, BASS_ATTRIB_VOL, FormMain.trcBarSignalsVol.Position / 100)
        else
           BASS_ChannelSetAttribute(SvistokCycleChannel, BASS_ATTRIB_VOL,
           (5 / (WagsNum + LocoSectionsNum)) * (FormMain.trcBarSignalsVol.Position / 100));
end;

procedure TFormMain.TWS_PlaySvistok(FileName: String);
begin
    try BASS_ChannelStop(SvistokChannel); BASS_StreamFree(SvistokChannel);
       SvistokChannel:=BASS_StreamCreateFile(FALSE, PChar(FileName), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
       BASS_ChannelPlay(SvistokChannel, TRUE);
       if Camera <> 2 then
          BASS_ChannelSetAttribute(SvistokChannel, BASS_ATTRIB_VOL, trcBarSignalsVol.Position/100)
       else
          BASS_ChannelSetAttribute(SvistokChannel, BASS_ATTRIB_VOL,
          (5 / (WagsNum + LocoSectionsNum)) * (trcBarSignalsVol.Position / 100));
       BASS_ChannelSetSync(SvistokChannel, BASS_SYNC_POS,
                           BASS_ChannelSeconds2Bytes(SvistokChannel, BASS_ChannelBytes2Seconds(SvistokChannel, BASS_ChannelGetLength(SvistokChannel, BASS_POS_BYTE)) - 0.05),
                           @PlaySvistokIsEnd, nil);
    except end;
end;

procedure TFormMain.TWS_PlaySvistokCycle(FileName: String);
begin
    try BASS_ChannelStop(SvistokCycleChannel); BASS_StreamFree(SvistokCycleChannel);
       SvistokCycleChannel:=BASS_StreamCreateFile(FALSE, PChar(FileName), 0, 0, BASS_SAMPLE_LOOP{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
       BASS_ChannelPlay(SvistokCycleChannel, TRUE);
       BASS_ChannelSetAttribute(SvistokCycleChannel, BASS_ATTRIB_VOL, 0);
    except end;
end;

procedure PlayTifonIsEnd(vHandle, vStream, vData: Cardinal; vUser: Pointer); stdcall;
begin
  if BASS_ChannelIsActive(TifonCycleChannel) <> 0 then
     if Camera <> 2 then
        BASS_ChannelSetAttribute(TifonCycleChannel, BASS_ATTRIB_VOL, FormMain.trcBarSignalsVol.Position / 100)
     else
        BASS_ChannelSetAttribute(TifonCycleChannel, BASS_ATTRIB_VOL,
        (5 / (WagsNum + LocoSectionsNum)) * (FormMain.trcBarSignalsVol.Position / 100));
end;

procedure TFormMain.TWS_PlayTifon(FileName: String);
begin
    try BASS_ChannelStop(TifonChannel); BASS_StreamFree(TifonChannel);
       TifonChannel:=BASS_StreamCreateFile(FALSE, PChar(FileName), 0, 0, 0 {$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
       BASS_ChannelPlay(TifonChannel, TRUE);
       if Camera <> 2 then
          BASS_ChannelSetAttribute(TifonChannel, BASS_ATTRIB_VOL, trcBarSignalsVol.Position/100)
       else
          BASS_ChannelSetAttribute(TifonChannel, BASS_ATTRIB_VOL,
          (5 / (WagsNum + LocoSectionsNum)) * (trcBarSignalsVol.Position / 100));
       BASS_ChannelSetSync(TifonChannel, BASS_SYNC_POS,
                           BASS_ChannelSeconds2Bytes(TifonChannel, BASS_ChannelBytes2Seconds(TifonChannel, BASS_ChannelGetLength(TifonChannel, BASS_POS_BYTE)) - 0.05),
                           @PlayTifonIsEnd, nil);
    except end;
end;

procedure TFormMain.TWS_PlayTifonCycle(FileName: String);
begin
    try BASS_ChannelStop(TifonCycleChannel); BASS_StreamFree(TifonCycleChannel);
       TifonCycleChannel:=BASS_StreamCreateFile(FALSE, PChar(FileName), 0, 0, BASS_SAMPLE_LOOP{$IFDEF UNICODE} or BASS_UNICODE {$ENDIF});
       BASS_ChannelPlay(TifonCycleChannel, TRUE);
       BASS_ChannelSetAttribute(TifonCycleChannel, BASS_ATTRIB_VOL, 0);
       BASS_ChannelStop(Tifon); BASS_StreamFree(Tifon);
    except end;
end;

// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
// ***************************************************************************************************************** //
procedure TFormMain.timerSoundSliderTimer(Sender: TObject);
var
  VentVolume: Single;
begin
  // ПЕРЕХОД МЕЖДУ ДОРОЖКАМИ ПЕРЕСТУКА ЛОКОМОТИВА //
  if PerehodLoco=True then begin
    if ChannelNum=0 then begin
      BASS_ChannelSetAttribute(LocoChannel[0], BASS_ATTRIB_VOL, LocoVolume/100);
      BASS_ChannelSetAttribute(LocoChannel[1], BASS_ATTRIB_VOL, LocoVolume2/100);
      Dec(LocoVolume); Inc(LocoVolume2);
      if LocoVolume<=0 then begin PerehodLoco:=False; BASS_ChannelStop(LocoChannel[0]); BASS_StreamFree(LocoChannel[0]); end;
    end;
    if ChannelNum=1 then begin
      BASS_ChannelSetAttribute(LocoChannel[1], BASS_ATTRIB_VOL, LocoVolume/100);
      BASS_ChannelSetAttribute(LocoChannel[0], BASS_ATTRIB_VOL, LocoVolume2/100);
      Dec(LocoVolume); Inc(LocoVolume2);
      if LocoVolume<=0 then begin PerehodLoco:=False; BASS_ChannelStop(LocoChannel[1]); BASS_StreamFree(LocoChannel[1]); end;
    end;
  end;
  // ******************************************** //
  // ПЕРЕХОД МЕЖДУ ДОРОЖКАМИ ТЕД-ов //
  if PerehodTED=True then begin
    if TEDVolume>TEDVlm then TEDVolume:=TEDVlm;
    if TEDVolume2>TEDVlm then TEDVolume2:=TEDVlm;
    if TEDVolume<0 then TEDVolume:=0;
    if TEDVolume2<0 then TEDVolume2:=0;
    if ChannelNumTED=0 then begin
      try BASS_ChannelGetAttribute(TEDChannel_FX , BASS_ATTRIB_VOL, TEDVolume ); except TEDVolume:=0; end;
      try BASS_ChannelGetAttribute(TEDChannel2, BASS_ATTRIB_VOL, TEDVolume2); except TEDVolume2:=TEDVlm; end;
      if TEDVolume  > 0      then TEDVolume  := TEDVolume  - PerehodTEDStep;
      if TEDVolume2 < TEDVlm then TEDVolume2 := TEDVolume2 + PerehodTEDStep*2;
      BASS_ChannelSetAttribute(TEDChannel_FX, BASS_ATTRIB_VOL, TEDVolume);
      BASS_ChannelSetAttribute(TEDChannel2, BASS_ATTRIB_VOL, TEDVolume2);
      if (TEDVolume<=0) and (TEDVolume2>=TEDVlm) then begin PerehodTED:=False; BASS_ChannelStop(TEDChannel); BASS_StreamFree(TEDChannel); BASS_ChannelStop(TEDChannel_FX); BASS_StreamFree(TEDChannel_FX); end;
    end;
    if ChannelNumTED=1 then begin
      try BASS_ChannelGetAttribute(TEDChannel2 , BASS_ATTRIB_VOL, TEDVolume ); except TEDVolume:=0; end;
      try BASS_ChannelGetAttribute(TEDChannel_FX, BASS_ATTRIB_VOL, TEDVolume2); except TEDVolume2:=TEDVlm; end;
      if TEDVolume  > 0      then TEDVolume  := TEDVolume  - PerehodTEDStep;
      if TEDVolume2 < TEDVlm then TEDVolume2 := TEDVolume2 + PerehodTEDStep*2;
      BASS_ChannelSetAttribute(TEDChannel2, BASS_ATTRIB_VOL, TEDVolume );
      BASS_ChannelSetAttribute(TEDChannel_FX , BASS_ATTRIB_VOL, TEDVolume2);
      if (TEDVolume<=0) and (TEDVolume2>=TEDVlm) then begin PerehodTED:=False; BASS_ChannelStop(TEDChannel2); BASS_StreamFree(TEDChannel2); end;
    end;
  end;
  // ******************************* //
  // ПЕРЕХОД МЕЖДУ ДОРОЖКАМИ ДИЗЕЛЕЙ //
  if PerehodDIZ=True then begin
    if DIZVolume>DIZVlm then DIZVolume:=DIZVlm;
    if DIZVolume2>DIZVlm then DIZVolume2:=DIZVlm;
    if DIZVolume<0 then DIZVolume:=0;
    if DIZVolume2<0 then DIZVolume2:=0;
    if ChannelNumDIZ=0 then begin
      try BASS_ChannelGetAttribute(DIZChannel , BASS_ATTRIB_VOL, DIZVolume ); except DIZVolume:=0; end;
      try BASS_ChannelGetAttribute(DizChannel2, BASS_ATTRIB_VOL, DIZVolume2); except DIZVolume2:=DIZVlm; end;
      if DIZVolume  > 0      then DIZVolume  := DIZVolume  - PerehodDIZStep;
      if DIZVolume2 < DIZVlm then DIZVolume2 := DIZVolume2 + PerehodDIZStep*2;
      BASS_ChannelSetAttribute(DIZChannel, BASS_ATTRIB_VOL, DIZVolume);
      BASS_ChannelSetAttribute(DIZChannel2, BASS_ATTRIB_VOL, DIZVolume2);
      if (DIZVolume<=0) and (DIZVolume2>=DIZVlm) then begin PerehodDIZ:=False; BASS_ChannelStop(DIZChannel); BASS_StreamFree(DIZChannel); end;
    end;
    if ChannelNumDIZ=1 then begin
      try BASS_ChannelGetAttribute(DIZChannel2 , BASS_ATTRIB_VOL, DIZVolume ); except DIZVolume:=0; end;
      try BASS_ChannelGetAttribute(DIZChannel, BASS_ATTRIB_VOL, DIZVolume2); except DIZVolume2:=DIZVlm; end;
      if DIZVolume  > 0      then DIZVolume  := DIZVolume  - PerehodDIZStep;
      if DIZVolume2 < DIZVlm then DIZVolume2 := DIZVolume2 + PerehodDIZStep*2;
      BASS_ChannelSetAttribute(DIZChannel2, BASS_ATTRIB_VOL, DIZVolume );
      BASS_ChannelSetAttribute(DIZChannel , BASS_ATTRIB_VOL, DIZVolume2);
      if (DIZVolume<=0) and (DIZVolume2>=DIZVlm) then begin PerehodDIZ:=False; BASS_ChannelStop(DIZChannel2); BASS_StreamFree(DIZChannel2); end;
    end;
  end;
  // ******************************* //
  // ЗАТУХАНИЕ ЗВУКА ВСТРЕЧНОГО ПОЕЗДА //
  if VstrZat=True then begin
        VstrVolume := VstrVolume - 3;
        if VstrVolume <= 0 then begin VstrVolume:=0; VstrZat:=False; BASS_ChannelStop(Vstrech); BASS_StreamFree(Vstrech);end;
        BASS_ChannelSetAttribute(Vstrech, BASS_ATTRIB_VOL, VstrVolume/100);
  end;
  if StartVentVU=True then begin
        BASS_ChannelGetAttribute(VentCycle_Channel, BASS_ATTRIB_VOL, VentVolume);
        if VentVolume < trcBarVspomMahVol.Position/100 then begin
  	   VentVolume:=VentVolume + 0.01;
           BASS_ChannelSetAttribute(VentCycle_Channel, BASS_ATTRIB_VOL, VentVolume);
           BASS_ChannelSetAttribute(XVentCycle_Channel, BASS_ATTRIB_VOL,VentVolume);
        end else begin
           StartVentVU := False;
        end;
  end;
  // ********************************* //
  // ЗАТУХАНИЕ ЗВОНКА НА ПЕРЕЕЗДЕ //
  if PereezdZatuh=True then begin
        ZvonVolume := ZvonVolume - 0.5;
        if ZvonVolume <= 0 then begin ZvonVolume:=0; PereezdZatuh:=False; BASS_ChannelStop(SAUTChannelZvonok); BASS_StreamFree(SAUTChannelZvonok); end;
  	BASS_ChannelSetAttribute(SAUTChannelZvonok, BASS_ATTRIB_VOL, ZvonVolume/100);
  end;
  // **************************** //
  With CHS8__ do begin
  if isStartUnipuls=True then begin
        BASS_ChannelSetAttribute(Unipuls_Channel[UnipulsChanNum], BASS_ATTRIB_VOL, UnipulsFaktVol/100);
        Inc(UnipulsFaktVol);
        if UnipulsFaktVol=UnipulsTargetVol then isStartUnipuls:=False;
  end;
  if isStopUnipuls=True then begin
        BASS_ChannelSetAttribute(Unipuls_Channel[UnipulsChanNum], BASS_ATTRIB_VOL, UnipulsFaktVol/100);
        Dec(UnipulsFaktVol);
        if UnipulsFaktVol=UnipulsTargetVol then begin isStopUnipuls:=False;
        BASS_ChannelStop(Unipuls_Channel[UnipulsChanNum]); BASS_StreamFree(Unipuls_Channel[UnipulsChanNum]);
        UnipulsFaktPos:=0; UnipulsTargetPos:=0;
        end;
  end;
  end;
  // Переход между дорожками Унипульса
  (*if UnipulsPerehod=True then begin
    if UnipulsChanNum=0 then begin
      UnipulsVol1:=UnipulsVol1-10; UnipulsVol2:=UnipulsVol2+10;
      if UnipulsVol1<0 then begin UnipulsVol1:=0; UnipulsVol2:=TrackBar8.Position; end;
      BASS_ChannelSetAttribute(Unipuls_Channel1, BASS_ATTRIB_VOL, UnipulsVol1/100);
      BASS_ChannelSetAttribute(Unipuls_Channel2, BASS_ATTRIB_VOL, UnipulsVol2/100);
      if UnipulsVol1=0 then begin UnipulsPerehod:=False; BASS_ChannelStop(Unipuls_Channel1); BASS_StreamFree(Unipuls_Channel1); end;
    end;
    if UnipulsChanNum=1 then begin
      UnipulsVol1:=UnipulsVol1-10; UnipulsVol2:=UnipulsVol2+10;
      if UnipulsVol1<0 then begin UnipulsVol1:=0; UnipulsVol2:=TrackBar8.Position; end;
      BASS_ChannelSetAttribute(Unipuls_Channel2, BASS_ATTRIB_VOL, UnipulsVol1/100);
      BASS_ChannelSetAttribute(Unipuls_Channel1, BASS_ATTRIB_VOL, UnipulsVol2/100);
      if UnipulsVol1=0 then begin UnipulsPerehod:=False; BASS_ChannelStop(Unipuls_Channel2); BASS_StreamFree(Unipuls_Channel2); end;
    end;
  end;*)
end;

procedure TFormMain.timerPRSswitcherTimer(Sender: TObject);
begin
  if (cbPRS_RZD.Checked = True) or (cbPRS_UZ.Checked = True) then isPlayPRS := False;
  // Если мы на станции, то интервал радиостанции - меньше
  if (isPlayPerestuk_OnStation=True) then timerPRSswitcher.Interval:=180000 else begin
    Randomize; Randomize; timerPRSswitcher.Interval:=350000+Random(150000); end;
end;

// Смена громкости звуков при измене показаний любого TrackBar
procedure TFormMain.ChangeVolume(Sender: TObject);
begin
       VolumeMaster_RefreshVolume();
end;

// Таймер проверки запущеного симулятора ZDSimulator
procedure TFormMain.timerSearchSimulatorWindowTimer(Sender: TObject);
var
	I: Integer;
begin
	isConnectedMemory := FindTask('Launcher.exe');	// Проверка запущен-ли симулятор?

        if isConnectedMemory = True then begin
  	   for I := 0 to 2 do begin
     	      if I = 0 then GameWindowName := 'ZDSimulator55.008';
       	      if I = 1 then GameWindowName := 'ZDSimulator54.006';
              if I = 2 then GameWindowName := 'viewer';
              wHandle := FindWindow(nil, PChar(GameWindowName+' [Paused]'));
     	      if wHandle<>0 then begin
                 isGameOnPause        := True;
                 isConnectedMemory    := True;
                 Label5.Caption       := GameWindowName;
                 Break;
     	      end else begin
                 wHandle := FindWindow(nil, PChar(GameWindowName));
                 if wHandle=0 then begin
                    isGameOnPause     := True;
                    isConnectedMemory := False;
                    Label5.Caption    := 'Симулятор не запущен';
                 end else begin
                    tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
                    pHandle := OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcessID);
                    //if I = 0 then ADDR_ZDS_EXE_LABEL:=ptr($00172C28);
                    //if ReadStringFromMemory(ADDR_ZDS_EXE_LABEL,17)='DGLEngine Launcher' then
                    isGameOnPause     := False;
                    //else
                    //   isGameOnPause     := True;
                    CloseHandle(pHandle);
                    isConnectedMemory := True;
                    Label5.Caption    := GameWindowName;
                    if I = 2 then begin RRS_.createSoundRRSManager(Self); ClockMain.Enabled := False; end;
                    Break;
                 end;
              end;
              CloseHandle(wHandle);
  	   end;
        end else isGameOnPause := True;
        if I <> VersionID then begin
           InitializeStartParams(I);
        end;

	RefreshSnd:=True;
        VersionID := I;
end;

// === Нажатие на чекбокс "Звук КЛУБ-у" === //
procedure TFormMain.cbKLUBSoundsClick(Sender: TObject);
begin
	if cbKLUBSounds.Checked=True then begin
           cb3SL2mSounds.Checked:=False
        end else begin
           BASS_ChannelStop(Ogr_Speed_KLUB); BASS_StreamFree(Ogr_Speed_KLUB);
           isPlayOgrSpKlub:=0;
        end;
end;

// === Нажатие на чекбокс "Звуки 3СЛ2м" === //
procedure TFormMain.cb3SL2mSoundsClick(Sender: TObject);
begin
	if cb3SL2mSounds.Checked=True then begin
           cbKLUBSounds.Checked:=False; isPlayClock:=False;
        end else begin
           BASS_ChannelStop(ClockChannel); BASS_StreamFree(ClockChannel);
        end;
end;

// === Нажатие на чекбокс "Звук встречного поезда" === //
procedure TFormMain.cbHeadTrainSoundClick(Sender: TObject);
begin
	if cbHeadTrainSound.Checked=False then begin
           BASS_ChannelStop(Vstrech); BASS_StreamFree(Vstrech);
        end;
end;

procedure TFormMain.Button3Click(Sender: TObject);
begin
        ShellExecute(Self.Handle,'explore', PChar(ExtractFilePath(Application.ExeName)+'TWS/БАТНИКИ/'),nil,nil,SW_SHOWNORMAL);
end;

procedure TFormMain.timerPlayPerestukTimer(Sender: TObject);
begin
	if Speed >= 3 then begin
           if (BASS_ChannelIsActive(LocoChannelPerestuk)=0) then begin
              PerestukPLAY:=True;
              TimerPlayPerestuk.Enabled := False;
           end;
           Randomize; Randomize; Randomize;
           if isPlayPerestuk_OnStation = True then begin
              TimerPlayPerestuk.Interval := 10000;
           end else begin
              TimerPlayPerestuk.Interval := 35000+Random(Speed*40);
           end;
        end;
end;

// === Нажатие на чекбокс "Звук трения колодок при торможении" === //
procedure TFormMain.cbBrakingSoundsClick(Sender: TObject);
begin
	if cbBrakingSounds.Checked=False then begin
           BASS_ChannelStop(Brake_Channel[0]); BASS_StreamFree(Brake_Channel[0]);
           BASS_ChannelStop(Brake_Channel[1]); BASS_StreamFree(Brake_Channel[1]);
        end else begin
           BrakeCylinders:=0.0;
        end;
end;

// === Нажатие на чекбокс "Звуки окружения" ===
procedure TFormMain.cbNatureSoundsClick(Sender: TObject);
begin
	if cbNatureSounds.Checked=False then begin
           BASS_ChannelStop(Rain_Channel); BASS_StreamFree(Rain_Channel);
           BASS_ChannelStop(Stochist_Channel); BASS_StreamFree(Stochist_Channel);
           BASS_ChannelStop(StochistUdar_Channel); BASS_StreamFree(StochistUdar_Channel);
        end else begin
           PrevRain:=0;
        end;
end;

//------------------------------------------------------------------------------//
//                Нажатие на чекбокс блок ЭПЛ2т (информатор УЗ)                 //
//------------------------------------------------------------------------------//
procedure TFormMain.cbEPL2TBlockClick(Sender: TObject);
var
   sr:TSearchRec;
begin
   if cbEPL2TBlock.Checked=True then begin
      cbSAVPESounds.Checked := False;cbSAUTSounds.Checked:=False;cbUSAVPSounds.Checked:=False;cbGSAUTSounds.Checked:=False;

      groupBoxLocoSndCheckboxes.Left:=groupBoxLocoSndCheckboxes.Left+groupBoxSOVIDescription.Width;
      groupBoxSAVPCheckboxes.Left:=groupBoxSAVPCheckboxes.Left+groupBoxSOVIDescription.Width;
      groupBoxPRSCheckboxes.Left:=groupBoxPRSCheckboxes.Left+groupBoxSOVIDescription.Width;
      lblSimulatorVersionLaunched.Left:=lblSimulatorVersionLaunched.Left+groupBoxSOVIDescription.Width;
      Label5.Left:=Label5.Left+groupBoxSOVIDescription.Width;
      panelPasswagSounds.Left:=panelPasswagSounds.Left+groupBoxSOVIDescription.Width;
      groupBoxSOVIDescription.Visible:=True;
      FormMain.ClientWidth:=FormMain.ClientWidth+groupBoxSOVIDescription.Width;

      isSpeedLimitRouteLoad:=False;
      SAVPName := 'EPL2T';

      if FindFirst('TWS/SOVI_INFORMATOR/Info/*.*',faAnyFile,sr)=0 then
         repeat
            if (sr.Attr and faDirectory <> 0) and (sr.Name <> '.') and (sr.Name <> '..') then
               ComboBox3.Items.Add(SR.Name);
         until Findnext(sr)<>0;
      FindClose(sr);
      ComboBox3.ItemIndex:=0;
      ComboBox3Change(cbEPL2TBlock);

      //Load_TWS_SAVP_EK();
   end else begin
      groupBoxLocoSndCheckboxes.Left:=groupBoxLocoSndCheckboxes.Left-groupBoxSOVIDescription.Width;
      groupBoxSAVPCheckboxes.Left:=groupBoxSAVPCheckboxes.Left-groupBoxSOVIDescription.Width;
      groupBoxPRSCheckboxes.Left:=groupBoxPRSCheckboxes.Left-groupBoxSOVIDescription.Width;
      lblSimulatorVersionLaunched.Left:=lblSimulatorVersionLaunched.Left-groupBoxSOVIDescription.Width;
      Label5.Left:=Label5.Left-groupBoxSOVIDescription.Width;
      panelPasswagSounds.Left:=panelPasswagSounds.Left-groupBoxSOVIDescription.Width;
      groupBoxSOVIDescription.Visible:=False;
      FormMain.ClientWidth:=FormMain.ClientWidth-groupBoxSOVIDescription.Width;

      BASS_ChannelStop(SAUTChannelObjects); BASS_StreamFree(SAUTChannelObjects);
      BASS_ChannelStop(SAUTChannelObjects2); BASS_StreamFree(SAUTChannelObjects2);
      BASS_ChannelStop(SAUTChannelZvonok); BASS_StreamFree(SAUTChannelZvonok);
      UpdateInfoName;
   end;
end;

//------------------------------------------------------------------------------//
//                           Нажатие на чекбокс САВПЭ                           //
//------------------------------------------------------------------------------//
procedure TFormMain.cbSAVPESoundsClick(Sender: TObject);
var
	sr:TSearchRec;
begin
	if cbSAVPESounds.Checked=True then begin
          RefreshMVPSType();

          SAVPName := 'SAVPE';
          cbSAUTSounds.Checked:=False;
          cbGSAUTSounds.Checked:=False;
          cbUSAVPSounds.Checked:=False;
          cbEPL2TBlock.Checked:=False;
          SAUTOFFF:='TWS/INFO/USAVP_podskazka.mp3';
          isSpeedLimitRouteLoad:=False;SAUTOff:=True;

          groupBoxLocoSndCheckboxes.Left:=groupBoxLocoSndCheckboxes.Left+groupBoxSAVPEbox.Width;
          groupBoxSAVPCheckboxes.Left:=groupBoxSAVPCheckboxes.Left+groupBoxSAVPEbox.Width;
          groupBoxPRSCheckboxes.Left:=groupBoxPRSCheckboxes.Left+groupBoxSAVPEbox.Width;
          lblSimulatorVersionLaunched.Left:=lblSimulatorVersionLaunched.Left+groupBoxSAVPEbox.Width;
          Label5.Left:=Label5.Left+groupBoxSAVPEbox.Width;
          panelPasswagSounds.Left:=panelPasswagSounds.Left+groupBoxSAVPEbox.Width;
          groupBoxSAVPEbox.Visible := True;
          FormMain.ClientWidth:=FormMain.ClientWidth+groupBoxSAVPEbox.Width;

          if FindFirst('TWS/SAVPE_INFORMATOR/Info/*.*',faAnyFile,sr)=0 then
	  repeat
            if (sr.Attr and faDirectory <> 0) and (sr.Name <> '.') and (sr.Name <> '..') then
	      ComboBox1.Items.Add(SR.Name);
	  until Findnext(sr)<>0;
            FindClose(sr);
          end;
          ComboBox1.ItemIndex:=0;
          ComboBox1Change(cbSAVPESounds);

  	if cbSAVPESounds.Checked=False then begin
          SAVPEEnabled := False;

    	  BASS_ChannelStop(SAUTChannelObjects); BASS_StreamFree(SAUTChannelObjects);
    	  BASS_ChannelStop(SAUTChannelZvonok); BASS_StreamFree(SAUTChannelZvonok);
          BASS_ChannelStop(SAVPE_INFO_Channel); BASS_StreamFree(SAVPE_INFO_Channel);
          BASS_ChannelStop(SAVPE_Peek_Channel); BASS_StreamFree(SAVPE_Peek_Channel);

          groupBoxSAVPEbox.Visible := False;
          groupBoxLocoSndCheckboxes.Left:=groupBoxLocoSndCheckboxes.Left-groupBoxSAVPEbox.Width;
          groupBoxSAVPCheckboxes.Left:=groupBoxSAVPCheckboxes.Left-groupBoxSAVPEbox.Width;
          groupBoxPRSCheckboxes.Left:=groupBoxPRSCheckboxes.Left-groupBoxSAVPEbox.Width;
          lblSimulatorVersionLaunched.Left:=lblSimulatorVersionLaunched.Left-groupBoxSAVPEbox.Width;
          Label5.Left:=Label5.Left-groupBoxSAVPEbox.Width;
          panelPasswagSounds.Left:=panelPasswagSounds.Left-groupBoxSAVPEbox.Width;
          FormMain.ClientWidth:=FormMain.ClientWidth-groupBoxSAVPEbox.Width;
          UpdateInfoName;
  	end;
end;

procedure TFormMain.ComboBox3Change(Sender: TObject);
var
	sr:TSearchRec;
        TempSc: TStringList;
begin
	ComboBox4.Items.Clear;
        TempSc := TStringList.Create;
        if FindFirst('TWS/SOVI_INFORMATOR/Info/'+ComboBox3.Items[ComboBox3.ItemIndex]+'/*.TWS',faAnyFile,sr)=0 then
        repeat
           if (sr.Attr <> 0) and (sr.Name <> '.') and (sr.Name <> '..') then begin
              ComboBox4.Items.Add(SR.Name)
           end;
        until Findnext(sr)<>0;
        FindClose(sr);
end;

procedure TFormMain.ComboBox4Change(Sender: TObject);
begin
        LoadSOVI_EK('TWS/SOVI_INFORMATOR/Info/'+ComboBox3.Items[ComboBox3.ItemIndex]+'/'+ComboBox4.Items[ComboBox4.ItemIndex]);
end;

procedure TFormMain.ComboBox1Change(Sender: TObject);
var
	sr:TSearchRec;
        TempSc: TStringList;
        PrevIndx, PrevParIndx: Integer;
begin
        PrevIndx := ComboBox2.ItemIndex;
        PrevParIndx := ComboBox1.ItemIndex;
        ComboBox2.Items.Clear;
        ComboBox2.Items.Add('< Без ЭК >');
        ComboBox2.Sorted := True;
        TempSc := TStringList.Create;
        if FindFirst('TWS/SAVPE_INFORMATOR/Info/'+ComboBox1.Items[ComboBox1.ItemIndex]+'/*.TWS',faAnyFile,sr)=0 then
        repeat
           if (sr.Attr <> 0) and (sr.Name <> '.') and (sr.Name <> '..') then begin
              if (Pos('sc_', SR.Name))=0 then
                 ComboBox2.Items.Add(SR.Name) else
                 TempSc.Add(Sr.Name);
           end;
	   until Findnext(sr)<>0;
              FindClose(sr);
        ComboBox2.Sorted:=False;
        ComboBox2.Items.AddStrings(TempSc);

        try
           if (ComboBox1.ItemIndex = PrevParIndx) and (PrevIndx>=0) then
              ComboBox2.ItemIndex := PrevIndx
           else
              ComboBox2.ItemIndex := 0;
        except end;
        ComboBox2Change(ComboBox1);
end;

// === Нажатие на чекбокс "Звуки вспомогательных машин" === //
procedure TFormMain.cbVspomMashClick(Sender: TObject);
begin
	if cbVspomMash.Checked=False then begin
            BASS_ChannelStop(Unipuls_Channel[0]); BASS_StreamFree(Unipuls_Channel[0]);
            BASS_ChannelStop(Unipuls_Channel[1]); BASS_StreamFree(Unipuls_Channel[1]);
            With CHS8__ do begin
               UnipulsFaktVol:=0; UnipulsTargetVol:=0; UnipulsTargetPos:=0; UnipulsFaktPos:=0;
            end;
            TimerPerehodUnipulsSwitch.Enabled := False;

            BASS_ChannelStop(Compressor_Channel); BASS_StreamFree(Compressor_Channel);
            BASS_ChannelStop(Vent_Channel); BASS_StreamFree(Vent_Channel);
            BASS_ChannelStop(VentCycle_Channel); BASS_StreamFree(VentCycle_Channel);
            BASS_ChannelStop(VentTD_Channel); BASS_StreamFree(VentTD_Channel);
            BASS_ChannelStop(VentCycleTD_Channel); BASS_StreamFree(VentCycleTD_Channel);
            BASS_ChannelStop(XVent_Channel); BASS_StreamFree(XVent_Channel);
            BASS_ChannelStop(XVentCycle_Channel); BASS_StreamFree(XVentCycle_Channel);
            BASS_ChannelStop(XVentTD_Channel); BASS_StreamFree(XVentTD_Channel);
            BASS_ChannelStop(XVentCycleTD_Channel); BASS_StreamFree(XVentCycleTD_Channel);
        end;
end;

procedure TFormMain.timerPerehodUnipulsSwitchTimer(Sender: TObject);
begin
        TimerPerehodUnipulsSwitch.Enabled := False;
end;

procedure TFormMain.timerPerehodDizSwitchTimer(Sender: TObject);
begin
	TimerPerehodDizSwitch.Enabled := False;
end;

// -=-=-=-=-=-=- БЛОК ВЫБОРА ПОЛЬЗОВАТЕЛЕМ ЭК САВПЭ -=-=-=-=-=-=- //
procedure TFormMain.ComboBox2Change(Sender: TObject);
begin
	LoadSAVPE_EK('TWS/SAVPE_INFORMATOR/Info/' + ComboBox1.Items[ComboBox1.ItemIndex] + '/' +
                     ComboBox2.Items[ComboBox2.ItemIndex]);
end;

procedure TFormMain.timerDoorCloseDelayTimer(Sender: TObject);
begin
	SAVPE_DoorCloseTimerTick();
end;

// Включение Автоматического режима работы САВПЭ на МВПС
procedure TFormMain.RB_AutoEKModeClick(Sender: TObject);
begin
	cbSAVPE_Marketing.Enabled := True;	// Включаем галочку "проигрывать маркетинговые объявления"
        GroupBox5.Enabled := True;	// Включаем блок настройки задержки объявления закрытия дверей
        Edit1.Enabled := True;
        Edit1.Color := clWindow;
        ComboBox2Change(FormMain);
end;

procedure TFormMain.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
	if Key in ['0'..'9']+[#8] then
  	begin

  	end else Key:=#0;
end;

procedure TFormMain.Edit1Change(Sender: TObject);
begin
	try if StrToInt(Edit1.Text)>255 then Edit1.Text:=IntToStr(255); except end;
end;

procedure TFormMain.timer3SL2m_3SecTimer(Sender: TObject);
begin
	isPlayClock := False;	Timer3SL2m_3Sec.Enabled := False;
end;

// Метод: открытие папки с батниками
// ------------------------------------------
// На вход: ничего
// Примечания: нет
procedure TFormMain.N5Click(Sender: TObject);
begin
   ShellExecute(Self.Handle,'explore', PChar(ExtractFilePath(Application.ExeName)+'TWS/BAT_FILES/'),nil,nil,SW_SHOWNORMAL);
end;

// Метод: открытие файла ReadME
// ------------------------------------------
// На вход: ничего
// Примечания: нет
procedure TFormMain.ReadME1Click(Sender: TObject);
begin
   ShellExecute(Handle, 'open', PChar(ExtractFilePath(Application.ExeName)+'TWS/ReadME.doc'), nil, nil, SW_SHOWNORMAL);
end;

// Метод: сохранение настроек в файл
// ------------------------------------------
// На вход: ничего
// Примечания: нет
procedure TFormMain.N3Click(Sender: TObject);
var
	saveDialog : TSaveDialog;    // Переменная диалога сохранения
        Res : Integer;
begin
	saveDialog := TSaveDialog.Create(self);

  	// Give the dialog a title
  	saveDialog.Title := 'Save your text or word file';

  	saveDialog.InitialDir := 'TWS\saves\';

  	saveDialog.Filter := 'Ini files|*.ini';

  	saveDialog.DefaultExt := 'ini';

  	saveDialog.FilterIndex := 0;

  	if saveDialog.Execute then begin
           //Если файл с указанным именем уже существует.
           if FileExists(saveDialog.FileName) then begin
              Res := MessageDlg(
                     'Файл с именем:' + #10
                      + '"' + saveDialog.FileName + '"' + #10
                      + 'Уже существует. Перезаписать?'
                      ,mtConfirmation
                      ,[mbYes, mbNo]
                      ,0
                   );
              if Res = mrYes then SaveTWSParams(saveDialog.FileName);
           end else SaveTWSParams(saveDialog.FileName);
        end;

  	saveDialog.Free;
end;

// Метод: загрузка настроек TWS из файла
// ------------------------------------------
// На вход: ничего
// Примечания: нет
procedure TFormMain.N4Click(Sender: TObject);
var
  	openDialog: TOpenDialog;    // Переменная OpenDialog
begin
  	openDialog := TOpenDialog.Create(self);

  	openDialog.InitialDir := 'TWS\saves\';

  	openDialog.Options := [ofFileMustExist];

  	openDialog.Filter :=
    	'Ini files|*.ini';

  	openDialog.FilterIndex := 0;

  	if openDialog.Execute
  	then LoadTWSParams(openDialog.FileName);

  	openDialog.Free;
end;

// Метод: Открытие окна "АВТОРЫ"
// ------------------------------------------
// На вход: ничего
// Примечания: нет
procedure TFormMain.N6Click(Sender: TObject);
begin
	FormAuthors.Show();
end;

procedure TFormMain.N9Click(Sender: TObject);
begin
	FormSettings.Show();
end;

procedure TFormMain.N10Click(Sender: TObject);
begin
	FormDebug.Show();
end;

procedure TFormMain.btnSAVPEHelpClick(Sender: TObject);
begin
	FormSAVPEHelp.Show;
end;

procedure TFormMain.cbSignalsSoundsClick(Sender: TObject);
begin
	if cbSignalsSounds.Checked = False then begin
           BASS_ChannelStop(SvistokChannel); BASS_StreamFree(SvistokChannel);
           BASS_ChannelStop(SvistokCycleChannel); BASS_StreamFree(SvistokCycleChannel);
           BASS_ChannelStop(TifonChannel); BASS_StreamFree(TifonChannel);
           BASS_ChannelStop(TifonCycleChannel); BASS_StreamFree(TifonCycleChannel);
        end;
end;

procedure TFormMain.trcBarSignalsVolChange(Sender: TObject);
begin
	VolumeMaster_RefreshVolume();
end;

procedure TFormMain.timerVigilanceUSAVPDelayTimer(Sender: TObject);
begin
        TimerVigilanceUSAVPDelay.Enabled := False;
        if VCheck <> 0 then
	   DecodeResAndPlay('TWS/SAVP/USAVP/567.res', isPlaySAUTObjects, SAUTF, SAUTChannelObjects, ResPotok, PlayRESFlag);
end;

procedure TFormMain.btnSOVIHelpClick(Sender: TObject);
begin
	FormSOVIHelp.ShowModal();
end;

end.

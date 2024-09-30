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
 |    UKRAINE, DNEPR CITY, 2017-2024 (C)                             |    /
 |                                                                   |   /
 |                                                                   |  /
 |                                                                   | /
 |                                                                   |/
 +-------------------------------------------------------------------+
*)
unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Graphics, Forms, Dialogs, StdCtrls, ComCtrls,
  Menus, IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME, ExtCtrls,
  Controls, Classes, Bass, inifiles, UnitAuthors, TlHelp32, ShellApi, Grids,
  ValEdit, jpeg, UnitSAVPEHelp, UnitDebug, Math, UnitUSAVP,
  EncdDecd, SAVP, RAMMemModule, FileManager, ExtraUtils, SoundManager, Debug,
  bass_fx, UnitSOVIHelp, UnitSoundRRS, CHS8, CHS4KVR, CHS7, CHS4T, VL80T,
  ES5K, EP1M, ED4M, ED9M, CHS2K, sl2m, VL82M, CHS4, TE10U, M62;

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
    timerDoorCloseZvonok: TTimer;
    
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
    procedure timerDoorCloseZvonokTimer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  // ************************ ���������� ���������� ******************************
type
   ProcReadDataMemoryType = procedure() of object; // ���������� ���, ��� ���� ����� �������� ���������� �� ��� ��� ������� ����������

var
  FormMain: TFormMain;			   // ������� ����� ���������

  MainCycleFreq:               Integer;    // ������� ������ ��������� [ms]

  ResPotok:                    TMemoryStream; // ����� ������ ��� RES-��������

  VersionID:                   Byte;	   // ID ������ ���������� (������������ �������������)

  Log_: log;				   // ��� ���������
  RRS_: soundrrs;                          // ����� RRS (�������� 1.0.4)

  CHS7__: chs7_;
  CHS8__: chs8_; 			   // ��������� ��8
  CHS4T__: chs4t_;
  CHS2K__: chs2k_;
  CHS4KVR__: chs4kvr_;
  CHS4__: chs4_;
  VL80T__: vl80t_;
  EP1M__: ep1m_;
  ES5K__: es5k_;
  ED4M__: ed4m_;
  ED9M__: ed9m_;
  VL82M__: vl82m_;
  TE10U__: te10u_;
  M62__: m62_;

  SL2M__: sl2m_;

  // ������ ���������� � ����� settings.ini (� 2.6 �� ���) //
  Route:                       String;	   // ���������� ��� �������� ����� ��������
  Naprav:		       String;	   // ���������� ��� �������� ����������� �������� (Tuda && Obratno)
  NapravOrdinata:              String;     // ���������� ��� �������� ����������� �������� (��� �������)
  Freight:                     Byte;	   // ���������� ��� ���� ������ (1 - ��������; 0 - ������������)
  MP:                          Byte;       // ���������� ��� ���� ����� ������ ������� ��� ��
  Winter:                      Byte;	   // ����������-���� ���� � ����, ��� ��� [0, 1]
  ConsistLength:               Single;     // ������ ������ ������� � ������
  WagsNum:                     Byte;       // ���-�� ������� � ����� �������
  ConName:                     String;     // ��� ����� �������, ��� ��� ������������ �������
  TrackLength:                 Single;     // ����� ������ ����� � ������
  SceneryName:                 String;     // ��� �������� ��������
  LocoNum:                     Integer;    // ����� ���������� ����������
  LocoPowerVoltage:            Integer;    // -3/~25kV
  // ----------------------------------------------------- //

  // ������� ������� �� ����� start_kilometers.dat //
  StationTrack1:               array[0..75] Of Integer; // 1-�� ������� �������
  StationTrack2:               array[0..75] Of Integer; // 2-�� ������� �������
  StationCount:                Byte = 0;   // ����� ���������� �������
  // --------------------------------------------- //

  Loco, LocoGlobal:            String;	   // ���������� ��� �������� ����� ����������
  LocoSectionsNum:             Byte;       // ���������� ������ �� ����������
  LocoWithTED:                 Boolean;    // ���������� ��� �����������, ����-�� �� ������ ��������� ���� ���-��
  LocoWithReductor:            Boolean;
  LocoWithDIZ:                 Boolean;
  LocoWithSndKM:               Boolean;    // ���������� ��� �����������, ����-�� �� ������ ��������� ���� ������ �����������
  LocoWithSndKM_OP:            Boolean;    // ���������� ��� �����������, ����-�� �� ������ ��������� ���� ���������� ��
  LocoWithSndTP:               Boolean;    // ���������� ��� �����������, ����-�� �� ������ ��������� ����� ��
  LocoWithExtMVSound:          Boolean;    // ���������� ��� �����������, ����-�� �� ������ ��������� ������� ����� ��
  LocoWithExtMKSound:          Boolean;    // ���������� ��� �����������, ����-�� �� ������ ��������� ������� ����� ��
  LocoWithMVPitch:             Boolean;
  LocoWithMVTDPitch:           Boolean;
  LocoTEDNamePrefiks:          String;
  LocoReductorNamePrefiks:     String;
  LocoDIZNamePrefiks:          String;
  LocoSvistokF:                String;
  LocoHornF:                   String;
  LocoWorkDir:                 String;     // ������� ���������� ����������
  VentStartF, XVentStartF:     PChar;
  VentCycleF, XVentCycleF:     PChar;
  VentStopF,  XVentStopF:      PChar;
  VentTDStartF, XVentTDStartF: PChar;
  VentTDCycleF, XVentTDCycleF: PChar;
  VentTDStopF,  XVentTDStopF:  PChar;

  // ���������� ��� ������ ���������� //
  PrevKeyA, PrevKeyD:	       Byte;         // ���������� ��� ����. ������� ������ <<A>> � <<D>>
  PrevKeyE, PrevKeyQ:	       Byte;         // ���������� ��� ����. ������� ������ <<E>> � <<Q>>
  PrevKeyZ, PrevKeyLKM:	       Byte;         // ���������� ��� ����. ������� ������ <<Z>> � <<LKM>>
  PrevKeyW, PrevKeyS:	       Byte;         // ���������� ��� ����. ������� ������ <<W>> � <<S>>
  PrevKeyM, PrevKeyEPK:        Byte;         // ���������� ��� ����. ������� ������ <<M>> � <<N ��� SHIFT+N>>
  PrevKeyEPKS:                 Byte;
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
  GRIncrementer2:              Byte;

  sDecodeString:	       String;

  CycleVentVolume:             Byte = 100;   // ��������� ����� ������ ������������ (��80�)
  VentVolume:                  Byte = 100;   // ��������� ������ ������������ (��80�)
  ZvonVolume:                  Extended;
  ZvonTrack:                   Integer;      // ���������� ��� ������ ��������
  Vstrecha_dlina:              Integer;      // ������ �������� (� ������)
  PrevSpeed_Fakt:              Integer;      // ����������� ���������� ��������
  Prev_KMAbs:                  Integer;      // ����������� ���������� �������
  Prev_VentLocal:              Integer;	     // ��� ��4 ���

  // ----------------------------------------------------------------------- //
  // === ����� - ���������� ��� �������� ������ ������� ���������� � ��� === //
  // ----------------------------------------------------------------------- //
  KM_395,            PrevKM_395:      Byte;	    // ��������� ����� �395
  KM_294,            PrevKM_294:      Single;       // ��������� ����� �254 (������������)
  Svetofor,          PrevSvetofor:    Byte;	    // ��������� ��������� (��� �������)
  CoupleStat,        PrevCoupleStat:  Byte;
  Highlights,        PrevHighLights:  Byte;         // ��������� �����������
  VstrechStatus,     PrevVstrechStatus:Byte;
  PickKLUB,          PrevPickKLUB:    Integer;
  Reostat,           PrevReostat:     Byte;         // ���������� ��������� ��� �� ��8, ��� ����� �������
  Fazan,             PrevFazan:       Byte;         // ��������������� ��� ��80�
  Rain,              PrevRain:        Byte;         // ���������� ������������� �����
  Camera,            PrevCamera:      Byte;         // ���������� ��� ����������� ���� ������
  RB,                PrevRB:          Byte;         // ���������� ��� �� (�������)
  RBS,               PrevRBS:         Byte;         // ���������� ��� ��C (�������)
  EPT,               PrevEPT:         Byte;         // ���������� ��������� ��� (��� �������� ��-���)
  BV,                PrevBV:          Byte;         // ��, ��4(9)�, ��7 ����� ������� ������ �������� � ����������� �� ��7
  Voltage,           PrevVoltage:     Single;       // ���������� �� ����������� ��7
  CameraX,           PrevCameraX:     WORD;         // ���������� ��� ����������� ��������� ������ � ������
  KME_ED,            PrevKME_ED:      Integer;
  Zhaluzi,           PrevZhaluzi:     Byte;         // ��������� ������� [��7]
  Compressor,        Prev_Compressor: Single;       // ��������� ������������
  Stochist,          Prev_Stochist:   Single;       // ��������� ���������
  StochistDGR,       Prev_StchstDGR:  Double;       // ���� �������� ���������
  Vent,              Prev_Vent:       Integer;      // ��������� ������������ [1]
  Vent2,             Prev_Vent2:      Single;       // ��������� ������������ [2] (��80�, ��1�)
  Vent3,             Prev_Vent3:      Single;       // ��������� ������������ [3] (��80�, ��1�)
  Vent4,             Prev_Vent4:      Single;       // ��������� ������������ [4] (��80�)
  VCheck,            PrevVCheck:      Byte;         // ��������� �������� ������������, ��� ����� ������� �� ����-�
  SvetoforDist,    Prev_SvetoforDist: WORD;         // ���������� �� ���������
  FrontTP,           PrevFrontTP:     Integer;	    // ��������� ��������� ��
  BackTP,            PrevBackTP:      Integer;      // ��������� ������� ��
  LDOOR,             PrevLDOOR:       Byte;
  RDOOR,             PrevRDOOR:       Byte;
  diesel2,           PrevDiesel2:     Single;       // ��������� ������ ������ ������
  VstrTrack,         PrevVstrTrack:   WORD;         // ���������� �������� ��������
  Track_Vstrechi:                     Integer;      // ���� �� ������� ��������� ������� ������ ������� � ���������
  Acceleretion,      PrevAcceleretion:Double;       // ��������� �/(�^2)
  ReversorPos,       PrevReversorPos: Integer;      // ������� ��������� [255(-1); 0; 1]
  Speed,             PrevSpeed:       Integer;	    // ��������
  OgrSpeed,          PrevOgrSpeed:    WORD;         // ����������� ��������
  NextOgrSpeed,      PrevNextOgrSpeed:Byte;         // ��������� ����������� �������� (������ ����� �� ����-�)
  NextOgrPeekStatus:                  Byte;	    // ������ ��� ������� ��� �������� ����������� [0-��� �������� 1-� ��������]
  PrevPRS:                            Integer;
  BrakeCylinders,    PrevBrkCyl:      Single;       // �������� � ��������� ���������
  Svistok,           PrevSvistok:     Byte;         // ������ ��� ������ �������
  Tifon,             PrevTifon:       Byte;         // ������ ��� ������ ������
  KLUBOpen:                           Byte;	    // ����������-���� �������-�� � ���� ���������� ����
  TrackTail:                          Integer;      // ����� ����� ������ ������ ������
  VstrechStatusCounter:               Integer;
  isVstrechDrive:                     Boolean;
  Ordinata,          PrevOrdinata:    Double;
  OrdinataEstimate,PrevOrdinataEstimate: Double;
  OutsideLocoStatus:                  WORD;
  GR,                PrevGR:          Double;
  TC,                PrevTC:          Double;
  VR242,             PrevVR242:       Single;

  DebugFile: TextFile;

  // ------------------------------------------------------------------------------- //
  // ================ ����� - ���������� ��� �������� ���� � ������ ================ //
  // ------------------------------------------------------------------------------- //
  ChannelNum, Track, PrevTrack, ChannelNumTED:Integer;
  ChannelNumDiz:               Byte;    // ����� ������ ��� ������ ������
  Ini:                         TIniFile;// Ini ���� ��������
  LocoVolume, LocoVolume2:     Integer; // ��������� ������� ��������� ����������, ����� ������ ��� ��������
  LocoVolumePerestuk, LocoVolumePerestuk2: Integer;
  DizVolume, DizVolume2:       Single;  // ��������� ������� ������, ����� ��� ���������� ������ �� ������� � ����������
  PerehodDIZ:                  Boolean;
  DIZVlm:                      Single;
  PerehodDIZStep:              Single;
  EDTAmperage, PrevEDTAmperage:Single;
  VstrVolume:                  Integer;
  TEDAmperage, PrevTEDAmperage:Single;
  UltimateTEDAmperage:         Integer; // ���������� ��� �������� �� ���-�
  TrackVstrechi:	       Integer; // ����� ����� ��� ����������� ������ ������ �� ���������
  WagNum_Vstr:	       	       Byte;
  TEDVlm:                      Extended;// ��������� ���-��
  TEDVlmDest:                  Extended;
  TEDVolume, TEDVolume2:       Single;  // ��������� ������� ���-�� ����������, ����� ������ ��� ���������
  PerehodTEDStep:              Single;  // ��� ����������-���������� ��������� ������� ���-�� ��� �������� �������
  AB_ZB_1, AB_ZB_2:            Byte;
  PrevAB_ZB_1, PrevAB_ZB_2:    Byte;
  PrevBoks_Stat, Boks_Stat:    Byte;
  Brake_scrVolume:             Single;
  Brake_scrDestVolume:         Single;
  Brake_scrVolumeIncrementer:  Single = 0.035;
  // ------------------------------------------------------ //
  // ******* ����� ******* //
  SAVPENextMessage:            Boolean = False;
  HeadTrainEndOfTrain:         Boolean;
  isCameraInCabin:             Boolean; // ���� ��� ���������, � ������-�� ������?
  PrevisCameraInCabin:         Boolean;
  isRefreshLocalData:          Boolean; // ���� ��� ������������ � ������ ���� ������ ����������� ��� ������
  perestukPLAY:                Boolean; // ���� ��� �������������� ����� ��������� ������� ���������� � ��������� ���������� �������
  PrevPerestukStation:         Boolean; // ����� ��� ��������� ���������� �� �������
  isPlayWag:                   Boolean; // ���� ��� ��������� ����� ��������� �������
  SAUTOff:                     Boolean; // ���� ��� ��������������� ���������� ����� ���������� ����
  isConnectedMemory,PrevConMem:Boolean; // ���� ��� �����������: ������� �� ������������ � ������?
  isGameOnPause:               Boolean; // ���� ��� ��������� ����� ���� (������������)
  VstrZat:		       Boolean; // ���� ��� ��������� ��������� ����� ���������� ������
  isPlayRB:	               Boolean; // ���� ��� ��������������� ������� �� ������ �� � ���
  PlayRESFlag:                 Boolean;
  PereezdZatuh:                Boolean;
  isSpeedLimitRouteLoad:       Boolean;
  Brake:                       Boolean;
  StopVent:                    Boolean;
  StopVentTD:                  Boolean;
  RefreshSnd:                  Boolean;
  isNatureNowPlay:array[0..4]of Boolean;// ���� ��� ��������� ������-�� ������� ������� �������
  NatureOrd1: array [0..4] of  Integer; // �������� ������ ������� ������� �������
  NatureOrd2: array [0..4] of  Integer; // �������� ����� ������� ������� �������
  NatureKoefZatuh:array[0..4]of Integer;// ����� ���������
  Brake_Counter:               Integer;
  Prev_KME:                    Integer;
  PerestukBase: Array[0..100] of Integer;
  PerestukBaseNumElem:         Integer;
  TEDBase: Array[0..600] of    Integer;
  TEDBaseNumElem:              Integer;
  VIPBase: Array[0..600] of    Integer; // ������ � �������� ������� ��� ��� (��1� � 2��5�)
  VIPBaseNumElem:              Integer; // ���������� ������� ��� (��1� � 2��5�)
  TedFound:                    Boolean;
  isPlayTrog:                  Boolean; // ���� ������ �� ����
  TedNow:		       Integer;
  PerehodTED:                  Boolean; // ���� ��� ��������� �������� ������� ���-��
  PerehodLoco:                 Boolean; // ���� ��� ��������� �������� ������� �������
  StartVentVU:                 Boolean;
  DizNow:                      Byte;
  // ****************************************** //
  GameScreen:                  HWND;    // ���������� ���� ����
  GameWindowName:              String;
  wHandle:                     Integer;
  tHandle, ProcessID, pHandle: Cardinal;
  temp:                        Cardinal;
  KM_Pos_1, Prev_KM:           Integer;
  KM_Pos_2, Prev_KM_2:         Byte;
  Prev_Diz:                    Integer;
  Vstr_Speed:                  Integer;
  Prev_KM_OP, KM_OP:           Single;  // ����������� ������� �� � ���������� ������� ��

  LocoWithDNoisePitch:         Boolean;
  DNoisePitch:                 Single = -20;
  DNoisePitchDest:             Single = -20;
  DNoisePitchIncrementer:      Single = 0.025;
  VentTDPitch:                 Single = -20;  // ����������� �� (���) �����������
  VentTDPitchDest:             Single = -20;  // �������� ����������� ������ �� (���) ��� �������� ����������/����������
  VentTDPitchIncrementer:      Single;  // ����������� ����������� ��� �� ��
  VentTDPitchDecrementer:      Single; 
  VentTDVol:                   Single = 0;  // ����������� �� (���) ���������
  VentTDVolDest:               Single = 0;
  VentPitch:                   Single = 0;
  VentPitchDest:               Single;
  VentPitchIncrementer:        Single;  // ����������� ����������� ��� ��
  ZvonokVolume:                Single;  // ��������� ������ �� ��������
  ZvonokVolumeDest:            Single;
  ZvonokFreq:                  Integer; // ������� ������������� ����� ������ �� ��������
  PereezdZone:                 Boolean; // ���� - ����� � ���� (30�) ��������

  // SETTINGS_TWS.INI VARS
  SimpleHorn:                  Boolean = False;
  SlowComputer:                Boolean;
  TEDNewSystem:                Boolean = True;
  CHS4tVentNewSystemOnAllLocos:Boolean = False;
  MVPS5secZvonok:              Boolean;
  VR242Allow:                  Boolean;
  MVPSTedInCabin:              Boolean;
  VentSingleVolume: Single;
  VentSingleVolumeIncrementer: Extended;
  TEDPitch, TEDPitchDest:      Single;
  ReduktorPitch:               Single;
  ReduktorVolume:              Single;
  ReduktorVolumeDest:          Single;

implementation

uses StrUtils, Variants, UnitSettings;

{$R *.dfm}

//------------------------------------------------------------------------------//
//                   ������� �� ������� ��������� ����������                    //
//------------------------------------------------------------------------------//
procedure TFormMain.cbLocPerestukClick(Sender: TObject);      // ������� �� "�������� ����������"
begin
  if cbLocPerestuk.Checked=True then begin
    PrevSpeed  := 0;
    ChannelNum := 0;
  end else begin
    BASS_ChannelStop(LocoChannel[0]); BASS_ChannelStop(LocoChannel[1]);
    BASS_ChannelStop(LocoChannelPerestuk[0]); BASS_ChannelStop(LocoChannelPerestuk[1]);
    BASS_StreamFree(LocoChannel[0]); BASS_StreamFree(LocoChannel[1]);
    BASS_StreamFree(LocoChannelPerestuk[0]); BASS_StreamFree(LocoChannelPerestuk[1]);
  end;
end;

//------------------------------------------------------------------------------//
//                     ������� �� ������� ��������� �������                     //
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
//                  ������� �� ������� "����� ���-�� � ������"                  //
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
//             ������������ ��� ���������� ����� ������������ ����              //
//------------------------------------------------------------------------------//
procedure TFormMain.UpdateInfoName();
begin
    if (cbSAUTSounds.Checked=False) and (cbSAVPESounds.Checked=False) and
       (cbUSAVPSounds.Checked=False)and (cbGSAUTSounds.Checked=False) then
          SAVPName := '';
end;

//------------------------------------------------------------------------------//
//             ������������ ��� ��������� ������� �� ������� "����"             //
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
     SAUTOFFF:='TWS/SAVP/SAUT/Off.mp3'; SAUTOff:=True; // ��������� ���� ���������� ����
     UpdateInfoName;
  end;
end;

//------------------------------------------------------------------------------//
//           ������������ ��� ��������� ������� �� ������� "��� ���"            //
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
//            ������������ ��� ��������� ������� �� ������� "������"            //
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
//         ������������ ��� ��������� ������� �� ������� "�������� ����"        //
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
    SAUTOff:=True;      // ��������� ���� ���������� ����
    UpdateInfoName;
  end;
end;

//------------------------------------------------------------------------------//
//                       ������������ �������� ���������                        //
//------------------------------------------------------------------------------//
procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log_.DebugFreeLog();
  try SaveTWSParams('TWS\settings_TWS.ini');  except end;   // �������������� ���� ����������
  try Bass_Stop();               // ������������� ������������
     Bass_Free;                  // ����������� ������� ������������ Bass
  except end;
end;

//------------------------------------------------------------------------------//
//                       ������������ �������� ���������                        //
//------------------------------------------------------------------------------//
procedure TFormMain.FormCreate(Sender: TObject);
begin
  //if CheckInstallation=False then Application.Terminate; // �������� ���������-�� ����������� ���������

  if not OneInstance then begin
      Application.Terminate;
  end;

  BASS_Init(-1, 44100, 0, application.Handle, nil);      // ������������� BASS
  
  LoadTWSParams('TWS\settings_TWS.ini');   		 // ������ �������� ���������� TWS

  CHS7__ := chs7_.Create;
  CHS8__ := chs8_.Create;
  CHS4T__ := chs4t_.Create;
  CHS2K__ := chs2k_.Create;
  CHS4KVR__ := chs4kvr_.Create;
  CHS4__ := chs4_.Create;
  VL80T__ := vl80t_.Create;
  EP1M__ := ep1m_.Create;
  ES5K__ := es5k_.Create;
  ED4M__ := ed4m_.Create;
  ED9M__ := ed9m_.Create;
  VL82M__ := vl82m_.Create;
  TE10U__ := te10u_.Create;
  M62__ := m62_.Create;

  isGameOnPause := True;

  MainCycleFreq := ClockMain.Interval;

  SAVP.InitializeSAVP;

  SAUTOff           :=  False;    // ��������� ������������ ����� ���������� ����
  isPlayPRS         :=  True;     // ��������� ����������� �������� ������������
  isPlayRain        :=  True;
  isPlayClock       :=  True;     // ��������� ������ ������� ����� ��� ������� �������
  isPlayCabinClicks :=  True;
  isSpeedLimitRouteLoad:=False;
  isPlayCompressorCycle:=True;
  isRefreshLocalData:=  True;	  // ��� ������� ��������� ��� ������ ������ ��� ���������������� ���������
  isPlaySAVPEZvonok :=  True;
  isPlayStochist    :=  True;
  isPlayBeltPool    :=  True;

  Log_.DebugLogStart(Self);
  Log_.DebugWriteErrorToErrorList('TWS started');

  PerehodDIZStep:=0.01;
end;

//------------------------------------------------------------------------------//
//      ������������ ��� ��������� ������� �� ������� "������ �����" �����      //
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

function TFormMain.CheckInstallation(): Boolean;
begin
    if FileExists('Launcher.exe') = False then begin
        if FileExists('ZLauncher.exe') = False then begin
           MessageDLG('������ ��������� ����������� �� ���������! ���������� �������� � ������ ZDSimulator!', mterror, mbOKCancel, 0);
           Result:=False;
        end else Result:=True;
    end else Result:=True;
end;

function CameraInCabinCheck(CameraX: Integer; Camera: Byte) : Boolean;
begin
    Result := False;
    if Camera = 0 then
       if ((CameraX<=49130) and (CameraX>=32000)) or (CameraX<16384) or (CameraX=0) then Result:=True;
end;

// === ��������� ��� ��������� ������ ������� �� ����� start_kilometers === //
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
      Log_.DebugWriteErrorToErrorList(FileLinesList[I]);
      StationsList := ExtractWord(FileLinesList[I], ' ');
      if StationsList.Count >= 3 then begin
         try
            StationTrack1[I] := StrToInt(StationsList[1]);
            StationTrack2[I] := StrToInt(StationsList[2]);
         except end;
      end;
   end;
   Log_.DebugWriteErrorToErrorList('Route stations borders loaded successfully');
   StationsList.Free();
   FileLinesList.Free();
end;

//------------------------------------------------------------------------------//
//                                �������� ����                                 //
//------------------------------------------------------------------------------//
procedure TFormMain.ClockMainTimer(Sender: TObject);
var
  St: String;
  sl: TStringList;
  I, J: Integer;
  Station1, Station2: String;
  SR: TSearchRec;
  CompTimeLeft: Single;
  XCompTimeLeft: Single;
  temp_single: Single;
label
  Next1;
begin
try
   // �������� ���������� ������� ��������� ����������
   try
      if (isConnectedMemory <> PrevConMem) Or (LocoGlobal = '') then begin
         isRefreshLocalData := True;
         LocoGlobal := '';
         if isConnectedMemory = True then begin
            if BASS_IsStarted = False then begin
               BASS_Start;
               Log_.DebugWriteErrorToErrorList('BASS.DLL was started');
            end;
         end else begin
            if BASS_IsStarted = True then begin
               BASS_Stop;
               Log_.DebugWriteErrorToErrorList('BASS.DLL stopped');
            end;
         end;
      end;
   except Log_.DebugWriteErrorToErrorList('Fatal error 0x00 (error Checking the status of the current simulator in mainTimer)'); end;

   if isGameOnPause = False then begin
      if isConnectedMemory = True then begin
         // ������ ������ ���������� �� ��� (�������� � �������� mainTimer-�)
         try
            ReadVarsFromRAM();
         except
            Log_.DebugWriteErrorToErrorList('Fatal error 0x01 (error reading simulator data from ram in mainTimer)');
         end;
      end;

      // ���� ���������� ��������� ������ (���� ���, ��� ��� ����� ��������/����������) //
      if isRefreshLocalData = True then begin
         isSpeedLimitRouteLoad := False;

         // ������ ������ ����� settings.ini �� ��� ����������
         try
            Log_.DebugWriteErrorToErrorList('Loading data from settings.ini from RAM');
            GetStartSettingParamsFromRAM();
         except
            Log_.DebugWriteErrorToErrorList('Fatal error 0x02 (error reading start data (settings.ini) from RAM in mainTimer)');
         end;

         // �������� ��������� �� TWS �� ���� �������� (���� ��� ����)
         try
            if SceneryName <> '' then begin
               Log_.DebugWriteErrorToErrorList('Loading local TWS EK from scenery: ' + SceneryName);
               GetLocalEKFromScenery('routes/' + Route + '/scenaries/' + SceneryName);
            end;
         except
            Log_.DebugWriteErrorToErrorList('Fatal error 0x03 (error loading local scenery EK in mainTimer)');
         end;

         // �������� ������ ������� �� ��������
         try
            if Route <> '' then begin
               Log_.DebugWriteErrorToErrorList('Loading route ' + Route + ' stations borders');
               GetStationsBordersFromFile('routes/' + Route + '/start_kilometers.dat');
            end;
         except
            Log_.DebugWriteErrorToErrorList('Fatal error 0x04 (error loading route stations borders in mainTimer)');
         end;

         // ���������� ������ ������� ������
         try
            Log_.DebugWriteErrorToErrorList('Started calculating player train length');
            ConsistLength := 0;
            if Pos('.con', ConName)>0 then begin
               Log_.DebugWriteErrorToErrorList('Loading consist data');
               Log_.DebugWriteErrorToErrorList(ConName + ' data:');
               Memo1.Lines.LoadFromFile('data\consists\'+ConName);
               sl := TStringList.Create;
               for I:=0 to Memo1.Lines.Count-1 do begin
                  log_.DebugWriteErrorToErrorList(Memo1.Lines[I]);
                  try
                     St := Memo1.Lines[I];
                     if St[1]<>';' then begin
                        ExtractStrings([#9], [' '], PChar(St), sl);
                        ConsistLength := ConsistLength + StrToFloat(sl[2]);
                     end;
                  except
                     Log_.DebugWriteErrorToErrorList('Fatal error 0x05 (extract data error I=)' + IntToStr(I) + 'string: (' + Memo1.Lines[I] + ')');
                  end;
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
            Log_.DebugWriteErrorToErrorList('Consist length: ' + FloatToStr(ConsistLength) + 'm.');
         except
            Log_.DebugWriteErrorToErrorList('Fatal error 0x06 (error in calculating player train length in mainTimer)');
         end;

         // ��������� ���� ������� ��� �� ���������
         if Freight=1 then RadioButton2.Checked:=True else RadioButton1.Checked:=True;

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

         InitializeStartParams(VersionID);		// ��������� ������ � ������ �� �����������

         // ������� ���������� � ������������ �� �����
       	 if Loco='ED9M' then Loco:='ED4M';
       	 if Loco='M62' then Loco:='2TE10U';
  	     if Loco='CHS4' then Loco:='CHS4KVR';
  	     if Loco='CHS4 KVR' then Loco:='CHS4KVR';
         if Loco='TEP70bs' then Loco:='TEP70';


         if (scSAVPOverrideRouteEK = False) and (Route <> '') then begin
            Log_.DebugWriteErrorToErrorList('Loading TWS SAVP EK');
            Load_TWS_SAVP_EK();
         end;
      end;

      isCameraInCabin := CameraInCabinCheck(CameraX, Camera);

      if NapravOrdinata = 'Tuda' then
         OrdinataEstimate := OrdinataEstimate + (Speed / 3600 * MainCycleFreq)
      else
         OrdinataEstimate := OrdinataEstimate - (Speed / 3600 * MainCycleFreq);

      // ************************************************ //
      // ********* ���� ��������� ������ ���-�� ********* //
      if cbTEDs.Checked=True then begin
         if LocoWithTED=True then begin
            // ------/------ �� � �� ���-� ------/------ //
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
               if TEDFound=False then begin TEDF:=PChar('');BASS_ChannelStop(TEDChannel);BASS_ChannelStop(TEDChannel2);end;	// ���� ������ �� ����� - �� �������� ��������������� ������� ���
               if PerehodTED = False then begin
                  try
                     if TEDAmperage<>0 then TEDvlm := TEDAmperage / (UltimateTEDAmperage/140) else
                     if EDTAmperage<>0 then TEDvlm := EDTAmperage / (UltimateTEDAmperage/140) else
                     TEDVlm := 0.0;

                     // ������ ��������� ���-�� � ����������� �� ���� ����� ������� ������
                     if isCameraInCabin=True then TEDVlm:=TEDVlm/130 else TEDVlm:=TEDVlm/100;
                     PerehodTEDStep := 0.01;
                  except end;
               end;
               // ������ ���������
               if TEDAmperage+EDTAmperage=0 then begin
                  TEDF := PChar(' ');
                  BASS_ChannelSetAttribute(TEDChannel, BASS_ATTRIB_VOL, 0);
                  BASS_ChannelSetAttribute(TEDChannel2, BASS_ATTRIB_VOL, 0);
               end;
            end else begin
               // ����� ������� ����������� ������ ���-��
               TEDF := PChar('TWS/'+LocoTEDNamePrefiks+'/ted.wav');
               if BASS_ChannelIsActive(TEDChannel_FX)=0 then begin ChannelNumTED:=0; isPlayTED:=False; end;
               // ����� ��������� ������ ���
               if (Speed > 7) And (LocoTEDNamePrefiks <> 'ED4m') then begin
                  if TEDAmperage<>0 then TEDvlm := (TEDAmperage / (UltimateTEDAmperage*0.75)) * (trcBarTedsVol.Position/100) else
                  if EDTAmperage<>0 then TEDvlm := (EDTAmperage / (UltimateTEDAmperage*0.75)) * (trcBarTedsVol.Position/100) else
                  TEDVlm := 0.0;
               end;
               if (Speed <= 7) And (LocoTEDNamePrefiks <> 'ED4m') then TEDVlm := 0.0;

               if LocoTEDNamePrefiks = 'CHS_TED' then TEDPitchDest := power(Speed * 2350, 0.3) - 35;
               if LocoTEDNamePrefiks = 'EP_TED' then begin
                  TEDPitchDest := power(Speed * 2350, 0.3) - 35;
                  ReduktorPitch := (power(Speed*100, 0.3) - 30) * 2 + 30;
                  //ReduktorVolume := (3-(Speed/50))*power((TEDAmperage / (UltimateTEDAmperage * 0.8)),2);
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

              if TEDPitch > TEDPitchDest then TEDPitch := TEDPitch - ((TEDPitch-TEDPitchDest)/100);
              if TEDPitch < TEDPitchDest then TEDPitch := TEDPitch + ((TEDPitchDest-TEDPitch)/100);

              BASS_ChannelSetAttribute(TEDChannel_FX, BASS_ATTRIB_TEMPO_PITCH, TEDPitch);
            end;
         end;
         // ------/------ �� � �� ���-� [����� �����] ------/------ //

         // -----/----- ����� ������� -----/----- //
         if LocoWithDIZ=True then begin
            // ������� �������� ������� ������
            if (BV<>0) or ((diesel2<>0) and (LocoSectionsNum=2)) then begin
               if PerehodDIZ = False then begin
                  if ((BV<>0) and (PrevBV=0)) or ((diesel2<>0) and (PrevDiesel2=0)) then Prev_Diz:=-1;	// ������ ������
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
                  // ������� ������� ������/������� ����� ������
                  if (DizNow<>Prev_Diz) or
                     ((BV+diesel2<>0) and (BASS_ChannelIsActive(DizChannel)+BASS_ChannelIsActive(DizChannel2) = 0))
                  then begin
                     isPlayDiz:=False; Prev_Diz:=DizNow; TimerPerehodDizSwitch.Enabled:=True;
                  end;
               end;
            end;

            // ��������� ������ ������, ���� �� �������� � ����������
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
         // -----/----- ����� ����� ������ ������� -----/----- //

         if TEDvlm > trcBarTedsVol.Position/100 then TEDvlm := trcBarTedsVol.Position/100;

         if LocoWithReductor = True then begin
            BASS_ChannelSetAttribute(ReduktorChannel_FX, BASS_ATTRIB_VOL, ReduktorVolume * trcBarTedsVol.Position/100);
            BASS_ChannelSetAttribute(ReduktorChannel_FX, BASS_ATTRIB_TEMPO_PITCH, ReduktorPitch);
         end;

         // ���� ������ ��������� ���-�� � �������
         if (PerehodTED=False) and (Camera<>2) then begin
            if ChannelNumTED=1 then BASS_ChannelSetAttribute(TEDChannel_FX , BASS_ATTRIB_VOL, TEDvlm)
            else BASS_ChannelSetAttribute(TEDChannel2, BASS_ATTRIB_VOL, TEDvlm);
         end else begin
            if Camera=2 then begin
               if (Loco <> 'ED4M') and (Loco <> 'ED9M') then begin
                  BASS_ChannelSetAttribute(TEDChannel_FX, BASS_ATTRIB_VOL, 0);
                  BASS_ChannelSetAttribute(TEDChannel2, BASS_ATTRIB_VOL, 0);
               end else begin
                  if ChannelNumTED=1 then BASS_ChannelSetAttribute(TEDChannel_FX , BASS_ATTRIB_VOL, TEDvlm)
                  else BASS_ChannelSetAttribute(TEDChannel2, BASS_ATTRIB_VOL, TEDvlm);
               end;
            end;

         if TedNow<>Prev_KM then begin
            isPlayTED:=False; Prev_KM := TedNow;
         end;
         end;
         end;
  // ********************************************** //
  // ���� ������ ��������� //
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

     // ����������������, �����
     if Stochist<>Prev_Stochist then begin
            if Stochist=4 then begin StochistF:=PChar('TWS/stochist.wav'); isPlayStochist:=False end else begin
            if Stochist=8 then begin StochistF:=PChar('TWS/stochist2.wav'); isPlayStochist:=False end
            else begin BASS_ChannelStop(Stochist_Channel); BASS_StreamFree(Stochist_Channel) end;
         end;
     end;
     // ���� �������� ����������������� 2-��, �� ������ ���� ����� �� ���� ������
     if Stochist=8 then begin
         if ((StochistDGR>120) and (Prev_StchstDGR<=120)) or
            ((StochistDGR<55) and (Prev_StchstDGR>=55)) then isPlayStochistUdar:=False;
     end;
  end;
  // ***************** //
  // ���� ������ ������� �� ����������� //
  if cbCabinClicks.Checked=True then begin
     // ������ ������ ��������� //
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

     // ������ ����� ��� //
     if (GetAsyncKeyState(78)<>0) and (PrevKeyEPK=0) then
        if (GetAsyncKeyState(16)<>0) or (GetAsyncKeyState(16)=0) then begin
              IMRZashelka:=PChar('TWS/epk.wav'); isPlayIMRZachelka:=False; PrevKeyEPK:=1;
        end;
     if GetAsyncKeyState(16)+GetAsyncKeyState(78)=0 then PrevKeyEPK:=0;
     // ���� ������ ����������� //
     if LocoWithSndKM = True then begin
        if ReversorPos<>0 then begin
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
        end;

        if getasynckeystate(65)=0 then PrevKeyA:=0; if getasynckeystate(68)=0 then PrevKeyD:=0;
        if getasynckeystate(69)=0 then PrevKeyE:=0; if getasynckeystate(81)=0 then PrevKeyQ:=0;
     end;
  end;
  // ***************** //
  // ���� ������ �������� ��������� �� //
  if cbTPSounds.Checked=True then begin
     if LocoWithSndTP = True then begin
        if Loco<>'ED4M' then begin
           if LocoGlobal = 'CHS7' then begin
              if (FrontTP=63) and (FrontTP<>PrevFrontTP) then begin isPlayFTP:=False; FTPF:=PChar('TWS/CHS7/TPUp.wav'); end;
              if (FrontTP<>63) and (PrevFrontTP=63) and (PrevFrontTP<>188) then begin isPlayFTP:=False; FTPF:=PChar('TWS/CHS7/TPDown.wav'); end;
              if (BackTP=63) and (BackTP<>PrevBackTP) then begin isPlayBTP:=False; BTPF:=PChar('TWS/CHS7/TPUp.wav'); end;
              if (BackTP<>63) and (PrevBackTP=63) and (PrevBackTP<>188) then begin isPlayBTP:=False; BTPF:=PChar('TWS/CHS7/TPDown.wav'); end;
           end else begin
              if (FrontTP=63) and (FrontTP<>PrevFrontTP) then begin isPlayFTP:=False; FTPF:=PChar('TWS/TPUp.wav'); end;
              if (FrontTP<>63) and (PrevFrontTP=63) and (PrevFrontTP<>188) then begin isPlayFTP:=False; FTPF:=PChar('TWS/TPDown.wav'); end;
              if (BackTP=63) and (BackTP<>PrevBackTP) then begin isPlayBTP:=False; BTPF:=PChar('TWS/TPUp.wav'); end;
              if (BackTP<>63) and (PrevBackTP=63) and (PrevBackTP<>188) then begin isPlayBTP:=False; BTPF:=PChar('TWS/TPDown.wav'); end;
           end;
        end;
     end;
  end;
  // ********************************* //
  // ������ �������� ���� �� �� ������� //
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
  // ���� ������ ���� � 3��2� //
  if (isConnectedMemory=True) then begin
     if cbKLUBSounds.Checked=True then begin	// ����
        // ������� �� � ���
        if RB<>PrevRB then begin
           if RB=1 then begin RBF:=PChar('TWS/KLUB_pick.wav'); isPlayRB:=False; end;
           if RB=0 then begin RBF:=PChar('TWS/KLUB_pick.wav'); isPlayRB:=False; end;
        end;

        if RBS<>PrevRBS then begin
           if RBS=1 then begin RBF:=PChar('TWS/KLUB_pick.wav'); isPlayRB:=False; end;
           if RBS=0 then begin RBF:=PChar('TWS/KLUB_pick.wav'); isPlayRB:=False; end;
        end;
        // ������� ��� �����������
        if(OgrSpeed-Speed<=3) and (isPlayOgrSpKlub=0) and (OgrSpeed<>0) and (Svetofor<>0) then isPlayOgrSpKlub:=1;
        if((OgrSpeed-Speed>3) and (isPlayOgrSpKlub=-1)) or ((OgrSpeed=0) and (isPlayOgrSpKlub=-1)) then begin
           BASS_ChannelStop(Ogr_Speed_KLUB); BASS_StreamFree(Ogr_Speed_KLUB); isPlayOgrSpKlub:=0; end;
        //if ((getasynckeystate(9)<>0) and (PrevKeyTAB=0)) then begin isPlayBeltPool:=False; PrevKeyTAB := 1; end;
        //if getasynckeystate(9)=0 then begin
        //   PrevKeyTAB:=0;
        //   BASS_SampleStop(BeltPool_Channel); BASS_StreamFree(BeltPool_Channel);
        //end;
        // �������� ������������
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
     if cb3SL2mSounds.Checked=True then begin	// 3��2�
        // ������� �� � ���
        if RB<>PrevRB then begin
           if RB=1 then begin RBF:=PChar('TWS/RB_MexDown.wav'); isPlayRB:=False; end;
           if RB=0 then begin RBF:=PChar('TWS/RB_MexUp.wav'); isPlayRB:=False; end;
        end;

        if RBS<>PrevRBS then begin
           if RBS=1 then begin RBF:=PChar('TWS/RB_MexDown.wav'); isPlayRB:=False; end;
           if RBS=0 then begin RBF:=PChar('TWS/RB_MexUp.wav'); isPlayRB:=False; end;
        end;

        SL2M__.step();
     end;
  end;
  // ********************** //
  // ���� ����������������� ���������� ������ //
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
  // **** ����� ����� ���������� ������ **** //
  // ���� ��������-������� //
  if (cbSignalsSounds.Checked = True) and (Track <> 0) then begin
     // �������
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
     // ������
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
  // ���� �����-����� //
  if cbVspomMash.Checked=True then begin
      // ������� ������� ��� ������� ������������ ��
      (*if StopVent = False then begin
         if BASS_ChannelIsActive(Vent_Channel_FX) <> 0 then begin
            VentTimeLeft := BASS_ChannelBytes2Seconds(Vent_Channel_FX, BASS_ChannelGetLength(Vent_Channel_FX, BASS_POS_BYTE) - BASS_ChannelGetPosition(Vent_Channel_FX, BASS_POS_BYTE));
            if (VentTimeLeft <= 0.2) and (BASS_ChannelIsActive(VentCycle_Channel_FX)=0) then isPlayCycleVent:=False;
         end;
         if BASS_ChannelIsActive(XVent_Channel_FX) <> 0 then begin
            XVentTimeLeft := BASS_ChannelBytes2Seconds(XVent_Channel_FX, BASS_ChannelGetLength(XVent_Channel_FX, BASS_POS_BYTE) - BASS_ChannelGetPosition(XVent_Channel_FX, BASS_POS_BYTE));
            if (XVentTimeLeft <= 0.2) and (BASS_ChannelIsActive(XVentCycle_Channel_FX)=0) then isPlayCycleVentX:=False;
         end;
      end;*)

      // -=- ��������� ����� ������ ������������ ��� ������ ��������� ������ ������������ -=- //
      (*if (StopVent=True)AND(LocoGlobal<>'VL80t')AND(LocoGlobal<>'EP1m')AND(LocoGlobal<>'2ES5K') then begin
         if BASS_ChannelIsActive(VentCycle_Channel_FX)<>0 then begin
            VentTimeLeft := BASS_ChannelBytes2Seconds(Vent_Channel_FX, BASS_ChannelGetPosition(Vent_Channel_FX, BASS_POS_BYTE));
            if (VentTimeLeft >= 0.3) and (BASS_ChannelIsActive(VentCycle_Channel_FX)<>0) then begin BASS_ChannelStop(VentCycle_Channel_FX); BASS_StreamFree(VentCycle_Channel_FX); end;
         end;
         if BASS_ChannelIsActive(XVentCycle_Channel_FX)<>0 then begin
            XVentTimeLeft := BASS_ChannelBytes2Seconds(XVent_Channel_FX, BASS_ChannelGetPosition(XVent_Channel_FX, BASS_POS_BYTE));
            if (XVentTimeLeft >= 0.3) and (BASS_ChannelIsActive(XVentCycle_Channel_FX)<>0) then begin BASS_ChannelStop(XVentCycle_Channel_FX); BASS_StreamFree(XVentCycle_Channel_FX); end;
         end;
      end;*)
      // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= //

      // ������� ������� ��� ������� ������������ ��
      (*if AnsiCompareText(VentCycleTDF, '')<>0 then begin
          try VentTDTimeLeft := BASS_ChannelBytes2Seconds(VentTD_Channel_FX, BASS_ChannelGetLength(VentTD_Channel_FX, BASS_POS_BYTE) - BASS_ChannelGetPosition(VentTD_Channel_FX, BASS_POS_BYTE)); except end;
          if (VentTDTimeLeft <= 0.8) and (BASS_ChannelIsActive(VentCycleTD_Channel_FX)=0) then isPlayCycleVentTD:=False;
      end;
      if AnsiCompareText(XVentCycleTDF, '')<>0 then begin
          try XVentTDTimeLeft := BASS_ChannelBytes2Seconds(XVentTD_Channel_FX, BASS_ChannelGetLength(XVentTD_Channel_FX, BASS_POS_BYTE) - BASS_ChannelGetPosition(XVentTD_Channel_FX, BASS_POS_BYTE)); except end;
          if (XVentTDTimeLeft <= 0.8) and (BASS_ChannelIsActive(XVentCycleTD_Channel_FX)=0) then isPlayCycleVentTDX:=False;
      end;

      // -=- ��������� ����� ������ ������������ ��� ������ ��������� ������ ������������ -=- //
      if (AnsiCompareText(VentCycleTDF, '')=0) and (LocoGlobal<>'VL80t') then begin
          try VentTDTimeLeft := BASS_ChannelBytes2Seconds(VentTD_Channel_FX, BASS_ChannelGetPosition(VentTD_Channel_FX, BASS_POS_BYTE)); except end;
          if (VentTDTimeLeft >= 0.3) and (BASS_ChannelIsActive(VentCycleTD_Channel_FX)<>0) then begin BASS_ChannelStop(VentCycleTD_Channel_FX); BASS_StreamFree(VentCycleTD_Channel_FX); end;
      end;
      if (AnsiCompareText(XVentCycleTDF, '')=0) and (LocoGlobal<>'VL80t') then begin
          try XVentTDTimeLeft := BASS_ChannelBytes2Seconds(XVentTD_Channel_FX, BASS_ChannelGetPosition(XVentTD_Channel_FX, BASS_POS_BYTE)); except end;
          if (XVentTDTimeLeft >= 0.3) and (BASS_ChannelIsActive(XVentCycleTD_Channel_FX)<>0) then begin BASS_ChannelStop(XVentCycleTD_Channel_FX); BASS_StreamFree(XVentCycleTD_Channel_FX); end;
      end;*)
      // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= //

      if (LocoGlobal='CHS7') Or (LocoGlobal='CHS8') Or (LocoGlobal='CHS4t') then begin
         // ����������� ��� �� ��7
         if VentTDVol > trcBarVspomMahVol.Position / 100 then VentTDVol := trcBarVspomMahVol.Position / 100;
         if VentTDVol < 0 then VentTDVol := 0;
         // ����� ��������� ������ ������ ������������ (���) //
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
      //if AnsiCompareStr(CompressorCycleF, '') <> 0 then begin
      //    try CompTimeLeft := BASS_ChannelBytes2Seconds(Compressor_Channel, BASS_ChannelGetLength(Compressor_Channel, BASS_POS_BYTE) - BASS_ChannelGetPosition(Compressor_Channel, BASS_POS_BYTE)); except end;
      //    if (CompTimeLeft<=0.8) and (BASS_ChannelIsActive(CompressorCycleChannel)=0) then isPlayCompressorCycle:=False;
      //end;
      //if AnsiCompareStr(XCompressorCycleF, '')<> 0 then begin
      //    try XCompTimeLeft := BASS_ChannelBytes2Seconds(XCompressor_Channel, BASS_ChannelGetLength(XCompressor_Channel, BASS_POS_BYTE) - BASS_ChannelGetPosition(XCompressor_Channel, BASS_POS_BYTE)); except end;
       //   if (XCompTimeLeft<=0.8) and (BASS_ChannelIsActive(XCompressorCycleChannel)=0) then isPlayXCompressorCycle:=False;
      //end;
      // ����� ������� �����������
      (*if Compressor<>Prev_Compressor then begin
         if Compressor<>0 then begin
            if LocoGlobal='VL11m' then begin
               CompressorF:=PChar('TWS/VL11m/MK-start.wav'); CompressorCycleF:=PChar('TWS/VL11m/MK-loop.wav');
               XCompressorF:=PChar('TWS/VL11m/x_MK-start.wav'); XCompressorCycleF:=PChar('TWS/VL11m/x_MK-loop.wav');
            end;
            isPlayCompressor:=False; isPlayXCompressor:=False;
         end;
         // ����� ��������� �����������
         if Compressor=0 then begin
            if LocoGlobal='VL11m' then begin
               CompressorF:=PChar('TWS/VL11m/MK-stop.wav');
               XCompressorF:=PChar('TWS/VL11m/x_MK-stop.wav');
            end;
            CompressorCycleF:=PChar(''); XCompressorCycleF:=PChar('');
            isPlayCompressor:=False; isPlayXCompressor:=False;
         end;
      end;*)
      // **************** //
      // ���� ������������ //
      // ����������� ��� ���� ��-�����, ����� ��4, ��80�, ��1� � 2��5�
      (*if (LocoGlobal<>'CHS4 KVR') and (LocoGlobal<>'VL80t') and (LocoGlobal<>'EP1m') and (LocoGlobal<>'2ES5K') then begin
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
      if (LocoGlobal <> 'EP1m') and (LocoGlobal <> 'VL80t') then begin
         VentVolume:=100;
         CycleVentVolume:=100;
      end;*)
      // ����������������� ����������� ������������
      TWS_MVPitchRegulation();
      // ********************* //
  end;
  // **************** //

  // ���� ����� ������ ������� ��� ��������� //
  if cbLocPerestuk.Checked = True then begin
     if (Speed <= 5) and (BrakeCylinders > 0.0) then begin
        if BASS_ChannelIsActive(BrakeScr_Channel) = 0 then begin
           BrakeScrF  := PChar('TWS/' + Loco + '/brake_scr.wav');
           isPlayBrakeScr := False;
        end;

        Brake_scrDestVolume := (Abs(Acceleretion)/0.25)*(trcBarLocoPerestukVol.Position/100);

        if Speed <> 0 then BASS_ChannelSetAttribute(BrakeScr_Channel, BASS_ATTRIB_VOL, Brake_scrVolume)
                      else begin
           //BASS_ChannelSetAttribute(BrakeScr_Channel, BASS_ATTRIB_VOL, 0.0);
        end;
     end;

     if Brake_scrVolume < Brake_scrDestVolume then Brake_scrVolume := Brake_scrVolume + Brake_scrVolumeIncrementer;
     if Brake_scrVolume > Brake_scrDestVolume then Brake_scrVolume := Brake_scrVolume - Brake_scrVolumeIncrementer;

     if (Speed > 5) or (BrakeCylinders = 0) Or (Speed = 0) then begin
        if (Brake_scrVolume < 0.01) then begin
           BASS_ChannelStop(BrakeScr_Channel); BASS_StreamFree(BrakeScr_Channel);
        end;
        //Brake_scrVolume := 0.0;
        Brake_scrDestVolume := 0.0;
     end;
  end;

  // ���� ����� ������ ������� ��� ���������� //
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

  // ��������� ��������-�� ��������� ������?
  if (Camera<>PrevCamera) or (CameraX<>PrevCameraX) then
     VolumeMaster_RefreshVolume();

  // -/- ���� �������� �������, ���������� � ����� ������� -/- //
  if isRefreshLocalData = True then begin
     // (1) ��������� ������ �� ������� ��������� (1) //
     I:=0; PerestukBaseNumElem:=0;
     //if LocoWithDNoisePitch = False then begin
       //Memo3.Lines.Clear;
     if FindFirst('TWS/'+Loco+'/*.wav',faAnyFile,SR) = 0 then
        repeat
           try
              St:=Copy(SR.Name,1,Pos('-', SR.Name)-1);
              Station1:=Copy(SR.Name, Length(St)+2, Length(SR.Name));
              Station1:=StringReplace(Station1,'.wav', '', [rfReplaceAll]);
              if Station1='~' then Station1:='10000';
              PerestukBase[I]:=StrToInt(St);
              PerestukBase[I+1]:=StrToInt(Station1);
              //Memo3.Lines.Add(IntToStr(PerestukBase[I]));
              Inc(I,2); Inc(PerestukBaseNumElem);
           except end;
     until FindNext(SR) <> 0;
     FindClose(SR);
     //end;

     // (2) ��������� ������ �� ������� ���-�� (2) //
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
  if (cbLocPerestuk.Checked=True) then begin
     // ���� ���� ���� (� ������ ������� ���������)
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
     if Speed = 0 then begin
         BASS_ChannelStop(LocoChannel[0]); BASS_StreamFree(LocoChannel[0]);
         BASS_ChannelStop(LocoChannel_FX[0]); BASS_StreamFree(LocoChannel_FX[0]);
         BASS_ChannelStop(LocoChannel[1]); BASS_StreamFree(LocoChannel[1]);
         BASS_ChannelStop(LocoChannel_FX[1]); BASS_StreamFree(LocoChannel_FX[1]);
     end;

     (*if LocoWithDNoisePitch = True then begin
        DNoisePitchDest := ((power(Speed*2.5, 0.4) - 15) * 2) + 15;
        TWS_DNoisePitchRegulation();
        LocoVolume := Trunc(power(Speed/105,0.7)*100);
        if Camera <> 2 then
           BASS_ChannelSetAttribute(LocoChannel_FX[ChannelNum], BASS_ATTRIB_VOL, LocoVolume / 100)
        else
           BASS_ChannelSetAttribute(LocoChannel_FX[ChannelNum], BASS_ATTRIB_VOL, 0);
        if BASS_ChannelIsActive(LocoChannel_FX[0]) = 0 then
           TWS_PlayDrivingNoise(PChar('TWS/'+Loco+'/DNoise.wav'));
     end;*)

     // ���� ��������� ������� ���������� �� ����������
     if ((SvetoforDist<=(Speed/1.8)+4) and (Prev_SvetoforDist>(Speed/1.8)+4))
        Or (perestukPLAY=True) then begin
        perestukPLAY:=False;
        if BASS_ChannelIsActive(LocoChannelPerestuk[LChannelPerestuk])=0 then begin
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

    // ���� �������� ��������� �������� ���������� ��� ��������� �������� �������
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

       // ���� �������� ��������� �������� ���������� ��� ��������� ������������ �������
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

    // --- ��������� � ������ ����, ������ "������" --- //
    if LocoGlobal = 'CHS7' then chs7__.step();
    if LocoGlobal = 'CHS8' then chs8__.step();
    if LocoGlobal = 'CHS4t' then chs4t__.step();
    if LocoGlobal = 'CHS2K' then chs2k__.step();
    if LocoGlobal = 'CHS4 KVR' then chs4kvr__.step();
    if LocoGlobal = 'CHS4' then chs4__.step();
    if LocoGlobal = 'VL80t' then vl80t__.step();
    if LocoGlobal = 'VL82m' then vl82m__.step();
    if LocoGlobal = 'EP1m' then ep1m__.step();
    if LocoGlobal = '2ES5K' then es5k__.step();
    if LocoGlobal = 'ED4M' then ed4m__.step();
    if LocoGlobal = 'ED9M' then ed9m__.step();
    if LocoGlobal = '2TE10U' then te10u__.step();
    if LocoGlobal = 'M62' then m62__.step();

    SAVPTick();

    SoundManagerTick();

    //Prev_KM_OP := KM_OP;
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
    PrevGR := GR;
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
    //PrevGR := GR;
    PrevVR242 := VR242;
    PrevisCameraInCabin := isCameraInCabin;
end;	// ����� ����� ���� ���� �� �� �����!!!!!

PrevConMem:=isConnectedMemory;
//end;
except
   // ������
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

procedure TFormMain.timerSoundSliderTimer(Sender: TObject);
var
  VentVolume: Single;
begin
  if PerehodLocoPerestuk=True then begin
    if LChannelPerestuk=0 then begin
      BASS_ChannelSetAttribute(LocoChannelPerestuk[0], BASS_ATTRIB_VOL, LocoVolumePerestuk/100);
      BASS_ChannelSetAttribute(LocoChannelPerestuk[1], BASS_ATTRIB_VOL, LocoVolumePerestuk2/100);
      Dec(LocoVolumePerestuk); Inc(LocoVolumePerestuk2);
      if LocoVolumePerestuk<=0 then begin PerehodLocoPerestuk:=False; BASS_ChannelStop(LocoChannelPerestuk[0]); BASS_StreamFree(LocoChannelPerestuk[0]); end;
    end;
    if LChannelPerestuk=1 then begin
      BASS_ChannelSetAttribute(LocoChannelPerestuk[1], BASS_ATTRIB_VOL, LocoVolumePerestuk/100);
      BASS_ChannelSetAttribute(LocoChannelPerestuk[0], BASS_ATTRIB_VOL, LocoVolumePerestuk2/100);
      Dec(LocoVolumePerestuk); Inc(LocoVolumePerestuk2);
      if LocoVolumePerestuk<=0 then begin PerehodLocoPerestuk:=False; BASS_ChannelStop(LocoChannelPerestuk[1]); BASS_StreamFree(LocoChannelPerestuk[1]); end;
    end;
  end;
  // ������� ����� ��������� ��������� ���������� //
  if PerehodLoco=True then begin
    if ChannelNum=0 then begin
      BASS_ChannelSetAttribute(LocoChannel_FX[0], BASS_ATTRIB_VOL, LocoVolume/100);
      BASS_ChannelSetAttribute(LocoChannel_FX[1], BASS_ATTRIB_VOL, LocoVolume2/100);
      Dec(LocoVolume); Inc(LocoVolume2);
      if LocoVolume<=0 then begin PerehodLoco:=False; BASS_ChannelStop(LocoChannel[0]); BASS_StreamFree(LocoChannel[0]); end;
    end;
    if ChannelNum=1 then begin
      BASS_ChannelSetAttribute(LocoChannel_FX[1], BASS_ATTRIB_VOL, LocoVolume/100);
      BASS_ChannelSetAttribute(LocoChannel_FX[0], BASS_ATTRIB_VOL, LocoVolume2/100);
      Dec(LocoVolume); Inc(LocoVolume2);
      if LocoVolume<=0 then begin PerehodLoco:=False; BASS_ChannelStop(LocoChannel[1]); BASS_StreamFree(LocoChannel[1]); end;
    end;
  end;
  // ******************************************** //
  // ������� ����� ��������� ���-�� //
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
  // ������� ����� ��������� ������� //
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
  // ��������� ����� ���������� ������ //
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
  // ��������� ������ �� �������� //
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
        BASS_ChannelStop(Unipuls_Channel[0]); BASS_StreamFree(Unipuls_Channel[0]);
        BASS_ChannelStop(Unipuls_Channel[1]); BASS_StreamFree(Unipuls_Channel[1]);
        UnipulsFaktPos:=-1; UnipulsTargetPos:=-1;
        end;
  end;
  end;
  // ������� ����� ��������� ���������
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
  // ���� �� �� �������, �� �������� ������������ - ������
  if (isPlayPerestuk_OnStation=True) then timerPRSswitcher.Interval:=180000 else begin
    Randomize; Randomize; timerPRSswitcher.Interval:=350000+Random(150000); end;
end;

// ����� ��������� ������ ��� ������ ��������� ������ TrackBar
procedure TFormMain.ChangeVolume(Sender: TObject);
begin
       VolumeMaster_RefreshVolume();
end;

// ������ �������� ���������� ���������� ZDSimulator
procedure TFormMain.timerSearchSimulatorWindowTimer(Sender: TObject);
begin
   ConnectSimulatorRAM();
end;

// === ������� �� ������� "���� ����-�" === //
procedure TFormMain.cbKLUBSoundsClick(Sender: TObject);
begin
	if cbKLUBSounds.Checked=True then begin
           cb3SL2mSounds.Checked:=False
        end else begin
           BASS_ChannelStop(Ogr_Speed_KLUB); BASS_StreamFree(Ogr_Speed_KLUB);
           isPlayOgrSpKlub:=0;
        end;
end;

// === ������� �� ������� "����� 3��2�" === //
procedure TFormMain.cb3SL2mSoundsClick(Sender: TObject);
begin
	if cb3SL2mSounds.Checked=True then begin
           cbKLUBSounds.Checked:=False; isPlayClock:=False;
           SL2M__ := sl2m_.Create('TWS/Devices/3SL2m/');
        end else begin
           BASS_ChannelStop(ClockChannel); BASS_StreamFree(ClockChannel);
           SL2M__.Destroy();
        end;
end;

// === ������� �� ������� "���� ���������� ������" === //
procedure TFormMain.cbHeadTrainSoundClick(Sender: TObject);
begin
	if cbHeadTrainSound.Checked=False then begin
           BASS_ChannelStop(Vstrech); BASS_StreamFree(Vstrech);
        end;
end;

procedure TFormMain.Button3Click(Sender: TObject);
begin
        ShellExecute(Self.Handle,'explore', PChar(ExtractFilePath(Application.ExeName)+'TWS/�������/'),nil,nil,SW_SHOWNORMAL);
end;

procedure TFormMain.timerPlayPerestukTimer(Sender: TObject);
begin
	if Speed >= 3 then begin
           //if (BASS_ChannelIsActive(LocoChannelPerestuk[LChannelPerestuk])=0) then begin
           PerestukPLAY:=True;
           TimerPlayPerestuk.Enabled := False;
           //end;
           Randomize; Randomize; Randomize;
           if isPlayPerestuk_OnStation = True then begin
              TimerPlayPerestuk.Interval := 10000;
           end else begin
              TimerPlayPerestuk.Interval := 35000+Random(Speed*40);
           end;
        end;
end;

// === ������� �� ������� "���� ������ ������� ��� ����������" === //
procedure TFormMain.cbBrakingSoundsClick(Sender: TObject);
begin
	if cbBrakingSounds.Checked=False then begin
           BASS_ChannelStop(Brake_Channel[0]); BASS_StreamFree(Brake_Channel[0]);
           BASS_ChannelStop(Brake_Channel[1]); BASS_StreamFree(Brake_Channel[1]);
        end else begin
           BrakeCylinders:=0.0;
        end;
end;

// === ������� �� ������� "����� ���������" ===
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
//                ������� �� ������� ���� ���2� (���������� ��)                 //
//------------------------------------------------------------------------------//
procedure TFormMain.cbEPL2TBlockClick(Sender: TObject);
var
   sr:TSearchRec;
begin
   if cbEPL2TBlock.Checked=True then begin
      cbSAVPESounds.Checked := False;cbSAUTSounds.Checked:=False;cbUSAVPSounds.Checked:=False;cbGSAUTSounds.Checked:=False;

      ComboBox3.Items.Clear;

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
//                           ������� �� ������� �����                           //
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

          ComboBox1.Items.Clear(); // ������� ������ ��������� ����� �� ��������� � ������

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
        ComboBox2.Items.Add(Utf8ToAnsi('< ��� �� >'));
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

// === ������� �� ������� "����� ��������������� �����" === //
procedure TFormMain.cbVspomMashClick(Sender: TObject);
begin
	if cbVspomMash.Checked=False then begin
            BASS_ChannelStop(Unipuls_Channel[0]); BASS_StreamFree(Unipuls_Channel[0]);
            BASS_ChannelStop(Unipuls_Channel[1]); BASS_StreamFree(Unipuls_Channel[1]);
            With CHS8__ do begin
               UnipulsFaktVol:=0; UnipulsTargetVol:=0; UnipulsTargetPos:=-1; UnipulsFaktPos:=-1;
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

// -=-=-=-=-=-=- ���� ������ ������������� �� ����� -=-=-=-=-=-=- //
procedure TFormMain.ComboBox2Change(Sender: TObject);
begin
	LoadSAVPE_EK('TWS/SAVPE_INFORMATOR/Info/' + ComboBox1.Items[ComboBox1.ItemIndex] + '/' +
                     ComboBox2.Items[ComboBox2.ItemIndex]);
end;

procedure TFormMain.timerDoorCloseDelayTimer(Sender: TObject);
begin
	SAVPE_DoorCloseTimerTick();
end;

// ��������� ��������������� ������ ������ ����� �� ����
procedure TFormMain.RB_AutoEKModeClick(Sender: TObject);
begin
	cbSAVPE_Marketing.Enabled := True;	// �������� ������� "����������� ������������� ����������"
        GroupBox5.Enabled := True;	// �������� ���� ��������� �������� ���������� �������� ������
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

// �����: �������� ����� � ���������
// ------------------------------------------
// �� ����: ������
// ����������: ���
procedure TFormMain.N5Click(Sender: TObject);
begin
   ShellExecute(Self.Handle,'explore', PChar(ExtractFilePath(Application.ExeName)+'TWS/BAT_FILES/'),nil,nil,SW_SHOWNORMAL);
end;

// �����: �������� ����� ReadME
// ------------------------------------------
// �� ����: ������
// ����������: ���
procedure TFormMain.ReadME1Click(Sender: TObject);
begin
   ShellExecute(Handle, 'open', PChar(ExtractFilePath(Application.ExeName)+'TWS/ReadME.doc'), nil, nil, SW_SHOWNORMAL);
end;

// �����: ���������� �������� � ����
// ------------------------------------------
// �� ����: ������
// ����������: ���
procedure TFormMain.N3Click(Sender: TObject);
var
	saveDialog : TSaveDialog;    // ���������� ������� ����������
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
           //���� ���� � ��������� ������ ��� ����������.
           if FileExists(saveDialog.FileName) then begin
              Res := MessageDlg(
                     '���� � ������:' + #10
                      + '"' + saveDialog.FileName + '"' + #10
                      + '��� ����������. ������������?'
                      ,mtConfirmation
                      ,[mbYes, mbNo]
                      ,0
                   );
              if Res = mrYes then SaveTWSParams(saveDialog.FileName);
           end else SaveTWSParams(saveDialog.FileName);
        end;

  	saveDialog.Free;
end;

// �����: �������� �������� TWS �� �����
// ------------------------------------------
// �� ����: ������
// ����������: ���
procedure TFormMain.N4Click(Sender: TObject);
var
  	openDialog: TOpenDialog;    // ���������� OpenDialog
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

// �����: �������� ���� "������"
// ------------------------------------------
// �� ����: ������
// ����������: ���
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

// --- ������������ ������ ��������� ��������� ����� 5���. ����� �������� ������ --- //
procedure TFormMain.timerDoorCloseZvonokTimer(Sender: TObject);
begin
   isPlaySAVPEZvonok:=False;
   timerDoorCloseZvonok.Enabled := False;
end;

procedure TFormMain.Button1Click(Sender: TObject);
begin
  isRefreshLocalData := True;
end;

end.

object FormDebug: TFormDebug
  Left = 380
  Top = 130
  HorzScrollBar.Visible = False
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1080#1089#1090#1077#1084#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' TWS'
  ClientHeight = 781
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label90: TLabel
    Left = 8
    Top = 584
    Width = 57
    Height = 13
    Caption = #1041#1072#1079#1072' '#1057#1040#1042#1055
  end
  object Label93: TLabel
    Left = 232
    Top = 584
    Width = 142
    Height = 13
    Caption = #1057#1077#1082#1094#1080#1103' TWS-EK '#1074' '#1089#1094#1077#1085#1072#1088#1080#1080
  end
  object ListView1: TListView
    Left = 8
    Top = 8
    Width = 747
    Height = 561
    Columns = <
      item
        Caption = #8470
        Width = 25
      end
      item
        Caption = #1048#1084#1103
        Width = 250
      end
      item
        Caption = #1058#1080#1087' '#1076#1072#1085#1085#1099#1093
        Width = 100
      end
      item
        Caption = #1043#1088#1091#1087#1087#1072
        Width = 200
      end
      item
        Caption = #1047#1085#1072#1095#1077#1085#1080#1077
        Width = 150
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GridLines = True
    MultiSelect = True
    RowSelect = True
    ParentFont = False
    SortType = stData
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = ListView1ColumnClick
  end
  object btnStationsBorder: TButton
    Left = 8
    Top = 752
    Width = 113
    Height = 25
    Caption = #1043#1088#1072#1085#1080#1094#1099' '#1089#1090#1072#1085#1094#1080#1081
    TabOrder = 1
    OnClick = btnStationsBorderClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 600
    Width = 217
    Height = 145
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 232
    Top = 600
    Width = 217
    Height = 145
    Lines.Strings = (
      'Memo2')
    TabOrder = 3
  end
  object Memo3: TMemo
    Left = 456
    Top = 600
    Width = 201
    Height = 145
    Lines.Strings = (
      'Memo3')
    TabOrder = 4
  end
  object btnShowWagonsLenghts: TButton
    Left = 128
    Top = 752
    Width = 193
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1083#1080#1085#1099' '#1074#1072#1075#1086#1085#1086#1074' '#1089#1086#1089#1090#1072#1074#1072
    TabOrder = 5
    OnClick = btnShowWagonsLenghtsClick
  end
  object btnWorkInProgress: TButton
    Left = 400
    Top = 576
    Width = 241
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1087#1077#1088#1077#1084#1077#1085#1085#1099#1077' Work In Progress'
    TabOrder = 6
    OnClick = btnWorkInProgressClick
  end
  object tmrRefreshDebugData: TTimer
    Enabled = False
    Interval = 20
    OnTimer = tmrRefreshDebugDataTimer
    Left = 664
    Top = 600
  end
end

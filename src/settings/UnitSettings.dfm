object FormSettings: TFormSettings
  Left = 971
  Top = 635
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' TWS'
  ClientHeight = 226
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object groupBoxSettings: TGroupBox
    Left = 0
    Top = 0
    Width = 337
    Height = 225
    Caption = #1054#1089#1085#1086#1074#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 0
    object cbSlowComputer: TCheckBox
      Left = 16
      Top = 24
      Width = 129
      Height = 17
      BiDiMode = bdRightToLeftNoAlign
      Caption = #1057#1083#1072#1073#1099#1081' '#1082#1086#1084#1087#1100#1102#1090#1077#1088
      ParentBiDiMode = False
      TabOrder = 0
      OnClick = cbSlowComputerClick
    end
    object cbTEDNewSystem: TCheckBox
      Left = 16
      Top = 40
      Width = 177
      Height = 17
      Caption = #1053#1086#1074#1072#1103' '#1089#1080#1089#1090#1077#1084#1072' '#1079#1074#1091#1082#1086#1074' '#1058#1069#1044
      Checked = True
      State = cbChecked
      TabOrder = 1
      Visible = False
      OnClick = cbTEDNewSystemClick
    end
    object cbHornClick: TCheckBox
      Left = 16
      Top = 56
      Width = 313
      Height = 17
      Caption = #1057#1074#1080#1089#1090#1082#1080' '#1080' '#1090#1080#1092#1086#1085#1099' '#1073#1077#1079' '#1087#1088#1086#1074#1077#1088#1082#1080' '#1076#1072#1074#1083#1077#1085#1080#1103' '#1080' '#1101#1083'. '#1094#1077#1087#1077#1081
      TabOrder = 2
    end
    object cbCHS4tNewMVSystemOnAllLocoNum: TCheckBox
      Left = 16
      Top = 168
      Width = 297
      Height = 49
      Caption = 
        #1048#1079#1084#1077#1085#1103#1102#1097#1077#1077#1089#1103' '#1090#1086#1085#1072#1083#1100#1085#1086#1089#1090#1100' '#1052#1042' '#1085#1072' '#1063#1057'4'#1090' '#1087#1086#1089#1083#1077' 700'#1040' '#1085#1072' '#1074#1089#1077#1093' '#1085#1086#1084#1077#1088#1072#1093' '#1089 +
        #1077#1088#1080#1080' ('#1073#1077#1079' '#1101#1090#1086#1075#1086' '#1090#1086#1083#1100#1082#1086' '#1085#1072' 62'#1045'8 '#1080' '#1073#1086#1083#1077#1077', '#1090#1086' '#1077#1089#1090#1100' '#1085#1086#1084#1077#1088#1072' '#1074#1099#1096#1077' 607-' +
        #1075#1086')'
      TabOrder = 3
      WordWrap = True
      OnClick = cbCHS4tNewMVSystemOnAllLocoNumClick
    end
  end
end

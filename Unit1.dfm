object Form1: TForm1
  Left = 370
  Top = 259
  Width = 1047
  Height = 537
  Hint = #1044#1074#1086#1081#1085#1086#1081' '#1097#1077#1083#1095#1086#1082' '#1084#1099#1096#1100#1102' - '#1089#1087#1088#1103#1090#1072#1090#1100' '#1086#1082#1085#1086
  Caption = #1057#1080#1089#1090#1077#1084#1072' '#1072#1074#1090#1086#1076#1080#1072#1075#1085#1086#1089#1090#1080#1082#1080
  Color = clCream
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010100000000000280100001600000028000000100000002000
    00000100040000000000C0000000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00CCCC
    BBBBBBBBCCCCCCBBBBBBBBBBBBCCCCBBBCAACCCBBBCCCBBCCCAAACCCCBBCBBBC
    AAAAACCCCBBBBBCAAAAAAACCCCBBBBAAAACCAACCCCBBBBAAACCCAAACCCBBBBCA
    CCCCCAAACCBBBBCCCCCCCCAACCBBBBCCCCCCCCAAACBBBBBCCCCCCCCAAABBCBBC
    CCCCCCCCAABCCCBBBCCCCCCBAAAACCBBBBBBBBBBBBAACCCCBBBBBBBBCCCC0000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  DesignSize = (
    1039
    510)
  PixelsPerInch = 96
  TextHeight = 13
  object btnAddToNumbers: TSpeedButton
    Left = 8
    Top = 220
    Width = 73
    Height = 26
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    OnClick = btnAddToNumbersClick
  end
  object Label8: TLabel
    Left = 13
    Top = 76
    Width = 97
    Height = 13
    Alignment = taRightJustify
    Caption = #1056#1077#1082#1083#1072#1084#1085#1099#1081' '#1085#1086#1084#1077#1088':'
  end
  object Label9: TLabel
    Left = 93
    Top = 100
    Width = 95
    Height = 13
    Alignment = taRightJustify
    Caption = 'ID '#1089#1083#1091#1078#1073#1099' (FTAXI):'
  end
  object Label10: TLabel
    Left = 8
    Top = 52
    Width = 92
    Height = 13
    Alignment = taRightJustify
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1083#1091#1078#1073#1099
  end
  object Label11: TLabel
    Left = 72
    Top = 124
    Width = 112
    Height = 13
    Alignment = taRightJustify
    Caption = #1051#1080#1084#1080#1090' '#1074#1088#1077#1084#1077#1085#1080' ('#1084#1080#1085'):'
  end
  object Label12: TLabel
    Left = 32
    Top = 148
    Width = 153
    Height = 13
    Alignment = taRightJustify
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1086#1073#1085#1099#1093' '#1079#1074#1086#1085#1082#1086#1074':'
  end
  object btnDelFromNumbers: TSpeedButton
    Left = 168
    Top = 220
    Width = 73
    Height = 26
    Caption = #1059#1076#1072#1083#1080#1090#1100
    OnClick = btnDelFromNumbersClick
  end
  object btnUpdateNumbers: TSpeedButton
    Left = 88
    Top = 220
    Width = 73
    Height = 26
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    OnClick = btnUpdateNumbersClick
  end
  object Label1: TLabel
    Left = 163
    Top = 172
    Width = 20
    Height = 13
    Alignment = taRightJustify
    Caption = 'FIN:'
  end
  object Label2: TLabel
    Left = 15
    Top = 196
    Width = 154
    Height = 13
    Alignment = taRightJustify
    Caption = #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1089#1090#1072#1090#1091#1089' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072':'
  end
  object btnEnableCheck: TSpeedButton
    Left = 8
    Top = 0
    Width = 1015
    Height = 19
    Hint = #1042#1082#1083'/'#1042#1099#1082#1083' '#1087#1088#1086#1074#1077#1088#1082#1091
    Anchors = [akLeft, akTop, akRight]
    Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1088#1086#1074#1077#1088#1082#1091
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = btnEnableCheckClick
  end
  object btnHideProgram: TSpeedButton
    Left = 24
    Top = 360
    Width = 201
    Height = 33
    Caption = #1057#1087#1088#1103#1090#1072#1090#1100' '#1086#1082#1085#1086
    Flat = True
    OnClick = FormDblClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 490
    Width = 1039
    Height = 20
    Panels = <
      item
        Bevel = pbRaised
        Text = #1057#1090#1072#1088#1090' '#1087#1088#1086#1075#1088#1072#1084#1084#1099':'
        Width = 110
      end
      item
        Text = ' '
        Width = 150
      end
      item
        Bevel = pbRaised
        Text = #1042#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099':'
        Width = 90
      end
      item
        Text = ' '
        Width = 100
      end>
  end
  object RaklamGrid: TDBGridEh
    Left = 24
    Top = 404
    Width = 113
    Height = 61
    DataGrouping.GroupLevels = <>
    DataSource = RaklamSource
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    IndicatorOptions = [gioShowRowIndicatorEh]
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object btnResetSiemens: TButton
    Left = 24
    Top = 326
    Width = 201
    Height = 26
    Caption = 'RESET siemens'
    Enabled = False
    TabOrder = 15
    OnClick = btnResetSiemensClick
  end
  object Memo1: TMemo
    Left = 248
    Top = 268
    Width = 776
    Height = 208
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clSilver
    Constraints.MinHeight = 208
    Constraints.MinWidth = 722
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 9
  end
  object mGr: TDBGridEh
    Left = 248
    Top = 20
    Width = 775
    Height = 226
    Cursor = crIBeam
    Anchors = [akLeft, akTop, akRight]
    Color = clSilver
    DataGrouping.Color = clGray
    DataGrouping.GroupLevels = <>
    DataGrouping.ParentColor = False
    DataSource = mDSource
    EvenRowColor = clSilver
    FixedColor = clSkyBlue
    Flat = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    FooterColor = clMenuText
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    IndicatorOptions = [gioShowRowIndicatorEh]
    OddRowColor = clGradientInactiveCaption
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    RowDetailPanel.Color = clBtnFace
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    TitleHeight = 20
    UseMultiTitle = True
    OnCellClick = mGrCellClick
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Number: TMaskEdit
    Left = 112
    Top = 68
    Width = 125
    Height = 21
    EditMask = '9999999999;1;_'
    MaxLength = 10
    TabOrder = 3
    Text = '          '
  end
  object Ftaxi: TMaskEdit
    Left = 192
    Top = 92
    Width = 49
    Height = 21
    BiDiMode = bdLeftToRight
    EditMask = '!999;1;_'
    MaxLength = 3
    ParentBiDiMode = False
    TabOrder = 2
    Text = '  0'
  end
  object TimeLimit: TMaskEdit
    Left = 192
    Top = 116
    Width = 49
    Height = 21
    EditMask = '!99;1;_'
    MaxLength = 2
    TabOrder = 4
    Text = '30'
  end
  object countChec: TMaskEdit
    Left = 192
    Top = 140
    Width = 49
    Height = 21
    EditMask = '!9;1;_'
    MaxLength = 1
    TabOrder = 5
    Text = '2'
  end
  object telephones: TComboBox
    Left = 8
    Top = 20
    Width = 233
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = #1053#1086#1084#1077#1088#1072' '#1088#1077#1082#1083#1072#1084#1085#1099#1093' '#1083#1080#1085#1080#1081
    OnChange = telephonesChange
    OnSelect = telephonesSelect
  end
  object ipadr: TMaskEdit
    Left = 144
    Top = 403
    Width = 97
    Height = 22
    BevelKind = bkFlat
    BorderStyle = bsNone
    CharCase = ecUpperCase
    EditMask = '192.168.0.!999;1;_'
    MaxLength = 13
    TabOrder = 11
    Text = '192.168.0.242'
  end
  object port: TMaskEdit
    Left = 144
    Top = 427
    Width = 97
    Height = 22
    BevelKind = bkFlat
    BorderStyle = bsNone
    CharCase = ecUpperCase
    EditMask = '00000;1;_'
    MaxLength = 5
    TabOrder = 12
    Text = '40078'
  end
  object btnReconnectMoxa: TButton
    Left = 144
    Top = 451
    Width = 97
    Height = 26
    Caption = 'Reconnect'
    TabOrder = 13
    OnClick = btnReconnectMoxaClick
  end
  object btnSendCmd: TButton
    Left = 24
    Top = 297
    Width = 201
    Height = 26
    Caption = 'Send command'
    Enabled = False
    TabOrder = 14
    OnClick = btnSendCmdClick
  end
  object command: TEdit
    Left = 24
    Top = 272
    Width = 201
    Height = 22
    Hint = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1040#1058'-'#1082#1086#1084#1072#1085#1076#1072
    BevelKind = bkFlat
    BorderStyle = bsNone
    CharCase = ecUpperCase
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    Text = 'AT'
  end
  object FDEVIN: TMaskEdit
    Left = 192
    Top = 164
    Width = 49
    Height = 21
    EditMask = '!99;1;_'
    MaxLength = 2
    TabOrder = 6
    Text = ' 0'
  end
  object Stat: TComboBox
    Left = 176
    Top = 188
    Width = 65
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 17
    Text = #1044#1072'=0'
    Items.Strings = (
      #1044#1072'=0'
      #1053#1077#1090'=1')
  end
  object FNameTaxi: TEdit
    Left = 112
    Top = 44
    Width = 129
    Height = 21
    TabOrder = 1
    Text = #1085#1072#1079#1074#1072#1085#1080#1077
    OnClick = FNameTaxiClick
    OnKeyPress = FNameTaxiKeyPress
  end
  object progres: TProgressBar
    Left = 8
    Top = 248
    Width = 1015
    Height = 17
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    Max = 200
    ParentShowHint = False
    Smooth = True
    Step = 1
    ShowHint = True
    TabOrder = 18
  end
  object RaklamSource: TDataSource
    DataSet = ReklamDataSet
    Left = 72
    Top = 412
  end
  object RaklamDB: TpFIBDatabase
    AutoReconnect = True
    Connected = True
    DBName = '192.168.0.130:D:\cc5\callcenter.fdb'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    DefaultTransaction = ReklamTr
    SQLDialect = 3
    Timeout = 0
    WaitForRestoreConnect = 0
    Left = 16
    Top = 444
  end
  object ReklamDataSet: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT'
      'first 3 skip 0'
      '    FDATE,'
      '    FTAXI,'
      '    FCTEL'
      'FROM'
      '    CALLBACKA'
      'ORDER BY FDATE DESC')
    Transaction = ReklamTr
    Database = RaklamDB
    Left = 48
    Top = 444
  end
  object ReklamTr: TpFIBTransaction
    Active = True
    DefaultDatabase = RaklamDB
    TimeoutAction = TARollback
    TRParams.Strings = (
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 104
    Top = 412
  end
  object mDSource: TDataSource
    DataSet = mdataset
    Left = 304
    Top = 180
  end
  object mdb: TpFIBDatabase
    DBName = 'localhost:D:\SERVER\FBase\REKLAMLINES.FDB'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    DefaultTransaction = mtr
    DefaultUpdateTransaction = mtr
    SQLDialect = 3
    Timeout = 0
    WaitForRestoreConnect = 0
    Left = 304
    Top = 108
  end
  object mdataset: TpFIBDataSet
    InsertSQL.Strings = (
      '')
    SelectSQL.Strings = (
      'SELECT'
      '    ID,'
      '    NUMBER,'
      '    FTAXI,'
      '    NAMETAXI,'
      '    LASTCHEC,'
      '    TIMELIMIT,'
      '    COUNTCHEC,'
      '    FDEVIN,'
      '    STATUS'
      'FROM'
      '    NUMBERS ')
    Transaction = mtr
    Database = mdb
    Left = 304
    Top = 156
  end
  object mtr: TpFIBTransaction
    DefaultDatabase = mdb
    TimeoutAction = TACommit
    TRParams.Strings = (
      'write'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 304
    Top = 132
  end
  object PopupMenu1: TPopupMenu
    Left = 888
    Top = 468
    object mniShowProgram: TMenuItem
      Caption = #1054#1090#1088#1082#1088#1099#1090#1100' '#1085#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      OnClick = mniShowProgramClick
    end
    object mniShowErrors: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1086#1096#1080#1073#1086#1082
      OnClick = mniShowErrorsClick
    end
    object mniCloseProgram: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = mniCloseProgramClick
    end
  end
  object tray: TCoolTrayIcon
    CycleInterval = 0
    Hint = #1057#1080#1089#1090#1077#1084#1072' '#1072#1074#1090#1086#1076#1080#1072#1075#1085#1086#1089#1090#1080#1082#1080
    Icon.Data = {
      0000010001001010100000000000280100001600000028000000100000002000
      00000100040000000000C0000000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00CCCC
      BBBBBBBBCCCCCCBBBBBBBBBBBBCCCCBBBCAACCCBBBCCCBBCCCAAACCCCBBCBBBC
      AAAAACCCCBBBBBCAAAAAAACCCCBBBBAAAACCAACCCCBBBBAAACCCAAACCCBBBBCA
      CCCCCAAACCBBBBCCCCCCCCAACCBBBBCCCCCCCCAAACBBBBBCCCCCCCCAAABBCBBC
      CCCCCCCCAABCCCBBBCCCCCCBAAAACCBBBBBBBBBBBBAACCCCBBBBBBBBCCCC0000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    IconVisible = True
    IconIndex = 0
    PopupMenu = PopupMenu1
    MinimizeToTray = True
    OnClick = trayClick
    Left = 920
    Top = 468
  end
  object Client: TClientSocket
    Active = True
    Address = '192.168.0.242'
    ClientType = ctNonBlocking
    Port = 40078
    OnConnect = ClientConnect
    OnRead = ClientRead
    OnError = ClientError
    Left = 856
    Top = 468
  end
  object timer: TTimer
    Interval = 10000
    OnTimer = Tmr
    Left = 824
    Top = 468
  end
  object work: TTimer
    Interval = 500
    OnTimer = workTimer
    Left = 984
    Top = 468
  end
  object XPManifest1: TXPManifest
    Left = 952
    Top = 468
  end
end

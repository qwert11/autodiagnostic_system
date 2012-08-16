unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FIBDatabase, pFIBDatabase, DB, FIBDataSet, pFIBDataSet, Grids,
  DBGrids, ExtCtrls, ScktComp, StdCtrls, ComCtrls, FIBQuery, pFIBQuery,
  DBGridEhGrouping, GridsEh, DBGridEh, Mask, Buttons, CoolTrayIcon, Menus,
  XPMan, IniFiles;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    RaklamSource: TDataSource;
    RaklamDB: TpFIBDatabase;
    ReklamDataSet: TpFIBDataSet;
    ReklamTr: TpFIBTransaction;
    RaklamGrid: TDBGridEh;
    btnResetSiemens: TButton;
    Memo1: TMemo;
    mGr: TDBGridEh;
    mDSource: TDataSource;
    btnAddToNumbers: TSpeedButton;
    Number: TMaskEdit;
    Label8: TLabel;
    Label9: TLabel;
    Ftaxi: TMaskEdit;
    Label10: TLabel;
    Label11: TLabel;
    TimeLimit: TMaskEdit;
    countChec: TMaskEdit;
    Label12: TLabel;
    mdb: TpFIBDatabase;
    mdataset: TpFIBDataSet;
    mtr: TpFIBTransaction;
    btnDelFromNumbers: TSpeedButton;
    btnUpdateNumbers: TSpeedButton;
    telephones: TComboBox;
    ipadr: TMaskEdit;
    port: TMaskEdit;
    btnReconnectMoxa: TButton;
    btnSendCmd: TButton;
    command: TEdit;
    PopupMenu1: TPopupMenu;
    mniShowProgram: TMenuItem;
    mniCloseProgram: TMenuItem;
    mniShowErrors: TMenuItem;
    tray: TCoolTrayIcon;
    Client: TClientSocket;
    timer: TTimer;
    Label1: TLabel;
    FDEVIN: TMaskEdit;
    Stat: TComboBox;
    Label2: TLabel;
    btnEnableCheck: TSpeedButton;
    FNameTaxi: TEdit;
    progres: TProgressBar;
    work: TTimer;
    btnHideProgram: TSpeedButton;
    XPManifest1: TXPManifest;
    procedure FormCreate(Sender: TObject);
    procedure ClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure btnResetSiemensClick(Sender: TObject);
    procedure Tmr(Sender: TObject);
    procedure btnAddToNumbersClick(Sender: TObject);
    procedure btnDelFromNumbersClick(Sender: TObject);
    procedure mGrCellClick(Column: TColumnEh);
    procedure telephonesSelect(Sender: TObject);
    procedure btnUpdateNumbersClick(Sender: TObject);
    procedure btnReconnectMoxaClick(Sender: TObject);
    procedure btnSendCmdClick(Sender: TObject);
    procedure trayClick(Sender: TObject);
    procedure mniShowProgramClick(Sender: TObject);
    procedure mniCloseProgramClick(Sender: TObject);
    procedure btnEnableCheckClick(Sender: TObject);
    procedure ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure mniShowErrorsClick(Sender: TObject);
    procedure telephonesChange(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FNameTaxiKeyPress(Sender: TObject; var Key: Char);
    procedure workTimer(Sender: TObject);
    procedure FNameTaxiClick(Sender: TObject);
  private
    function  UnixTimeToDateTime(UnixTime: LongInt): TDate;
    function  DateTimeToUnixTime(DelphiDate: TDate): LongInt;
  public
    { Public declarations }
  end;

const
  SecPerDay = 86400;
  Offset1970 = 25569;

var
  Form1: TForm1;
  maxid: Integer; // последняя запись в Reklamlines.Numbers - btnAddToNumbersClick, TForm1.FormCreate
  selid: string; // выделенный номер из ReklamLines.Numbers btnDelFromNumbersClick, mGrCellClick,
    // telephonesSelect, btnUpdateNumbersClick
  stopID: string = '0'; // последняя запись из ReklamLines.Numbers на кот. остановились
    // в Tmr, btnEnableCheckClick,
  // datastart: string = '0';
  chec: Boolean; // проверка - btnEnableCheck, ClientError, ClientConnect, Tmr
  // socket: Boolean;
  CurrTry: array [0..1000] of Integer; // текущее количество попыток дозвона по каждому номеру
  // calls: array [0..1000] of Integer; // время последних попыток звонков
  unt: Integer;  // время щас в юникс тайм
  errcount: Integer = 0; // счетчик ошибок по сокету с сименса
  PortRead: string;
  PortErrorCount: Integer;

implementation

uses Unit2;

{$R *.dfm}

function TForm1.UnixTimeToDateTime(UnixTime : LongInt):TDate;
begin
  Result := UnixTime / SecPerDay + Offset1970;
end;

function TForm1.DateTimeToUnixTime(DelphiDate : TDate) : LongInt;
begin
  Result := Trunc((DelphiDate - Offset1970) * SecPerDay);
end;
//******************

procedure TForm1.FormCreate(Sender: TObject);
  procedure ConnectBase();
  var
    FIniFile: TIniFile;
  begin
    FIniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config.ini');
    //with CustomerDM do
    try
      mdb.DatabaseName := FIniFile.ReadString('Base', 'Patch', '');
      mdb.Connected := True;
    finally
      FIniFile.Free;
    end;
  end;
var
  I: Integer;
begin
  //form1.Hide;

  // ExtractFilePath(Application.ExeName);
  if not DirectoryExists('d:\diagnostic_logs') then
    CreateDirectory('d:\diagnostic_logs', nil);  // почему nil /qwert

//  if not FileExists(ExtractFilePath(Application.ExeName)+'\REKLAMLINES.FDB') then
//  begin
//    ShowMessage('ОШИБКА!'+#13#10+
//                'не обнаружен файл \REKLAMLINES.FDB' + #13#10 +
//                'по адресу ' + ExtractFilePath(Application.ExeName) + #13#10 +
//                'Проверьте наличие файла, либо обратитесь к администратору!' + #13#13#10 +
//                'Приложение будет закрыто!');
//    unt := 0;
//    timer.Enabled := False;
//    Client.Active := False;
//    work.Enabled := False;
//    Button1.Enabled := False;
//    Button2.Enabled := False;
//    Button3.Enabled := False;
//    SpeedButton1.Enabled := False;
//    SpeedButton2.Enabled := False;
//    SpeedButton3.Enabled := False;
//    SpeedButton4.Enabled := False;
//    Form1.Close;
//    exit;
//  end;



//  mdb.DBName := 'localhost:' + ExtractFilePath(Application.ExeName) + '\REKLAMLINES.FDB';
//  mdb.Connected := True;

  try
    ConnectBase;
    // mtr.Active := True; // qwert11

    StatusBar1.Panels[1].Text := DateTimeToStr(Date + Time);
    StatusBar1.Panels[3].Text := '0';
    unt := DateTimeToUnixTime(date + time);
    Client.Active := True;

    for i := 0 to 1000 do
    begin
      CurrTry[i] := 0;
      // calls[i] := 0;
    end;

    mdataset.Active := True;
    mdataset.First;
    
    while not mdataset.Eof do
      begin
        telephones.Items.Add(mdataset.FieldByName('number').AsString);
        mdataset.Next;
      end;
    mdataset.Active := False;
    mdataset.SQLs.SelectSQL.Clear;
    mdataset.SQLs.SelectSQL.Add('select max(id) from numbers');
    mdataset.Active := True;
    maxid := mdataset.Fields[0].AsInteger;
    mdataset.Active := False;
    mdataset.SQLs.SelectSQL.Clear;
    mdataset.SQLs.SelectSQL.Add('select * from numbers');
    mdataset.Active := True;
  except
    on E: Exception do begin
      Application.MessageBox(PChar(E.Message), 'ошибка', MB_ICONERROR);
      Halt;
    end;
  end;
end;

procedure TForm1.ClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  ErrorCode := 0;
  Client.Active := False;
  timer.Enabled := False;
  MessageDlg('Нет подклюжчения устройству Siemens или оно занято другим пользователем!'
            + #13#10 +
            'Обратитесь к администратору!' + #13#13#10 +
            'Или попробуйте переподключится', mtWarning , [mbOk], 0);
  btnEnableCheck.Enabled := False;
  btnSendCmd.Enabled := False;
  btnResetSiemens.Enabled := False;
  chec := True;
  Memo1.Lines.Insert(0, DateTimeToStr(Date + Time) + ': Нет подключения к Siemens');
end;

procedure TForm1.ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  chec := False;
  btnEnableCheck.Enabled := True;
  btnSendCmd.Enabled := True;
  btnResetSiemens.Enabled := True;
  btnEnableCheck.Caption := 'Отключить проверку';
  Memo1.Lines.Insert(0, DateTimeToStr(date + Time) + ': Успешное подключение к сокету');
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  chec := True;
  Client.Active := False;
  if unt > 0 then
    begin
      Memo1.Lines.Insert(0, DateTimeToStr(Date + Time) + ': Порт закрыт');
      Memo1.Lines.Insert(0, DateTimeToStr(Date + Time) + ': Конец');
      Memo1.Lines.SaveToFile('d:\diagnostic_logs\log.txt');
      Form2.Memo1.Lines.SaveToFile('d:\diagnostic_logs\log_error.txt');
    end;
end;

procedure TForm1.ClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  PortRead : string;
  // t:integer;
begin
  PortRead := Client.Socket.ReceiveText;
{if ((pos ('+',PortRead)<>0)
    or (pos('0',PortRead)<>0)
    or (pos('1',PortRead)<>0)
    or (pos('2',PortRead)<>0)
    or (pos('3',PortRead)<>0)
    or (pos('4',PortRead)<>0)
    or (pos('5',PortRead)<>0)
    or (pos('6',PortRead)<>0)
    or (pos('7',PortRead)<>0)
    or (pos('8',PortRead)<>0)
    or (pos('9',PortRead)<>0)
    or (pos('*',PortRead)<>0)) then
      if (pos('ATD',PortRead)<>0) then
        begin
          PortRead := 'ПОРТ: '+PortRead;
          t:=1;
        end else begin
          PortRead := 'ПОРТ: Входящий номер'+PortRead;
          t:=1;
          end;
//
if (pos('OK',PortRead)<>0) then
  begin
    PortRead := 'ПОРТ: AT-Команда выполнена без ошибок';
    t:=1;
    end;
if (pos('RING',PortRead)<>0) then
  begin
    PortRead := 'ПОРТ: Входящий звонок';
    Client.Socket.SendText('ATH0'+#13);
    t:=1;
    end;
if (pos('NO CARRIER',PortRead)<>0) then
  begin
    PortRead := 'ПОРТ: Потеряна или не получена несущая от удаленного модема';
    t:=1;
    end;
if (pos('NO DIALTONE',PortRead)<>0) then
  begin
    PortRead := 'ПОРТ: Нет сигнала (гудка) при снятии трубки';
    t:=1;
    end;
if (pos('BUSY',PortRead)<>0) then
  begin
    PortRead := 'ПОРТ:  Обнаружен сигнал <занято> после набора номера';
    t:=1;
    end;
if (pos('ERROR',PortRead)<>0) then
  begin
    PortRead := 'ПОРТ: ERROR';
    Client.Socket.SendText('ATZ'+#13);
    t:=1;
    inc(PortErrorCount);
    if PortErrorCount = 10 then begin
      chec := true;
      Memo1.Lines.Insert(0,DateTimeToStr(date+Time)+': Порт вышел из строя');
      Form2.Memo1.Lines.Insert(0,DateTimeToStr(date+Time)+': Порт вышел из строя, обратитесь ' +
        'к администратору для перезагрузки устройства!' );
      Form2.Memo1.Lines.Insert(0,' ');
      SpeedButton4.Caption := 'Включить проверку';
      timer.Enabled:= false;
    end;
  end;   }
  Memo1.Lines.Insert(0, DateTimeToStr(date + Time) + ': ' + PortRead);
end;

// перезагрузить телефон
procedure TForm1.btnResetSiemensClick(Sender: TObject);
begin
  Client.Socket.SendText('ATZ' + #13);
  Application.ProcessMessages;
  Cursor := crHourGlass;
  Sleep(10000);
  Cursor := crDefault;
end;

// проверка доступности рекламных линий-----------------------
procedure TForm1.Tmr(Sender: TObject);
var
  i, j, countch, lastchec, timelimit, status: integer;
  ftaxi, ftel, nametaxi, ot,id, DEIN, st: string;
  UTNow: INTEGER;
begin
  timer.Enabled := False;
  i:=0;
  //mdataset.First;
  mdataset.Locate('ID', stopID, []);

  while not mdataset.Eof do
    begin
      if (chec = True) then exit; // резрашить проверку

      id := mdataset.FieldByName('id').AsString;
      stopID := id;
      ftel := mdataset.FieldByName('number').AsString;
      ftaxi := mdataset.FieldByName('ftaxi').AsString;
      nametaxi := mdataset.FieldByName('nametaxi').AsString;
      lastchec := mdataset.FieldByName('lastchec').AsInteger;
      timelimit := mdataset.FieldByName('timelimit').AsInteger * 60; // лимит времини
      countch := mdataset.FieldByName('countchec').AsInteger;        // в секундах
      DEIN := mdataset.FieldByName('fdevin').AsString;
      status := mdataset.FieldByName('status').AsInteger;
      UTNow := DateTimeToUnixTime(Date + time); // unix time now
      inc(i);
      st := IntToStr(status);

      if (status = 0) and (UTNow >= lastchec + timelimit) then // настало время проверки?
        begin
          Memo1.Lines.Insert(0, DateTimeToStr(date + Time) + ': Проверяется ' + ftel +
              ', служба такси: ' + nametaxi + '...' + #13#10);
          // ot := IntToStr(UTNow - timelimit); // время отбора от (время щас - лимит времини
                                                // проверки) // qwert11 зачем ??
          ReklamDataSet.Active := False;

          if nametaxi = 'Киев' then
            begin
              RaklamDB.Connected := False;
              RaklamDB.DBName := '192.168.0.130:d:\cck\db\cc5.fdb';
            end
          else
            begin
              RaklamDB.Connected := False;
              RaklamDB.DBName := '192.168.0.130:D:\cc5\callcenter.fdb';
            end;
          RaklamDB.Connected := True;
          // ReklamTr.Active := True; // qwert11

    // тестовый дозвон
          Client.Socket.SendText('ATD' + ftel + ';' + #13);
          command.Text := 'ATD' + ftel + ';';
          Memo1.Lines.Insert(0, DateTimeToStr(date + Time) + ': Попытка дозвона на ' + ftel +
            ',службы такси: ' + nametaxi);
    {}     UTNow := DateTimeToUnixTime(Date + time) - 20; // unix time now  - 50c // qwert11 бред!!!
    {}     ot := IntToStr(UTNow);
    {}     for j := 0 to progres.Max do
    {}      begin
    {}        Application.ProcessMessages;
    {}        Sleep(100);
    {}        progres.StepIt;
    {}        if (chec = True) then exit; // резрашить проверку
    {}      end;
    {}     progres.Position := 0;
    {}     inc(CurrTry[i]);
    {-конец тестового дозвона-}

          // по количеству попыток
          while status = 0 do
          begin
            ReklamDataSet.Active := False;
            ReklamDataSet.SelectSQL.Clear;
            ReklamDataSet.SelectSQL.Text := ('SELECT first 1 skip 0 FCTEL from CALLBACKA WHERE fdate>' + ot +
                                        ' and FTAXI=' + Ftaxi +
                                        ' and fctel=''+380684142932'' ORDER BY FDATE DESC');

    //        Memo1.Lines.Insert(0,s);
    //        ReklamDataSet.SelectSQL. .Add('SELECT first 1 skip 0 FCTEL from CALLBACKA WHERE fdate>'+ot+
    //                                    ' and FTAXI='+Ftaxi+
    //                                    ' and fctel=''+380684142934'' ORDER BY FDATE DESC');
            ReklamDataSet.Active := True;

            //проверка поступления звонка
            if ReklamDataSet.FieldByName('fctel').AsString <> '+380684142932' then
              if countch = CurrTry[i] then
              // лимит попыток исчерпан то вывод сообщения
                begin
                  status := 1;
                  st := '1';
                  CurrTry[i] := 0;
                  Form2.Memo1.Lines.Insert(0, DateTimeToStr(date + Time) +
                    ': Обнаружена проблема на рекламном номере ' + ftel +
                      ', служба такси: ' + nametaxi );
                  Form2.Memo1.Lines.Insert(0, ' ');
                  Form2.Show;
                  tray.ShowBalloonHint('Внимание!', 'Обнаружена проблема на рекламном номере ' +
                    ftel + ', служба такси: ' + nametaxi, bitError, 60);
                  Memo1.Lines.Insert(0, DateTimeToStr(date + Time) +
                    ': Обнаружена проблема на рекламном номере ' + ftel +
                      ', служба такси: ' + nametaxi);
                end
              else
                begin
                // повторный дозвон
                  Client.Socket.SendText('ATD+38' + ftel + ';' + #13);
                  command.Text := 'ATD+38' + ftel + ';';
                  UTNow := DateTimeToUnixTime(Date + time) - 20; // unix time now
                  ot := IntToStr(UTNow);
                  Memo1.Lines.Insert(0, DateTimeToStr(date + Time) +
                    ': повторная попытка дозвона на ' + ftel + ', службы такси: ' + nametaxi);
                  for j := 0 to 3000 do
                    begin
                      Application.ProcessMessages;
                      Sleep(100);
                      progres.StepIt;
                      if (chec = True) then exit; // резрашить проверку
                    end;
                  progres.Position := 0;
                  inc(CurrTry[i]);
                  UTNow := DateTimeToUnixTime(Date + time) - 50; // unix time now
                  ot := IntToStr(UTNow);
    {-конец повторного дозвона-}
                end
            else
              begin
              // всё харашо с этой линией
                Memo1.Lines.Insert(0, DateTimeToStr(date + Time) + ': Рекламная линия ' +
                  ftel+', служба такси: ' + nametaxi + ' в порядке');
                CurrTry[i] := 0;
                status := 1;
                st := '0';
                UTNow := DateTimeToUnixTime(Date + time); // unix time now
              end;
          end;
          // записываем время последней удачной попытки + статус линии
          mtr.StartTransaction;
          mdataset.Active := False;
          mdataset.SQLs.SelectSQL.Clear;
          mdataset.SQLs.SelectSQL.Add('update numbers set LASTCHEC = ' + IntToStr(UTNow) +
            ', STATUS = ' + st + ' where ID = ' + ID);
          mdataset.Active := True;
          mtr.Commit;
          mdataset.Active := False;
          mdataset.SQLs.SelectSQL.Clear;
          mdataset.SQLs.SelectSQL.Add('select * from numbers order by (id)');
          mdataset.Active := True;
          mdataset.Locate('ID',ID,[]);
        end;
      PortErrorCount := 0;
      mdataset.Next;
      Cursor := crHourGlass;
      sleep(1000);
      Cursor := crDefault;
      if (chec = True) then exit; // резрашить проверку
    end;
  Memo1.Lines.SaveToFile('d:\diagnostic_logs\log.txt');
  timer.Enabled := True;
end;

// новая запись в ReklamLines.Numbers
procedure TForm1.btnAddToNumbersClick(Sender: TObject);
var
  id, lastchec : string;
begin
  mdataset.Last;
  inc(maxid);
  id := IntToStr(maxid);
  lastchec := IntToStr(DateTimeToUnixTime(Date + Time));
  mtr.StartTransaction;
  mdataset.Active := False;
  mdataset.SQLs.SelectSQL.Clear;
  mdataset.SQLs.SelectSQL.Add('insert into numbers(id,number,     ftaxi,             ' +
    'nametaxi,            lastchec,         timelimit,         countchec,         ' +
      'fdevin,              status)');
  mdataset.SQLs.SelectSQL.Add('values ('+id+','''+Number.Text+''','+Ftaxi.Text+
    ','''+FNameTaxi.Text+''','+lastchec+','+TimeLimit.Text+','+countChec.Text+','''+
    FDEVIN.Text+''','''+IntToStr(Stat.ItemIndex)+''')');
  mdataset.Active := True;
  mtr.Commit;
  mdataset.Active := False;
  mdataset.SQLs.SelectSQL.Clear;
  mdataset.SQLs.SelectSQL.Add('select * from numbers order by (id)');
  mdataset.Active := True;
  telephones.Clear;
  telephones.Text := 'Номера рекламных линий';
  mdataset.First;
  while not mdataset.Eof do
    begin
      telephones.Items.Add(mdataset.FieldByName('number').AsString);
      mdataset.Next;
    end;
end;

// удалить из ReklamLines.Numbers
procedure TForm1.btnDelFromNumbersClick(Sender: TObject);
begin
  mtr.StartTransaction;
  mdataset.Active := False;
  mdataset.SQLs.SelectSQL.Clear;
  mdataset.SQLs.SelectSQL.Add('delete from numbers where id=' + selid);
  mdataset.Active := True;
  mtr.Commit;
  mdataset.Active := False;
  mdataset.SQLs.SelectSQL.Clear;
  mdataset.SQLs.SelectSQL.Add('select * from numbers order by (id)');
  mdataset.Active := True;
  telephones.Items.Clear;
  telephones.Text := 'Номера рекламных линий';
  mdataset.First;
  while not mdataset.Eof do
    begin
      telephones.Items.Add(mdataset.FieldByName('number').AsString);
      mdataset.Next;
    end;
  mdataset.First;
end;

// занести в поля текущую запись
procedure TForm1.mGrCellClick(Column: TColumnEh);
begin
  selid := mdataset.FieldByName('id').AsString;
  Number.Text := mdataset.FieldByName('number').AsString;
  Ftaxi.Text := mdataset.FieldByName('ftaxi').AsString;
  FNameTaxi.Text := mdataset.FieldByName('nametaxi').AsString;
  TimeLimit.Text := mdataset.FieldByName('timelimit').AsString; // лимит времини в секундах
  countChec.Text := mdataset.FieldByName('countchec').AsString;
  FDEVIN.Text := mdataset.FieldByName('fdevin').AsString;
  Stat.ItemIndex := mdataset.FieldByName('status').AsInteger;
  telephones.ItemIndex := StrToInt(selid) + 1;
  telephones.Text := 'Номера рекламных линий';
end;

// занести в поля из telephonesSelect(TComboBox)
procedure TForm1.telephonesSelect(Sender: TObject);
begin
  mdataset.Locate('number',telephones.Text,[]);
  selid := mdataset.FieldByName('id').AsString;
  Number.Text := mdataset.FieldByName('number').AsString;
  Ftaxi.Text := mdataset.FieldByName('ftaxi').AsString;
  FNameTaxi.Text := mdataset.FieldByName('nametaxi').AsString;
  TimeLimit.Text := mdataset.FieldByName('timelimit').AsString; // лимит времини в секундах
  countChec.Text := mdataset.FieldByName('countchec').AsString;
end;

// внести изменения в ReklamLines.Numbers
procedure TForm1.btnUpdateNumbersClick(Sender: TObject);
begin
  mtr.StartTransaction;
  mdataset.Active := False;
  mdataset.SQLs.SelectSQL.Clear;
  mdataset.SQLs.SelectSQL.Add('update numbers set number = ''' + Number.Text +
      ''',ftaxi = ''' + Ftaxi.Text +
      ''',nametaxi = ''' + FNameTaxi.Text +
      ''',lastchec = ''' + IntToStr(DateTimeToUnixTime(Date + Time)) +
      ''',timelimit = ''' + TimeLimit.Text +
      ''',countchec = ''' + countChec.Text +
      ''',fdevin = ''' + FDEVIN.Text +
      ''',status = ''' + IntToStr(Stat.ItemIndex) +
      '''where id=' + selid);
      
  mdataset.Active := True;
  mtr.Commit;
  mdataset.Active := False;
  mdataset.SQLs.SelectSQL.Clear;
  mdataset.SQLs.SelectSQL.Add('select * from numbers order by (id)');
  mdataset.Active := True;
  telephones.ItemIndex := StrToInt(selid);
  mdataset.Locate('id', selid, []);
end;

// перезагрузить Сокет (TClientSoket)
procedure TForm1.btnReconnectMoxaClick(Sender: TObject);
begin
  Client.Active := False;
  Client.Address := ipadr.Text;
  Client.Port := StrToInt(port.Text);
  Client.Active := True;
end;

// Send Command
procedure TForm1.btnSendCmdClick(Sender: TObject);
begin
  Client.Socket.SendText(command.Text + #13);
  Cursor := crHourGlass;
  Sleep(10000);
  Cursor := crDefault;
end;

procedure TForm1.trayClick(Sender: TObject);
begin
  PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.y);
end;

// показать окно программы
procedure TForm1.mniShowProgramClick(Sender: TObject);
begin
  WindowState := wsNormal;
  Form1.Show;
end;

// выйти из программы
procedure TForm1.mniCloseProgramClick(Sender: TObject);
begin
  chec := True;
  Client.Active := False;
  Form1.Close;
end;

// вкл./ выкл. проверку доступности рекламных линий
procedure TForm1.btnEnableCheckClick(Sender: TObject);
begin         
  if btnEnableCheck.Caption <> 'Включить проверку' then
    begin
      timer.Enabled := False;
      btnEnableCheck.Caption := 'Включить проверку';
      chec := True;
      Memo1.Lines.Insert(0,DateTimeToStr(date + Time)+': Отключение проверки' );
      stopID := mdataset.FieldByName('ID').AsString;
      progres.Position := 0;
    end
  else
    begin
      timer.Enabled := True;
      btnEnableCheck.Caption := 'Отключить проверку';
      chec := False;
      Memo1.Lines.Insert(0, DateTimeToStr(date + Time) + ': Включение проверки');
      PortErrorCount := 0;
      mdataset.Locate('ID', stopID, []);
    end;  
end;

// показать окно программы
procedure TForm1.mniShowErrorsClick(Sender: TObject);
begin
  Form2.Show
end;

// поиск по номеру телефона
procedure TForm1.telephonesChange(Sender: TObject);
begin
  mdataset.Active := False;
  mdataset.SQLs.SelectSQL.Clear;
  mdataset.SQLs.SelectSQL.Add('select * from numbers where number like ''%' +
    telephones.Text + '%'' order by (id)');
  mdataset.Active := True;
end;

// скрыть окно программы
procedure TForm1.FormDblClick(Sender: TObject);
begin
  Hide
end;

// поиск по названию службы
procedure TForm1.FNameTaxiKeyPress(Sender: TObject; var Key: Char);
begin
  if (key <> #8) and (Length(FNameTaxi.Text) >= 25) then
    key := #0;
  mdataset.Active := False;
  mdataset.SQLs.SelectSQL.Clear;
  mdataset.SQLs.SelectSQL.Add('select * from numbers where nametaxi like ''%' +
    FNameTaxi.Text + '%'' order by (id)');
  mdataset.Active := True;
end;

// обновить время
procedure TForm1.workTimer(Sender: TObject);
var
  t : integer;
begin
  t := (DateTimeToUnixTime(date + time) - unt);
  StatusBar1.Panels[3].Text := TimeToStr(UnixTimeToDateTime(t));
end;

procedure TForm1.FNameTaxiClick(Sender: TObject);
begin
  if FNameTaxi.Text = 'название' then FNameTaxi.Clear;
end;

end.

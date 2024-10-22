unit Camera;

interface

type camera_ = class (TObject)
    private
      WagsLenght: array[0..100] of Double;
      lastWagShadowOff: array[0..5] of Byte;
      ExtraCodeZDS: array[0..16] of Byte;

      procedure checkButtons();
      procedure writeMemory();
      procedure reset();
      procedure Initialize();
      procedure WagsLenghtForm();

    protected

    public
      Initialized: Boolean;
      SelectedWagon: Integer;
      PrevSelectedWagon: Integer;
      isCon: Boolean;

      procedure step();

    published

    constructor Create;
   end;

implementation

   uses UnitMain, soundManager, Bass, SysUtils, Math, Windows, RAMMemModule;

   var
     pressed: Boolean;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   constructor Camera_.Create;
   begin
      Initialized := False;
      pressed := False;
      SelectedWagon := WagsNum;

      lastWagShadowOff[0] := 233;
      lastWagShadowOff[1] := 201;
      lastWagShadowOff[2] := 156;
      lastWagShadowOff[3] := 247;
      lastWagShadowOff[4] := 255;
      lastWagShadowOff[5] := 144;

      // jb 0048A6CA
      ExtraCodeZDS[0] := 15;
      ExtraCodeZDS[1] := 130;
      ExtraCodeZDS[2] := 56;
      ExtraCodeZDS[3] := 99;
      ExtraCodeZDS[4] := 8;
      ExtraCodeZDS[5] := 0;
      // fsub dword ptr[0048A818]
      ExtraCodeZDS[6] := 216;
      ExtraCodeZDS[7] := 37;
      ExtraCodeZDS[8] := 24;
      ExtraCodeZDS[9] := 168;
      ExtraCodeZDS[10] := 72;
      ExtraCodeZDS[11] := 0;
      // jmp 0048A6C3
      ExtraCodeZDS[12] := 233;
      ExtraCodeZDS[13] := 38;
      ExtraCodeZDS[14] := 99;
      ExtraCodeZDS[15] := 8;
      ExtraCodeZDS[16] := 0;
   end;

   // ----------------------------------------------------
   //  ��������� ������������� ������
   // ----------------------------------------------------
   procedure Camera_.Initialize();
   var
     addr_wagCell: PByte;
     addr_lastWag: PByte;
     I: Integer;
     LenSt: Byte;
   begin
      // �������� ��� ������ ������ ������� ������ � �������
      for I := 0 to 100 do begin
         WagsLenght[I] := 0.0;
      end;

      if Pos('.con', ConName) > 0 then isCon := True else isCon := False;

      // �������� ����� �������� ZDSimulator
      UnitMain.tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
      UnitMain.pHandle := OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcessID);

      if (isCon = False) And (WagsNum = WagonsAmount) then begin
         // ���� ������ � ������� �� *.con - �� ������ ���������� ��������� �����
         // ���� ���������� ������� �� ��� = ���������� ������� �� settings.ini
         Inc(WagsNum);
         WriteProcessMemory(UnitMain.pHandle, ADDR_WAGS_NUM, @WagsNum, 4, temp);
      end;

      // �������� ��������� ����� ��������� ��� ����������?
      addr_wagCell := ADDR_CAMERA_LAST_WAGON_OFFSET;
      I:=144*WagsNum-135;
      Inc(addr_wagCell, I);
      try ReadProcessMemory(UnitMain.pHandle, addr_wagCell, @LenSt, 1, temp); except end;


      if LenSt > 1 then begin
         // ���� ��������� ����� ���������
         // �� ������ "����������" �����
         Inc(WagsNum);
         WriteProcessMemory(UnitMain.pHandle, ADDR_WAGS_NUM, @WagsNum, 4, temp);
      end else begin
         WriteProcessMemory(UnitMain.pHandle, ADDR_EXTRA_CODE_ZDS1, @ExtraCodeZDS, sizeof(ExtraCodeZDS), temp);
         WriteProcessMemory(UnitMain.pHandle, ADDR_LAST_WAGON_SHADOW_OFF, @lastWagShadowOff, sizeof(lastWagShadowOff), temp);

         // ���� ��������� ����� ����������
         // �� ����� ��������
         try
            WagsLenghtForm(); // �������� ����� ������ ������ �� ���
         except
            UnitMain.Log_.DebugWriteErrorToErrorList('Camera.Initialization procedure WagsLenghtForm() - fatal error');
         end;

         // ������ ����� "�����������" ������ - ������� ����������
         // ���������� ������ �� ������ �����
         CameraLastWagonOffset := 0-WagsLenght[WagsNum-2];

         // � ������ ������ ����� "����������� ������"
         writeMemory();
         
         SelectedWagon := WagsNum-1; // ��������� ����� - ���������

         //addr_lastWag := ADDR_LAST_WAGON_SHADOW_OFF;
         //for I := 0 to 5 do begin

            //Inc(addr_lastWag, 1);
         //end;

         Initialized := True; // ������������� ���������
      end;

      try CloseHandle(UnitMain.pHandle); except end;
   end;

   // ----------------------------------------------------
   //  �������� ����� ������� ������ ������� �� ���
   // ----------------------------------------------------
   procedure Camera_.WagsLenghtForm();
   var
     addr_wagCell: PByte;
     I: Integer;
     db: double;
     startIndex: Integer;
   begin
      startIndex := 0;

      // �������� ����� �������� ZDSimulator
      UnitMain.tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
      UnitMain.pHandle := OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcessID);

      addr_wagCell := ADDR_CAMERA_LAST_WAGON_OFFSET;

      if LocoSectionsNum = 2 then begin
         WagsLenght[0] := UnitMain.LocoLength; // ������ ������ ����������
         startIndex := 1;
      end;
      
      for I := startIndex to WagsNum-1 do begin
         try ReadProcessMemory(UnitMain.pHandle, addr_wagCell, @db, 8, temp); except end;
         WagsLenght[I] := db;
         UnitMain.Log_.DebugWriteErrorToErrorList('Camera.Initialization procedure WagsLenghtForm() - wag #' + IntToStr(I+1) + ' len - ' + FloatToStr(db) + 'm');
         // ��� ������� ������ � ��� x0090[hex]
         // 0144 [dec]
         Inc(addr_wagCell, 144);
      end;

      try CloseHandle(UnitMain.pHandle); except end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure Camera_.step();
   begin
      if track > 1 then begin // �������� ��������� ��������� ZDSimulator???
         if Initialized = False then begin
            Initialize(); // ���� �� ���� ������������� - ������ ��
         end else begin
            if UnitMain.Camera = 2 then begin
               checkButtons();
            end else begin
               reset();
            end;
         end;
      end;
   end;

   // ----------------------------------------------------
   //  CTRL + �����/������
   // ----------------------------------------------------
   procedure Camera_.checkButtons();
   begin
      writeMemory();
      // ������� CTRL
      if (GetAsyncKeyState(17) <> 0) then begin
         // ������� - ������ �����
         if (GetAsyncKeyState(37) <> 0) And (Pressed = False) then begin
            Dec(SelectedWagon); // ��������� ����� ����� (-) 1
            if SelectedWagon < -(LocoSectionsNum)+2 then SelectedWagon := -(LocoSectionsNum)+2;

            // ����� ���������� �������� ������ �����
            if SelectedWagon <> PrevSelectedWagon then
               CameraLastWagonOffset := CameraLastWagonOffset - (WagsLenght[SelectedWagon]+WagsLenght[SelectedWagon+1]);
            pressed := True;
         end;

         // ������� - ������ ������
         if (GetAsyncKeyState(39) <> 0) And (Pressed = False) then begin
            Inc(SelectedWagon);
            if SelectedWagon > WagsNum-1 then SelectedWagon := WagsNum-1;

            if SelectedWagon <> PrevSelectedWagon then
               CameraLastWagonOffset := CameraLastWagonOffset + (WagsLenght[SelectedWagon-1]+WagsLenght[SelectedWagon]);
            Pressed := True;
         end;
      end;

      if (GetAsyncKeyState(37) = 0) And (GetAsyncKeyState(39) = 0) then begin
         pressed := False;
      end;

      PrevSelectedWagon := SelectedWagon;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure Camera_.writeMemory();
   var
     addr_wagCell: PByte;
     I: Integer;
   begin
      // �������� ����� �������� ZDSimulator
      UnitMain.tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
      UnitMain.pHandle := OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcessID);

      addr_wagCell := ADDR_CAMERA_LAST_WAGON_OFFSET;
      I:=144*WagsNum-144;
      Inc(addr_wagCell, I);

      WriteProcessMemory(UnitMain.pHandle, addr_wagCell, @CameraLastWagonOffset, 8, temp);

      try CloseHandle(UnitMain.pHandle); except end;
   end;

   // ----------------------------------------------------
   //
   // ----------------------------------------------------
   procedure Camera_.reset();
   var
     addr_wagCell: PByte;
     I: Integer;
     db: Double;
   begin
      // �������� ����� �������� ZDSimulator
      UnitMain.tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
      UnitMain.pHandle := OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcessID);

      addr_wagCell := ADDR_CAMERA_LAST_WAGON_OFFSET;
      I:=144*WagsNum-144;
      Inc(addr_wagCell, I);

      db := 0;

      WriteProcessMemory(UnitMain.pHandle, addr_wagCell, @db, 8, temp);

      try CloseHandle(UnitMain.pHandle); except end;
   end;

end.


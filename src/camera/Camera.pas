unit Camera;

interface

type camera_ = class (TObject)
    private
      WagsLenght: array[0..100] of Double;

      procedure checkButtons();
      procedure writeMemory();
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
   end;

   // ----------------------------------------------------
   //  Начальная инициализация камеры
   // ----------------------------------------------------
   procedure Camera_.Initialize();
   var
     addr_wagCell: PByte;
     I: Integer;
     LenSt: Byte;
   begin
      // Обнуляем все ячейки длинны каждого вагона в составе
      for I := 0 to 100 do begin
         WagsLenght[I] := 0.0;
      end;

      if Pos('.con', ConName) > 0 then isCon := True else isCon := False;

      // Получаем адрес процесса ZDSimulator
      UnitMain.tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
      UnitMain.pHandle := OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcessID);

      // Проверка последний вагон настоящий или фикционный?
      addr_wagCell := ADDR_CAMERA_LAST_WAGON_OFFSET;
      I:=144*WagsNum-135;
      Inc(addr_wagCell, I);
      try ReadProcessMemory(UnitMain.pHandle, addr_wagCell, @LenSt, 1, temp); except end;


      if LenSt > 1 then begin
         // Если последний вагон настоящий
         // То делаем "фикционный" вагон
         Inc(WagsNum);
         WriteProcessMemory(UnitMain.pHandle, ADDR_WAGS_NUM, @WagsNum, 4, temp);
      end else begin
         // Если последний вагон фикционный
         // То можно работать
         WagsLenghtForm(); // Получаем длину КАЖОГО вагона из ОЗУ

         addr_wagCell := ADDR_CAMERA_LAST_WAGON_OFFSET;
         I:=144*WagsNum-56;
         Inc(addr_wagCell, I);
         //try ReadProcessMemory(UnitMain.pHandle, addr_wagCell, @LenSt, 1, temp); except end;

         //Inc(addr_wagCell, 79);
         LenSt := 50;
         WriteProcessMemory(UnitMain.pHandle, addr_wagCell, @LenSt, 1, temp);

         // Задаем длину "фикционного" вагона - длинной настоящего
         // последнего вагона со знаком минус
         CameraLastWagonOffset := 0-WagsLenght[WagsNum-2];

         // И делаем запись длины "фикционного вагона"
         writeMemory();
         
         SelectedWagon := WagsNum-1; // Выбранный вагон - последний
         Initialized := True; // Инициализация завершена
      end;

      try CloseHandle(UnitMain.pHandle); except end;
   end;

   // ----------------------------------------------------
   //  Получаем длину КАЖДОГО вагона состава из ОЗУ
   // ----------------------------------------------------
   procedure Camera_.WagsLenghtForm();
   var
     addr_wagCell: PByte;
     I: Integer;
     db: double;
   begin
      // Получаем адрес процесса ZDSimulator
      UnitMain.tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
      UnitMain.pHandle := OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcessID);

      addr_wagCell := ADDR_CAMERA_LAST_WAGON_OFFSET;

      for I := 0 to WagsNum-1 do begin
         try ReadProcessMemory(UnitMain.pHandle, addr_wagCell, @db, 8, temp); except end;
         WagsLenght[I] := db;
         // Шаг каждого вагона в ОЗУ x0090[hex]
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
      if track > 1 then begin // Проверка полностью запустиля ZDSimulator???
         if Initialized = False then begin
            Initialize(); // Если не было инициализации - делаем ее
         end else begin
            if UnitMain.Camera = 2 then begin
               checkButtons();
            end;
         end;
      end;
   end;

   // ----------------------------------------------------
   //  CTRL + влево/вправо
   // ----------------------------------------------------
   procedure Camera_.checkButtons();
   begin
      // Клавиша CTRL
      if (GetAsyncKeyState(17) <> 0) then begin
         // Клавиша - курсор влево
         if (GetAsyncKeyState(37) <> 0) And (Pressed = False) then begin
            Dec(SelectedWagon); // Выбранный вагон минус (-) 1
            if SelectedWagon < 1 then SelectedWagon := 1;

            // Здесь собственно смещение камеры влево
            if SelectedWagon <> PrevSelectedWagon then
               CameraLastWagonOffset := CameraLastWagonOffset - WagsLenght[SelectedWagon]*2;
            writeMemory();
            pressed := True;
         end;

         // Клавиша - курсор вправо
         if (GetAsyncKeyState(39) <> 0) And (Pressed = False) then begin
            Inc(SelectedWagon);
            if SelectedWagon > WagsNum-1 then SelectedWagon := WagsNum-1;

            if SelectedWagon <> PrevSelectedWagon then
               CameraLastWagonOffset := CameraLastWagonOffset + WagsLenght[SelectedWagon-1]*2;
            writeMemory();
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
      // Получаем адрес процесса ZDSimulator
      UnitMain.tHandle := GetWindowThreadProcessId(wHandle, @ProcessID);
      UnitMain.pHandle := OpenProcess(PROCESS_ALL_ACCESS, FALSE, ProcessID);

      addr_wagCell := ADDR_CAMERA_LAST_WAGON_OFFSET;
      I:=144*WagsNum-144;
      Inc(addr_wagCell, I);

      WriteProcessMemory(UnitMain.pHandle, addr_wagCell, @CameraLastWagonOffset, 8, temp);

      try CloseHandle(UnitMain.pHandle); except end;
   end;

end.


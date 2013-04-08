unit mdf_ConvertStorage;

interface

uses
  IBDatabase, gdModify;

procedure ConvertStorage(IBDB: TIBDatabase; Log: TModifyLog);

implementation

uses
  Classes, DB, IBSQL, IBBlob, SysUtils, mdf_MetaData_unit, gsStorage,
  gdcLBRBTreeMetaData, gdcStorage_Types;

const
  cCreateDomain =
    'CREATE DOMAIN dstorage_data_type AS CHAR(1) NOT NULL                                 '#13#10 +
    '  CHECK(VALUE IN (                                                                   '#13#10 +
    '    ''G'',   /* ������ ����������� ���������                                      */ '#13#10 +
    '    ''U'',   /* ������ ����������������� ���������, int_data -- ���� ������������ */ '#13#10 +
    '    ''O'',   /* ������ ��������� ��������, int_data -- ���� ��������              */ '#13#10 +
    '    ''T'',   /* ������ ��������� �.�����, int_data -- ���� �.�����                */ '#13#10 +
    '    ''F'',   /* �����                                                             */ '#13#10 +
    '    ''S'',   /* ������                                                            */ '#13#10 +
    '    ''I'',   /* ����� �����                                                       */ '#13#10 +
    '    ''C'',   /* ������� �����                                                     */ '#13#10 +
    '    ''L'',   /* ��������� ���                                                     */ '#13#10 +
    '    ''D'',   /* ���� � �����                                                      */ '#13#10 +
    '    ''B''    /* �������� ������                                                   */ '#13#10 +
    '  )) ';

  cCreateTable =
    'CREATE TABLE gd_storage_data ( '#13#10 +
    '  id             dintkey, '#13#10 +
    '  lb             dlb, '#13#10 +
    '  rb             drb, '#13#10 +
    '  parent         dparent, '#13#10 +
    '  name           dtext120 NOT NULL, '#13#10 +
    '  data_type      dstorage_data_type, '#13#10 +
    '  str_data       dtext120, '#13#10 +
    '  int_data       dinteger, '#13#10 +
    '  datetime_data  dtimestamp, '#13#10 +
    '  curr_data      dcurrency, '#13#10 +
    '  blob_data      dblob4096, '#13#10 +
    ' '#13#10 +
    '  CONSTRAINT gd_pk_storage_data_id PRIMARY KEY (id), '#13#10 +
    '  CONSTRAINT gd_fk_storage_data_parent FOREIGN KEY (parent) '#13#10 +
    '    REFERENCES gd_storage_data (id) '#13#10 +
    '    ON UPDATE CASCADE '#13#10 +
    '    ON DELETE CASCADE, '#13#10 +
    '  CHECK ((NOT parent IS NULL) OR (data_type IN (''G'', ''U'', ''O'', ''T''))) '#13#10 +
    ') ';

  cCreateException =
    'CREATE EXCEPTION gd_e_storage_data ''''';

  cCreateTrigger =
    'CREATE TRIGGER gd_biu_storage_data FOR gd_storage_data'#13#10 +
    '  BEFORE INSERT OR UPDATE'#13#10 +
    '  POSITION 0'#13#10 +
    'AS'#13#10 +
    '  DECLARE VARIABLE FID INTEGER = -1;'#13#10 +
    'BEGIN'#13#10 +
    '  IF (NEW.ID IS NULL) THEN'#13#10 +
    '    NEW.ID = GEN_ID(gd_g_unique, 1) + GEN_ID(gd_g_offset, 0);'#13#10 +
    ''#13#10 +
    '  IF (NEW.data_type IN (''G'', ''U'', ''O'', ''T'')) THEN'#13#10 +
    '  BEGIN'#13#10 +
    '    NEW.parent = NULL;'#13#10 +
    '  END'#13#10 +
    ''#13#10 +
    '  IF (NEW.data_type IN (''G'', ''F'')) THEN'#13#10 +
    '  BEGIN'#13#10 +
    '    NEW.int_data = NULL;'#13#10 +
    '  END'#13#10 +
    ''#13#10 +
    '  IF (NEW.data_type IN (''G'', ''U'', ''O'', ''T'', ''F'')) THEN'#13#10 +
    '  BEGIN'#13#10 +
    '    NEW.str_data = NULL;'#13#10 +
    '    NEW.curr_data = NULL;'#13#10 +
    '    NEW.datetime_data = NULL;'#13#10 +
    '    NEW.blob_data = NULL;'#13#10 +
    '  END'#13#10 +
    ''#13#10 +
    '  IF (NEW.data_type = ''S'') THEN'#13#10 +
    '  BEGIN'#13#10 +
    '    NEW.curr_data = NULL;'#13#10 +
    '    NEW.datetime_data = NULL;'#13#10 +
    '    NEW.blob_data = NULL;'#13#10 +
    '    NEW.int_data = NULL;'#13#10 +
    '    NEW.str_data = COALESCE(NEW.str_data, '''');'#13#10 +
    '  END'#13#10 +
    ''#13#10 +
    '  IF (NEW.data_type IN (''I'', ''L'')) THEN'#13#10 +
    '  BEGIN'#13#10 +
    '    NEW.str_data = NULL;'#13#10 +
    '    NEW.curr_data = NULL;'#13#10 +
    '    NEW.datetime_data = NULL;'#13#10 +
    '    NEW.blob_data = NULL;'#13#10 +
    '    NEW.int_data = COALESCE(NEW.int_data, 0);'#13#10 +
    '  END'#13#10 +
    ''#13#10 +
    '  IF (NEW.data_type = ''C'') THEN'#13#10 +
    '  BEGIN'#13#10 +
    '    NEW.str_data = NULL;'#13#10 +
    '    NEW.datetime_data = NULL;'#13#10 +
    '    NEW.blob_data = NULL;'#13#10 +
    '    NEW.int_data = NULL;'#13#10 +
    '    NEW.curr_data = COALESCE(NEW.curr_data, 0);'#13#10 +
    '  END'#13#10 +
    ''#13#10 +
    '  IF (NEW.data_type = ''D'') THEN'#13#10 +
    '  BEGIN'#13#10 +
    '    NEW.str_data = NULL;'#13#10 +
    '    NEW.curr_data = NULL;'#13#10 +
    '    NEW.blob_data = NULL;'#13#10 +
    '    NEW.int_data = NULL;'#13#10 +
    '    NEW.datetime_data = COALESCE(NEW.datetime_data, CURRENT_TIMESTAMP);'#13#10 +
    '  END'#13#10 +
    ''#13#10 +
    '  IF (NEW.data_type = ''B'') THEN'#13#10 +
    '  BEGIN'#13#10 +
    '    NEW.str_data = NULL;'#13#10 +
    '    NEW.curr_data = NULL;'#13#10 +
    '    NEW.datetime_data = NULL;'#13#10 +
    '    NEW.int_data = NULL;'#13#10 +
    '  END'#13#10 +
    ''#13#10 +
    '  IF (NEW.parent IS NULL) THEN'#13#10 +
    '  BEGIN'#13#10 +
    '    FOR'#13#10 +
    '      SELECT id FROM gd_storage_data WHERE parent IS NULL'#13#10 +
    '        AND data_type = NEW.data_type AND int_data IS NOT DISTINCT FROM NEW.int_data'#13#10 +
    '        AND id <> NEW.id'#13#10 +
    '      INTO :FID'#13#10 +
    '    DO'#13#10 +
    '      EXCEPTION gd_e_storage_data ''Root already exists. ID='' || :FID;'#13#10 +
    '  END ELSE'#13#10 +
    '  BEGIN'#13#10 +
    '    FOR'#13#10 +
    '      SELECT id FROM gd_storage_data WHERE parent = NEW.parent'#13#10 +
    '        AND UPPER(name) = UPPER(NEW.name) AND id <> NEW.id'#13#10 +
    '      INTO :FID'#13#10 +
    '    DO'#13#10 +
    '      EXCEPTION gd_e_storage_data ''Duplicate name. ID='' || :FID;'#13#10 +
    '  END'#13#10 +
    'END';

procedure ConvertStorage(IBDB: TIBDatabase; Log: TModifyLog);
var
  FTransaction: TIBTransaction;
  FIBSQL: TIBSQL;

  procedure ConvertStorage(const AnSQL: String; const ARootType: Char);
  var
    S: TgsIBStorage;
    bs: TIBBlobStream;
    F: TgsStorageFolder;
    EmptyStorage: Boolean;
  begin
    FIBSQL.Close;
    FIBSQL.SQL.Text := AnSQL;
    FIBSQL.ExecQuery;

    while not FIBSQL.EOF do
    begin
      case ARootType of
        cStorageGlobal: S := TgsGlobalStorage.Create;
        cStorageUser: S := TgsUserStorage.Create;
        cStorageCompany: S := TgsCompanyStorage.Create;
        cStorageDesktop: S := TgsDesktopStorage.Create;
      else
        raise Exception.Create('Invalid storage root');
      end;

      try
        if FIBSQL.FieldByName('akey').AsInteger > -1 then
          S.ObjectKey := FIBSQL.FieldByName('akey').AsInteger
        else
          S.LoadFromDatabase;

        F := S.OpenFolder('', False, False);
        try
          EmptyStorage := (F.FoldersCount = 0) and (F.ValuesCount = 0);
        finally
          S.CloseFolder(F, False);
        end;

        if not EmptyStorage then
        begin
          Log('��������� ' + FIBSQL.FieldByName('name').AsString +
            ' ��� ���� ��������������� �/��� �������� ������.'#13#10 +
            '��������� ����������� ������������� �� �����!');
        end else
        begin
          bs := TIBBlobStream.Create;
          try
            bs.Mode := bmRead;
            bs.Database := IBDB;
            bs.Transaction := FTransaction;
            bs.BlobID := FIBSQL.FieldByName('data').AsQuad;
            try
              S.LoadFromStream(bs);
            except
              on E: Exception do
              begin
                Log('������ ��� ���������� �� ������ ��������� ' + FIBSQL.FieldByName('name').AsString +
                  '.'#13#10'���������: ' + E.Message);
                FreeAndNil(S);
              end;
            end;
          finally
            bs.Free;
          end;

          if S <> nil then
          begin
            Log('����������� ��������� ' + FIBSQL.FieldByName('name').AsString + '...');
            S.SaveToDatabase(FTransaction);
          end;
        end;
      finally
        S.Free;
      end;

      FIBSQL.Next;
    end;
  end;

var
  SL: TStringList;
  I: Integer;
  FNeedToCreateMeta: Boolean;
begin
  FNeedToCreateMeta := False;
  FTransaction := TIBTransaction.Create(nil);
  try
    FTransaction.DefaultDatabase := IBDB;
    try
      FIBSQL := TIBSQL.Create(nil);
      try
        FTransaction.StartTransaction;

        FIBSQL.Transaction := FTransaction;
        FIBSQL.ParamCheck := False;

        FIBSQL.SQL.Text := 'SELECT * FROM rdb$fields WHERE rdb$field_name = ''DSTORAGE_DATA_TYPE'' ';
        FIBSQL.ExecQuery;
        if FIBSQL.EOF then
        begin
          FIBSQL.Close;
          FIBSQL.SQL.Text := cCreateDomain;
          FIBSQL.ExecQuery;
        end;

        FIBSQL.Close;
        FIBSQL.SQL.Text := 'SELECT * FROM rdb$exceptions WHERE rdb$exception_name = ''GD_E_STORAGE_DATA'' ';
        FIBSQL.ExecQuery;
        if FIBSQL.EOF then
        begin
          FIBSQL.Close;
          FIBSQL.SQL.Text := cCreateException;
          FIBSQL.ExecQuery;
        end;

        FIBSQL.Close;
        FIBSQL.SQL.Text := 'SELECT * FROM rdb$relations WHERE rdb$relation_name = ''GD_STORAGE_DATA'' ';
        FIBSQL.ExecQuery;
        if FIBSQL.EOF then
        begin
          FIBSQL.Close;
          FIBSQL.SQL.Text := cCreateTable;
          FIBSQL.ExecQuery;

          FNeedToCreateMeta := True;
        end;

        FIBSQL.Close;
        FTransaction.Commit;
        FTransaction.StartTransaction;

        ConvertStorage(
          'SELECT -1           AS AKey,     data, ''GLOBAL'' AS Name FROM gd_globalstorage', 'G');
        ConvertStorage(
          'SELECT s.userkey    AS AKey,   s.data,             u.name FROM gd_userstorage s JOIN gd_user u ON u.id = s.userkey', 'U');
        ConvertStorage(
          'SELECT s.companykey AS AKey,   s.data,             c.name FROM gd_companystorage s JOIN gd_contact c ON c.id = s.companykey', 'O');
        ConvertStorage(
          'SELECT d.id         AS AKey, d.dtdata AS data, d.name || '' ('' || u.name || '')'' AS name FROM gd_desktop d JOIN gd_user u ON u.id = d.userkey', 'T');

        if FNeedToCreateMeta then
        begin
          FIBSQL.Close;

          FTransaction.Commit;
          FTransaction.StartTransaction;

          SL := TStringList.Create;
          try
            CreateLBRBTreeMetaDataScript(SL, 'GD', 'STORAGE_DATA', 'GD_STORAGE_DATA');
            for I := 0 to 2 do
            begin
              FIBSQL.Close;
              FIBSQL.SQL.Text := SL[I];
              FIBSQL.ExecQuery;
            end;

            FIBSQL.Close;

            FTransaction.Commit;
            FTransaction.StartTransaction;

            FIBSQL.SQL.Text := 'EXECUTE PROCEDURE GD_P_RESTRUCT_STORAGE_DATA';
            FIBSQL.ExecQuery;

            for I := 3 to SL.Count - 1 do
            begin
              FIBSQL.Close;
              FIBSQL.SQL.Text := SL[I];
              FIBSQL.ExecQuery;
            end;
          finally
            SL.Free;
          end;

          FIBSQL.Close;
          FIBSQL.SQL.Text := cCreateTrigger;
          FIBSQL.ExecQuery;
        end;

        FIBSQL.Close;
        FIBSQL.SQL.Text :=
          'INSERT INTO fin_versioninfo ' +
          '  VALUES (114, ''0000.0001.0000.0145'', ''25.09.2009'', ''Storage being converted into new data structures'')';
        try
          FIBSQL.ExecQuery;
        except
        end;

        FTransaction.Commit;
      finally
        FIBSQL.Free;
      end;
    except
      on E: Exception do
      begin
        Log('��������� ������: ' + E.Message);
        if FTransaction.InTransaction then
          FTransaction.Rollback;
        raise;
      end;
    end;
  finally
    FTransaction.Free;
  end;
end;

end.
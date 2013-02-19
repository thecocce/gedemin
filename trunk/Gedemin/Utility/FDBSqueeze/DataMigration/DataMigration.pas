unit DataMigration;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Edit2: TEdit;

    Database: TIBDatabase;
    DatabaseInfo: TIBDatabaseInfo;
    ReadTransaction: TIBTransaction;
    WriteTransaction: TIBTransaction;
    DatabaseName: String;
    //DatabaseOriginalName: String;
     DatabaseCopyName: String;
  //  DatabaseBackupName: String;
     ConnectionInformation: TgsConnectionInformation;


    IBSQLRead: TIBSQL;
    IBSQLWrite: TIBSQL;

    M, M2: TgsHugeIntSet;
    SIZE_SET: Integer;          /// ������� const !

    ActivTriggersList: TStringList    // ������ ���� �������� ���������
    ActivIndicesList: TStringList     // ������ ���� �������� ��������

    //�����������, ��� �������� ������������� �� ���� ������� ��������������
    ConstrTypeList, ConstrNameList, ConstrIndexNameList, ConstrRelationNameList: TStringList;

    constructor Create;
    destructor Destroy;

    //�����������
    procedure Button1Click(Sender: TObject);

     // ����������� � ��
    procedure Connect;
    // ���������� �� ��
    procedure Disconnect;
    //
    procedure triggersSwitch(disableFlag: integer, Triggers: TStringList, IBSQL: TIBSQL);
    procedure indicesSwitch(disableFlag: integer, Indices: TStringList, IBSQL: TIBSQL)

    property Database: TIBDatabase read Database;
    property DatabaseName: String read GetDatabaseName write SetDatabaseName;
   // property DatabaseOriginalName: String read DatabaseOriginalName write DatabaseOriginalName;
   // property DatabaseCopyName: String read DatabaseCopyName write DatabaseCopyName;

    property DatabaseInfo: TIBDatabaseInfo read DatabaseInfo;

  end;
var
  Form1: TForm1;

  implementation
{$R *.DFM}

//===============================================
constructor Create;
begin
 // �������� ������� ���� ������, � ���������� � �� � ������ ��
  Database := TIBDatabase.Create(nil);
  DatabaseInfo := TIBDatabaseInfo.Create(nil);
  DatabaseInfo.Database := Database;
  // �������� ����������
  ReadTransaction := TIBTransaction.Create(nil);
  ReadTransaction.DefaultDatabase := Database;
 // ReadTransaction.Params.Text := 'read_committed'#13#10'rec_version'#13#10'nowait'#13#10'read'#13#10;
 // ReadTransaction.AutoStopAction := saNone;
  // ��������� �������� ����������, ��� ���������� �� ��������� ��� ��
  Database.DefaultTransaction := ReadTransaction;
  // ���������� �� ������ �� ���������
  WriteTransaction := TIBTransaction.Create(nil);
  WriteTransaction.DefaultDatabase := Database;

  DatabaseCopyName := '';


  // �, �2

   M := TgsHugeIntSet.Create;
   M2 := TgsHugeIntSet.Create;

   IBSQLRead.SQL.Text := ' SELECT GEN_ID(gd_g_unique, 1) as ID_UNIQUE ' +
     ' FROM RDB$DATABASE ';
   try
     IBSQLRead.ExecQuery;
	 SIZE_SET := IBSQLRead.FieldByName('ID_UNIQUE').AsInteger - 147000000;    

	 M.Include(SIZE_SET); 
	 M2.Include(SIZE_SET);
   finally
     IBSQLRead.Close;
   end;





end;
//================================================
destructor Destroy;
begin
  inherited;

  if Assigned(WriteTransaction) and WriteTransaction.InTransaction then
    WriteTransaction.Commit;
  FreeAndNil(WriteTransaction);
  if Assigned(ReadTransaction) and ReadTransaction.InTransaction then
    ReadTransaction.Commit;
  FreeAndNil(ReadTransaction);
  FreeAndNil(DatabaseInfo);
  FreeAndNil(Database);
end;


//===============================================  ���������� ����������� �����
procedure Button1Click(Sender: TObject);
const
  BUFFER_SIZE = 10240;
  FromPath: String = 'C:\Users\mk\Desktop\test\test.txt';
var
  Buffer: array[0..BUFFER_SIZE - 1] of byte;
  NumRead: Integer;
  FromFile, ToFile: TFileStream;
  ToPath: string;
begin
 // FromPath := Edit1.Text
  ToPath := Edit2.Text;
  if FileExists(FromPath) then
  begin
    FromFile := TFileStream.Create(FromPath, fmOpenRead or fmShareDenyNone);
    try
      if FileExists(ToPath) then
        ToFile := TFileStream.Create(ToPath, fmOpenWrite or fmShareDenyWrite);
      else
        ToFile := TFileStream.Create(ToPath, fmCreate);
      try
        ToFile.Size := FromFile.Size; //?????????
        ToFile.Position := 0;
        FromFile.Position := 0;
        NumRead := FromFile.Read(Buffer[0], BUFFER_SIZE);
        while NumRead > 0 do
        begin
          ToFile.Write(Buffer[0], NumRead);
          NumRead := FromFile.Read(Buffer[0], BUFFER_SIZE);
        end;
      finally
        FreeAndNil(ToFile);
      end;
    finally
      FreeAndNil(FromFile);       //Stream.Free
    end;
   end;
end;

//=========================================== ������� �� ���������! ��������� ���
   //================================ ��������

//������ ���� �������� ���������
//var ActivTriggersList: TStringList             /// ���������� �������


IBSQLRead.SQL.Text := ' SELECT g.Rdb$trigger_name AS trigger_name ' +
  ' FROM Rdb$triggers g ' +
  ' WHERE rdb$trigger_inactive = 0 ';
try
	 IBSQLRead.ExecQuery;
	 if IBSQLRead.RecordCount > 0 then
     begin
	   ActivTriggersList:= TStringList.Create;

	   while not IBSQLRead.Eof do
       begin
		 ActivTriggersList.Add(IBSQLRead.FieldByName('trigger_name').AsString);
		 IBSQLRead.Next;
	   end;
finally
     IBSQLRead.Close;
end;
// triggersSwitch(1, ActivTriggersList, IBSQLWrite);  //�������� ��������






//1-���������, 0-��������
procedure triggersSwitch(disableFlag: integer, Triggers: TStringList, IBSQL: TIBSQL);
var i: integer;
begin
  IBSQL.Close;
  for i:=0 to Triggers.Count-1 do
  begin
    IBSQL.ParamCheck := True;
    IBSQL.SQL.Text := ' UPDATE rdb$triggers ' + 
      ' SET rdb$trigger_inactive = :disableFlag ' +
      ' WHERE rdb$trigger_name = :trig_name ';
    IBSQL.Prepare;
    try
      IBSQL.ExecQuery;
	  IBSQL.ParamByName('disableFlag').AsInteger := disableFlag;
	  IBSQL.ParamByName('trig_name').AsString := Triggers[i];
	finally
      IBSQL.Close;
    end;
end;

//================================ �������
//������ ���� �������� ��������
//var ActivIndicesList: TStringList             /// ���������� �������


IBSQL.SQL.Text := ' SELECT I.RDB$INDEX_NAME AS index_name ' +
  ' FROM RDB$INDICES I ' +
  ' WHERE I.RDB$INDEX_INACTIVE = 0 ';
try
	 IBSQLRead.ExecQuery;
	 if IBSQLRead.RecordCount > 0 then
     begin
	   ActivIndicesList:= TStringList.Create;

	   while not IBSQLRead.Eof do
       begin
		 ActivIndicesList.Add(IBSQLRead.FieldByName('index_name').AsString);
		 IBSQLRead.Next;
	   end;
   finally
     IBSQLRead.Close;
   end;

// RDB$INDEX_NAME	CHAR(31)	���������� ��� �������, RDB$INDEX_ID	SMALLINT	���������� ������������� �������

// indicesSwitch(1, ActivIndicesList, IBSQLWrite)  //�������� �������



/////////////////////////////////
//1-���������, 0-��������
procedure indicesSwitch(disableFlag: integer, Indices: TStringList, IBSQL: TIBSQL);
var i: integer;
begin
  IBSQL.Close;
  for i:=0 to Indices.Count-1 do
  begin
    IBSQL.ParamCheck := True;
    IBSQL.SQL.Text := ' UPDATE RDB$INDICES ' +
      ' SET I.RDB$INDEX_INACTIVE =  disableFlag ' +
      ' WHERE I.RDB$INDEX_NAME = :index_name ';
    IBSQL.Prepare;
    try
      IBSQL.ExecQuery;
	  IBSQL.ParamByName('disableFlag').AsInteger := disableFlag;
	  IBSQL.ParamByName('index_name').AsString := Indices[i];
	finally
      IBSQL.Close;
    end;
end;


//================================ ����������� 
                                                                                         /// ������� �����������
/// tempConstraintsTblName, : string

//ConstrTypeList, ConstrNameList, ConstrIndexNameList, ConstrRelationNameList: TStringList;


//��� ����������� (PK,FK,UNIC,CHEK,NOT NULL)
IBSQLRead.SQL.Text := ' SELECT r.RDB$CONSTRAINT_TYPE as type, r.RDB$CONSTRAINT_NAME as name, ' +
  ' r.RDB$INDEX_NAME as index, r.RDB$RELATION_NAME as relation ' +
  ' FROM RDB$RELATION_CONSTRAINTS r '
  ' ORDER BY RDB$CONSTRAINT_TYPE ';                                                         /// �� �����������
try
  IBSQLRead.ExecQuery;
  if IBSQLRead.RecordCount > 0 then
  begin
    //������: ���, ��� �����������, ��� �������, ��� �������    (��������������)            /// ����� ������� �������� ������� � ���� ��������� 
	ConstrTypeList := TStringList.Create;
	ConstraintNameList := TStringList.Create;
    IndexNameList := TStringList.Create;
	RelationNameList := TStringList.Create;

	while not IBSQLRead.Eof do
    begin
     ConstrTypeList.Add(IBSQLRead.FieldByName('type').AsString);
	 ConstraintNameList.Add(IBSQLRead.FieldByName('name').AsString);
	 IndexNameList.Add(IBSQLRead.FieldByName('index').AsString);
	 RelationNameList.Add(IBSQLRead.FieldByName('relation').AsString);
	 

	 { case IBSQLRead.FieldByName('type').AsString of
        'UNIC' : begin
		.Add(IBSQLRead.FieldByName('').AsString);
		  end;
		'PRIMARY KEY':
		'FOREIGN KEY':
        'CHECK':
        'NOT NULL':
	  }
      IBSQLRead.Next;
	end;
  end;
finally
  IBSQLRead.Close;
end;

// ������� ��� �����������
IBSQLRead.SQL.Text := ' DELETE FROM RDB$RELATION_CONSTRAINTS ';
try
  IBSQLRead.ExecQuery;
finally
  IBSQLRead.Close;
end;
///////////////////////////////////////��������� � �����
// ����������� ��� �����������
var i: integer

for i:=0 to ConstraintNameList.Count-1 do
begin
  IBSQLRead.ParamCheck := True;
  IBSQLRead.SQL.Text := ' INSERT INTO RDB$RELATION_CONSTRAINTS ' +
  ' (RDB$CONSTRAINT_TYPE, RDB$CONSTRAINT_NAME, RDB$INDEX_NAME, RDB$RELATION_NAME) ' +
  ' VALUES (:constraint_type, :constraint_name, :inx_name, :relation_name) ';
  IBSQLRead.Prepare;
  try
    IBSQLRead.ExecQuery;
	IBSQLRead.ParamByName('constraint_type').AsString := ConstrTypeList[i];
    IBSQLRead.ParamByName('constraint_name').AsString := ConstraintNameList[i];
    IBSQLRead.ParamByName('inx_name').AsString := IndexNameList[i];
    IBSQLRead.ParamByName('relation_name').AsString := RelationNameList[i];
  finally
    IBSQLRead.Close;
  end;
end;


   //========================================================[temp1] ������ TablesNameList: TStringList  ���� ���� ����������� ������
   var 
   TablesNameList: TStringList; 
   commaTextTables : String;
   
   IBSQLRead.SQL.Text := ' SELECT r.RDB$RELATION_NAME as Table_Name ' +
   ' FROM RDB$RELATIONS  r ' +
   ' WHERE ((r.RDB$SYSTEM_FLAG <> 1) ' +
   '  AND  (r.RDB$VIEW_SOURCE IS NULL )) ' +
   ' ORDER BY r.RDB$RELATION_NAME ';
   try
	 IBSQLRead.ExecQuery;
	 if IBSQLRead.RecordCount > 0 then
     begin
	   TablesNameList:= TStringList.Create;
	   
	   while not IBSQLRead.Eof do
       begin
		 commaTextTables := IBSQLRead.FieldByName('Table_Name').AsString + '=' + '0' ;
		 
		 IBSQLRead.Next;
		 if not IBSQLRead.Eof then commaTextTables := commaTextTables + ', '; 
	   end;
	   TablesNameList.CommaText := commaTextTables;
   finally
     IBSQLRead.Close;
   end;
   
  
   //===========================================================[temp2] ListPkFk, master tables, detail tables, 1to1 master tables
    var
    textSQL: String;
    i: integer;
    master_table_name: TStringList;
    master_field_name: TStringList;
	master_pk_field_name: TStringList;
    detail_table_name: TStringList;   
    detail_field_name: TStringList; 
    ///IntList  !
	GD_DOCUMENT_pk_field: TStringList; 
	masterkey_table_pk_field: TStringList; //���������� masterkey ��� masterdockey
	
	
    IBSQLRead.SQL.Text := ' SELECT I.rdb$relation_name   as Master_Table_Name ' +
       ' I_S.rdb$field_name    as Master_Field_Name, ' +
       ' F.rdb$field_name      as Master_PK_Field_Name, ' +
       ' I1.rdb$relation_name  as Detail_Table_Name, ' +
       ' I_S1.rdb$field_name   as Detail_Field_Name ';
     ' FROM rdb$indices I ' +
       ' JOIN rdb$index_segments I_S on I.rdb$index_name = I_S.rdb$index_name ' +
       ' JOIN rdb$indices I1 on I1.rdb$index_name = I.rdb$foreign_key ' +
       ' JOIN rdb$index_segments I_S1 on I1.rdb$index_name = I_S1.rdb$index_name ' +
       ' JOIN RDB$RELATION_CONSTRAINTS C on I.rdb$relation_name = C.RDB$RELATION_NAME ' +
       ' JOIN rdb$index_segments F on C.RDB$INDEX_NAME = F.RDB$INDEX_NAME ' +
       ' WHERE  I.rdb$foreign_key is not null ' +
       ' AND (C.RDB$CONSTRAINT_TYPE IN ('PRIMARY KEY')) ';

    try
      IBSQLRead.ExecQuery;

      if IBSQLRead.RecordCount > 0 then
      begin
	    master_table_name:= TStringList.Create;
		master_field_name:= TStringList.Create;
		master_pk_field_name:= TStringList.Create;
		detail_table_name:= TStringList.Create;
		detail_field_name:= TStringList.Create;
        
		
		
		///��� �� ����???
		var 
		field_master_table_name : string;
		field_master_field_name : string;
		
		
		i := 0;
        // ������� �� ������
        while not IBSQLRead.Eof do
        begin
		  field_master_table_name := IBSQLRead.FieldByName('Master_Table_Name').AsString; 
		  field_master_field_name := IBSQLRead.FieldByName('Master_Field_Name').AsString;
		  	  
		  
		 
		  else 
		  begin
		 
	//	  else //� ����� ������  
	//	   begin
			master_pk_field_name.Add(IBSQLRead.FieldByName('Master_PK_Field_Name').AsString);   //.Add()
            master_table_name.Add(IBSQLRead.FieldByName('Master_Table_Name').AsString;
            master_field_name.Add(IBSQLRead.FieldByName('Master_Field_Name').AsString;
		// ���� �� ����������	
            detail_table_name.Add(IBSQLRead.FieldByName('Detail_Table_Name').AsString;   
            detail_field_name[i] := IBSQLRead.FieldByName('Detail_Field_Name').AsString; 
    //     end;
		  end;
           i := i+1;
           IBSQLRead.Next;
        end;
        //Result := List.Text;

       end;
     finally
         IBSQLRead.Close;
     end;


    
    List: TStringList;
    ElementStr: String;
    Result := '';

	//TablesNameList.Delete('GD_DOCUMENT'); 
		  
	  
  /// try
   for i := 0 to master_field_name.Count-1 do
   begin
     textSQL := 'SELECT '+master_pk_field_name[i]+' as Master_PK, '+master_field_name[i]+'as Master_FK FROM '+master_table_name[i] ;
  
     IBSQLRead.SQL.Text := textSQL;

     try
     IBSQLRead.ExecQuery;
     if IBSQLRead.RecordCount > 0 then
     begin
	 ///Int !
	 GD_DOCUMENT_pk := TStringList.Create;
     //GD_RUID_pk := TStringList.Create;	 
     masterkey_table_pk:= TStringList.Create
	 
	 //���������� ������ pk ������          /// ��������� �������-������! (�� ����� ������ ������ ����)
	 if(master_table_name[i] <> 'GD_RUID') then 
	 begin

	   //[1]������ pk ��������� ������
	   if (master_pk_field_name[i] = 'MASTERKEY') 
	    or (master_pk_field_name[i] = 'MASTERDOCKEY') then 
	   begin 
         masterkey_table_pk.Add(IBSQLRead.FieldByName('Master_PK').AsInteger);
	     TablesNameList.Values[master_table_name[i]] := IntToStr(StrToInt(TablesNameList.Values[master_table_name[i]]) + 1);//����� fk ++
	   end;
	   else begin
	     //[2] c����� pk GD_DOCUMENT
		 if(master_table_name[i] = 'GD_DOCUMENT') then
		 begin
		   GD_DOCUMENT_pk.Add(IBSQLRead.FieldByName('Master_PK').AsInteger);
	       //TablesNameList.Values['GD_DOCUMENT'] := IntToStr(StrToInt(TablesNameList.Values['GD_DOCUMENT']) + 1); //����� fk ++
         end; 
         else begin
		   //[4]������ ������ 1-�-1 (�� �������)                     ///������� �������� !
		   if (master_field_name[i] = master_pk_field_name[i]) then
		   begin
		     master_1to1_pk.Add(IBSQLRead.FieldByName('Master_PK').AsInteger);
			 TablesNameList.Values[master_table_name[i]] := IntToStr(StrToInt(TablesNameList.Values[master_table_name[i]]) + 1);//����� fk ++
		   end;
		   else begin
		     //[3]������ ������-������ 
			 ID	         FIELDNAME	        RELATIONNAME	FIELDSOURCE	        CROSSTABLE	           CROSSFIELD	RELATIONKEY	FIELDSOURCEKEY	CROSSTABLEKEY	CROSSFIELDKEY	
            147084221	USR$TESTTEST_FIELD	USR$TESTTEST	USR$ACC_DACCOUNTSET	USR$CROSS1045_2012822647	ALIAS	147084216	147039906		
 
		   end;
		 end;
	   end;
		
		 

	 end;
	  
	 
       ListPkFk := TStringList.Create;
       
	   var commaTextPkFk : String  //����������!
	   
	   commaTextPkFk := '';
		while not IBSQLRead.Eof do
        begin 
		  commaTextPkFk := IBSQLRead.FieldByName('Master_PK').AsString + '=' + IBSQLRead.FieldByName('Master_FK').AsString ; 
          
		  IBSQLRead.Next;
		  if not IBSQLRead.Eof then commaTextPkFk := commaTextPkFk + ', '; 
        end;
     
        //Result := List.Text;
    
	    ListPkFk.CommaText := commaTextPkFk; ///for i := 0 to ListPkFk.Count-1 do begin ShowMessage(ListPkFk.Names[i]+' - ��� PK '+ListPkFk.ValueFromIndex[i] + ' - ��� FK'); end;
     end;
	 finally
       IBSQLRead.Close;
     end;
	end;
     

   ///
  //finally
  //  FreeAndNil(List);
  //end; 
  
  //========================================================temp9 � � pk ������, ��� �� ��������� ����������
	//����� ����������� ������������
  IBSQLRead.SQL.Text := ' SELECT RDB$GENERATORS.RDB$GENERATOR_NAME, ' +
       ' RDB$GENERATORS.RDB$SYSTEM_FLAG FROM RDB$GENERATORS ' +
      ' WHERE RDB$GENERATORS.RDB$SYSTEM_FLAG <> 1 ';  
	  
	  //����� ������� ������������ ��� ����������
   
  //========================================================temp4
   
   
   
  //========================================================temp6 : ������� �� ������� PK ��� ������ �� ������� id  �������� � M
   
  //========================================================[temp]end : ������� �� GD_RUID ������������ ������ (id)
  
  /// ���������!
  
    for i:=0 to M.Count-1  do 
	begin 
	 if(M[i]=0) then  
       IBSQLWrite.SQL.Text := ' DELETE FROM  GD_RUID ' +
	    ' WHERE id = :id ';
	   try
         IBSQLWrite.ExecQuery;
         IBSQLWrite.ParamByName('id').AsInteger := i + 147000000 + 1;
	   finally
         IBSQLWrite.Close;
       end;
    end;
   
   //========================================================[temp1] ������ TablesNameList: TStringList  ���� ���� ����������� ������
   var TablesNameList: TStringList 
   
   IBSQLRead.SQL.Text := ' SELECT r.RDB$RELATION_NAME as Table_Name ' +
   ' FROM RDB$RELATIONS  r ' +
   ' WHERE ((r.RDB$SYSTEM_FLAG <> 1) ' +
   '  AND  (r.RDB$VIEW_SOURCE IS NULL )) ' +
   ' ORDER BY r.RDB$RELATION_NAME ';
   try
	 IBSQLRead.ExecQuery;
	 if IBSQLRead.RecordCount > 0 then
     begin
	   TablesNameList:= TStringList.Create;
	   
	   while not IBSQLRead.Eof do
       begin
		 TablesNameList.Add(IBSQLRead.FieldByName('Table_Name').AsString);
		 IBSQLRead.Next;
	   end;
   finally
     IBSQLRead.Close;
   end;
   
   //========================================================[���������  gd_document], c��������� X: TList c ID  ������������������ �������
   var id, i: integer;   
   masFK: array[1..7] of integer;
   
  // ��������� �����
   IBSQLRead.SQL.Text := ' SELECT doc.ID, doc.DOCUMENTTYPEKEY, doc.TRTYPEKEY, doc.TRANSACTIONKEY, ' + 
   ' doc.COMPANYKEY, doc.CREATORKEY, doc.CURRKEY, doc.EDITORKEY ' +
   ' FROM GD_DOCUMENT doc ' +
   ' WHERE doc.PARENT is NULL ';
   try
	 IBSQLRead.ExecQuery;
	 if IBSQLRead.RecordCount > 0 then
     begin
		while not IBSQLRead.Eof do
        begin
		  masFK[0] := IBSQLRead.FieldByName('DOCUMENTTYPEKEY').AsInteger;
		  masFK[1] := IBSQLRead.FieldByName('TRTYPEKEY').AsInteger;      //null??
		  masFK[2] := IBSQLRead.FieldByName('COMPANYKEY').AsInteger;
		  masFK[3] := IBSQLRead.FieldByName('CREATORKEY').AsInteger;
		  masFK[4] := IBSQLRead.FieldByName('CURRKEY').AsInteger;        //null??
		  masFK[5] := IBSQLRead.FieldByName('EDITORKEY').AsInteger;
		  masFK[6] := IBSQLRead.FieldByName('TRANSACTIONKEY').AsInteger; //null??
		
          id = IBSQLRead.FieldByName('ID').AsInteger;		
	      //���� ������������� �������
	      if ( X.IndexOf(id)<> -1) then //����� ��� ������������������ ������  (-1 ���� �����������)
	      begin
            M[id-147000000] := 1;

	        for i:=0 to masFK.Count-1 do
			begin
			  while masFK[i] = NULL do i=i+1;  //�� ������������ FK � NULL
			  M[masFK[i]-147000000] := 1;
			  if (M2[masFK[i]-147000000] = 1) then // M2.Has(...)
			  begin 
			    M2.Exclude(...);  //
			  end;
	        end;
			 //�� L ������� ��� fk ������ �����
			 for i := 0 to ListPkFk.Count-1 do   
			 begin 
			 if (ListPkFk.Names[i]= id )  then //PK GD_DOCUMENT
			 //������� ��������-���� �� ������          //  ListPkFk.ValueFromIndex[i]  //ListPkFk.Value - ��� FK 
			 ListPkFk.Delete(i);                         ///??
			 end;
	      end;
	      //���� ������ �� ������������� �������
		  else 
		  begin
		    M2[id-147000000] := 1;
			
			for i:=0 to masFK.Count-1 do
			begin
			  while masFK[i] = NULL do i=i+1;  //�� ������������ FK � NULL
              if(M[masFK[i]-147000000] = 0) then
              begin
			   //�������� ��������-���� � ListPkFk
               commaTextPkFk := commaTextPkFk + ', ' + id +'=' + masFK[i];
              end;			   
			end; 
			ListPkFk.CommaText := commaTextPkFk;
		  end;
		  
	      IBSQLRead.Next;
	    end;
   finally
     IBSQLRead.Close;
   end;
   
   //��������� �������
   IBSQLRead.SQL.Text := ' SELECT doc.ID, doc.PARENT, doc.DOCUMENTTYPEKEY, doc.TRTYPEKEY, doc.TRANSACTIONKEY, ' + 
   ' doc.COMPANYKEY, doc.CREATORKEY, doc.CURRKEY, doc.EDITORKEY ' +
   ' FROM GD_DOCUMENT doc ' +
   ' WHERE doc.PARENT is NOT NULL ';
   try
	 IBSQLRead.ExecQuery;
	 if IBSQLRead.RecordCount > 0 then
     begin
		while not IBSQLRead.Eof do
        begin
          if (M[IBSQLRead.FieldByName('PARENT').AsInteger - 147000000] = 1) then // M.Has(...)
		  begin 
			M[IBSQLRead.FieldByName('ID').AsInteger - 147000000] = 1;
			
			//� ������ ����??
		  end;
   
          IBSQLRead.Next;
	    end;
   finally
     IBSQLRead.Close;
   end;
   
   ///ListPkFk - ������ 
   ///X - ������ id ������� �� ������� �� ������������� ������ ����������
   ///list - ������ ������� ������
   //==============================================================[temp] private procedure master_migration(TStringList list),  X : TgsHugeIntSet
   var value, i, i2: integer; 
   
   
   for i:=0 to list.Count-1 do
   begin
     //���� ������������� �������
     if (not X.Has(list[i]-147000000)) then
     begin
       M.Include(list[i]-147000000);
	   for i2:=0 to ListPkFk.Count-1 do
	   begin
		 if (ListPkFk.Names[i2] = list[i]) then
		 begin
	       value := ListPkFk.ValueFromIndex[i2]-147000000; 
		   //while masFK[i] = NULL do i=i+1;  //�� ������������ FK � NULL           /// ? 
		   M.Include(value);
		   if (M2.Has(value)) then
		   begin 
			 M2.Exclude(value);
		   end;
		 end;
	   end;
	   //�� L ������� ��� ������������ - �������� ������
	   for i2 := 0 to ListPkFk.Count-1 do   
	   begin
		 if (ListPkFk.Names[i2] = list[i])  then 
		 //������� ��������-���� �� ������          //  ListPkFk.ValueFromIndex[i]  //ListPkFk.Value - ��� FK 
		 ListPkFk.Delete(i2);                         ///??
		 end;
     end;
	 else begin//���� ������ �� ������������� �������
	   M2.Include(list[i]-147000000);
	   for i2:=0 to ListPkFk.Count-1 do
	   begin
		 if (ListPkFk.Names[i2] = list[i]) then
		 begin
	       value := ListPkFk.ValueFromIndex[i2]-147000000; 
		   //while masFK[i] = NULL do i=i+1;  //�� ������������ FK � NULL        /// ?
		   if (not M.Has(value)) then
           begin
			 //�������� ��������-���� � ListPkFk
             commaTextPkFk := commaTextPkFk + ', ' + IntToStr(list[i]) + '=' + IntToStr(value);
           end;			   
		 end;  
	   end;
	   ListPkFk.CommaText := commaTextPkFk;
	 end;
   end;	  
	    
  //������� ������ 1-�-1 (detail)
  //======================================[temp] private procedure 1to1_migration(TStringList list)  1-to-1 ��� !!!!
    //�������� �������-������ ��� ���� ������� �� �� ��������� � M
  for i:=0 to list.Count-1 do
  begin
    i2:=0;
    while(ListPkFk.Values[i2] <> list[i]) then
	begin
	  i2 := i2+1; 
	end;
	if (M.Has(ListPkFk.Names[i2]-147000000)) then //������ �������  pk
	begin
	//��������� �����
	  M.Include(list[i]-147000000);
	                                                     /// ?
	  
	end;
  end;
  
  //==================================[temp] private procedure masterkeyTable_migration (TIntList list, TIntList masterkeys) 
  for i:=0 to list.Count-1 do
  begin
    if (M.Has(masterkeys[i]-147000000)) then //������ �������  pk
	begin
	//��������� �����
	  M.Include(list[i]-147000000);
	                                                     /// ? 
	end;
  end;
  
  //=================================[temp] private procedure ������� �������-������_migration (TIntList CrossList, TIntList masterPK)  //������ �� ������ � ������ �� ������ ���������� ���������
 
  for i:=0 to list.Count-1 do
  begin
    if (M.Has(masterPK[i]-147000000)) then //������ �������  pk
	begin
	//��������� ������
	  M.Include(list[i]-147000000);
	                                                     /// ? 
	end;
  end;
  
  
  
end;



//=================================================================
procedure Connect;
begin

 // �������� ���������� ������
  LoadIBLibrary;  //IBX
  // ����������� � ��
  Database.DatabaseName := DatabaseName;    // *.fdb
  Database.Params.Clear;
  Database.Params.Add('user_name=' + DefaultIBUserName);
  if ConnectionInformation.CharacterSet <> '' then
    Database.Params.Add('lc_ctype=' + ConnectionInformation.CharacterSet);
  Database.LoginPrompt := False;
  
  
  // 3-�� �������
  //Database.SQLDialect := 3;
  //try
  Database.Open;
  //except
  //  on E: IBInterBaseError do
   // begin
   //   if E.IBErrorCode = isc_bad_db_format then
   //     raise Exception.Create(GetLocalizedString(lsUnknownDatabaseType))
   //   else
   //     raise;
  //  end
   // else
   //   raise;
  //end;
  // �������� �������� ����������
  ReadTransaction.StartTransaction;
end;

//=======================================================
procedure Disconnect;
begin
  if Assigned(FDatabase) then
    if Database.Connected  then
    begin
      if Assigned(ReadTransaction) and ReadTransaction.InTransaction then
        ReadTransaction.Commit;
      Database.Close;
      // �������� ���������� ������
      FreeIBLibrary;
    end;
end;

end.
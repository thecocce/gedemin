unit mdf_RemakeACENTRY;

interface

uses
  IBDatabase, gdModify, mdf_MetaData_unit, Forms,
  Windows, Controls;

  procedure RemakeACENTRY(IBDB: TIBDatabase; Log: TModifyLog);
  procedure RemakeStored(IBDB: TIBDatabase; Log: TModifyLog);
  procedure RemakeACENTRY_NEW(IBDB: TIBDatabase; Log: TModifyLog);
  procedure RemakeExStored(IBDB: TIBDatabase; Log: TModifyLog);

implementation

uses
  IBSQL, SysUtils, IBScript, classes;

procedure RemakeACENTRY_NEW(IBDB: TIBDatabase; Log: TModifyLog);
var
  StoredProcedure: TmdfStoredProcedure;
  IBTr: TIBTransaction;
  q: TIBSQL;
begin
  IBTr := TIBTransaction.Create(nil);
  q := TIBSQL.Create(nil);
  try
    IBTr.DefaultDatabase := IBDB;

    q.Transaction := IBTr;

    try
      StoredProcedure.ProcedureName := 'AC_CIRCULATIONLIST';
      StoredProcedure.Description :=
        '( ' + #13#10 +
        '    datebegin date, ' + #13#10 +
        '    dateend date, ' + #13#10 +
        '    companykey integer, ' + #13#10 +
        '    allholdingcompanies integer, ' + #13#10 +
        '    accountkey integer, ' + #13#10 +
        '    ingroup integer, ' + #13#10 +
        '    currkey integer, ' + #13#10 +
        '    dontinmove integer /* �� �������� ���������� �������� */) ' + #13#10 +
        'returns ( ' + #13#10 +
        '    alias varchar(20), ' + #13#10 +
        '    name varchar(180), ' + #13#10 +
        '    id integer, ' + #13#10 +
        '    ncu_begin_debit numeric(15,4), ' + #13#10 +
        '    ncu_begin_credit numeric(15,4), ' + #13#10 +
        '    ncu_debit numeric(15,4), ' + #13#10 +
        '    ncu_credit numeric(15,4), ' + #13#10 +
        '    ncu_end_debit numeric(15,4), ' + #13#10 +
        '    ncu_end_credit numeric(15,4), ' + #13#10 +
        '    curr_begin_debit numeric(15,4), ' + #13#10 +
        '    curr_begin_credit numeric(15,4), ' + #13#10 +
        '    curr_debit numeric(15,4), ' + #13#10 +
        '    curr_credit numeric(15,4), ' + #13#10 +
        '    curr_end_debit numeric(15,4), ' + #13#10 +
        '    curr_end_credit numeric(15,4), ' + #13#10 +
        '    eq_begin_debit numeric(15,4), ' + #13#10 +
        '    eq_begin_credit numeric(15,4), ' + #13#10 +
        '    eq_debit numeric(15,4), ' + #13#10 +
        '    eq_credit numeric(15,4), ' + #13#10 +
        '    eq_end_debit numeric(15,4), ' + #13#10 +
        '    eq_end_credit numeric(15,4), ' + #13#10 +
        '    offbalance integer) ' + #13#10 +
        'as ' + #13#10 +
        '  declare variable activity varchar(1); ' + #13#10 +
        '  declare variable saldo numeric(15,4); ' + #13#10 +
        '  declare variable saldocurr numeric(15,4); ' + #13#10 +
        '  declare variable saldoeq numeric(15,4); ' + #13#10 +
        '  declare variable fieldname varchar(60); ' + #13#10 +
        '  declare variable lb integer; ' + #13#10 +
        '  declare variable rb integer; ' + #13#10 +
        'BEGIN                                                                                                  ' + #13#10 +
        '  /* Procedure Text */                                                                                 ' + #13#10 +
        ' ' + #13#10 +
        '  SELECT c.lb, c.rb FROM ac_account c                                                                  ' + #13#10 +
        '  WHERE c.id = :ACCOUNTKEY ' + #13#10 +
        '  INTO :lb, :rb;                                                                                       ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '  FOR                                                                                                  ' + #13#10 +
        '    SELECT a.ID, a.ALIAS, a.activity, f.fieldname, a.Name, a.offbalance                                ' + #13#10 +
        '    FROM ac_account a LEFT JOIN at_relation_fields f ON a.analyticalfield = f.id                       ' + #13#10 +
        '    WHERE                                                                                              ' + #13#10 +
        '      a.accounttype IN (''A'', ''S'') AND                                                                  ' + #13#10 +
        '      a.LB >= :LB AND a.RB <= :RB AND a.alias <> ''00''                                                  ' + #13#10 +
        '    INTO :id, :ALIAS, :activity, :fieldname, :name, :offbalance                                        ' + #13#10 +
        '  DO                                                                                                   ' + #13#10 +
        '  BEGIN                                                                                                ' + #13#10 +
        '    NCU_BEGIN_DEBIT = 0;                                                                               ' + #13#10 +
        '    NCU_BEGIN_CREDIT = 0;                                                                              ' + #13#10 +
        '    CURR_BEGIN_DEBIT = 0;                                                                              ' + #13#10 +
        '    CURR_BEGIN_CREDIT = 0;                                                                             ' + #13#10 +
        '    EQ_BEGIN_DEBIT = 0;                                                                                ' + #13#10 +
        '    EQ_BEGIN_CREDIT = 0;  ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '    IF ((activity <> ''B'') OR (fieldname IS NULL)) THEN                                                 ' + #13#10 +
        '    BEGIN  ' + #13#10 +
        '      IF ( ALLHOLDINGCOMPANIES = 0) THEN  ' + #13#10 +
        '      SELECT                                                                                           ' + #13#10 +
        '        SUM(e.DEBITNCU - e.CREDITNCU),                                                                 ' + #13#10 +
        '        SUM(e.DEBITCURR - e.CREDITCURR),  ' + #13#10 +
        '        SUM(e.DEBITEQ - e.CREDITEQ)                                                                    ' + #13#10 +
        '      FROM                                                                                             ' + #13#10 +
        '        ac_entry e                                                                                     ' + #13#10 +
        '      WHERE  ' + #13#10 +
        '        e.accountkey = :id AND e.entrydate < :datebegin AND                                            ' + #13#10 +
        '        (e.companykey = :companykey) AND  ' + #13#10 +
        '        ((0 = :currkey) OR (e.currkey = :currkey))  ' + #13#10 +
        '      INTO :SALDO,                                                                                     ' + #13#10 +
        '        :SALDOCURR, :SALDOEQ;                                                                          ' + #13#10 +
        '      ELSE  ' + #13#10 +
        '      SELECT                                                                                           ' + #13#10 +
        '        SUM(e.DEBITNCU - e.CREDITNCU),                                                                 ' + #13#10 +
        '        SUM(e.DEBITCURR - e.CREDITCURR),                                                               ' + #13#10 +
        '        SUM(e.DEBITEQ - e.CREDITEQ)                                                                    ' + #13#10 +
        '      FROM                                                                                             ' + #13#10 +
        '        ac_entry e                                                                                     ' + #13#10 +
        '      WHERE ' + #13#10 +
        '        e.accountkey = :id AND e.entrydate < :datebegin AND                                            ' + #13#10 +
        '        (e.companykey = :companykey or e.companykey IN ( ' + #13#10 +
        '          SELECT                                                                                       ' + #13#10 +
        '            h.companykey                                                                               ' + #13#10 +
        '          FROM                                                                                         ' + #13#10 +
        '            gd_holding h                                                                               ' + #13#10 +
        '          WHERE                                                                                        ' + #13#10 +
        '            h.holdingkey = :companykey)) AND  ' + #13#10 +
        '        ((0 = :currkey) OR (e.currkey = :currkey))  ' + #13#10 +
        '      INTO :SALDO,                                                                                     ' + #13#10 +
        '        :SALDOCURR, :SALDOEQ;                                                                          ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '      IF (SALDO IS NULL) THEN                                                                          ' + #13#10 +
        '        SALDO = 0;                                                                                     ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '      IF (SALDOCURR IS NULL) THEN  ' + #13#10 +
        '        SALDOCURR = 0;                                                                                 ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '      IF (SALDOEQ IS NULL) THEN                                                                        ' + #13#10 +
        '        SALDOEQ = 0;                                                                                   ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '      IF (SALDO > 0) THEN                                                                              ' + #13#10 +
        '        NCU_BEGIN_DEBIT = SALDO;                                                                       ' + #13#10 +
        '      ELSE                                                                                             ' + #13#10 +
        '        NCU_BEGIN_CREDIT = 0 - SALDO;                                                                  ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '      IF (SALDOCURR > 0) THEN                                                                          ' + #13#10 +
        '        CURR_BEGIN_DEBIT = SALDOCURR;                                                                  ' + #13#10 +
        '      ELSE                                                                                             ' + #13#10 +
        '        CURR_BEGIN_CREDIT = 0 - SALDOCURR;                                                             ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '      IF (SALDOEQ > 0) THEN                                                                            ' + #13#10 +
        '        EQ_BEGIN_DEBIT = SALDOEQ;                                                                      ' + #13#10 +
        '      ELSE                                                                                             ' + #13#10 +
        '        EQ_BEGIN_CREDIT = 0 - SALDOEQ;                                                                 ' + #13#10 +
        '    END                                                                                                ' + #13#10 +
        '    ELSE                                                                                               ' + #13#10 +
        '    BEGIN                                                                                              ' + #13#10 +
        '      SELECT                                                                                           ' + #13#10 +
        '        DEBITsaldo,                                                                                    ' + #13#10 +
        '        creditsaldo  ' + #13#10 +
        '      FROM ' + #13#10 +
        '        AC_ACCOUNTEXSALDO(:datebegin, :ID, :FIELDNAME, :COMPANYKEY,                                    ' + #13#10 +
        '          :allholdingcompanies, :INGROUP, :currkey) ' + #13#10 +
        '      INTO                                                                                             ' + #13#10 +
        '        :NCU_BEGIN_DEBIT,                                                                              ' + #13#10 +
        '        :NCU_BEGIN_CREDIT;                                                                             ' + #13#10 +
        '    END  ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '    IF (ALLHOLDINGCOMPANIES = 0) THEN  ' + #13#10 +
        '    BEGIN ' + #13#10 +
        '      IF (DONTINMOVE = 1) THEN ' + #13#10 +
        '        SELECT ' + #13#10 +
        '          SUM(e.DEBITNCU), ' + #13#10 +
        '          SUM(e.CREDITNCU), ' + #13#10 +
        '          SUM(e.DEBITCURR), ' + #13#10 +
        '          SUM(e.CREDITCURR), ' + #13#10 +
        '          SUM(e.DEBITEQ), ' + #13#10 +
        '          SUM(e.CREDITEQ) ' + #13#10 +
        '        FROM ' + #13#10 +
        '          ac_entry e ' + #13#10 +
        '        WHERE ' + #13#10 +
        '          e.accountkey = :id AND e.entrydate >= :datebegin AND ' + #13#10 +
        '          e.entrydate <= :dateend AND (e.companykey = :companykey) AND ' + #13#10 +
        '          ((0 = :currkey) OR (e.currkey = :currkey)) AND ' + #13#10 +
        '          NOT EXISTS( SELECT e_m.id FROM  ac_entry e_m ' + #13#10 +
        '              JOIN ac_entry e_cm ON e_cm.recordkey=e_m.recordkey AND ' + #13#10 +
        '               e_cm.accountpart <> e_m.accountpart AND ' + #13#10 +
        '               e_cm.accountkey=e_m.accountkey AND ' + #13#10 +
        '               (e_m.debitncu=e_cm.creditncu OR ' + #13#10 +
        '                e_m.creditncu=e_cm.debitncu OR ' + #13#10 +
        '                e_m.debitcurr=e_cm.creditcurr OR ' + #13#10 +
        '                e_m.creditcurr=e_cm.debitcurr) ' + #13#10 +
        '              WHERE e_m.id=e.id) ' + #13#10 +
        '        INTO :NCU_DEBIT, :NCU_CREDIT, :CURR_DEBIT, CURR_CREDIT, :EQ_DEBIT, EQ_CREDIT; ' + #13#10 +
        '      ELSE ' + #13#10 +
        '        SELECT ' + #13#10 +
        '          SUM(e.DEBITNCU), ' + #13#10 +
        '          SUM(e.CREDITNCU), ' + #13#10 +
        '          SUM(e.DEBITCURR), ' + #13#10 +
        '          SUM(e.CREDITCURR), ' + #13#10 +
        '          SUM(e.DEBITEQ), ' + #13#10 +
        '          SUM(e.CREDITEQ) ' + #13#10 +
        '        FROM ' + #13#10 +
        '          ac_entry e ' + #13#10 +
        '        WHERE ' + #13#10 +
        '          e.accountkey = :id AND e.entrydate >= :datebegin AND ' + #13#10 +
        '          e.entrydate <= :dateend AND (e.companykey = :companykey) AND ' + #13#10 +
        '          ((0 = :currkey) OR (e.currkey = :currkey)) ' + #13#10 +
        '        INTO :NCU_DEBIT, :NCU_CREDIT, :CURR_DEBIT, CURR_CREDIT, :EQ_DEBIT, EQ_CREDIT; ' + #13#10 +
        '    END ' + #13#10 +
        '    ELSE ' + #13#10 +
        '    BEGIN ' + #13#10 +
        '      IF (DONTINMOVE = 1) THEN ' + #13#10 +
        '        SELECT ' + #13#10 +
        '          SUM(e.DEBITNCU), ' + #13#10 +
        '          SUM(e.CREDITNCU), ' + #13#10 +
        '          SUM(e.DEBITCURR), ' + #13#10 +
        '          SUM(e.CREDITCURR), ' + #13#10 +
        '          SUM(e.DEBITEQ), ' + #13#10 +
        '          SUM(e.CREDITEQ) ' + #13#10 +
        '        FROM ' + #13#10 +
        '          ac_entry e ' + #13#10 +
        '        WHERE ' + #13#10 +
        '          e.accountkey = :id AND e.entrydate >= :datebegin AND ' + #13#10 +
        '          e.entrydate <= :dateend AND ' + #13#10 +
        '          (e.companykey = :companykey or e.companykey IN ( ' + #13#10 +
        '          SELECT h.companykey FROM gd_holding h ' + #13#10 +
        '           WHERE h.holdingkey = :companykey)) AND ' + #13#10 +
        '          ((0 = :currkey) OR (e.currkey = :currkey)) AND ' + #13#10 +
        '          NOT EXISTS( SELECT e_m.id FROM  ac_entry e_m ' + #13#10 +
        '              JOIN ac_entry e_cm ON e_cm.recordkey=e_m.recordkey AND ' + #13#10 +
        '               e_cm.accountpart <> e_m.accountpart AND ' + #13#10 +
        '               e_cm.accountkey=e_m.accountkey AND ' + #13#10 +
        '               (e_m.debitncu=e_cm.creditncu OR ' + #13#10 +
        '                e_m.creditncu=e_cm.debitncu OR ' + #13#10 +
        '                e_m.debitcurr=e_cm.creditcurr OR ' + #13#10 +
        '                e_m.creditcurr=e_cm.debitcurr) ' + #13#10 +
        '              WHERE e_m.id=e.id) ' + #13#10 +
        '        INTO :NCU_DEBIT, :NCU_CREDIT, :CURR_DEBIT, CURR_CREDIT, :EQ_DEBIT, :EQ_CREDIT; ' + #13#10 +
        '      ELSE ' + #13#10 +
        '        SELECT ' + #13#10 +
        '          SUM(e.DEBITNCU), ' + #13#10 +
        '          SUM(e.CREDITNCU), ' + #13#10 +
        '          SUM(e.DEBITCURR), ' + #13#10 +
        '          SUM(e.CREDITCURR), ' + #13#10 +
        '          SUM(e.DEBITEQ), ' + #13#10 +
        '          SUM(e.CREDITEQ) ' + #13#10 +
        '        FROM ' + #13#10 +
        '          ac_entry e ' + #13#10 +
        '        WHERE ' + #13#10 +
        '          e.accountkey = :id AND e.entrydate >= :datebegin AND ' + #13#10 +
        '          e.entrydate <= :dateend AND ' + #13#10 +
        '          (e.companykey = :companykey or e.companykey IN ( ' + #13#10 +
        '          SELECT h.companykey FROM gd_holding h ' + #13#10 +
        '           WHERE h.holdingkey = :companykey)) AND ' + #13#10 +
        '          ((0 = :currkey) OR (e.currkey = :currkey)) ' + #13#10 +
        '        INTO :NCU_DEBIT, :NCU_CREDIT, :CURR_DEBIT, CURR_CREDIT, :EQ_DEBIT, :EQ_CREDIT; ' + #13#10 +
        '    END ' + #13#10 +
        '                                                                                                             ' + #13#10 +
        '    IF (NCU_DEBIT IS NULL) THEN                                                                        ' + #13#10 +
        '      NCU_DEBIT = 0;                                                                                   ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '    IF (NCU_CREDIT IS NULL) THEN                                                                       ' + #13#10 +
        '      NCU_CREDIT = 0;                                                                                  ' + #13#10 +
        '  ' + #13#10 +
        '    IF (CURR_DEBIT IS NULL) THEN                                                                       ' + #13#10 +
        '      CURR_DEBIT = 0;                                                                                  ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '    IF (CURR_CREDIT IS NULL) THEN                                                                      ' + #13#10 +
        '      CURR_CREDIT = 0;                                                                                 ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '    IF (EQ_DEBIT IS NULL) THEN  ' + #13#10 +
        '      EQ_DEBIT = 0;                                                                                    ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '    IF (EQ_CREDIT IS NULL) THEN                                                                        ' + #13#10 +
        '      EQ_CREDIT = 0;                                                                                   ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '    NCU_END_DEBIT = 0;                                                                                 ' + #13#10 +
        '    NCU_END_CREDIT = 0;                                                                                ' + #13#10 +
        '    CURR_END_DEBIT = 0;                                                                                ' + #13#10 +
        '    CURR_END_CREDIT = 0;                                                                               ' + #13#10 +
        '    EQ_END_DEBIT = 0;                                                                                  ' + #13#10 +
        '    EQ_END_CREDIT = 0;                                                                                 ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '    IF ((ACTIVITY <> ''B'') OR (FIELDNAME IS NULL)) THEN                                                 ' + #13#10 +
        '    BEGIN                                                                                              ' + #13#10 +
        '      SALDO = NCU_BEGIN_DEBIT - NCU_BEGIN_CREDIT + NCU_DEBIT - NCU_CREDIT;                             ' + #13#10 +
        '      IF (SALDO > 0) THEN ' + #13#10 +
        '        NCU_END_DEBIT = SALDO;                                                                         ' + #13#10 +
        '      ELSE ' + #13#10 +
        '        NCU_END_CREDIT = 0 - SALDO;                                                                    ' + #13#10 +
        '                                                                                                       ' + #13#10 +
        '      SALDOCURR = CURR_BEGIN_DEBIT - CURR_BEGIN_CREDIT + CURR_DEBIT - CURR_CREDIT;                     ' + #13#10 +
        '      IF (SALDOCURR > 0) THEN                                                                          ' + #13#10 +
        '        CURR_END_DEBIT = SALDOCURR;                                                                    ' + #13#10 +
        '      ELSE                                                                                             ' + #13#10 +
        '        CURR_END_CREDIT = 0 - SALDOCURR;                                                               ' + #13#10 +
        '  ' + #13#10 +
        '      SALDOEQ = EQ_BEGIN_DEBIT - EQ_BEGIN_CREDIT + EQ_DEBIT - EQ_CREDIT;                               ' + #13#10 +
        '      IF (SALDOEQ > 0) THEN                                                                            ' + #13#10 +
        '        EQ_END_DEBIT = SALDOEQ;                                                                        ' + #13#10 +
        '      ELSE                                                                                             ' + #13#10 +
        '        EQ_END_CREDIT = 0 - SALDOEQ;                                                                   ' + #13#10 +
        '    END                                                                                                ' + #13#10 +
        '    ELSE  ' + #13#10 +
        '    BEGIN  ' + #13#10 +
        '      IF ((NCU_BEGIN_DEBIT <> 0) OR (NCU_BEGIN_CREDIT <> 0) OR  ' + #13#10 +
        '        (NCU_DEBIT <> 0) OR (NCU_CREDIT <> 0) OR  ' + #13#10 +
        '        (CURR_BEGIN_DEBIT <> 0) OR (CURR_BEGIN_CREDIT <> 0) OR  ' + #13#10 +
        '        (CURR_DEBIT <> 0) OR (CURR_CREDIT <> 0) OR  ' + #13#10 +
        '        (EQ_BEGIN_DEBIT <> 0) OR (EQ_BEGIN_CREDIT <> 0) OR  ' + #13#10 +
        '        (EQ_DEBIT <> 0) OR (EQ_CREDIT <> 0)) THEN  ' + #13#10 +
        '      BEGIN  ' + #13#10 +
        '        SELECT  ' + #13#10 +
        '          DEBITsaldo, creditsaldo,  ' + #13#10 +
        '          CurrDEBITsaldo, Currcreditsaldo,  ' + #13#10 +
        '          EQDEBITsaldo, EQcreditsaldo  ' + #13#10 +
        '        FROM AC_ACCOUNTEXSALDO(:DATEEND + 1, :ID, :FIELDNAME, :COMPANYKEY,  ' + #13#10 +
        '          :allholdingcompanies, :INGROUP, :currkey)  ' + #13#10 +
        '        INTO :NCU_END_DEBIT, :NCU_END_CREDIT, :CURR_END_DEBIT, :CURR_END_CREDIT, :EQ_END_DEBIT, :EQ_END_CREDIT;  ' + #13#10 +
        '      END  ' + #13#10 +
        '    END  ' + #13#10 +
        '    IF ((NCU_BEGIN_DEBIT <> 0) OR (NCU_BEGIN_CREDIT <> 0) OR  ' + #13#10 +
        '      (NCU_DEBIT <> 0) OR (NCU_CREDIT <> 0) OR  ' + #13#10 +
        '      (CURR_BEGIN_DEBIT <> 0) OR (CURR_BEGIN_CREDIT <> 0) OR  ' + #13#10 +
        '      (CURR_DEBIT <> 0) OR (CURR_CREDIT <> 0) OR  ' + #13#10 +
        '      (EQ_BEGIN_DEBIT <> 0) OR (EQ_BEGIN_CREDIT <> 0) OR  ' + #13#10 +
        '      (EQ_DEBIT <> 0) OR (EQ_CREDIT <> 0)) THEN  ' + #13#10 +
        '    SUSPEND;  ' + #13#10 +
        '  END  ' + #13#10 +
        'END ';

      Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
      try
        AlterProcedure(StoredProcedure, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      IbTr.StartTransaction;

      AddFinVersion(78, '0000.0001.0000.0106', 'Change StoredProc AC_CIRCULATIONLIST', '15.09.2006', IBTr);

      IbTr.Commit;

    except
      on E: Exception do
      begin
        Log(Format('������: %s', [E.Message]));
        if IBTr.InTransaction then IBTr.Rollback;
      end;
    end;

  finally
    IBTr.Free;
    q.Free;
  end;

end;

procedure RemakeACENTRY(IBDB: TIBDatabase; Log: TModifyLog);
var
  F: TmdfField;
  AlterConstraints: TmdfConstraint;
  AlterTrigger: TmdfTrigger;
  StoredProcedure: TmdfStoredProcedure;
  Index: TmdfIndex;
  IBTr: TIBTransaction;
  q: TIBSQL;
  FieldList, TextSQL, Header: String;
begin
  IBTr := TIBTransaction.Create(nil);
  q := TIBSQL.Create(nil);
  try
    IBTr.DefaultDatabase := IBDB;

    q.Transaction := IBTr;

    try

      Log('���������� ���� companykey � AC_ENTRY');
      F.RelationName := 'ac_entry';
      F.FieldName := 'companykey';
      F.Description := 'DINTKEY';
      if not FieldExist(F, IBDB) then
        AddField(F, IBDB);

      Log('���������� ���� documentkey � AC_ENTRY');
      F.RelationName := 'ac_entry';
      F.FieldName := 'documentkey';
      F.Description := 'DINTKEY';
      if not FieldExist(F, IBDB) then
        AddField(F, IBDB);

      Log('���������� ���� masterdockey � AC_ENTRY');
      F.RelationName := 'ac_entry';
      F.FieldName := 'masterdockey';
      F.Description := 'DINTKEY';
      if not FieldExist(F, IBDB) then
        AddField(F, IBDB);

      Log('���������� ���� transactionkey � AC_ENTRY');
      F.RelationName := 'ac_entry';
      F.FieldName := 'transactionkey';
      F.Description := 'DINTKEY';
      if not FieldExist(F, IBDB) then
        AddField(F, IBDB);

      IBTr.StartTransaction;

      Log('���������� ����������� �����');
      q.SQL.Text :=
        'UPDATE AC_ENTRY e SET ' + #13#10 +
        'e.documentkey = (SELECT documentkey FROM ac_record r WHERE r.id = e.recordkey), ' + #13#10 +
        'e.masterdockey = (SELECT masterdockey FROM ac_record r WHERE r.id = e.recordkey), ' + #13#10 +
        'e.transactionkey = (SELECT transactionkey FROM ac_record r WHERE r.id = e.recordkey), ' + #13#10 +
        'e.companykey = (SELECT companykey FROM ac_record r WHERE r.id = e.recordkey) ';
      q.ExecQuery;
      q.Close;

      IBTr.Commit;

      AlterConstraints.TableName := 'ac_entry';
      AlterConstraints.ConstraintName := 'AC_FK_ENTRY_DOCKEY';
      AlterConstraints.Description := 'FOREIGN KEY (DOCUMENTKEY) REFERENCES GD_DOCUMENT (ID) ON DELETE CASCADE ON UPDATE CASCADE';

      Log(Format('���������� foreign key %s � ������� %s', [AlterConstraints.ConstraintName,
        AlterConstraints.TableName]));
      try
        AddConstraint(AlterConstraints, IBDB);
      except
        on E: Exception do
          Log('������: ' + E.Message);
      end;

      IBDB.Connected := False;
      IBDB.Connected := True;

      AlterConstraints.TableName := 'ac_entry';
      AlterConstraints.ConstraintName := 'AC_FK_ENTRY_MASTERDOCKEY';
      AlterConstraints.Description := 'FOREIGN KEY (MASTERDOCKEY) REFERENCES GD_DOCUMENT (ID) ON DELETE CASCADE ON UPDATE CASCADE';

      Log(Format('���������� foreign key %s � ������� %s', [AlterConstraints.ConstraintName,
        AlterConstraints.TableName]));
      try
        AddConstraint(AlterConstraints, IBDB);
      except
        on E: Exception do
          Log('������: ' + E.Message);
      end;

      IBDB.Connected := False;
      IBDB.Connected := True;

      AlterConstraints.TableName := 'ac_entry';
      AlterConstraints.ConstraintName := 'AC_FK_ENTRY_COMPANYKEY';
      AlterConstraints.Description := 'FOREIGN KEY (COMPANYKEY) REFERENCES GD_COMPANY (CONTACTKEY) ON UPDATE CASCADE';

      Log(Format('���������� foreign key %s � ������� %s', [AlterConstraints.ConstraintName,
        AlterConstraints.TableName]));
      try
        AddConstraint(AlterConstraints, IBDB);
      except
        on E: Exception do
          Log('������: ' + E.Message);
      end;

      IBDB.Connected := False;
      IBDB.Connected := True;

      AlterConstraints.TableName := 'ac_entry';
      AlterConstraints.ConstraintName := 'AC_FK_ENTRY_TRANSACTIONKEY';
      AlterConstraints.Description := 'FOREIGN KEY (TRANSACTIONKEY) REFERENCES AC_TRANSACTION (ID) ON UPDATE CASCADE';

      Log(Format('���������� foreign key %s � ������� %s', [AlterConstraints.ConstraintName,
        AlterConstraints.TableName]));
      try
        AddConstraint(AlterConstraints, IBDB);
      except
        on E: Exception do
          Log('������: ' + E.Message);
      end;

      IBDB.Connected := False;
      IBDB.Connected := True;

      Index.RelationName := 'AC_ENTRY';
      Index.IndexName := 'AC_ENTRY_ACCKEY_CK_ENTRYDATE';
      Index.Columns := 'ACCOUNTKEY, COMPANYKEY, ENTRYDATE';
      Index.Unique := False;
      Index.Sort := stAsc;

      if not IndexExist(Index, IBDB) then
      begin
        Log(Format('���������� ������� %s � ������� %s', [Index.IndexName,
          Index.RelationName]));
        try
          AddIndex(Index, IBDB);
        except
          on E: Exception do
            Log('������: ' + E.Message);
        end;
      end;

      IBDB.Connected := False;
      IBDB.Connected := True;

      AlterTrigger.TriggerName := 'AC_BI_ENTRY_RECORD';
      AlterTrigger.Description :=
        'FOR AC_ENTRY ' + #13#10 +
        'ACTIVE BEFORE INSERT POSITION 10 ' + #13#10 +
        'AS ' + #13#10 +
        'BEGIN ' + #13#10 +
        '  /* Trigger text */ ' + #13#10 +
        '  SELECT documentkey, masterdockey, transactionkey, companykey FROM ac_record ' + #13#10 +
        '  WHERE id = NEW.recordkey ' + #13#10 +
        '  INTO NEW.documentkey, NEW.masterdockey, NEW.transactionkey, NEW.companykey; ' + #13#10 +
        'END ';

      Log(Format('���������� �������� %s ', [AlterTrigger.TriggerName]));
      try
        CreateTrigger(AlterTrigger, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      AlterTrigger.TriggerName := 'AC_BU_ENTRY_RECORD';
      AlterTrigger.Description :=
        'FOR AC_ENTRY ' + #13#10 +
        'ACTIVE BEFORE UPDATE POSITION 10 ' + #13#10 +
        'AS ' + #13#10 +
        'BEGIN ' + #13#10 +
        '  /* Trigger text */ ' + #13#10 +
        '  SELECT documentkey, masterdockey, transactionkey, companykey FROM ac_record ' + #13#10 +
        '  WHERE id = NEW.recordkey ' + #13#10 +
        '  INTO NEW.documentkey, NEW.masterdockey, NEW.transactionkey, NEW.companykey; ' + #13#10 +
        'END ';

      Log(Format('���������� �������� %s ', [AlterTrigger.TriggerName]));
      try
        CreateTrigger(AlterTrigger, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      StoredProcedure.ProcedureName := 'AC_CIRCULATIONLIST';
      StoredProcedure.Description :=
        '( ' + #13#10 +
        '    DATEBEGIN DATE, ' + #13#10 +
        '    DATEEND DATE, ' + #13#10 +
        '    COMPANYKEY INTEGER, ' + #13#10 +
        '    ALLHOLDINGCOMPANIES INTEGER, ' + #13#10 +
        '    ACCOUNTKEY INTEGER, ' + #13#10 +
        '    INGROUP INTEGER, ' + #13#10 +
        '    CURRKEY INTEGER) ' + #13#10 +
        'RETURNS ( ' + #13#10 +
        '    ALIAS VARCHAR(20), ' + #13#10 +
        '    NAME VARCHAR(180), ' + #13#10 +
        '    ID INTEGER, ' + #13#10 +
        '    NCU_BEGIN_DEBIT NUMERIC(15,4), ' + #13#10 +
        '    NCU_BEGIN_CREDIT NUMERIC(15,4), ' + #13#10 +
        '    NCU_DEBIT NUMERIC(15,4), ' + #13#10 +
        '    NCU_CREDIT NUMERIC(15,4), ' + #13#10 +
        '    NCU_END_DEBIT NUMERIC(15,4), ' + #13#10 +
        '    NCU_END_CREDIT NUMERIC(15,4), ' + #13#10 +
        '    CURR_BEGIN_DEBIT NUMERIC(15,4), ' + #13#10 +
        '    CURR_BEGIN_CREDIT NUMERIC(15,4), ' + #13#10 +
        '    CURR_DEBIT NUMERIC(15,4), ' + #13#10 +
        '    CURR_CREDIT NUMERIC(15,4), ' + #13#10 +
        '    CURR_END_DEBIT NUMERIC(15,4), ' + #13#10 +
        '    CURR_END_CREDIT NUMERIC(15,4), ' + #13#10 +
        '    EQ_BEGIN_DEBIT NUMERIC(15,4), ' + #13#10 +
        '    EQ_BEGIN_CREDIT NUMERIC(15,4), ' + #13#10 +
        '    EQ_DEBIT NUMERIC(15,4), ' + #13#10 +
        '    EQ_CREDIT NUMERIC(15,4), ' + #13#10 +
        '    EQ_END_DEBIT NUMERIC(15,4), ' + #13#10 +
        '    EQ_END_CREDIT NUMERIC(15,4), ' + #13#10 +
        '    OFFBALANCE INTEGER) ' + #13#10 +
        'AS ' + #13#10 +
        'DECLARE VARIABLE ACTIVITY VARCHAR(1); ' + #13#10 +
        'DECLARE VARIABLE SALDO NUMERIC(15,4); ' + #13#10 +
        'DECLARE VARIABLE SALDOCURR NUMERIC(15,4); ' + #13#10 +
        'DECLARE VARIABLE SALDOEQ NUMERIC(15,4); ' + #13#10 +
        'DECLARE VARIABLE FIELDNAME VARCHAR(60); ' + #13#10 +
        'DECLARE VARIABLE LB INTEGER; ' + #13#10 +
        'DECLARE VARIABLE RB INTEGER; ' + #13#10 +
        'BEGIN                                                                                                 ' + #13#10 +
        '  /* Procedure Text */                                                                                ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '  SELECT c.lb, c.rb FROM ac_account c                                                                 ' + #13#10 +
        '  WHERE c.id = :ACCOUNTKEY                                                                            ' + #13#10 +
        '  INTO :lb, :rb;                                                                                      ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '  FOR                                                                                                 ' + #13#10 +
        '    SELECT a.ID, a.ALIAS, a.activity, f.fieldname, a.Name, a.offbalance                               ' + #13#10 +
        '    FROM ac_account a LEFT JOIN at_relation_fields f ON a.analyticalfield = f.id                      ' + #13#10 +
        '    WHERE                                                                                             ' + #13#10 +
        '      a.accounttype IN (''A'', ''S'') AND                                                                 ' + #13#10 +
        '      a.LB >= :LB AND a.RB <= :RB AND a.alias <> ''00''                                                 ' + #13#10 +
        '    INTO :id, :ALIAS, :activity, :fieldname, :name, :offbalance                                       ' + #13#10 +
        '  DO                                                                                                  ' + #13#10 +
        '  BEGIN                                                                                               ' + #13#10 +
        '    NCU_BEGIN_DEBIT = 0;                                                                              ' + #13#10 +
        '    NCU_BEGIN_CREDIT = 0;                                                                             ' + #13#10 +
        '    CURR_BEGIN_DEBIT = 0;                                                                             ' + #13#10 +
        '    CURR_BEGIN_CREDIT = 0;                                                                            ' + #13#10 +
        '    EQ_BEGIN_DEBIT = 0;                                                                               ' + #13#10 +
        '    EQ_BEGIN_CREDIT = 0; ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '    IF ((activity <> ''B'') OR (fieldname IS NULL)) THEN                                                ' + #13#10 +
        '    BEGIN ' + #13#10 +
        '      IF ( ALLHOLDINGCOMPANIES = 0) THEN ' + #13#10 +
        '      SELECT                                                                                          ' + #13#10 +
        '        SUM(e.DEBITNCU - e.CREDITNCU),                                                                ' + #13#10 +
        '        SUM(e.DEBITCURR - e.CREDITCURR), ' + #13#10 +
        '        SUM(e.DEBITEQ - e.CREDITEQ)                                                                   ' + #13#10 +
        '      FROM                                                                                            ' + #13#10 +
        '        ac_entry e                                                                                    ' + #13#10 +
        '      WHERE ' + #13#10 +
        '        e.accountkey = :id AND e.entrydate < :datebegin AND                                           ' + #13#10 +
        '        (e.companykey = :companykey) AND ' + #13#10 +
        '        ((0 = :currkey) OR (e.currkey = :currkey)) ' + #13#10 +
        '      INTO :SALDO,                                                                                    ' + #13#10 +
        '        :SALDOCURR, :SALDOEQ;                                                                         ' + #13#10 +
        '      ELSE ' + #13#10 +
        '      SELECT                                                                                          ' + #13#10 +
        '        SUM(e.DEBITNCU - e.CREDITNCU),                                                                ' + #13#10 +
        '        SUM(e.DEBITCURR - e.CREDITCURR),                                                              ' + #13#10 +
        '        SUM(e.DEBITEQ - e.CREDITEQ)                                                                   ' + #13#10 +
        '      FROM                                                                                            ' + #13#10 +
        '        ac_entry e                                                                                    ' + #13#10 +
        '      WHERE ' + #13#10 +
        '        e.accountkey = :id AND e.entrydate < :datebegin AND                                           ' + #13#10 +
        '        (e.companykey = :companykey or e.companykey IN ( ' + #13#10 +
        '          SELECT                                                                                      ' + #13#10 +
        '            h.companykey                                                                              ' + #13#10 +
        '          FROM                                                                                        ' + #13#10 +
        '            gd_holding h                                                                              ' + #13#10 +
        '          WHERE                                                                                       ' + #13#10 +
        '            h.holdingkey = :companykey)) AND ' + #13#10 +
        '        ((0 = :currkey) OR (e.currkey = :currkey)) ' + #13#10 +
        '      INTO :SALDO,                                                                                    ' + #13#10 +
        '        :SALDOCURR, :SALDOEQ;                                                                         ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '      IF (SALDO IS NULL) THEN                                                                         ' + #13#10 +
        '        SALDO = 0;                                                                                    ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '      IF (SALDOCURR IS NULL) THEN ' + #13#10 +
        '        SALDOCURR = 0;                                                                                ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '      IF (SALDOEQ IS NULL) THEN                                                                       ' + #13#10 +
        '        SALDOEQ = 0;                                                                                  ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '      IF (SALDO > 0) THEN                                                                             ' + #13#10 +
        '        NCU_BEGIN_DEBIT = SALDO;                                                                      ' + #13#10 +
        '      ELSE                                                                                            ' + #13#10 +
        '        NCU_BEGIN_CREDIT = 0 - SALDO;                                                                 ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '      IF (SALDOCURR > 0) THEN                                                                         ' + #13#10 +
        '        CURR_BEGIN_DEBIT = SALDOCURR;                                                                 ' + #13#10 +
        '      ELSE                                                                                            ' + #13#10 +
        '        CURR_BEGIN_CREDIT = 0 - SALDOCURR;                                                            ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '      IF (SALDOEQ > 0) THEN                                                                           ' + #13#10 +
        '        EQ_BEGIN_DEBIT = SALDOEQ;                                                                     ' + #13#10 +
        '      ELSE                                                                                            ' + #13#10 +
        '        EQ_BEGIN_CREDIT = 0 - SALDOEQ;                                                                ' + #13#10 +
        '    END                                                                                               ' + #13#10 +
        '    ELSE                                                                                              ' + #13#10 +
        '    BEGIN                                                                                             ' + #13#10 +
        '      SELECT                                                                                          ' + #13#10 +
        '        DEBITsaldo,                                                                                   ' + #13#10 +
        '        creditsaldo ' + #13#10 +
        '      FROM                                                                                            ' + #13#10 +
        '        AC_ACCOUNTEXSALDO(:datebegin, :ID, :FIELDNAME, :COMPANYKEY,                                   ' + #13#10 +
        '          :allholdingcompanies, :INGROUP, :currkey)                                                   ' + #13#10 +
        '      INTO                                                                                            ' + #13#10 +
        '        :NCU_BEGIN_DEBIT,                                                                             ' + #13#10 +
        '        :NCU_BEGIN_CREDIT;                                                                            ' + #13#10 +
        '    END ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '    IF (ALLHOLDINGCOMPANIES = 0) THEN ' + #13#10 +
        '    SELECT                                                                                            ' + #13#10 +
        '      SUM(e.DEBITNCU),                                                                                ' + #13#10 +
        '      SUM(e.CREDITNCU),                                                                               ' + #13#10 +
        '      SUM(e.DEBITCURR),                                                                               ' + #13#10 +
        '      SUM(e.CREDITCURR),                                                                              ' + #13#10 +
        '      SUM(e.DEBITEQ),                                                                                 ' + #13#10 +
        '      SUM(e.CREDITEQ)                                                                                 ' + #13#10 +
        '    FROM                                                                                              ' + #13#10 +
        '      ac_entry e                                                                                      ' + #13#10 +
        '    WHERE ' + #13#10 +
        '      e.accountkey = :id AND e.entrydate >= :datebegin AND                                            ' + #13#10 +
        '      e.entrydate <= :dateend AND                                                                     ' + #13#10 +
        '        (e.companykey = :companykey) AND ' + #13#10 +
        '        ((0 = :currkey) OR (e.currkey = :currkey))                                                    ' + #13#10 +
        '    INTO :NCU_DEBIT, :NCU_CREDIT, ' + #13#10 +
        '      :CURR_DEBIT, CURR_CREDIT,                                                                       ' + #13#10 +
        '      :EQ_DEBIT, EQ_CREDIT; ' + #13#10 +
        '    ELSE ' + #13#10 +
        '    SELECT                                                                                            ' + #13#10 +
        '      SUM(e.DEBITNCU),                                                                                ' + #13#10 +
        '      SUM(e.CREDITNCU),                                                                               ' + #13#10 +
        '      SUM(e.DEBITCURR), ' + #13#10 +
        '      SUM(e.CREDITCURR),                                                                              ' + #13#10 +
        '      SUM(e.DEBITEQ),                                                                                 ' + #13#10 +
        '      SUM(e.CREDITEQ)                                                                                 ' + #13#10 +
        '    FROM                                                                                              ' + #13#10 +
        '      ac_entry e                                                                                      ' + #13#10 +
        '    WHERE ' + #13#10 +
        '      e.accountkey = :id AND e.entrydate >= :datebegin AND                                            ' + #13#10 +
        '      e.entrydate <= :dateend AND ' + #13#10 +
        '      (e.companykey = :companykey or e.companykey IN ( ' + #13#10 +
        '          SELECT                                                                                      ' + #13#10 +
        '            h.companykey                                                                              ' + #13#10 +
        '          FROM                                                                                        ' + #13#10 +
        '            gd_holding h                                                                              ' + #13#10 +
        '          WHERE                                                                                       ' + #13#10 +
        '            h.holdingkey = :companykey)) AND ' + #13#10 +
        '      ((0 = :currkey) OR (e.currkey = :currkey)) ' + #13#10 +
        '    INTO :NCU_DEBIT, :NCU_CREDIT,                                                                     ' + #13#10 +
        '      :CURR_DEBIT, CURR_CREDIT,                                                                       ' + #13#10 +
        '      :EQ_DEBIT, EQ_CREDIT; ' + #13#10 +
        '                                                                                                            ' + #13#10 +
        '    IF (NCU_DEBIT IS NULL) THEN                                                                       ' + #13#10 +
        '      NCU_DEBIT = 0;                                                                                  ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '    IF (NCU_CREDIT IS NULL) THEN                                                                      ' + #13#10 +
        '      NCU_CREDIT = 0;                                                                                 ' + #13#10 +
        ' ' + #13#10 +
        '    IF (CURR_DEBIT IS NULL) THEN                                                                      ' + #13#10 +
        '      CURR_DEBIT = 0;                                                                                 ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '    IF (CURR_CREDIT IS NULL) THEN                                                                     ' + #13#10 +
        '      CURR_CREDIT = 0;                                                                                ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '    IF (EQ_DEBIT IS NULL) THEN ' + #13#10 +
        '      EQ_DEBIT = 0;                                                                                   ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '    IF (EQ_CREDIT IS NULL) THEN                                                                       ' + #13#10 +
        '      EQ_CREDIT = 0;                                                                                  ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '    NCU_END_DEBIT = 0;                                                                                ' + #13#10 +
        '    NCU_END_CREDIT = 0;                                                                               ' + #13#10 +
        '    CURR_END_DEBIT = 0;                                                                               ' + #13#10 +
        '    CURR_END_CREDIT = 0;                                                                              ' + #13#10 +
        '    EQ_END_DEBIT = 0;                                                                                 ' + #13#10 +
        '    EQ_END_CREDIT = 0;                                                                                ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '    IF ((ACTIVITY <> ''B'') OR (FIELDNAME IS NULL)) THEN                                                ' + #13#10 +
        '    BEGIN                                                                                             ' + #13#10 +
        '      SALDO = NCU_BEGIN_DEBIT - NCU_BEGIN_CREDIT + NCU_DEBIT - NCU_CREDIT;                            ' + #13#10 +
        '      IF (SALDO > 0) THEN                                                                             ' + #13#10 +
        '        NCU_END_DEBIT = SALDO;                                                                        ' + #13#10 +
        '      ELSE                                                                                            ' + #13#10 +
        '        NCU_END_CREDIT = 0 - SALDO;                                                                   ' + #13#10 +
        '                                                                                                      ' + #13#10 +
        '      SALDOCURR = CURR_BEGIN_DEBIT - CURR_BEGIN_CREDIT + CURR_DEBIT - CURR_CREDIT;                    ' + #13#10 +
        '      IF (SALDOCURR > 0) THEN                                                                         ' + #13#10 +
        '        CURR_END_DEBIT = SALDOCURR;                                                                   ' + #13#10 +
        '      ELSE                                                                                            ' + #13#10 +
        '        CURR_END_CREDIT = 0 - SALDOCURR;                                                              ' + #13#10 +
        ' ' + #13#10 +
        '      SALDOEQ = EQ_BEGIN_DEBIT - EQ_BEGIN_CREDIT + EQ_DEBIT - EQ_CREDIT;                              ' + #13#10 +
        '      IF (SALDOEQ > 0) THEN                                                                           ' + #13#10 +
        '        EQ_END_DEBIT = SALDOEQ;                                                                       ' + #13#10 +
        '      ELSE                                                                                            ' + #13#10 +
        '        EQ_END_CREDIT = 0 - SALDOEQ;                                                                  ' + #13#10 +
        '    END                                                                                               ' + #13#10 +
        '    ELSE ' + #13#10 +
        '    BEGIN ' + #13#10 +
        '      IF ((NCU_BEGIN_DEBIT <> 0) OR (NCU_BEGIN_CREDIT <> 0) OR ' + #13#10 +
        '        (NCU_DEBIT <> 0) OR (NCU_CREDIT <> 0) OR ' + #13#10 +
        '        (CURR_BEGIN_DEBIT <> 0) OR (CURR_BEGIN_CREDIT <> 0) OR ' + #13#10 +
        '        (CURR_DEBIT <> 0) OR (CURR_CREDIT <> 0) OR ' + #13#10 +
        '        (EQ_BEGIN_DEBIT <> 0) OR (EQ_BEGIN_CREDIT <> 0) OR ' + #13#10 +
        '        (EQ_DEBIT <> 0) OR (EQ_CREDIT <> 0)) THEN ' + #13#10 +
        '      BEGIN ' + #13#10 +
        '        SELECT ' + #13#10 +
        '          DEBITsaldo, creditsaldo, ' + #13#10 +
        '          CurrDEBITsaldo, Currcreditsaldo, ' + #13#10 +
        '          EQDEBITsaldo, EQcreditsaldo ' + #13#10 +
        '        FROM AC_ACCOUNTEXSALDO(:DATEEND + 1, :ID, :FIELDNAME, :COMPANYKEY, ' + #13#10 +
        '          :allholdingcompanies, :INGROUP, :currkey) ' + #13#10 +
        '        INTO :NCU_END_DEBIT, :NCU_END_CREDIT, :CURR_END_DEBIT, :CURR_END_CREDIT, :EQ_END_DEBIT, :EQ_END_CREDIT; ' + #13#10 +
        '      END ' + #13#10 +
        '    END ' + #13#10 +
        '    IF ((NCU_BEGIN_DEBIT <> 0) OR (NCU_BEGIN_CREDIT <> 0) OR ' + #13#10 +
        '      (NCU_DEBIT <> 0) OR (NCU_CREDIT <> 0) OR ' + #13#10 +
        '      (CURR_BEGIN_DEBIT <> 0) OR (CURR_BEGIN_CREDIT <> 0) OR ' + #13#10 +
        '      (CURR_DEBIT <> 0) OR (CURR_CREDIT <> 0) OR ' + #13#10 +
        '      (EQ_BEGIN_DEBIT <> 0) OR (EQ_BEGIN_CREDIT <> 0) OR ' + #13#10 +
        '      (EQ_DEBIT <> 0) OR (EQ_CREDIT <> 0)) THEN ' + #13#10 +
        '    SUSPEND; ' + #13#10 +
        '  END ' + #13#10 +
        'END ';

      Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
      try
        AlterProcedure(StoredProcedure, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      StoredProcedure.ProcedureName := 'AC_E_L_S';
      StoredProcedure.Description :=
        '( '+ #13#10 +
        '    ABEGINENTRYDATE DATE, '+ #13#10 +
        '    SALDOBEGIN NUMERIC(18,4), '+ #13#10 +
        '    SALDOBEGINCURR NUMERIC(18,4), '+ #13#10 +
        '    SALDOBEGINEQ NUMERIC(18,4), '+ #13#10 +
        '    SQLHANDLE INTEGER, '+ #13#10 +
        '    CURRKEY INTEGER) '+ #13#10 +
        'RETURNS ( '+ #13#10 +
        '    ENTRYDATE DATE, '+ #13#10 +
        '    DEBITNCUBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITNCUBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITNCUEND NUMERIC(15,4), '+ #13#10 +
        '    CREDITNCUEND NUMERIC(15,4), '+ #13#10 +
        '    DEBITCURRBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITCURRBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITCURREND NUMERIC(15,4), '+ #13#10 +
        '    CREDITCURREND NUMERIC(15,4), '+ #13#10 +
        '    DEBITEQBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITEQBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITEQEND NUMERIC(15,4), '+ #13#10 +
        '    CREDITEQEND NUMERIC(15,4), '+ #13#10 +
        '    FORCESHOW INTEGER) '+ #13#10 +
        'AS '+ #13#10 +
        'DECLARE VARIABLE O NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOEND NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE OCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE OEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE C INTEGER; '+ #13#10 +
        'BEGIN '+ #13#10 +
        '  IF (saldobegin IS NULL) THEN '+ #13#10 +
        '    saldobegin = 0; '+ #13#10 +
        '  IF (saldobegincurr IS NULL) THEN '+ #13#10 +
        '    saldobegincurr = 0; '+ #13#10 +
        '  IF (saldobegineq IS NULL) THEN '+ #13#10 +
        '    saldobegineq = 0; '+ #13#10 +
        '  C = 0; '+ #13#10 +
        '  FORCESHOW = 0; '+ #13#10 +
        '  FOR '+ #13#10 +
        '    SELECT '+ #13#10 +
        '      e.entrydate, '+ #13#10 +
        '      SUM(e.debitncu - e.creditncu), '+ #13#10 +
        '      SUM(e.debitcurr - e.creditcurr), '+ #13#10 +
        '      SUM(e.debiteq - e.crediteq) '+ #13#10 +
        '    FROM '+ #13#10 +
        '      ac_ledger_entries le '+ #13#10 +
        '      LEFT JOIN ac_entry e ON le.entrykey = e.id '+ #13#10 +
        '    WHERE '+ #13#10 +
        '      le.sqlhandle = :sqlhandle AND '+ #13#10 +
        '      ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
        '    group by e.entrydate '+ #13#10 +
        '    INTO :ENTRYDATE, '+ #13#10 +
        '         :O, '+ #13#10 +
        '         :OCURR, '+ #13#10 +
        '         :OEQ '+ #13#10 +
        '  DO '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    DEBITNCUBEGIN = 0; '+ #13#10 +
        '    CREDITNCUBEGIN = 0; '+ #13#10 +
        '    DEBITNCUEND = 0; '+ #13#10 +
        '    CREDITNCUEND = 0; '+ #13#10 +
        '    DEBITCURRBEGIN = 0; '+ #13#10 +
        '    CREDITCURRBEGIN = 0; '+ #13#10 +
        '    DEBITCURREND = 0; '+ #13#10 +
        '    CREDITCURREND = 0; '+ #13#10 +
        '    DEBITEQBEGIN = 0; '+ #13#10 +
        '    CREDITEQBEGIN = 0; '+ #13#10 +
        '    DEBITEQEND = 0; '+ #13#10 +
        '    CREDITEQEND = 0; '+ #13#10 +
        '    SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
        '    if (SALDOBEGIN > 0) then '+ #13#10 +
        '      DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '    if (SALDOEND > 0) then '+ #13#10 +
        '      DEBITNCUEND = :SALDOEND; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITNCUEND =  - :SALDOEND; '+ #13#10 +
        '    SALDOENDCURR = :SALDOBEGINCURR + :OCURR; '+ #13#10 +
        '    if (SALDOBEGINCURR > 0) then '+ #13#10 +
        '      DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
        '    if (SALDOENDCURR > 0) then '+ #13#10 +
        '      DEBITCURREND = :SALDOENDCURR; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITCURREND =  - :SALDOENDCURR; '+ #13#10 +
        '    SALDOENDEQ = :SALDOBEGINEQ + :OEQ; '+ #13#10 +
        '    if (SALDOBEGINEQ > 0) then '+ #13#10 +
        '      DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
        '    if (SALDOENDEQ > 0) then '+ #13#10 +
        '      DEBITEQEND = :SALDOENDEQ; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITEQEND =  - :SALDOENDEQ; '+ #13#10 +
        '    SUSPEND; '+ #13#10 +
        '    SALDOBEGIN = :SALDOEND; '+ #13#10 +
        '    SALDOBEGINCURR = :SALDOENDCURR; '+ #13#10 +
        '    SALDOBEGINEQ = :SALDOENDEQ; '+ #13#10 +
        '    C = C + 1; '+ #13#10 +
        '  END '+ #13#10 +
        '  /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
        '  IF (C = 0) THEN '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    ENTRYDATE = :abeginentrydate; '+ #13#10 +
        '    IF (SALDOBEGIN > 0) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
        '      DEBITNCUEND = :SALDOBEGIN; '+ #13#10 +
        '    END ELSE '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '      CREDITNCUEND =  - :SALDOBEGIN; '+ #13#10 +
        '    END '+ #13#10 +
        ' '+ #13#10 +
        '    IF (SALDOBEGINCURR > 0) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
        '      DEBITCURREND = :SALDOBEGINCURR; '+ #13#10 +
        '    END ELSE '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
        '      CREDITCURREND =  - :SALDOBEGINCURR; '+ #13#10 +
        '    END '+ #13#10 +
        ' '+ #13#10 +
        '    IF (SALDOBEGINEQ > 0) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
        '      DEBITEQEND = :SALDOBEGINEQ; '+ #13#10 +
        '    END ELSE '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
        '      CREDITEQEND =  - :SALDOBEGINEQ; '+ #13#10 +
        '    END '+ #13#10 +
        ' '+ #13#10 +
        '    FORCESHOW = 1; '+ #13#10 +
        '    SUSPEND; '+ #13#10 +
        '  END '+ #13#10 +
        'END ';

      Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
      try
        AlterProcedure(StoredProcedure, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      StoredProcedure.ProcedureName := 'AC_E_L_S1';
      StoredProcedure.Description :=
        '( '+ #13#10 +
        '    ABEGINENTRYDATE DATE, '+ #13#10 +
        '    SALDOBEGIN NUMERIC(18,4), '+ #13#10 +
        '    SALDOBEGINCURR NUMERIC(18,4), '+ #13#10 +
        '    SALDOBEGINEQ INTEGER, '+ #13#10 +
        '    SQLHANDLE INTEGER, '+ #13#10 +
        '    PARAM INTEGER, '+ #13#10 +
        '    CURRKEY INTEGER) '+ #13#10 +
        'RETURNS ( '+ #13#10 +
        '    DATEPARAM INTEGER, '+ #13#10 +
        '    DEBITNCUBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITNCUBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITNCUEND NUMERIC(15,4), '+ #13#10 +
        '    CREDITNCUEND NUMERIC(15,4), '+ #13#10 +
        '    DEBITCURRBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITCURRBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITCURREND NUMERIC(15,4), '+ #13#10 +
        '    CREDITCURREND NUMERIC(15,4), '+ #13#10 +
        '    DEBITEQBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITEQBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITEQEND NUMERIC(15,4), '+ #13#10 +
        '    CREDITEQEND NUMERIC(15,4), '+ #13#10 +
        '    FORCESHOW INTEGER) '+ #13#10 +
        'AS '+ #13#10 +
        'DECLARE VARIABLE O NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOEND NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE OCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE OEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE C INTEGER; '+ #13#10 +
        'BEGIN '+ #13#10 +
        '  IF (saldobegin IS NULL) THEN '+ #13#10 +
        '    saldobegin = 0; '+ #13#10 +
        '  IF (saldobegincurr IS NULL) THEN '+ #13#10 +
        '    saldobegincurr = 0; '+ #13#10 +
        '  IF (saldobegineq IS NULL) THEN '+ #13#10 +
        '    saldobegineq = 0; '+ #13#10 +
        '  C = 0; '+ #13#10 +
        '  FORCESHOW = 0; '+ #13#10 +
        '  FOR '+ #13#10 +
        '    SELECT '+ #13#10 +
        '      SUM(e.debitncu - e.creditncu), '+ #13#10 +
        '      SUM(e.debitcurr - e.creditcurr), '+ #13#10 +
        '      SUM(e.debiteq - e.crediteq), '+ #13#10 +
        '      g_d_getdateparam(e.entrydate, :param) '+ #13#10 +
        '    FROM '+ #13#10 +
        '      ac_ledger_entries le '+ #13#10 +
        '      LEFT JOIN ac_entry e ON le.entrykey = e.id '+ #13#10 +
        '    WHERE '+ #13#10 +
        '      le.sqlhandle = :sqlhandle AND '+ #13#10 +
        '      ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
        '    group by 4 '+ #13#10 +
        '    INTO :O, '+ #13#10 +
        '         :OCURR, '+ #13#10 +
        '         :OEQ, '+ #13#10 +
        '         :dateparam '+ #13#10 +
        '  DO '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    DEBITNCUBEGIN = 0; '+ #13#10 +
        '    CREDITNCUBEGIN = 0; '+ #13#10 +
        '    DEBITNCUEND = 0; '+ #13#10 +
        '    CREDITNCUEND = 0; '+ #13#10 +
        '    DEBITCURRBEGIN = 0; '+ #13#10 +
        '    CREDITCURRBEGIN = 0; '+ #13#10 +
        '    DEBITCURREND = 0; '+ #13#10 +
        '    CREDITCURREND = 0; '+ #13#10 +
        '    DEBITEQBEGIN = 0; '+ #13#10 +
        '    CREDITEQBEGIN = 0; '+ #13#10 +
        '    DEBITEQEND = 0; '+ #13#10 +
        '    CREDITEQEND = 0; '+ #13#10 +
        '    SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
        '    if (SALDOBEGIN > 0) then '+ #13#10 +
        '      DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '    if (SALDOEND > 0) then '+ #13#10 +
        '      DEBITNCUEND = :SALDOEND; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITNCUEND =  - :SALDOEND; '+ #13#10 +
        '    SALDOENDCURR = :SALDOBEGINCURR + :OCURR; '+ #13#10 +
        '    if (SALDOBEGINCURR > 0) then '+ #13#10 +
        '      DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
        '    if (SALDOENDCURR > 0) then '+ #13#10 +
        '      DEBITCURREND = :SALDOENDCURR; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITCURREND =  - :SALDOENDCURR; '+ #13#10 +
        '    SALDOENDEQ = :SALDOBEGINEQ + :OEQ; '+ #13#10 +
        '    if (SALDOBEGINEQ > 0) then '+ #13#10 +
        '      DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
        '    if (SALDOENDEQ > 0) then '+ #13#10 +
        '      DEBITEQEND = :SALDOENDEQ; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITEQEND =  - :SALDOENDEQ; '+ #13#10 +
        '    SUSPEND; '+ #13#10 +
        '    SALDOBEGIN = :SALDOEND; '+ #13#10 +
        '    SALDOBEGINCURR = :SALDOENDCURR; '+ #13#10 +
        '    SALDOBEGINEQ = :SALDOENDEQ; '+ #13#10 +
        '    C = C + 1; '+ #13#10 +
        '  END '+ #13#10 +
        '  /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
        '  IF (C = 0) THEN '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    DATEPARAM = g_d_getdateparam(:abeginentrydate, :param); '+ #13#10 +
        '    IF (SALDOBEGIN > 0) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
        '      DEBITNCUEND = :SALDOBEGIN; '+ #13#10 +
        '    END ELSE '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '      CREDITNCUEND =  - :SALDOBEGIN; '+ #13#10 +
        '    END '+ #13#10 +
        ' '+ #13#10 +
        '    IF (SALDOBEGINCURR > 0) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
        '      DEBITCURREND = :SALDOBEGINCURR; '+ #13#10 +
        '    END ELSE '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
        '      CREDITCURREND =  - :SALDOBEGINCURR; '+ #13#10 +
        '    END '+ #13#10 +
        ' '+ #13#10 +
        '    IF (SALDOBEGINEQ > 0) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
        '      DEBITEQEND = :SALDOBEGINEQ; '+ #13#10 +
        '    END ELSE '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
        '      CREDITEQEND =  - :SALDOBEGINEQ; '+ #13#10 +
        '    END '+ #13#10 +
        ' '+ #13#10 +
        '    FORCESHOW = 1; '+ #13#10 +
        '    SUSPEND; '+ #13#10 +
        '  END '+ #13#10 +
        'END ';

      Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
      try
        AlterProcedure(StoredProcedure, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      StoredProcedure.ProcedureName := 'AC_E_Q_S';
      StoredProcedure.Description :=
        '( '+ #13#10 +
        '    VALUEKEY INTEGER, '+ #13#10 +
        '    ABEGINENTRYDATE DATE, '+ #13#10 +
        '    SALDOBEGIN NUMERIC(15,4), '+ #13#10 +
        '    SQLHANDLE INTEGER, '+ #13#10 +
        '    CURRKEY INTEGER) '+ #13#10 +
        'RETURNS ( '+ #13#10 +
        '    ENTRYDATE DATE, '+ #13#10 +
        '    DEBITBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBIT NUMERIC(15,4), '+ #13#10 +
        '    CREDIT NUMERIC(15,4), '+ #13#10 +
        '    DEBITEND NUMERIC(15,4), '+ #13#10 +
        '    CREDITEND NUMERIC(15,4)) '+ #13#10 +
        'AS '+ #13#10 +
        'DECLARE VARIABLE O NUMERIC(15,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOEND NUMERIC(15,4); '+ #13#10 +
        'DECLARE VARIABLE C INTEGER; '+ #13#10 +
        'BEGIN '+ #13#10 +
        '  C = 0; '+ #13#10 +
        '  if (saldobegin IS NULL) then '+ #13#10 +
        '    saldobegin = 0; '+ #13#10 +
        ' '+ #13#10 +
        '  FOR '+ #13#10 +
        '    SELECT '+ #13#10 +
        '      e.entrydate, '+ #13#10 +
        '      SUM(IIF(e.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
        '        SUM(IIF(e.accountpart = ''C'', q.quantity, 0)) '+ #13#10 +
        '    FROM '+ #13#10 +
        '      ac_ledger_entries le '+ #13#10 +
        '      LEFT JOIN ac_entry e ON le.entrykey = e.id '+ #13#10 +
        '      LEFT JOIN ac_quantity q ON q.entrykey = e.id AND q.valuekey = :valuekey '+ #13#10 +
        '    WHERE '+ #13#10 +
        '      le.sqlhandle = :SQLHANDLE AND '+ #13#10 +
        '      ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
        '    GROUP BY e.entrydate '+ #13#10 +
        '    INTO :ENTRYDATE, '+ #13#10 +
        '         :O '+ #13#10 +
        '  DO '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    IF (O IS NULL) THEN O = 0; '+ #13#10 +
        '    DEBITBEGIN = 0; '+ #13#10 +
        '    CREDITBEGIN = 0; '+ #13#10 +
        '    DEBITEND = 0; '+ #13#10 +
        '    CREDITEND = 0; '+ #13#10 +
        '    DEBIT = 0; '+ #13#10 +
        '    CREDIT = 0; '+ #13#10 +
        '    IF (O > 0) THEN '+ #13#10 +
        '      DEBIT = :O; '+ #13#10 +
        '    ELSE '+ #13#10 +
        '      CREDIT = - :O; '+ #13#10 +
        ' '+ #13#10 +
        '    SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
        '    if (SALDOBEGIN > 0) then '+ #13#10 +
        '      DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '    if (SALDOEND > 0) then '+ #13#10 +
        '      DEBITEND = :SALDOEND; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITEND =  - :SALDOEND; '+ #13#10 +
        '    SUSPEND; '+ #13#10 +
        '    SALDOBEGIN = :SALDOEND; '+ #13#10 +
        '    C = C + 1; '+ #13#10 +
        '  END '+ #13#10 +
        '  /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
        '  IF (C = 0) THEN '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    ENTRYDATE = :abeginentrydate; '+ #13#10 +
        '    IF (SALDOBEGIN > 0) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
        '      DEBITEND = :SALDOBEGIN; '+ #13#10 +
        '    END ELSE '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '      CREDITEND =  - :SALDOBEGIN; '+ #13#10 +
        '    END '+ #13#10 +
        '    SUSPEND; '+ #13#10 +
        '  END '+ #13#10 +
        'END ';

      Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
      try
        AlterProcedure(StoredProcedure, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      StoredProcedure.ProcedureName := 'AC_E_Q_S1';
      StoredProcedure.Description :=
        '( '+ #13#10 +
        '    VALUEKEY INTEGER, '+ #13#10 +
        '    ABEGINENTRYDATE DATE, '+ #13#10 +
        '    SALDOBEGIN NUMERIC(15,4), '+ #13#10 +
        '    SQLHANDLE INTEGER, '+ #13#10 +
        '    PARAM INTEGER, '+ #13#10 +
        '    CURRKEY INTEGER) '+ #13#10 +
        'RETURNS ( '+ #13#10 +
        '    DATEPARAM INTEGER, '+ #13#10 +
        '    DEBITBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBIT NUMERIC(15,4), '+ #13#10 +
        '    CREDIT NUMERIC(15,4), '+ #13#10 +
        '    DEBITEND NUMERIC(15,4), '+ #13#10 +
        '    CREDITEND NUMERIC(15,4)) '+ #13#10 +
        'AS '+ #13#10 +
        'DECLARE VARIABLE O NUMERIC(15,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOEND NUMERIC(15,4); '+ #13#10 +
        'DECLARE VARIABLE C INTEGER; '+ #13#10 +
        'BEGIN '+ #13#10 +
        '  C = 0; '+ #13#10 +
        '  if (SALDOBEGIN IS NULL) THEN '+ #13#10 +
        '    SALDOBEGIN = 0; '+ #13#10 +
        ' '+ #13#10 +
        '  FOR '+ #13#10 +
        '    SELECT '+ #13#10 +
        '      g_d_getdateparam(e.entrydate, :param), '+ #13#10 +
        '      SUM(IIF(e.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
        '        SUM(IIF(e.accountpart = ''C'', q.quantity, 0)) '+ #13#10 +
        '    FROM '+ #13#10 +
        '      ac_ledger_entries le '+ #13#10 +
        '      LEFT JOIN ac_entry e ON le.entrykey = e.id '+ #13#10 +
        '      LEFT JOIN ac_quantity q ON q.entrykey = e.id AND q.valuekey = :valuekey '+ #13#10 +
        '    WHERE '+ #13#10 +
        '      le.sqlhandle = :SQLHANDLE AND '+ #13#10 +
        '      ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
        '    GROUP BY 1 '+ #13#10 +
        '    INTO :dateparam, '+ #13#10 +
        '         :O '+ #13#10 +
        '  DO '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    IF (O IS NULL) THEN O = 0; '+ #13#10 +
        '    DEBITBEGIN = 0; '+ #13#10 +
        '    CREDITBEGIN = 0; '+ #13#10 +
        '    DEBITEND = 0; '+ #13#10 +
        '    CREDITEND = 0; '+ #13#10 +
        '    DEBIT = 0; '+ #13#10 +
        '    CREDIT = 0; '+ #13#10 +
        '    IF (O > 0) THEN '+ #13#10 +
        '      DEBIT = :O; '+ #13#10 +
        '    ELSE '+ #13#10 +
        '      CREDIT = - :O; '+ #13#10 +
        ' '+ #13#10 +
        '    SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
        '    if (SALDOBEGIN > 0) then '+ #13#10 +
        '      DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '    if (SALDOEND > 0) then '+ #13#10 +
        '      DEBITEND = :SALDOEND; '+ #13#10 +
        '    else '+ #13#10 +
        '      CREDITEND =  - :SALDOEND; '+ #13#10 +
        '    SUSPEND; '+ #13#10 +
        '    SALDOBEGIN = :SALDOEND; '+ #13#10 +
        '    C = C + 1; '+ #13#10 +
        '  END '+ #13#10 +
        '  /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
        '  IF (C = 0) THEN '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    DATEPARAM = g_d_getdateparam(:abeginentrydate, :param); '+ #13#10 +
        '    IF (SALDOBEGIN > 0) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
        '      DEBITEND = :SALDOBEGIN; '+ #13#10 +
        '    END ELSE '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '      CREDITEND =  - :SALDOBEGIN; '+ #13#10 +
        '    END '+ #13#10 +
        '    SUSPEND; '+ #13#10 +
        '  END '+ #13#10 +
        'END ';

      Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
      try
        AlterProcedure(StoredProcedure, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      StoredProcedure.ProcedureName := 'AC_G_L_S';
      StoredProcedure.Description :=
        '( '+ #13#10 +
        '    ABEGINENTRYDATE DATE, '+ #13#10 +
        '    AENDENTRYDATE DATE, '+ #13#10 +
        '    SQLHANDLE INTEGER, '+ #13#10 +
        '    COMPANYKEY INTEGER, '+ #13#10 +
        '    ALLHOLDINGCOMPANIES INTEGER, '+ #13#10 +
        '    INGROUP INTEGER, '+ #13#10 +
        '    CURRKEY INTEGER, '+ #13#10 +
        '    ANALYTICFIELD VARCHAR(60)) '+ #13#10 +
        'RETURNS ( '+ #13#10 +
        '    M INTEGER, '+ #13#10 +
        '    Y INTEGER, '+ #13#10 +
        '    BEGINDATE DATE, '+ #13#10 +
        '    ENDDATE DATE, '+ #13#10 +
        '    DEBITNCUBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITNCUBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITNCUEND NUMERIC(15,4), '+ #13#10 +
        '    CREDITNCUEND NUMERIC(15,4), '+ #13#10 +
        '    DEBITCURRBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITCURRBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITCURREND NUMERIC(15,4), '+ #13#10 +
        '    CREDITCURREND NUMERIC(15,4), '+ #13#10 +
        '    DEBITEQBEGIN NUMERIC(18,4), '+ #13#10 +
        '    CREDITEQBEGIN NUMERIC(18,4), '+ #13#10 +
        '    DEBITEQEND NUMERIC(18,4), '+ #13#10 +
        '    CREDITEQEND NUMERIC(18,4), '+ #13#10 +
        '    FORCESHOW INTEGER) '+ #13#10 +
        'AS '+ #13#10 +
        'DECLARE VARIABLE O NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE OCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE OEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOBEGINDEBIT NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOBEGINCREDIT NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDDEBIT NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDCREDIT NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOBEGINDEBITCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOBEGINCREDITCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDDEBITCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDCREDITCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOBEGINDEBITEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOBEGINCREDITEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDDEBITEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDCREDITEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SD NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SC NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SDC NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SCC NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SDEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SCEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE C INTEGER; '+ #13#10 +
        'DECLARE VARIABLE ACCOUNTKEY INTEGER; '+ #13#10 +
        'DECLARE VARIABLE D DATE; '+ #13#10 +
        'DECLARE VARIABLE DAYINMONTH INTEGER; '+ #13#10 +
        'BEGIN '+ #13#10 +
        '  saldobegindebit = 0; '+ #13#10 +
        '  saldobegincredit = 0; '+ #13#10 +
        '  saldobegindebitcurr = 0; '+ #13#10 +
        '  saldobegincreditcurr = 0; '+ #13#10 +
        ' '+ #13#10 +
        '  IF (ANALYTICFIELD = '''') THEN '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    SELECT '+ #13#10 +
        '      IIF((NOT SUM(e1.debitncu - e1.creditncu) IS NULL) AND '+ #13#10 +
        '        (SUM(e1.debitncu - e1.creditncu) > 0), SUM(e1.debitncu - e1.creditncu),  0), '+ #13#10 +
        '      IIF((NOT SUM(e1.creditncu - e1.debitncu) IS NULL) AND '+ #13#10 +
        '        (SUM(e1.creditncu - e1.debitncu) > 0), SUM(e1.creditncu - e1.debitncu),  0), '+ #13#10 +
        '      IIF((NOT SUM(e1.debitcurr - e1.creditcurr) IS NULL) AND '+ #13#10 +
        '        (SUM(e1.debitcurr - e1.creditcurr) > 0), SUM(e1.debitcurr - e1.creditcurr),  0), '+ #13#10 +
        '      IIF((NOT SUM(e1.creditcurr - e1.debitcurr) IS NULL) AND '+ #13#10 +
        '        (SUM(e1.creditcurr - e1.debitcurr) > 0), SUM(e1.creditcurr - e1.debitcurr),  0), '+ #13#10 +
        '      IIF((NOT SUM(e1.debiteq - e1.crediteq) IS NULL) AND '+ #13#10 +
        '        (SUM(e1.debiteq - e1.crediteq) > 0), SUM(e1.debiteq - e1.crediteq),  0), '+ #13#10 +
        '      IIF((NOT SUM(e1.crediteq - e1.debiteq) IS NULL) AND '+ #13#10 +
        '        (SUM(e1.crediteq - e1.debiteq) > 0), SUM(e1.crediteq - e1.debiteq),  0) '+ #13#10 +
        '    FROM '+ #13#10 +
        '      ac_ledger_accounts a '+ #13#10 +
        '      JOIN ac_entry e1 ON a.accountkey = e1.accountkey AND e1.entrydate < :abeginentrydate '+ #13#10 +
        '        AND a.sqlhandle = :sqlhandle '+ #13#10 +
        '    WHERE '+ #13#10 +
        '      (e1.companykey + 0 = :companykey OR '+ #13#10 +
        '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
        '      e1.companykey + 0 IN ( '+ #13#10 +
        '        SELECT '+ #13#10 +
        '          h.companykey '+ #13#10 +
        '        FROM '+ #13#10 +
        '          gd_holding h '+ #13#10 +
        '        WHERE '+ #13#10 +
        '          h.holdingkey = :companykey))) AND '+ #13#10 +
        '      ((0 = :currkey) OR (e1.currkey = :currkey)) '+ #13#10 +
        '    INTO :saldobegindebit, '+ #13#10 +
        '         :saldobegincredit, '+ #13#10 +
        '         :saldobegindebitcurr, '+ #13#10 +
        '         :saldobegincreditcurr, '+ #13#10 +
        '         :saldobegindebiteq, '+ #13#10 +
        '         :saldobegincrediteq; '+ #13#10 +
        '  END ELSE '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    FOR '+ #13#10 +
        '      SELECT '+ #13#10 +
        '        la.accountkey '+ #13#10 +
        '      FROM '+ #13#10 +
        '        ac_ledger_accounts la '+ #13#10 +
        '      WHERE '+ #13#10 +
        '        la.sqlhandle = :sqlhandle '+ #13#10 +
        '      INTO :accountkey '+ #13#10 +
        '    DO '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      SELECT '+ #13#10 +
        '        a.DEBITSALDO, '+ #13#10 +
        '        a.CREDITSALDO, '+ #13#10 +
        '        a.CURRDEBITSALDO, '+ #13#10 +
        '        a.CURRCREDITSALDO, '+ #13#10 +
        '        a.EQDEBITSALDO, '+ #13#10 +
        '        a.EQCREDITSALDO '+ #13#10 +
        '      FROM '+ #13#10 +
        '        ac_accountexsaldo(:abeginentrydate, :accountkey, :analyticfield, :companykey, '+ #13#10 +
        '          :allholdingcompanies, -1, :currkey) a '+ #13#10 +
        '      INTO :sd, '+ #13#10 +
        '           :sc, '+ #13#10 +
        '           :sdc, '+ #13#10 +
        '           :scc, '+ #13#10 +
        '           :sdeq, '+ #13#10 +
        '           :sceq; '+ #13#10 +
        ' '+ #13#10 +
        '      IF (sd IS NULL) then SD = 0; '+ #13#10 +
        '      IF (sc IS NULL) then SC = 0; '+ #13#10 +
        '      IF (sdc IS NULL) then SDC = 0; '+ #13#10 +
        '      IF (scc IS NULL) then SCC = 0; '+ #13#10 +
        ' '+ #13#10 +
        '      saldobegindebit = :saldobegindebit + :sd; '+ #13#10 +
        '      saldobegincredit = :saldobegincredit + :sc; '+ #13#10 +
        '      saldobegindebitcurr = :saldobegindebitcurr + :sdc; '+ #13#10 +
        '      saldobegincreditcurr = :saldobegincreditcurr + :scc; '+ #13#10 +
        '      saldobegindebiteq = :saldobegindebiteq + :sdeq; '+ #13#10 +
        '      saldobegincrediteq = :saldobegincrediteq + :sceq; '+ #13#10 +
        '    END '+ #13#10 +
        '  END '+ #13#10 +
        ' '+ #13#10 +
        '  C = 0; '+ #13#10 +
        '  FORCESHOW = 0; '+ #13#10 +
        '  FOR '+ #13#10 +
        '    SELECT '+ #13#10 +
        '      SUM(e.debitncu - e.creditncu), '+ #13#10 +
        '      SUM(e.debitcurr - e.creditcurr), '+ #13#10 +
        '      SUM(e.debiteq - e.crediteq), '+ #13#10 +
        '      EXTRACT(MONTH FROM e.entrydate), '+ #13#10 +
        '      EXTRACT(YEAR FROM e.entrydate) '+ #13#10 +
        '    FROM '+ #13#10 +
        '      ac_ledger_accounts a '+ #13#10 +
        '      JOIN ac_entry e ON a.accountkey = e.accountkey AND '+ #13#10 +
        '           e.entrydate <= :aendentrydate AND '+ #13#10 +
        '           e.entrydate >= :abeginentrydate '+ #13#10 +
        '    AND a.sqlhandle = :sqlhandle  '+ #13#10 +
        '    WHERE '+ #13#10 +
        '      (e.companykey + 0 = :companykey OR '+ #13#10 +
        '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
        '      e.companykey + 0 IN ( '+ #13#10 +
        '        SELECT '+ #13#10 +
        '          h.companykey '+ #13#10 +
        '        FROM '+ #13#10 +
        '          gd_holding h '+ #13#10 +
        '        WHERE '+ #13#10 +
        '          h.holdingkey = :companykey))) AND '+ #13#10 +
        '      ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
        '    group by 4, 5 '+ #13#10 +
        '    ORDER BY 5, 4 '+ #13#10 +
        '    INTO :O, :OCURR, :OEQ, :M, :Y '+ #13#10 +
        '  DO '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    begindate = CAST(:Y || ''-'' || :M || ''-'' || 1 as DATE); '+ #13#10 +
        '    IF (begindate < :abeginentrydate) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      begindate = :abeginentrydate; '+ #13#10 +
        '    END '+ #13#10 +
        ' '+ #13#10 +
        '    DAYINMONTH = EXTRACT(DAY FROM g_d_incmonth(1, CAST(:Y || ''-'' || :M || ''-'' || 1 as DATE)) - 1); '+ #13#10 +
        ' '+ #13#10 +
        '    D = CAST(:Y || ''-'' || :M || ''-'' || :dayinmonth as DATE); '+ #13#10 +
        ' '+ #13#10 +
        '    IF (D > :aendentrydate) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      D = :aendentrydate; '+ #13#10 +
        '    END '+ #13#10 +
        '    ENDDATE = D; '+ #13#10 +
        '    DEBITNCUBEGIN = 0; '+ #13#10 +
        '    CREDITNCUBEGIN = 0; '+ #13#10 +
        '    DEBITNCUEND = 0; '+ #13#10 +
        '    CREDITNCUEND = 0; '+ #13#10 +
        '    DEBITCURRBEGIN = 0; '+ #13#10 +
        '    CREDITCURRBEGIN = 0; '+ #13#10 +
        '    DEBITCURREND = 0; '+ #13#10 +
        '    CREDITCURREND = 0; '+ #13#10 +
        '    DEBITEQBEGIN = 0; '+ #13#10 +
        '    CREDITEQBEGIN = 0; '+ #13#10 +
        '    DEBITEQEND = 0; '+ #13#10 +
        '    CREDITEQEND = 0; '+ #13#10 +
        '    IF (analyticfield = '''') THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      IF (:saldobegindebit - :saldobegincredit + :o > 0) THEN '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        SALDOENDDEBIT = :saldobegindebit - :saldobegincredit + :o; '+ #13#10 +
        '        SALDOENDCREDIT = 0; '+ #13#10 +
        '      END ELSE '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        SALDOENDDEBIT = 0; '+ #13#10 +
        '        SALDOENDCREDIT =  - (:saldobegindebit - :saldobegincredit + :o); '+ #13#10 +
        '      END '+ #13#10 +
        ' '+ #13#10 +
        '      IF (:saldobegindebitcurr - :saldobegincreditcurr + :ocurr > 0) THEN '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        SALDOENDDEBITCURR = :saldobegindebitCURR - :saldobegincreditCURR + :ocurr; '+ #13#10 +
        '        SALDOENDCREDITCURR = 0; '+ #13#10 +
        '      END ELSE '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        SALDOENDDEBITCURR = 0; '+ #13#10 +
        '        SALDOENDCREDITCURR =  - (:saldobegindebitcurr - :saldobegincreditcurr + :ocurr); '+ #13#10 +
        '      END '+ #13#10 +
        ' '+ #13#10 +
        '      IF (:saldobegindebiteq - :saldobegincrediteq + :oeq > 0) THEN '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        SALDOENDDEBITEQ = :saldobegindebiteq - :saldobegincrediteq + :oeq; '+ #13#10 +
        '        SALDOENDCREDITEQ = 0; '+ #13#10 +
        '      END ELSE '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        SALDOENDDEBITEQ = 0; '+ #13#10 +
        '        SALDOENDCREDITEQ =  - (:saldobegindebiteq - :saldobegincrediteq + :oeq); '+ #13#10 +
        '      END '+ #13#10 +
        '    END ELSE '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      saldoenddebit = 0; '+ #13#10 +
        '      saldoendcredit = 0; '+ #13#10 +
        '      saldoenddebitcurr = 0; '+ #13#10 +
        '      saldoendcreditcurr = 0; '+ #13#10 +
        '      saldoenddebiteq = 0; '+ #13#10 +
        '      saldoendcrediteq = 0; '+ #13#10 +
        ' '+ #13#10 +
        '      FOR '+ #13#10 +
        '        SELECT '+ #13#10 +
        '          la.accountkey '+ #13#10 +
        '        FROM '+ #13#10 +
        '          ac_ledger_accounts la '+ #13#10 +
        '        WHERE '+ #13#10 +
        '          la.sqlhandle = :sqlhandle '+ #13#10 +
        '        INTO :accountkey '+ #13#10 +
        '      DO '+ #13#10 +
        '      BEGIN '+ #13#10 +
        ' '+ #13#10 +
        '        SELECT '+ #13#10 +
        '          a.DEBITSALDO, '+ #13#10 +
        '          a.CREDITSALDO, '+ #13#10 +
        '          a.CURRDEBITSALDO, '+ #13#10 +
        '          a.CURRCREDITSALDO, '+ #13#10 +
        '          a.EQDEBITSALDO, '+ #13#10 +
        '          a.EQCREDITSALDO '+ #13#10 +
        '        FROM '+ #13#10 +
        '          ac_accountexsaldo(:d + 1, :accountkey, :analyticfield, :companykey, '+ #13#10 +
        '            :allholdingcompanies, -1, :currkey) a '+ #13#10 +
        '        INTO :sd, '+ #13#10 +
        '             :sc, '+ #13#10 +
        '             :sdc, '+ #13#10 +
        '             :scc, '+ #13#10 +
        '             :sdeq, '+ #13#10 +
        '             :sceq; '+ #13#10 +
        ' '+ #13#10 +
        '        IF (sd IS NULL) then SD = 0; '+ #13#10 +
        '        IF (sc IS NULL) then SC = 0; '+ #13#10 +
        '        IF (sdc IS NULL) then SDC = 0; '+ #13#10 +
        '        IF (scc IS NULL) then SCC = 0; '+ #13#10 +
        '        IF (sdeq IS NULL) then SDEQ = 0; '+ #13#10 +
        '        IF (sceq IS NULL) then SCEQ = 0; '+ #13#10 +
        ' '+ #13#10 +
        '        saldoenddebit = :saldoenddebit + :sd; '+ #13#10 +
        '        saldoendcredit = :saldoendcredit + :sc; '+ #13#10 +
        '        saldoenddebitcurr = :saldoenddebitcurr + :sdc; '+ #13#10 +
        '        saldoendcreditcurr = :saldoendcreditcurr + :scc; '+ #13#10 +
        '        saldoenddebiteq = :saldoenddebiteq + :sdeq; '+ #13#10 +
        '        saldoendcrediteq = :saldoendcrediteq + :sceq; '+ #13#10 +
        '      END '+ #13#10 +
        '    END '+ #13#10 +
        ' '+ #13#10 +
        '    DEBITNCUBEGIN = :SALDOBEGINDEBIT; '+ #13#10 +
        '    CREDITNCUBEGIN =  :SALDOBEGINCREDIT; '+ #13#10 +
        '    DEBITNCUEND = :SALDOENDDEBIT; '+ #13#10 +
        '    CREDITNCUEND =  :SALDOENDCREDIT; '+ #13#10 +
        ' '+ #13#10 +
        '    DEBITCURRBEGIN = :SALDOBEGINDEBITCURR; '+ #13#10 +
        '    CREDITCURRBEGIN =  :SALDOBEGINCREDITCURR; '+ #13#10 +
        '    DEBITCURREND = :SALDOENDDEBITCURR; '+ #13#10 +
        '    CREDITCURREND =  :SALDOENDCREDITCURR; '+ #13#10 +
        ' '+ #13#10 +
        '    DEBITEQBEGIN = :SALDOBEGINDEBITEQ; '+ #13#10 +
        '    CREDITEQBEGIN =  :SALDOBEGINCREDITEQ; '+ #13#10 +
        '    DEBITEQEND = :SALDOENDDEBITEQ; '+ #13#10 +
        '    CREDITEQEND =  :SALDOENDCREDITEQ; '+ #13#10 +
        ' '+ #13#10 +
        '    SUSPEND; '+ #13#10 +
        ' '+ #13#10 +
        '    SALDOBEGINDEBIT = :SALDOENDDEBIT; '+ #13#10 +
        '    SALDOBEGINCREDIT = :SALDOENDCREDIT; '+ #13#10 +
        ' '+ #13#10 +
        '    SALDOBEGINDEBITCURR = :SALDOENDDEBITCURR; '+ #13#10 +
        '    SALDOBEGINCREDITCURR = :SALDOENDCREDITCURR; '+ #13#10 +
        ' '+ #13#10 +
        '    SALDOBEGINDEBITEQ = :SALDOENDDEBITEQ; '+ #13#10 +
        '    SALDOBEGINCREDITEQ = :SALDOENDCREDITEQ; '+ #13#10 +
        ' '+ #13#10 +
        '    C = C + 1; '+ #13#10 +
        '  END '+ #13#10 +
        '  /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
        '  IF (C = 0) THEN '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    M = EXTRACT(MONTH FROM :abeginentrydate); '+ #13#10 +
        '    Y = EXTRACT(YEAR FROM :abeginentrydate); '+ #13#10 +
        '    DEBITNCUBEGIN = :SALDOBEGINDEBIT; '+ #13#10 +
        '    CREDITNCUBEGIN =  :SALDOBEGINCREDIT; '+ #13#10 +
        '    DEBITNCUEND = :SALDOBEGINDEBIT; '+ #13#10 +
        '    CREDITNCUEND =  :SALDOBEGINCREDIT; '+ #13#10 +
        ' '+ #13#10 +
        '    DEBITCURRBEGIN = :SALDOBEGINDEBITCURR; '+ #13#10 +
        '    CREDITCURRBEGIN =  :SALDOBEGINCREDITCURR; '+ #13#10 +
        '    DEBITCURREND = :SALDOBEGINDEBITCURR; '+ #13#10 +
        '    CREDITCURREND =  :SALDOBEGINCREDITCURR; '+ #13#10 +
        ' '+ #13#10 +
        '    DEBITEQBEGIN = :SALDOBEGINDEBITEQ; '+ #13#10 +
        '    CREDITEQBEGIN =  :SALDOBEGINCREDITEQ; '+ #13#10 +
        '    DEBITEQEND = :SALDOBEGINDEBITEQ; '+ #13#10 +
        '    CREDITEQEND =  :SALDOBEGINCREDITEQ; '+ #13#10 +
        ' '+ #13#10 +
        '    BEGINDATE = :abeginentrydate; '+ #13#10 +
        '    ENDDATE = :abeginentrydate; '+ #13#10 +
        ' '+ #13#10 +
        '    FORCESHOW = 1; '+ #13#10 +
        ' '+ #13#10 +
        '    SUSPEND; '+ #13#10 +
        '  END '+ #13#10 +
        'END ';
      Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
      try
        AlterProcedure(StoredProcedure, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      StoredProcedure.ProcedureName := 'AC_L_S';
      StoredProcedure.Description :=
        '( '+ #13#10 +
        '    ABEGINENTRYDATE DATE, '+ #13#10 +
        '    AENDENTRYDATE DATE, '+ #13#10 +
        '    SQLHANDLE INTEGER, '+ #13#10 +
        '    COMPANYKEY INTEGER, '+ #13#10 +
        '    ALLHOLDINGCOMPANIES INTEGER, '+ #13#10 +
        '    INGROUP INTEGER, '+ #13#10 +
        '    CURRKEY INTEGER) '+ #13#10 +
        'RETURNS ( '+ #13#10 +
        '    ENTRYDATE DATE, '+ #13#10 +
        '    DEBITNCUBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITNCUBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITNCUEND NUMERIC(15,4), '+ #13#10 +
        '    CREDITNCUEND NUMERIC(15,4), '+ #13#10 +
        '    DEBITCURRBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITCURRBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITCURREND NUMERIC(15,4), '+ #13#10 +
        '    CREDITCURREND NUMERIC(15,4), '+ #13#10 +
        '    DEBITEQBEGIN NUMERIC(15,4), '+ #13#10 +
        '    CREDITEQBEGIN NUMERIC(15,4), '+ #13#10 +
        '    DEBITEQEND NUMERIC(15,4), '+ #13#10 +
        '    CREDITEQEND NUMERIC(15,4), '+ #13#10 +
        '    FORCESHOW INTEGER) '+ #13#10 +
        'AS '+ #13#10 +
        'DECLARE VARIABLE O NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOBEGIN NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOEND NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE OCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE OEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOBEGINCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDCURR NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOBEGINEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE SALDOENDEQ NUMERIC(18,4); '+ #13#10 +
        'DECLARE VARIABLE C INTEGER; '+ #13#10 +
        'BEGIN '+ #13#10 +
        '  IF (:SQLHANDLE = 0) THEN '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    SELECT '+ #13#10 +
        '      IIF(NOT SUM(e1.debitncu - e1.creditncu) IS NULL, SUM(e1.debitncu - e1.creditncu),  0), '+ #13#10 +
        '      IIF(NOT SUM(e1.debitcurr - e1.creditcurr) IS NULL, SUM(e1.debitcurr - e1.creditcurr), 0), '+ #13#10 +
        '      IIF(NOT SUM(e1.debiteq - e1.crediteq) IS NULL, SUM(e1.debiteq - e1.crediteq), 0) '+ #13#10 +
        '    FROM '+ #13#10 +
        '      ac_entry e1 '+ #13#10 +
        '    WHERE '+ #13#10 +
        '      (e1.companykey + 0 = :companykey OR '+ #13#10 +
        '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
        '      e1.companykey  + 0 IN ( '+ #13#10 +
        '        SELECT '+ #13#10 +
        '          h.companykey '+ #13#10 +
        '        FROM '+ #13#10 +
        '          gd_holding h '+ #13#10 +
        '        WHERE '+ #13#10 +
        '          h.holdingkey = :companykey))) AND '+ #13#10 +
        '      ((0 = :currkey) OR (e1.currkey = :currkey)) AND '+ #13#10 +
        '      e1.entrydate < :abeginentrydate '+ #13#10 +
        '    INTO :saldobegin, '+ #13#10 +
        '         :saldobegincurr, '+ #13#10 +
        '         :saldobegineq; '+ #13#10 +
        ' '+ #13#10 +
        '    IF (saldobegin IS NULL) THEN '+ #13#10 +
        '      saldobegin = 0; '+ #13#10 +
        '    IF (saldobegincurr IS NULL) THEN '+ #13#10 +
        '      saldobegincurr = 0; '+ #13#10 +
        '    IF (saldobegineq IS NULL) THEN '+ #13#10 +
        '      saldobegineq = 0; '+ #13#10 +
        ' '+ #13#10 +
        '    C = 0; '+ #13#10 +
        '    FORCESHOW = 0; '+ #13#10 +
        '    FOR '+ #13#10 +
        '      SELECT '+ #13#10 +
        '        e.entrydate, '+ #13#10 +
        '        SUM(e.debitncu - e.creditncu), '+ #13#10 +
        '        SUM(e.debitcurr - e.creditcurr), '+ #13#10 +
        '        SUM(e.debiteq - e.crediteq) '+ #13#10 +
        '      FROM '+ #13#10 +
        '        ac_entry e '+ #13#10 +
        '      WHERE '+ #13#10 +
        '        (e.companykey + 0 = :companykey OR '+ #13#10 +
        '        (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
        '        e.companykey + 0 IN ( '+ #13#10 +
        '          SELECT '+ #13#10 +
        '            h.companykey '+ #13#10 +
        '          FROM '+ #13#10 +
        '            gd_holding h '+ #13#10 +
        '          WHERE '+ #13#10 +
        '            h.holdingkey = :companykey))) AND '+ #13#10 +
        '        ((0 = :currkey) OR (e.currkey = :currkey)) AND '+ #13#10 +
        '         e.entrydate <= :aendentrydate AND '+ #13#10 +
        '        e.entrydate >= :abeginentrydate '+ #13#10 +
        ' '+ #13#10 +
        '      GROUP BY e.entrydate '+ #13#10 +
        '      INTO :ENTRYDATE, '+ #13#10 +
        '           :O, '+ #13#10 +
        '           :OCURR, '+ #13#10 +
        '           :OEQ '+ #13#10 +
        '    DO '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      DEBITNCUBEGIN = 0; '+ #13#10 +
        '      CREDITNCUBEGIN = 0; '+ #13#10 +
        '      DEBITNCUEND = 0; '+ #13#10 +
        '      CREDITNCUEND = 0; '+ #13#10 +
        '      DEBITCURRBEGIN = 0; '+ #13#10 +
        '      CREDITCURRBEGIN = 0; '+ #13#10 +
        '      DEBITCURREND = 0; '+ #13#10 +
        '      CREDITCURREND = 0; '+ #13#10 +
        '      DEBITEQBEGIN = 0; '+ #13#10 +
        '      CREDITEQBEGIN = 0; '+ #13#10 +
        '      DEBITEQEND = 0; '+ #13#10 +
        '      CREDITEQEND = 0; '+ #13#10 +
        '      SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
        '      if (SALDOBEGIN > 0) then '+ #13#10 +
        '        DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '      if (SALDOEND > 0) then '+ #13#10 +
        '        DEBITNCUEND = :SALDOEND; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITNCUEND =  - :SALDOEND; '+ #13#10 +
        '      SALDOENDCURR = :SALDOBEGINCURR + :OCURR; '+ #13#10 +
        '      if (SALDOBEGINCURR > 0) then '+ #13#10 +
        '        DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
        '      if (SALDOENDCURR > 0) then '+ #13#10 +
        '        DEBITCURREND = :SALDOENDCURR; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITCURREND =  - :SALDOENDCURR; '+ #13#10 +
        '      SALDOENDEQ = :SALDOBEGINEQ + :OEQ; '+ #13#10 +
        '      if (SALDOBEGINEQ > 0) then '+ #13#10 +
        '        DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
        '      if (SALDOENDEQ > 0) then '+ #13#10 +
        '        DEBITEQEND = :SALDOENDEQ; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITEQEND =  - :SALDOENDEQ; '+ #13#10 +
        '      SUSPEND; '+ #13#10 +
        '      SALDOBEGIN = :SALDOEND; '+ #13#10 +
        '      SALDOBEGINCURR = :SALDOENDCURR; '+ #13#10 +
        '      C = C + 1; '+ #13#10 +
        '    END '+ #13#10 +
        '    /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
        '    IF (C = 0) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      ENTRYDATE = :abeginentrydate; '+ #13#10 +
        '      IF (SALDOBEGIN > 0) THEN '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
        '        DEBITNCUEND = :SALDOBEGIN; '+ #13#10 +
        '      END ELSE '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '        CREDITNCUEND =  - :SALDOBEGIN; '+ #13#10 +
        '      END '+ #13#10 +
        '   '+ #13#10 +
        '      IF (SALDOBEGINCURR > 0) THEN '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
        '        DEBITCURREND = :SALDOBEGINCURR; '+ #13#10 +
        '      END ELSE '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
        '        CREDITCURREND =  - :SALDOBEGINCURR; '+ #13#10 +
        '      END '+ #13#10 +
        ' '+ #13#10 +
        '      IF (SALDOBEGINEQ > 0) THEN '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
        '        DEBITEQEND = :SALDOBEGINEQ; '+ #13#10 +
        '      END ELSE '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
        '        CREDITEQEND =  - :SALDOBEGINEQ; '+ #13#10 +
        '      END '+ #13#10 +
        '   '+ #13#10 +
        '      FORCESHOW = 1; '+ #13#10 +
        '      SUSPEND; '+ #13#10 +
        '    END '+ #13#10 +
        '  END '+ #13#10 +
        '  ELSE '+ #13#10 +
        '  BEGIN '+ #13#10 +
        '    SELECT '+ #13#10 +
        '      IIF(NOT SUM(e1.debitncu - e1.creditncu) IS NULL, SUM(e1.debitncu - e1.creditncu),  0), '+ #13#10 +
        '      IIF(NOT SUM(e1.debitcurr - e1.creditcurr) IS NULL, SUM(e1.debitcurr - e1.creditcurr), 0), '+ #13#10 +
        '      IIF(NOT SUM(e1.debiteq - e1.crediteq) IS NULL, SUM(e1.debiteq - e1.crediteq), 0) '+ #13#10 +
        '    FROM '+ #13#10 +
        '      ac_ledger_accounts a JOIN '+ #13#10 +
        '      ac_entry e1 ON a.accountkey = e1.accountkey AND e1.entrydate < :abeginentrydate '+ #13#10 +
        '      AND a.sqlhandle = :sqlhandle  '+ #13#10 +
        '    WHERE '+ #13#10 +
        '      (e1.companykey + 0 = :companykey OR '+ #13#10 +
        '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
        '      e1.companykey  + 0 IN ( '+ #13#10 +
        '        SELECT '+ #13#10 +
        '          h.companykey '+ #13#10 +
        '        FROM '+ #13#10 +
        '          gd_holding h '+ #13#10 +
        '        WHERE '+ #13#10 +
        '          h.holdingkey = :companykey))) AND '+ #13#10 +
        '      ((0 = :currkey) OR (e1.currkey = :currkey)) '+ #13#10 +
        '    INTO :saldobegin, '+ #13#10 +
        '         :saldobegincurr, '+ #13#10 +
        '         :saldobegineq; '+ #13#10 +
        ' '+ #13#10 +
        '    IF (saldobegin IS NULL) THEN '+ #13#10 +
        '      saldobegin = 0; '+ #13#10 +
        '    IF (saldobegincurr IS NULL) THEN '+ #13#10 +
        '      saldobegincurr = 0; '+ #13#10 +
        '    IF (saldobegineq IS NULL) THEN '+ #13#10 +
        '      saldobegineq = 0; '+ #13#10 +
        ' '+ #13#10 +
        '    C = 0; '+ #13#10 +
        '    FORCESHOW = 0; '+ #13#10 +
        '    FOR '+ #13#10 +
        '      SELECT '+ #13#10 +
        '        e.entrydate, '+ #13#10 +
        '        SUM(e.debitncu - e.creditncu), '+ #13#10 +
        '        SUM(e.debitcurr - e.creditcurr), '+ #13#10 +
        '        SUM(e.debiteq - e.crediteq) '+ #13#10 +
        '      FROM '+ #13#10 +
        '        ac_ledger_accounts a '+ #13#10 +
        '        JOIN ac_entry e ON a.accountkey = e.accountkey AND '+ #13#10 +
        '            e.entrydate <= :aendentrydate AND '+ #13#10 +
        '            e.entrydate >= :abeginentrydate '+ #13#10 +
        '            AND a.sqlhandle = :sqlhandle  '+ #13#10 +
        '      WHERE '+ #13#10 +
        '        (e.companykey + 0 = :companykey OR '+ #13#10 +
        '        (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
        '        e.companykey + 0 IN ( '+ #13#10 +
        '          SELECT '+ #13#10 +
        '            h.companykey '+ #13#10 +
        '          FROM '+ #13#10 +
        '            gd_holding h '+ #13#10 +
        '          WHERE '+ #13#10 +
        '            h.holdingkey = :companykey))) AND '+ #13#10 +
        '        ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
        '      GROUP BY e.entrydate '+ #13#10 +
        '      INTO :ENTRYDATE, '+ #13#10 +
        '           :O, '+ #13#10 +
        '           :OCURR, '+ #13#10 +
        '           :OEQ '+ #13#10 +
        '    DO '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      DEBITNCUBEGIN = 0; '+ #13#10 +
        '      CREDITNCUBEGIN = 0; '+ #13#10 +
        '      DEBITNCUEND = 0; '+ #13#10 +
        '      CREDITNCUEND = 0; '+ #13#10 +
        '      DEBITCURRBEGIN = 0; '+ #13#10 +
        '      CREDITCURRBEGIN = 0; '+ #13#10 +
        '      DEBITCURREND = 0; '+ #13#10 +
        '      CREDITCURREND = 0; '+ #13#10 +
        '      DEBITEQBEGIN = 0; '+ #13#10 +
        '      CREDITEQBEGIN = 0; '+ #13#10 +
        '      DEBITEQEND = 0; '+ #13#10 +
        '      CREDITEQEND = 0; '+ #13#10 +
        '      SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
        '      if (SALDOBEGIN > 0) then '+ #13#10 +
        '        DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '      if (SALDOEND > 0) then '+ #13#10 +
        '        DEBITNCUEND = :SALDOEND; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITNCUEND =  - :SALDOEND; '+ #13#10 +
        '      SALDOENDCURR = :SALDOBEGINCURR + :OCURR; '+ #13#10 +
        '      if (SALDOBEGINCURR > 0) then '+ #13#10 +
        '        DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
        '      if (SALDOENDCURR > 0) then '+ #13#10 +
        '        DEBITCURREND = :SALDOENDCURR; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITCURREND =  - :SALDOENDCURR; '+ #13#10 +
        '      SALDOENDEQ = :SALDOBEGINEQ + :OEQ; '+ #13#10 +
        '      if (SALDOBEGINEQ > 0) then '+ #13#10 +
        '        DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
        '      if (SALDOENDEQ > 0) then '+ #13#10 +
        '        DEBITEQEND = :SALDOENDEQ; '+ #13#10 +
        '      else '+ #13#10 +
        '        CREDITEQEND =  - :SALDOENDEQ; '+ #13#10 +
        '      SUSPEND; '+ #13#10 +
        '      SALDOBEGIN = :SALDOEND; '+ #13#10 +
        '      SALDOBEGINCURR = :SALDOENDCURR; '+ #13#10 +
        '      SALDOBEGINEQ = :SALDOENDEQ; '+ #13#10 +
        '      C = C + 1; '+ #13#10 +
        '    END '+ #13#10 +
        '    /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
        '    IF (C = 0) THEN '+ #13#10 +
        '    BEGIN '+ #13#10 +
        '      ENTRYDATE = :abeginentrydate; '+ #13#10 +
        '      IF (SALDOBEGIN > 0) THEN '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
        '        DEBITNCUEND = :SALDOBEGIN; '+ #13#10 +
        '      END ELSE '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
        '        CREDITNCUEND =  - :SALDOBEGIN; '+ #13#10 +
        '      END '+ #13#10 +
        ' '+ #13#10 +
        '      IF (SALDOBEGINCURR > 0) THEN '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
        '        DEBITCURREND = :SALDOBEGINCURR; '+ #13#10 +
        '      END ELSE '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
        '        CREDITCURREND =  - :SALDOBEGINCURR; '+ #13#10 +
        '      END '+ #13#10 +
        ' '+ #13#10 +
        '      IF (SALDOBEGINEQ > 0) THEN '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
        '        DEBITEQEND = :SALDOBEGINEQ; '+ #13#10 +
        '      END ELSE '+ #13#10 +
        '      BEGIN '+ #13#10 +
        '        CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
        '        CREDITEQEND =  - :SALDOBEGINEQ; '+ #13#10 +
        '      END '+ #13#10 +
        ' '+ #13#10 +
        '      FORCESHOW = 1; '+ #13#10 +
        '      SUSPEND; '+ #13#10 +
        '    END '+ #13#10 +
        '  END '+ #13#10 +
        'END ';

      Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
      try
        AlterProcedure(StoredProcedure, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      Header :=
        '  (DATEEND DATE, '#13#10 +
        '   ACCOUNTKEY INTEGER, '#13#10 +
        '   FIELDNAME VARCHAR(60), '#13#10 +
        '   COMPANYKEY INTEGER, '#13#10 +
        '   ALLHOLDINGCOMPANIES INTEGER,'#13#10 +
        '   INGROUP INTEGER,'#13#10 +
        '   CURRKEY INTEGER) '#13#10 +
        'RETURNS (DEBITSALDO NUMERIC(15, 4), '#13#10 +
        '   CREDITSALDO NUMERIC(15, 4), '#13#10 +
        '   CURRDEBITSALDO NUMERIC(15,4),'#13#10 +
        '   CURRCREDITSALDO NUMERIC(15,4),'#13#10 +
        '   EQDEBITSALDO NUMERIC(15,4),'#13#10 +
        '   EQCREDITSALDO NUMERIC(15,4))'#13#10 +
        'AS '#13#10 +
        '  DECLARE VARIABLE SALDO NUMERIC(15, 4); '#13#10 +
        '  DECLARE VARIABLE SALDOCURR NUMERIC(15,4);'#13#10 +
        '  DECLARE VARIABLE SALDOEQ NUMERIC(15,4);'#13#10;
      IbTr.StartTransaction;
      q.SQL.Text :=
        'SELECT * FROM at_relation_fields WHERE relationname = ''AC_ENTRY'' AND fieldname LIKE ''USR$%''';
      q.ExecQuery;

      FieldList := '';
      TextSQL := '';

      while not q.EOF do
      begin
        FieldList := FieldList + Format('  DECLARE VARIABLE %s INTEGER;', [q.FieldByName('fieldname').AsString]) + #13#10;
        TextSQL := TextSQL +
        '  IF (FIELDNAME = ''' + q.FieldByName('fieldname').AsString + ''') THEN '#13#10 +
        '  BEGIN '#13#10 +
        '      FOR '#13#10 +
        '        SELECT ' + q.FieldByName('fieldname').AsString + ', SUM(e.debitncu - e.creditncu), '#13#10 +
        '          SUM(e.debitcurr - e.creditcurr), '#13#10 +
        '          SUM(e.debiteq - e.crediteq)'#13#10 +
        '        FROM ac_entry e  '#13#10 +
        '        WHERE e.accountkey = :accountkey and e.entrydate < :DATEEND AND '#13#10 +
        '          ((e.companykey = :companykey) OR ( (:ALLHOLDINGCOMPANIES = 1) AND '#13#10 +
        '          (e.companykey in ('#13#10 +
        '          SELECT'#13#10 +
        '            h.companykey'#13#10 +
        '          FROM'#13#10 +
        '            gd_holding h'#13#10 +
        '          WHERE'#13#10 +
        '            h.holdingkey = :companykey)) )) AND'#13#10 +
        '          ((0 = :currkey) OR (e.currkey = :currkey))'#13#10 +
        '        GROUP BY ' + q.FieldByName('fieldname').AsString + ' '#13#10 +
        '        INTO :' + q.FieldByName('fieldname').AsString + ', :SALDO, :SALDOCURR, :SALDOEQ '#13#10 +
        '      DO '#13#10 +
        '      BEGIN '#13#10 +
        '        IF (SALDO IS NULL) THEN '#13#10 +
        '          SALDO = 0; '#13#10 +
        '        IF (SALDO > 0) THEN '#13#10 +
        '          DEBITSALDO = DEBITSALDO + SALDO; '#13#10 +
        '        ELSE '#13#10 +
        '          CREDITSALDO = CREDITSALDO - SALDO; '#13#10 +
        '        IF (SALDOCURR IS NULL) THEN'#13#10 +
        '           SALDOCURR = 0;'#13#10 +
        '         IF (SALDOCURR > 0) THEN'#13#10 +
        '           CURRDEBITSALDO = CURRDEBITSALDO + SALDOCURR;'#13#10 +
        '         ELSE'#13#10 +
        '           CURRCREDITSALDO = CURRCREDITSALDO - SALDOCURR;'#13#10 +
        '        IF (SALDOEQ IS NULL) THEN'#13#10 +
        '           SALDOEQ = 0;'#13#10 +
        '         IF (SALDOEQ > 0) THEN'#13#10 +
        '           EQDEBITSALDO = EQDEBITSALDO + SALDOEQ;'#13#10 +
        '         ELSE'#13#10 +
        '           EQCREDITSALDO = EQCREDITSALDO - SALDOEQ;'#13#10 +
        '      END '#13#10 +
        '  END '#13#10;
        q.Next;
      end;

      RemakeStored(IBDB, Log);

      IbTr.Commit;

      StoredProcedure.ProcedureName := 'AC_ACCOUNTEXSALDO';
      StoredProcedure.Description := Header + FieldList +
        'BEGIN '#13#10 +
        '  DEBITSALDO = 0; '#13#10 +
        '  CREDITSALDO = 0; '#13#10 +
        '  CURRDEBITSALDO = 0; '#13#10 +
        '  CURRCREDITSALDO = 0; '#13#10 +
        '  EQDEBITSALDO = 0; '#13#10 +
        '  EQCREDITSALDO = 0; '#13#10 +
        TextSQL + '  SUSPEND; '#13#10 +
        'END '#13#10;

      Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
      try
        AlterProcedure(StoredProcedure, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      IbTr.StartTransaction;

      AddFinVersion(77, '0000.0001.0000.0105', 'Add fields from AC_RECORD into AC_ENTRY', '31.07.2006', IBTr);

      IbTr.Commit;

    except
      on E: Exception do
      begin
        Log(Format('������: %s', [E.Message]));
        if IBTr.InTransaction then IBTr.Rollback;
      end;
    end;

  finally
    IBTr.Free;
    q.Free;
  end;

end;

procedure RemakeStored(IBDB: TIBDatabase; Log: TModifyLog);
var
  StoredProcedure: TmdfStoredProcedure;
begin

  StoredProcedure.ProcedureName := 'AC_L_S1';
  StoredProcedure.Description :=
    '( '+ #13#10 +
    '    ABEGINENTRYDATE DATE, '+ #13#10 +
    '    AENDENTRYDATE DATE, '+ #13#10 +
    '    SQLHANDLE INTEGER, '+ #13#10 +
    '    COMPANYKEY INTEGER, '+ #13#10 +
    '    ALLHOLDINGCOMPANIES INTEGER, '+ #13#10 +
    '    INGROUP INTEGER, '+ #13#10 +
    '    PARAM INTEGER, '+ #13#10 +
    '    CURRKEY INTEGER) '+ #13#10 +
    'RETURNS ( '+ #13#10 +
    '    DATEPARAM INTEGER, '+ #13#10 +
    '    DEBITNCUBEGIN NUMERIC(15,4), '+ #13#10 +
    '    CREDITNCUBEGIN NUMERIC(15,4), '+ #13#10 +
    '    DEBITNCUEND NUMERIC(15,4), '+ #13#10 +
    '    CREDITNCUEND NUMERIC(15,4), '+ #13#10 +
    '    DEBITCURRBEGIN NUMERIC(15,4), '+ #13#10 +
    '    CREDITCURRBEGIN NUMERIC(15,4), '+ #13#10 +
    '    DEBITCURREND NUMERIC(15,4), '+ #13#10 +
    '    CREDITCURREND NUMERIC(15,4), '+ #13#10 +
    '    DEBITEQBEGIN NUMERIC(15,4), '+ #13#10 +
    '    CREDITEQBEGIN NUMERIC(15,4), '+ #13#10 +
    '    DEBITEQEND NUMERIC(15,4), '+ #13#10 +
    '    CREDITEQEND NUMERIC(15,4), '+ #13#10 +
    '    FORCESHOW INTEGER) '+ #13#10 +
    'AS '+ #13#10 +
    'DECLARE VARIABLE O NUMERIC(18,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOBEGIN NUMERIC(18,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOEND NUMERIC(18,4); '+ #13#10 +
    'DECLARE VARIABLE OCURR NUMERIC(18,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOBEGINCURR NUMERIC(18,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOENDCURR NUMERIC(18,4); '+ #13#10 +
    'DECLARE VARIABLE OEQ NUMERIC(18,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOBEGINEQ NUMERIC(18,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOENDEQ NUMERIC(18,4); '+ #13#10 +
    'DECLARE VARIABLE C INTEGER; '+ #13#10 +
    'BEGIN '+ #13#10 +
    '  IF (:SQLHANDLE = 0) THEN '+ #13#10 +
    '  BEGIN '+ #13#10 +
    '    SELECT '+ #13#10 +
    '      IIF(NOT SUM(e1.debitncu - e1.creditncu) IS NULL, SUM(e1.debitncu - e1.creditncu),  0), '+ #13#10 +
    '      IIF(NOT SUM(e1.debitcurr - e1.creditcurr) IS NULL, SUM(e1.debitcurr - e1.creditcurr), 0), '+ #13#10 +
    '      IIF(NOT SUM(e1.debiteq - e1.crediteq) IS NULL, SUM(e1.debiteq - e1.crediteq), 0) '+ #13#10 +
    '    FROM '+ #13#10 +
    '      ac_entry e1 '+ #13#10 +
    '    WHERE '+ #13#10 +
    '      (e1.companykey + 0 = :companykey OR '+ #13#10 +
    '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '      e1.companykey + 0 IN ( '+ #13#10 +
    '        SELECT '+ #13#10 +
    '          h.companykey '+ #13#10 +
    '        FROM '+ #13#10 +
    '          gd_holding h '+ #13#10 +
    '        WHERE '+ #13#10 +
    '          h.holdingkey = :companykey))) AND '+ #13#10 +
    '      ((0 = :currkey) OR (e1.currkey = :currkey)) AND '+ #13#10 +
    '      e1.entrydate < :abeginentrydate '+ #13#10 +
    '    INTO :saldobegin, '+ #13#10 +
    '         :saldobegincurr, '+ #13#10 +
    '         :saldobegineq; '+ #13#10 +
    '    if (saldobegin IS NULL) then '+ #13#10 +
    '      saldobegin = 0; '+ #13#10 +
    '    if (saldobegincurr IS NULL) then '+ #13#10 +
    '      saldobegincurr = 0; '+ #13#10 +
    '    if (saldobegineq IS NULL) then '+ #13#10 +
    '      saldobegineq = 0; '+ #13#10 +
    ' '+ #13#10 +
    '    C = 0; '+ #13#10 +
    '    FORCESHOW = 0; '+ #13#10 +
    '    FOR '+ #13#10 +
    '      SELECT '+ #13#10 +
    '        SUM(e.debitncu - e.creditncu), '+ #13#10 +
    '        SUM(e.debitcurr - e.creditcurr), '+ #13#10 +
    '        SUM(e.debiteq - e.crediteq), '+ #13#10 +
    '        g_d_getdateparam(e.entrydate, :param) '+ #13#10 +
    '      FROM '+ #13#10 +
    '        ac_entry e '+ #13#10 +
    '      WHERE '+ #13#10 +
    '        (e.companykey + 0 = :companykey OR '+ #13#10 +
    '        (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '        e.companykey + 0 IN ( '+ #13#10 +
    '          SELECT '+ #13#10 +
    '            h.companykey '+ #13#10 +
    '          FROM '+ #13#10 +
    '            gd_holding h '+ #13#10 +
    '          WHERE '+ #13#10 +
    '            h.holdingkey = :companykey))) AND '+ #13#10 +
    '        ((0 = :currkey) OR (e.currkey = :currkey)) AND '+ #13#10 +
    '          e.entrydate <= :aendentrydate AND '+ #13#10 +
    '          e.entrydate >= :abeginentrydate '+ #13#10 +
    '      group by 4 '+ #13#10 +
    '      INTO :O, '+ #13#10 +
    '           :OCURR, '+ #13#10 +
    '           :OEQ, '+ #13#10 +
    '           :dateparam '+ #13#10 +
    '    DO '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      DEBITNCUBEGIN = 0; '+ #13#10 +
    '      CREDITNCUBEGIN = 0; '+ #13#10 +
    '      DEBITNCUEND = 0; '+ #13#10 +
    '      CREDITNCUEND = 0; '+ #13#10 +
    '      DEBITCURRBEGIN = 0; '+ #13#10 +
    '      CREDITCURRBEGIN = 0; '+ #13#10 +
    '      DEBITCURREND = 0; '+ #13#10 +
    '      CREDITCURREND = 0; '+ #13#10 +
    '      DEBITEQBEGIN = 0; '+ #13#10 +
    '      CREDITEQBEGIN = 0; '+ #13#10 +
    '      DEBITEQEND = 0; '+ #13#10 +
    '      CREDITEQEND = 0; '+ #13#10 +
    '      SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
    '      if (SALDOBEGIN > 0) then '+ #13#10 +
    '        DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '      if (SALDOEND > 0) then '+ #13#10 +
    '        DEBITNCUEND = :SALDOEND; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITNCUEND =  - :SALDOEND; '+ #13#10 +
    '      SALDOENDCURR = :SALDOBEGINCURR + :OCURR; '+ #13#10 +
    '      if (SALDOBEGINCURR > 0) then '+ #13#10 +
    '        DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
    '      if (SALDOENDCURR > 0) then '+ #13#10 +
    '        DEBITCURREND = :SALDOENDCURR; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITCURREND =  - :SALDOENDCURR; '+ #13#10 +
    '      SALDOENDEQ = :SALDOBEGINEQ + :OEQ; '+ #13#10 +
    '      if (SALDOBEGINEQ > 0) then '+ #13#10 +
    '        DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
    '      if (SALDOENDEQ > 0) then '+ #13#10 +
    '        DEBITEQEND = :SALDOENDEQ; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITEQEND =  - :SALDOENDEQ; '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '      SALDOBEGIN = :SALDOEND; '+ #13#10 +
    '      SALDOBEGINCURR = :SALDOENDCURR; '+ #13#10 +
    '      SALDOBEGINEQ = :SALDOENDEQ; '+ #13#10 +
    '      C = C + 1; '+ #13#10 +
    '    END '+ #13#10 +
    '    /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
    '    IF (C = 0) THEN '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      DATEPARAM = g_d_getdateparam(:abeginentrydate, :param); '+ #13#10 +
    '      IF (SALDOBEGIN > 0) THEN '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
    '        DEBITNCUEND = :SALDOBEGIN; '+ #13#10 +
    '      END ELSE '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '        CREDITNCUEND =  - :SALDOBEGIN; '+ #13#10 +
    '      END '+ #13#10 +
    '     '+ #13#10 +
    '      IF (SALDOBEGINCURR > 0) THEN '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
    '        DEBITCURREND = :SALDOBEGINCURR; '+ #13#10 +
    '      END ELSE '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
    '        CREDITCURREND =  - :SALDOBEGINCURR; '+ #13#10 +
    '      END '+ #13#10 +
    ' '+ #13#10 +
    '      IF (SALDOBEGINEQ > 0) THEN '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
    '        DEBITEQEND = :SALDOBEGINEQ; '+ #13#10 +
    '      END ELSE '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
    '        CREDITEQEND =  - :SALDOBEGINEQ; '+ #13#10 +
    '      END '+ #13#10 +
    ' '+ #13#10 +
    '      FORCESHOW = 1; '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '    END '+ #13#10 +
    '  END '+ #13#10 +
    '  ELSE '+ #13#10 +
    '  BEGIN '+ #13#10 +
    '    SELECT '+ #13#10 +
    '      IIF(NOT SUM(e1.debitncu - e1.creditncu) IS NULL, SUM(e1.debitncu - e1.creditncu),  0), '+ #13#10 +
    '      IIF(NOT SUM(e1.debitcurr - e1.creditcurr) IS NULL, SUM(e1.debitcurr - e1.creditcurr), 0), '+ #13#10 +
    '      IIF(NOT SUM(e1.debiteq - e1.crediteq) IS NULL, SUM(e1.debiteq - e1.crediteq), 0) '+ #13#10 +
    '    FROM '+ #13#10 +
    '      ac_ledger_accounts a '+ #13#10 +
    '      JOIN ac_entry e1 ON a.accountkey = e1.accountkey AND e1.entrydate < :abeginentrydate '+ #13#10 +
    '      AND a.sqlhandle = :sqlhandle  '+ #13#10 +
    '    WHERE '+ #13#10 +
    '      (e1.companykey + 0 = :companykey OR '+ #13#10 +
    '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '      e1.companykey + 0 IN ( '+ #13#10 +
    '        SELECT '+ #13#10 +
    '          h.companykey '+ #13#10 +
    '        FROM '+ #13#10 +
    '          gd_holding h '+ #13#10 +
    '        WHERE '+ #13#10 +
    '          h.holdingkey = :companykey))) AND '+ #13#10 +
    '      ((0 = :currkey) OR (e1.currkey = :currkey)) '+ #13#10 +
    '    INTO :saldobegin, '+ #13#10 +
    '         :saldobegincurr, '+ #13#10 +
    '         :saldobegineq; '+ #13#10 +
    '    if (saldobegin IS NULL) then '+ #13#10 +
    '      saldobegin = 0; '+ #13#10 +
    '    if (saldobegincurr IS NULL) then '+ #13#10 +
    '      saldobegincurr = 0; '+ #13#10 +
    '    if (saldobegineq IS NULL) then '+ #13#10 +
    '      saldobegineq = 0; '+ #13#10 +
    ' '+ #13#10 +
    '    C = 0; '+ #13#10 +
    '    FORCESHOW = 0; '+ #13#10 +
    '    FOR '+ #13#10 +
    '      SELECT '+ #13#10 +
    '        SUM(e.debitncu - e.creditncu), '+ #13#10 +
    '        SUM(e.debitcurr - e.creditcurr), '+ #13#10 +
    '        SUM(e.debiteq - e.crediteq), '+ #13#10 +
    '        g_d_getdateparam(e.entrydate, :param) '+ #13#10 +
    '      FROM '+ #13#10 +
    '        ac_ledger_accounts a '+ #13#10 +
    '        JOIN ac_entry e ON a.accountkey = e.accountkey AND '+ #13#10 +
    '             e.entrydate <= :aendentrydate AND '+ #13#10 +
    '             e.entrydate >= :abeginentrydate '+ #13#10 +
    '      AND a.sqlhandle = :sqlhandle  '+ #13#10 +
    '      WHERE '+ #13#10 +
    '        (e.companykey + 0 = :companykey OR '+ #13#10 +
    '        (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '        e.companykey + 0 IN ( '+ #13#10 +
    '          SELECT '+ #13#10 +
    '            h.companykey '+ #13#10 +
    '          FROM '+ #13#10 +
    '            gd_holding h '+ #13#10 +
    '          WHERE '+ #13#10 +
    '            h.holdingkey = :companykey))) AND '+ #13#10 +
    '        ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
    '      group by 4 '+ #13#10 +
    '      INTO :O, '+ #13#10 +
    '           :OCURR, '+ #13#10 +
    '           :OEQ, '+ #13#10 +
    '           :dateparam '+ #13#10 +
    '    DO '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      DEBITNCUBEGIN = 0; '+ #13#10 +
    '      CREDITNCUBEGIN = 0; '+ #13#10 +
    '      DEBITNCUEND = 0; '+ #13#10 +
    '      CREDITNCUEND = 0; '+ #13#10 +
    '      DEBITCURRBEGIN = 0; '+ #13#10 +
    '      CREDITCURRBEGIN = 0; '+ #13#10 +
    '      DEBITCURREND = 0; '+ #13#10 +
    '      CREDITCURREND = 0; '+ #13#10 +
    '      DEBITEQBEGIN = 0; '+ #13#10 +
    '      CREDITEQBEGIN = 0; '+ #13#10 +
    '      DEBITEQEND = 0; '+ #13#10 +
    '      CREDITEQEND = 0; '+ #13#10 +
    '      SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
    '      if (SALDOBEGIN > 0) then '+ #13#10 +
    '        DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '      if (SALDOEND > 0) then '+ #13#10 +
    '        DEBITNCUEND = :SALDOEND; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITNCUEND =  - :SALDOEND; '+ #13#10 +
    '      SALDOENDCURR = :SALDOBEGINCURR + :OCURR; '+ #13#10 +
    '      if (SALDOBEGINCURR > 0) then '+ #13#10 +
    '        DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
    '      if (SALDOENDCURR > 0) then '+ #13#10 +
    '        DEBITCURREND = :SALDOENDCURR; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITCURREND =  - :SALDOENDCURR; '+ #13#10 +
    '      SALDOENDEQ = :SALDOBEGINEQ + :OEQ; '+ #13#10 +
    '      if (SALDOBEGINEQ > 0) then '+ #13#10 +
    '        DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
    '      if (SALDOENDEQ > 0) then '+ #13#10 +
    '        DEBITEQEND = :SALDOENDEQ; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITEQEND =  - :SALDOENDEQ; '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '      SALDOBEGIN = :SALDOEND; '+ #13#10 +
    '      SALDOBEGINCURR = :SALDOENDCURR; '+ #13#10 +
    '      SALDOBEGINEQ = :SALDOENDEQ; '+ #13#10 +
    '      C = C + 1; '+ #13#10 +
    '    END '+ #13#10 +
    '    /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
    '    IF (C = 0) THEN '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      DATEPARAM = g_d_getdateparam(:abeginentrydate, :param); '+ #13#10 +
    '      IF (SALDOBEGIN > 0) THEN '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        DEBITNCUBEGIN = :SALDOBEGIN; '+ #13#10 +
    '        DEBITNCUEND = :SALDOBEGIN; '+ #13#10 +
    '      END ELSE '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        CREDITNCUBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '        CREDITNCUEND =  - :SALDOBEGIN; '+ #13#10 +
    '      END '+ #13#10 +
    ' '+ #13#10 +
    '      IF (SALDOBEGINCURR > 0) THEN '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        DEBITCURRBEGIN = :SALDOBEGINCURR; '+ #13#10 +
    '        DEBITCURREND = :SALDOBEGINCURR; '+ #13#10 +
    '      END ELSE '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        CREDITCURRBEGIN =  - :SALDOBEGINCURR; '+ #13#10 +
    '        CREDITCURREND =  - :SALDOBEGINCURR; '+ #13#10 +
    '      END '+ #13#10 +
    ' '+ #13#10 +
    '      IF (SALDOBEGINEQ > 0) THEN '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        DEBITEQBEGIN = :SALDOBEGINEQ; '+ #13#10 +
    '        DEBITEQEND = :SALDOBEGINEQ; '+ #13#10 +
    '      END ELSE '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        CREDITEQBEGIN =  - :SALDOBEGINEQ; '+ #13#10 +
    '        CREDITEQEND =  - :SALDOBEGINEQ; '+ #13#10 +
    '      END '+ #13#10 +
    ' '+ #13#10 +
    '      FORCESHOW = 1; '+ #13#10 +
    ' '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '    END '+ #13#10 +
    '   '+ #13#10 +
    '  END '+ #13#10 +
    'END ';
  Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
  try
    AlterProcedure(StoredProcedure, IBDB);
  except
    on E: Exception do
      Log(Format('������: %s', [E.Message]));
  end;

  StoredProcedure.ProcedureName := 'AC_Q_S';
  StoredProcedure.Description :=
    '( '+ #13#10 +
    '    VALUEKEY INTEGER, '+ #13#10 +
    '    ABEGINENTRYDATE DATE, '+ #13#10 +
    '    AENDENTRYDATE DATE, '+ #13#10 +
    '    SQLHANDLE INTEGER, '+ #13#10 +
    '    COMPANYKEY INTEGER, '+ #13#10 +
    '    ALLHOLDINGCOMPANIES INTEGER, '+ #13#10 +
    '    INGROUP INTEGER, '+ #13#10 +
    '    CURRKEY INTEGER) '+ #13#10 +
    'RETURNS ( '+ #13#10 +
    '    ENTRYDATE DATE, '+ #13#10 +
    '    DEBITBEGIN NUMERIC(15,4), '+ #13#10 +
    '    CREDITBEGIN NUMERIC(15,4), '+ #13#10 +
    '    DEBIT NUMERIC(15,4), '+ #13#10 +
    '    CREDIT NUMERIC(15,4), '+ #13#10 +
    '    DEBITEND NUMERIC(15,4), '+ #13#10 +
    '    CREDITEND NUMERIC(15,4)) '+ #13#10 +
    'AS '+ #13#10 +
    'DECLARE VARIABLE O NUMERIC(15,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOBEGIN NUMERIC(15,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOEND NUMERIC(15,4); '+ #13#10 +
    'DECLARE VARIABLE C INTEGER; '+ #13#10 +
    'BEGIN '+ #13#10 +
    '  IF (:sqlhandle = 0) THEN '+ #13#10 +
    '  BEGIN '+ #13#10 +
    '    SELECT '+ #13#10 +
    '      IIF(SUM(IIF(e1.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '        SUM(IIF(e1.accountpart = ''C'', q.quantity, 0)) > 0, '+ #13#10 +
    '        SUM(IIF(e1.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '        SUM(IIF(e1.accountpart = ''C'', q.quantity, 0)), 0) '+ #13#10 +
    '    FROM '+ #13#10 +
    '      ac_entry e1 '+ #13#10 +
    '      LEFT JOIN ac_quantity q ON q.entrykey = e1.id '+ #13#10 +
    '    WHERE '+ #13#10 +
    '      (e1.companykey + 0 = :companykey OR '+ #13#10 +
    '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '      e1.companykey + 0 IN ( '+ #13#10 +
    '        SELECT '+ #13#10 +
    '          h.companykey '+ #13#10 +
    '        FROM '+ #13#10 +
    '          gd_holding h '+ #13#10 +
    '        WHERE '+ #13#10 +
    '          h.holdingkey = :companykey))) AND '+ #13#10 +
    '      q.valuekey = :valuekey AND '+ #13#10 +
    '      ((0 = :currkey) OR (e1.currkey = :currkey)) AND '+ #13#10 +
    '      e1.entrydate < :abeginentrydate  '+ #13#10 +
    '    INTO :saldobegin; '+ #13#10 +
    '    if (saldobegin IS NULL) then '+ #13#10 +
    '      saldobegin = 0; '+ #13#10 +
    ' '+ #13#10 +
    '    C = 0; '+ #13#10 +
    '    FOR '+ #13#10 +
    '      SELECT '+ #13#10 +
    '        e.entrydate, '+ #13#10 +
    '        SUM(IIF(e.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '          SUM(IIF(e.accountpart = ''C'', q.quantity, 0)) '+ #13#10 +
    '      FROM '+ #13#10 +
    '        ac_entry e '+ #13#10 +
    '        LEFT JOIN ac_quantity q ON q.entrykey = e.id AND '+ #13#10 +
    '          q.valuekey = :valuekey '+ #13#10 +
    '      WHERE '+ #13#10 +
    '        (e.companykey + 0 = :companykey OR '+ #13#10 +
    '        (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '        e.companykey + 0 IN ( '+ #13#10 +
    '          SELECT '+ #13#10 +
    '            h.companykey '+ #13#10 +
    '          FROM '+ #13#10 +
    '            gd_holding h '+ #13#10 +
    '          WHERE '+ #13#10 +
    '            h.holdingkey = :companykey))) AND '+ #13#10 +
    '        ((0 = :currkey) OR (e.currkey = :currkey)) AND '+ #13#10 +
    '          e.entrydate <= :aendentrydate AND '+ #13#10 +
    '          e.entrydate >= :abeginentrydate '+ #13#10 +
    '      GROUP BY e.entrydate '+ #13#10 +
    '      INTO :ENTRYDATE, '+ #13#10 +
    '           :O '+ #13#10 +
    '    DO '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      IF (O IS NULL) THEN O = 0; '+ #13#10 +
    '      DEBITBEGIN = 0; '+ #13#10 +
    '      CREDITBEGIN = 0; '+ #13#10 +
    '      DEBITEND = 0; '+ #13#10 +
    '      CREDITEND = 0; '+ #13#10 +
    '      DEBIT = 0; '+ #13#10 +
    '      CREDIT = 0; '+ #13#10 +
    '      IF (O > 0) THEN '+ #13#10 +
    '        DEBIT = :O; '+ #13#10 +
    '      ELSE '+ #13#10 +
    '        CREDIT = - :O; '+ #13#10 +
    '   '+ #13#10 +
    '      SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
    '      if (SALDOBEGIN > 0) then '+ #13#10 +
    '        DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '      if (SALDOEND > 0) then '+ #13#10 +
    '        DEBITEND = :SALDOEND; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITEND =  - :SALDOEND; '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '      SALDOBEGIN = :SALDOEND; '+ #13#10 +
    '      C = C + 1; '+ #13#10 +
    '    END ' + #13#13 +
    '    /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
    '    IF (C = 0) THEN '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      ENTRYDATE = :abeginentrydate; '+ #13#10 +
    '      IF (SALDOBEGIN > 0) THEN '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
    '        DEBITEND = :SALDOBEGIN; '+ #13#10 +
    '      END ELSE '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '        CREDITEND =  - :SALDOBEGIN; '+ #13#10 +
    '      END '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '    END '+ #13#10 +
    ' '+ #13#10 +
    '  END '+ #13#10 +
    '  ELSE '+ #13#10 +
    '  BEGIN '+ #13#10 +
    ' '+ #13#10 +
    '    SELECT '+ #13#10 +
    '      IIF(SUM(IIF(e1.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '        SUM(IIF(e1.accountpart = ''C'', q.quantity, 0)) > 0, '+ #13#10 +
    '        SUM(IIF(e1.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '        SUM(IIF(e1.accountpart = ''C'', q.quantity, 0)), 0) '+ #13#10 +
    '    FROM '+ #13#10 +
    '      ac_ledger_accounts a '+ #13#10 +
    '      JOIN ac_entry e1 ON a.accountkey = e1.accountkey AND '+ #13#10 +
    '        e1.entrydate < :abeginentrydate '+ #13#10 +
    '      AND a.sqlhandle = :sqlhandle  '+ #13#10 +
    '      LEFT JOIN ac_quantity q ON q.entrykey = e1.id '+ #13#10 +
    '    WHERE '+ #13#10 +
    '      (e1.companykey + 0 = :companykey OR '+ #13#10 +
    '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '      e1.companykey + 0 IN ( '+ #13#10 +
    '        SELECT '+ #13#10 +
    '          h.companykey '+ #13#10 +
    '        FROM '+ #13#10 +
    '          gd_holding h '+ #13#10 +
    '        WHERE '+ #13#10 +
    '          h.holdingkey = :companykey))) AND '+ #13#10 +
    '      q.valuekey = :valuekey AND '+ #13#10 +
    '      ((0 = :currkey) OR (e1.currkey = :currkey)) '+ #13#10 +
    '    INTO :saldobegin; '+ #13#10 +
    '    if (saldobegin IS NULL) then '+ #13#10 +
    '      saldobegin = 0; '+ #13#10 +
    '   '+ #13#10 +
    '    C = 0; '+ #13#10 +
    '    FOR '+ #13#10 +
    '      SELECT '+ #13#10 +
    '        e.entrydate, '+ #13#10 +
    '        SUM(IIF(e.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '          SUM(IIF(e.accountpart = ''C'', q.quantity, 0)) '+ #13#10 +
    '      FROM '+ #13#10 +
    '        ac_ledger_accounts a '+ #13#10 +
    '        JOIN ac_entry e ON a.accountkey = e.accountkey AND '+ #13#10 +
    '          e.entrydate <= :aendentrydate AND '+ #13#10 +
    '          e.entrydate >= :abeginentrydate '+ #13#10 +
    '          AND a.sqlhandle = :sqlhandle  '+ #13#10 +
    '        LEFT JOIN ac_quantity q ON q.entrykey = e.id AND '+ #13#10 +
    '          q.valuekey = :valuekey '+ #13#10 +
    '      WHERE '+ #13#10 +
    '        (e.companykey + 0 = :companykey OR '+ #13#10 +
    '        (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '        e.companykey + 0 IN ( '+ #13#10 +
    '          SELECT '+ #13#10 +
    '            h.companykey '+ #13#10 +
    '          FROM '+ #13#10 +
    '            gd_holding h '+ #13#10 +
    '          WHERE '+ #13#10 +
    '            h.holdingkey = :companykey))) AND '+ #13#10 +
    '        ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
    '      GROUP BY e.entrydate '+ #13#10 +
    '      INTO :ENTRYDATE, '+ #13#10 +
    '           :O '+ #13#10 +
    '    DO '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      IF (O IS NULL) THEN O = 0; '+ #13#10 +
    '      DEBITBEGIN = 0; '+ #13#10 +
    '      CREDITBEGIN = 0; '+ #13#10 +
    '      DEBITEND = 0; '+ #13#10 +
    '      CREDITEND = 0; '+ #13#10 +
    '      DEBIT = 0; '+ #13#10 +
    '      CREDIT = 0; '+ #13#10 +
    '      IF (O > 0) THEN '+ #13#10 +
    '        DEBIT = :O; '+ #13#10 +
    '      ELSE '+ #13#10 +
    '        CREDIT = - :O; '+ #13#10 +
    '   '+ #13#10 +
    '      SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
    '      if (SALDOBEGIN > 0) then '+ #13#10 +
    '        DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '      if (SALDOEND > 0) then '+ #13#10 +
    '        DEBITEND = :SALDOEND; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITEND =  - :SALDOEND; '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '      SALDOBEGIN = :SALDOEND; '+ #13#10 +
    '      C = C + 1; '+ #13#10 +
    '    END '+ #13#10 +
    '    /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
    '    IF (C = 0) THEN '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      ENTRYDATE = :abeginentrydate; '+ #13#10 +
    '      IF (SALDOBEGIN > 0) THEN '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
    '        DEBITEND = :SALDOBEGIN; '+ #13#10 +
    '      END ELSE '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '        CREDITEND =  - :SALDOBEGIN; '+ #13#10 +
    '      END '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '    END '+ #13#10 +
    ' '+ #13#10 +
    '  END '+ #13#10 +
    'END ';

  Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
  try
    AlterProcedure(StoredProcedure, IBDB);
  except
    on E: Exception do
      Log(Format('������: %s', [E.Message]));
  end;

  StoredProcedure.ProcedureName := 'AC_Q_G_L';
  StoredProcedure.Description :=
    '( '+ #13#10 +
    '    VALUEKEY INTEGER, '+ #13#10 +
    '    DATEBEGIN DATE, '+ #13#10 +
    '    DATEEND DATE, '+ #13#10 +
    '    COMPANYKEY INTEGER, '+ #13#10 +
    '    ALLHOLDINGCOMPANIES INTEGER, '+ #13#10 +
    '    SQLHANDLE INTEGER, '+ #13#10 +
    '    INGROUP INTEGER, '+ #13#10 +
    '    CURRKEY INTEGER) '+ #13#10 +
    'RETURNS ( '+ #13#10 +
    '    M INTEGER, '+ #13#10 +
    '    Y INTEGER, '+ #13#10 +
    '    DEBITBEGIN NUMERIC(15,4), '+ #13#10 +
    '    CREDITBEGIN NUMERIC(15,4), '+ #13#10 +
    '    DEBIT NUMERIC(15,4), '+ #13#10 +
    '    CREDIT NUMERIC(15,4), '+ #13#10 +
    '    DEBITEND NUMERIC(15,4), '+ #13#10 +
    '    CREDITEND NUMERIC(15,4)) '+ #13#10 +
    'AS '+ #13#10 +
    'DECLARE VARIABLE O NUMERIC(15,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOBEGIN NUMERIC(15,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOEND NUMERIC(15,4); '+ #13#10 +
    'DECLARE VARIABLE C INTEGER; '+ #13#10 +
    'begin '+ #13#10 +
    '  SELECT '+ #13#10 +
    '    IIF(SUM(IIF(e1.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '      SUM(IIF(e1.accountpart = ''C'', q.quantity, 0)) > 0, '+ #13#10 +
    '      SUM(IIF(e1.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '      SUM(IIF(e1.accountpart = ''C'', q.quantity, 0)), 0) '+ #13#10 +
    '  FROM '+ #13#10 +
    '      ac_entry e1 '+ #13#10 +
    '      LEFT JOIN ac_quantity q ON q.entrykey = e1.id '+ #13#10 +
    '  WHERE '+ #13#10 +
    '    e1.entrydate < :datebegin AND '+ #13#10 +
    '    e1.accountkey IN ( '+ #13#10 +
    '      SELECT '+ #13#10 +
    '        a.accountkey '+ #13#10 +
    '      FROM '+ #13#10 +
    '        ac_ledger_accounts a '+ #13#10 +
    '      WHERE '+ #13#10 +
    '        a.sqlhandle = :sqlhandle) AND '+ #13#10 +
    '    (e1.companykey = :companykey OR '+ #13#10 +
    '    (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '    e1.companykey IN ( '+ #13#10 +
    '      SELECT '+ #13#10 +
    '        h.companykey '+ #13#10 +
    '      FROM '+ #13#10 +
    '        gd_holding h '+ #13#10 +
    '      WHERE '+ #13#10 +
    '        h.holdingkey = :companykey))) AND '+ #13#10 +
    '    q.valuekey = :valuekey AND '+ #13#10 +
    '    ((0 = :currkey) OR (e1.currkey = :currkey)) '+ #13#10 +
    '  INTO :saldobegin; '+ #13#10 +
    '  if (saldobegin IS NULL) then '+ #13#10 +
    '    saldobegin = 0; '+ #13#10 +
    ' '+ #13#10 +
    '  C = 0; '+ #13#10 +
    '  FOR '+ #13#10 +
    '    SELECT '+ #13#10 +
    '      EXTRACT(MONTH FROM e.entrydate), '+ #13#10 +
    '      EXTRACT(YEAR FROM e.entrydate), '+ #13#10 +
    '      SUM(IIF(e.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '        SUM(IIF(e.accountpart = ''C'', q.quantity, 0)) '+ #13#10 +
    '    FROM '+ #13#10 +
    '      ac_entry e '+ #13#10 +
    '      LEFT JOIN ac_quantity q ON q.entrykey = e.id AND '+ #13#10 +
    '        q.valuekey = :valuekey '+ #13#10 +
    '    WHERE '+ #13#10 +
    '      e.entrydate <= :dateend AND '+ #13#10 +
    '      e.entrydate >= :datebegin AND '+ #13#10 +
    '      e.accountkey IN ( '+ #13#10 +
    '        SELECT '+ #13#10 +
    '          a.accountkey '+ #13#10 +
    '        FROM '+ #13#10 +
    '          ac_ledger_accounts a '+ #13#10 +
    '        WHERE '+ #13#10 +
    '          a.sqlhandle = :sqlhandle '+ #13#10 +
    '      ) AND '+ #13#10 +
    '      (e.companykey = :companykey OR '+ #13#10 +
    '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '      e.companykey IN ( '+ #13#10 +
    '        SELECT '+ #13#10 +
    '          h.companykey '+ #13#10 +
    '        FROM '+ #13#10 +
    '          gd_holding h '+ #13#10 +
    '        WHERE '+ #13#10 +
    '          h.holdingkey = :companykey))) AND '+ #13#10 +
    '      ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
    '    GROUP BY 1, 2 '+ #13#10 +
    '    ORDER BY 2, 1 '+ #13#10 +
    '    INTO :M, :Y, :O '+ #13#10 +
    '  DO '+ #13#10 +
    '  BEGIN '+ #13#10 +
    '    IF (O IS NULL) THEN O = 0; '+ #13#10 +
    '    DEBITBEGIN = 0; '+ #13#10 +
    '    CREDITBEGIN = 0; '+ #13#10 +
    '    DEBITEND = 0; '+ #13#10 +
    '    CREDITEND = 0; '+ #13#10 +
    '    DEBIT = 0; '+ #13#10 +
    '    CREDIT = 0; '+ #13#10 +
    '    IF (O > 0) THEN '+ #13#10 +
    '      DEBIT = :O; '+ #13#10 +
    '    ELSE '+ #13#10 +
    '      CREDIT = - :O; '+ #13#10 +
    ' '+ #13#10 +
    '    SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
    '    if (SALDOBEGIN > 0) then '+ #13#10 +
    '      DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
    '    else '+ #13#10 +
    '      CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '    if (SALDOEND > 0) then '+ #13#10 +
    '      DEBITEND = :SALDOEND; '+ #13#10 +
    '    else '+ #13#10 +
    '      CREDITEND =  - :SALDOEND; '+ #13#10 +
    '    SALDOBEGIN = :SALDOEND; '+ #13#10 +
    '    C = C + 1; '+ #13#10 +
    '    SUSPEND; '+ #13#10 +
    '  END '+ #13#10 +
    '  /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
    '  IF (C = 0) THEN '+ #13#10 +
    '  BEGIN '+ #13#10 +
    '    M = EXTRACT(MONTH FROM :datebegin); '+ #13#10 +
    '    Y = EXTRACT(YEAR FROM :datebegin); '+ #13#10 +
    '    IF (SALDOBEGIN > 0) THEN '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
    '      DEBITEND = :SALDOBEGIN; '+ #13#10 +
    '    END ELSE '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '      CREDITEND =  - :SALDOBEGIN; '+ #13#10 +
    '    END '+ #13#10 +
    '    DEBIT = 0; '+ #13#10 +
    '    CREDIT = 0; '+ #13#10 +
    '    SUSPEND; '+ #13#10 +
    '  END '+ #13#10 +
    'END ';

  Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
  try
    AlterProcedure(StoredProcedure, IBDB);
  except
    on E: Exception do
      Log(Format('������: %s', [E.Message]));
  end;

  StoredProcedure.ProcedureName := 'AC_Q_S1';
  StoredProcedure.Description :=
    '( '+ #13#10 +
    '    VALUEKEY INTEGER, '+ #13#10 +
    '    ABEGINENTRYDATE DATE, '+ #13#10 +
    '    AENDENTRYDATE DATE, '+ #13#10 +
    '    SQLHANDLE INTEGER, '+ #13#10 +
    '    COMPANYKEY INTEGER, '+ #13#10 +
    '    ALLHOLDINGCOMPANIES INTEGER, '+ #13#10 +
    '    INGROUP INTEGER, '+ #13#10 +
    '    PARAM INTEGER, '+ #13#10 +
    '    CURRKEY INTEGER) '+ #13#10 +
    'RETURNS ( '+ #13#10 +
    '    DATEPARAM INTEGER, '+ #13#10 +
    '    DEBITBEGIN NUMERIC(15,4), '+ #13#10 +
    '    CREDITBEGIN NUMERIC(15,4), '+ #13#10 +
    '    DEBIT NUMERIC(15,4), '+ #13#10 +
    '    CREDIT NUMERIC(15,4), '+ #13#10 +
    '    DEBITEND NUMERIC(15,4), '+ #13#10 +
    '    CREDITEND NUMERIC(15,4)) '+ #13#10 +
    'AS '+ #13#10 +
    'DECLARE VARIABLE O NUMERIC(15,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOBEGIN NUMERIC(15,4); '+ #13#10 +
    'DECLARE VARIABLE SALDOEND NUMERIC(15,4); '+ #13#10 +
    'DECLARE VARIABLE C INTEGER; '+ #13#10 +
    'BEGIN '+ #13#10 +
    '  IF (:sqlhandle = 0) THEN '+ #13#10 +
    '  BEGIN '+ #13#10 +
    '    SALDOBEGIN = 0; '+ #13#10 +
    '    SELECT '+ #13#10 +
    '      SUM(IIF(e1.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '        SUM(IIF(e1.accountpart = ''C'', q.quantity, 0)) '+ #13#10 +
    '    FROM '+ #13#10 +
    '      ac_entry e1 '+ #13#10 +
    '      LEFT JOIN ac_quantity q ON q.entrykey = e1.id '+ #13#10 +
    '    WHERE '+ #13#10 +
    '      e1.entrydate < :abeginentrydate AND '+ #13#10 +
    '      (e1.companykey + 0 = :companykey OR '+ #13#10 +
    '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '      e1.companykey + 0 IN ( '+ #13#10 +
    '        SELECT '+ #13#10 +
    '          h.companykey '+ #13#10 +
    '        FROM '+ #13#10 +
    '          gd_holding h '+ #13#10 +
    '        WHERE '+ #13#10 +
    '          h.holdingkey = :companykey))) AND '+ #13#10 +
    '      q.valuekey = :valuekey AND '+ #13#10 +
    '      ((0 = :currkey) OR (e1.currkey = :currkey)) '+ #13#10 +
    '    INTO :saldobegin; '+ #13#10 +
    ' '+ #13#10 +
    '    if (SALDOBEGIN IS NULL) THEN '+ #13#10 +
    '      SALDOBEGIN = 0; '+ #13#10 +
    '   '+ #13#10 +
    '    C = 0; '+ #13#10 +
    '    FOR '+ #13#10 +
    '      SELECT '+ #13#10 +
    '        g_d_getdateparam(e.entrydate, :param), '+ #13#10 +
    '        SUM(IIF(e.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '          SUM(IIF(e.accountpart = ''C'', q.quantity, 0)) '+ #13#10 +
    '      FROM '+ #13#10 +
    '        ac_entry e '+ #13#10 +
    '        LEFT JOIN ac_quantity q ON q.entrykey = e.id AND q.valuekey = :valuekey '+ #13#10 +
    '      WHERE '+ #13#10 +
    '        e.entrydate <= :aendentrydate AND '+ #13#10 +
    '        e.entrydate >= :abeginentrydate AND '+ #13#10 +
    '        (e.companykey + 0 = :companykey OR '+ #13#10 +
    '        (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '        e.companykey + 0 IN ( '+ #13#10 +
    '          SELECT '+ #13#10 +
    '            h.companykey '+ #13#10 +
    '          FROM '+ #13#10 +
    '            gd_holding h '+ #13#10 +
    '          WHERE '+ #13#10 +
    '            h.holdingkey = :companykey))) AND '+ #13#10 +
    '        ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
    '      GROUP BY 1 '+ #13#10 +
    '      INTO :dateparam, '+ #13#10 +
    '           :O '+ #13#10 +
    '    DO '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      IF (O IS NULL) THEN O = 0; '+ #13#10 +
    '      DEBITBEGIN = 0; '+ #13#10 +
    '      CREDITBEGIN = 0; '+ #13#10 +
    '      DEBITEND = 0; '+ #13#10 +
    '      CREDITEND = 0; '+ #13#10 +
    '      DEBIT = 0; '+ #13#10 +
    '      CREDIT = 0; '+ #13#10 +
    '      IF (O > 0) THEN '+ #13#10 +
    '        DEBIT = :O; '+ #13#10 +
    '      ELSE '+ #13#10 +
    '        CREDIT = - :O; '+ #13#10 +
    ' '+ #13#10 +
    '      SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
    '      if (SALDOBEGIN > 0) then '+ #13#10 +
    '        DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '      if (SALDOEND > 0) then '+ #13#10 +
    '        DEBITEND = :SALDOEND; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITEND =  - :SALDOEND; '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '      SALDOBEGIN = :SALDOEND; '+ #13#10 +
    '      C = C + 1; '+ #13#10 +
    '    END '+ #13#10 +
    '    /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
    '    IF (C = 0) THEN '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      DATEPARAM = g_d_getdateparam(:abeginentrydate, :param); '+ #13#10 +
    '      IF (SALDOBEGIN > 0) THEN '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
    '        DEBITEND = :SALDOBEGIN; '+ #13#10 +
    '      END ELSE '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '        CREDITEND =  - :SALDOBEGIN; '+ #13#10 +
    '      END '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '    END '+ #13#10 +
    '  END '+ #13#10 +
    '  ELSE '+ #13#10 +
    '  BEGIN '+ #13#10 +
    ' '+ #13#10 +
    '    SALDOBEGIN = 0; '+ #13#10 +
    '    SELECT '+ #13#10 +
    '      SUM(IIF(e1.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '        SUM(IIF(e1.accountpart = ''C'', q.quantity, 0)) '+ #13#10 +
    '    FROM '+ #13#10 +
    '      ac_ledger_accounts a '+ #13#10 +
    '      JOIN ac_entry e1 ON a.accountkey = e1.accountkey AND '+ #13#10 +
    '        e1.entrydate < :abeginentrydate '+ #13#10 +
    '        AND a.sqlhandle = :sqlhandle  '+ #13#10 +
    '      LEFT JOIN ac_quantity q ON q.entrykey = e1.id '+ #13#10 +
    '    WHERE '+ #13#10 +
    '      (e1.companykey + 0 = :companykey OR '+ #13#10 +
    '      (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '      e1.companykey + 0 IN ( '+ #13#10 +
    '        SELECT '+ #13#10 +
    '          h.companykey '+ #13#10 +
    '        FROM '+ #13#10 +
    '          gd_holding h '+ #13#10 +
    '        WHERE '+ #13#10 +
    '          h.holdingkey = :companykey))) AND '+ #13#10 +
    '      q.valuekey = :valuekey AND '+ #13#10 +
    '      ((0 = :currkey) OR (e1.currkey = :currkey)) '+ #13#10 +
    '    INTO :saldobegin; '+ #13#10 +
    '   '+ #13#10 +
    '    if (SALDOBEGIN IS NULL) THEN '+ #13#10 +
    '      SALDOBEGIN = 0; '+ #13#10 +
    '   '+ #13#10 +
    '    C = 0; '+ #13#10 +
    '    FOR '+ #13#10 +
    '      SELECT '+ #13#10 +
    '        g_d_getdateparam(e.entrydate, :param), '+ #13#10 +
    '        SUM(IIF(e.accountpart = ''D'', q.quantity, 0)) - '+ #13#10 +
    '          SUM(IIF(e.accountpart = ''C'', q.quantity, 0)) '+ #13#10 +
    '      FROM '+ #13#10 +
    '        ac_ledger_accounts a '+ #13#10 +
    '        JOIN ac_entry e ON a.accountkey = e.accountkey AND '+ #13#10 +
    '          e.entrydate <= :aendentrydate AND '+ #13#10 +
    '          e.entrydate >= :abeginentrydate '+ #13#10 +
    '          AND a.sqlhandle = :sqlhandle  '+ #13#10 +
    '        LEFT JOIN ac_quantity q ON q.entrykey = e.id AND q.valuekey = :valuekey '+ #13#10 +
    '      WHERE '+ #13#10 +
    '        (e.companykey + 0 = :companykey OR '+ #13#10 +
    '        (:ALLHOLDINGCOMPANIES = 1 AND '+ #13#10 +
    '        e.companykey + 0 IN ( '+ #13#10 +
    '          SELECT '+ #13#10 +
    '            h.companykey '+ #13#10 +
    '          FROM '+ #13#10 +
    '            gd_holding h '+ #13#10 +
    '          WHERE '+ #13#10 +
    '            h.holdingkey = :companykey))) AND '+ #13#10 +
    '        ((0 = :currkey) OR (e.currkey = :currkey)) '+ #13#10 +
    '      GROUP BY 1 '+ #13#10 +
    '      INTO :dateparam, '+ #13#10 +
    '           :O '+ #13#10 +
    '    DO '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      IF (O IS NULL) THEN O = 0; '+ #13#10 +
    '      DEBITBEGIN = 0; '+ #13#10 +
    '      CREDITBEGIN = 0; '+ #13#10 +
    '      DEBITEND = 0; '+ #13#10 +
    '      CREDITEND = 0; '+ #13#10 +
    '      DEBIT = 0; '+ #13#10 +
    '      CREDIT = 0; '+ #13#10 +
    '      IF (O > 0) THEN '+ #13#10 +
    '        DEBIT = :O; '+ #13#10 +
    '      ELSE '+ #13#10 +
    '        CREDIT = - :O; '+ #13#10 +
    '   '+ #13#10 +
    '      SALDOEND = :SALDOBEGIN + :O; '+ #13#10 +
    '      if (SALDOBEGIN > 0) then '+ #13#10 +
    '        DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '      if (SALDOEND > 0) then '+ #13#10 +
    '        DEBITEND = :SALDOEND; '+ #13#10 +
    '      else '+ #13#10 +
    '        CREDITEND =  - :SALDOEND; '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '      SALDOBEGIN = :SALDOEND; '+ #13#10 +
    '      C = C + 1; '+ #13#10 +
    '    END '+ #13#10 +
    '    /*���� �� ��������� ������ ��� �������� �� ������� ������ �� ������ �������*/ '+ #13#10 +
    '    IF (C = 0) THEN '+ #13#10 +
    '    BEGIN '+ #13#10 +
    '      DATEPARAM = g_d_getdateparam(:abeginentrydate, :param); '+ #13#10 +
    '      IF (SALDOBEGIN > 0) THEN '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        DEBITBEGIN = :SALDOBEGIN; '+ #13#10 +
    '        DEBITEND = :SALDOBEGIN; '+ #13#10 +
    '      END ELSE '+ #13#10 +
    '      BEGIN '+ #13#10 +
    '        CREDITBEGIN =  - :SALDOBEGIN; '+ #13#10 +
    '        CREDITEND =  - :SALDOBEGIN; '+ #13#10 +
    '      END '+ #13#10 +
    '      SUSPEND; '+ #13#10 +
    '    END '+ #13#10 +
    ' '+ #13#10 +
    '  END '+ #13#10 +
    'END ';

  Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
  try
    AlterProcedure(StoredProcedure, IBDB);
  except
    on E: Exception do
      Log(Format('������: %s', [E.Message]));
  end;
end;

procedure RemakeExStored(IBDB: TIBDatabase; Log: TModifyLog);
var
  StoredProcedure: TmdfStoredProcedure;
  IBTr: TIBTransaction;
  q: TIBSQL;
  FieldList, TextSQL, Header: String;
begin
  IBTr := TIBTransaction.Create(nil);
  q := TIBSQL.Create(nil);
  try
    IBTr.DefaultDatabase := IBDB;

    q.Transaction := IBTr;

    try
      IBDB.Connected := False;
      IBDB.Connected := True;

      Header :=
        '  (DATEEND DATE, '#13#10 +
        '   ACCOUNTKEY INTEGER, '#13#10 +
        '   FIELDNAME VARCHAR(60), '#13#10 +
        '   COMPANYKEY INTEGER, '#13#10 +
        '   ALLHOLDINGCOMPANIES INTEGER,'#13#10 +
        '   INGROUP INTEGER,'#13#10 +
        '   CURRKEY INTEGER) '#13#10 +
        'RETURNS (DEBITSALDO NUMERIC(15, 4), '#13#10 +
        '   CREDITSALDO NUMERIC(15, 4), '#13#10 +
        '   CURRDEBITSALDO NUMERIC(15,4),'#13#10 +
        '   CURRCREDITSALDO NUMERIC(15,4),'#13#10 +
        '   EQDEBITSALDO NUMERIC(15,4),'#13#10 +
        '   EQCREDITSALDO NUMERIC(15,4))'#13#10 +
        'AS '#13#10 +
        '  DECLARE VARIABLE SALDO NUMERIC(15, 4); '#13#10 +
        '  DECLARE VARIABLE SALDOCURR NUMERIC(15,4);'#13#10 +
        '  DECLARE VARIABLE SALDOEQ NUMERIC(15,4);'#13#10;

      IbTr.StartTransaction;
      q.SQL.Text :=
        'SELECT * FROM at_relation_fields WHERE relationname = ''AC_ENTRY'' AND fieldname LIKE ''USR$%''';
      q.ExecQuery;

      FieldList := '';
      TextSQL := '';

      while not q.EOF do
      begin
        FieldList := FieldList + Format('  DECLARE VARIABLE %s INTEGER;', [q.FieldByName('fieldname').AsString]) + #13#10;
        TextSQL := TextSQL +
        '  IF (FIELDNAME = ''' + q.FieldByName('fieldname').AsString + ''') THEN '#13#10 +
        '  BEGIN '#13#10 +
        '      FOR '#13#10 +
        '        SELECT ' + q.FieldByName('fieldname').AsString + ', SUM(e.debitncu - e.creditncu), '#13#10 +
        '          SUM(e.debitcurr - e.creditcurr), '#13#10 +
        '          SUM(e.debiteq - e.crediteq)'#13#10 +
        '        FROM ac_entry e  '#13#10 +
        '        WHERE e.accountkey = :accountkey and e.entrydate < :DATEEND AND '#13#10 +
        '          ((e.companykey = :companykey) OR ( (:ALLHOLDINGCOMPANIES = 1) AND '#13#10 +
        '          (e.companykey in ('#13#10 +
        '          SELECT'#13#10 +
        '            h.companykey'#13#10 +
        '          FROM'#13#10 +
        '            gd_holding h'#13#10 +
        '          WHERE'#13#10 +
        '            h.holdingkey = :companykey)) )) AND'#13#10 +
        '          ((0 = :currkey) OR (e.currkey = :currkey))'#13#10 +
        '        GROUP BY ' + q.FieldByName('fieldname').AsString + ' '#13#10 +
        '        INTO :' + q.FieldByName('fieldname').AsString + ', :SALDO, :SALDOCURR, :SALDOEQ '#13#10 +
        '      DO '#13#10 +
        '      BEGIN '#13#10 +
        '        IF (SALDO IS NULL) THEN '#13#10 +
        '          SALDO = 0; '#13#10 +
        '        IF (SALDO > 0) THEN '#13#10 +
        '          DEBITSALDO = DEBITSALDO + SALDO; '#13#10 +
        '        ELSE '#13#10 +
        '          CREDITSALDO = CREDITSALDO - SALDO; '#13#10 +
        '        IF (SALDOCURR IS NULL) THEN'#13#10 +
        '           SALDOCURR = 0;'#13#10 +
        '         IF (SALDOCURR > 0) THEN'#13#10 +
        '           CURRDEBITSALDO = CURRDEBITSALDO + SALDOCURR;'#13#10 +
        '         ELSE'#13#10 +
        '           CURRCREDITSALDO = CURRCREDITSALDO - SALDOCURR;'#13#10 +
        '        IF (SALDOEQ IS NULL) THEN'#13#10 +
        '           SALDOEQ = 0;'#13#10 +
        '         IF (SALDOEQ > 0) THEN'#13#10 +
        '           EQDEBITSALDO = EQDEBITSALDO + SALDOEQ;'#13#10 +
        '         ELSE'#13#10 +
        '           EQCREDITSALDO = EQCREDITSALDO - SALDOEQ;'#13#10 +
        '      END '#13#10 +
        '  END '#13#10;
        q.Next;
      end;

      StoredProcedure.ProcedureName := 'AC_ACCOUNTEXSALDO';
      StoredProcedure.Description := Header + FieldList +
        'BEGIN '#13#10 +
        '  DEBITSALDO = 0; '#13#10 +
        '  CREDITSALDO = 0; '#13#10 +
        '  CURRDEBITSALDO = 0; '#13#10 +
        '  CURRCREDITSALDO = 0; '#13#10 +
        '  EQDEBITSALDO = 0; '#13#10 +
        '  EQCREDITSALDO = 0; '#13#10 +
        TextSQL + '  SUSPEND; '#13#10 +
        'END '#13#10;

      Log(Format('������������� �������� %s', [StoredProcedure.ProcedureName]));
      try
        AlterProcedure(StoredProcedure, IBDB);
      except
        on E: Exception do
          Log(Format('������: %s', [E.Message]));
      end;

      IbTr.Commit;
      IbTr.StartTransaction;

      AddFinVersion(79, '0000.0001.0000.0107', '���������� ��������� AC_ACCOUNTEXSALDO', '27.10.2006', IBTr);

      IbTr.Commit;

    except
      on E: Exception do
      begin
        Log(Format('������: %s', [E.Message]));
        if IBTr.InTransaction then IBTr.Rollback;
      end;
    end;

  finally
    IBTr.Free;
    q.Free;
  end;

end;


end.




/****************************************************/
/****************************************************/
/**                                                **/
/**   Gedemin project                              **/
/**   Copyright (c) 1999-2000 by                   **/
/**   Golden Software of Belarus                   **/
/**                                                **/
/****************************************************/
/****************************************************/

CREATE TABLE gd_command (
  id         dintkey,                      /* ��������� ������������� */
  parent     dparent,                      /* �������� �� ������      */

  name       dname,                        /* ��� ��������            */
  cmd        dtext20,                      /* �������                 */
  cmdtype    dinteger DEFAULT 0 NOT NULL,
  hotkey     dhotkey,                      /* ������� ������         */
  imgindex   dsmallint DEFAULT 0 NOT NULL, /* ������ �������          */
  ordr       dinteger,                     /* �������                 */
  classname  dclassname,                   /* ��� ������              */
  subtype    dtext40,                      /* ������ ������           */

  aview      dsecurity,                    /* �������                 */
  achag      dsecurity,
  afull      dsecurity,

  disabled   ddisabled,
  reserved   dreserved
);

COMMIT;

ALTER TABLE gd_command ADD CONSTRAINT gd_pk_command_id
  PRIMARY KEY (id);

ALTER TABLE gd_command ADD CONSTRAINT gd_fk_command_parent
  FOREIGN KEY (parent) REFERENCES gd_command (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE gd_documenttype ADD CONSTRAINT gd_fk_documenttype_branchkey
  FOREIGN KEY (branchkey) REFERENCES gd_command (id) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE at_relations ADD  CONSTRAINT at_kk_relations_branchkey
  FOREIGN KEY (branchkey) REFERENCES gd_command (id)
  ON UPDATE CASCADE
  ON DELETE SET NULL;

COMMIT;

SET TERM ^ ;

/*

  ��� ��������� ������� ����������� ��� � ������ ��� ��� � �����, ���
  � � ����������� �����.

*/

CREATE TRIGGER gd_bi_command FOR gd_command
  BEFORE INSERT
  POSITION 0
AS
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(gd_g_unique, 1) + GEN_ID(gd_g_offset, 0);
END
^

CREATE TRIGGER gd_aiu_command FOR gd_command
  AFTER INSERT OR UPDATE
  POSITION 100
AS
BEGIN
  UPDATE gd_command SET aview = NEW.aview, achag = NEW.achag, afull = NEW.afull
  WHERE classname = NEW.classname
    AND COALESCE(subtype, '') = COALESCE(NEW.subtype, '')
    AND ((aview <> NEW.aview) OR (achag <> NEW.achag) OR (afull <> NEW.afull))
    AND id <> NEW.id;
END
^

SET TERM ; ^

/*

  �� ����������� �������� ��������� ����� �� ������������� �
  ��������� ����������� (������ ������ � �������, ���������� �� ������).

*/

CREATE TABLE gd_desktop (
  id          dintkey,
  userkey     dintkey,
  screenres   dinteger,
  name        dname,
  saved       dtimestamp DEFAULT 'NOW' NOT NULL,
  dtdata      dblob4096,

  reserved    dinteger
);

COMMIT;

ALTER TABLE gd_desktop ADD CONSTRAINT gd_pk_desktop_id
  PRIMARY KEY (id);

ALTER TABLE gd_desktop ADD CONSTRAINT gd_fk_desktop_userkey
  FOREIGN KEY (userkey) REFERENCES gd_user (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE gd_desktop ADD CONSTRAINT gd_chk_desktop_name
  CHECK (name > '');

COMMIT;

SET TERM ^ ;

CREATE TRIGGER gd_bi_desktop FOR gd_desktop
  BEFORE INSERT
  POSITION 0
AS
BEGIN
  IF (NEW.id IS NULL) THEN
    NEW.id = GEN_ID(gd_g_unique, 1) + GEN_ID(gd_g_offset, 0);
END
^

CREATE TRIGGER gd_bu_desktop FOR gd_desktop
  BEFORE UPDATE
  POSITION 0
AS
BEGIN
  NEW.saved = 'NOW';
END
^

SET TERM ; ^

COMMIT;

COMMIT;

/*
 *  ���������� ��������,
 *  � ������ ����������
 *  ����� ���� ����
 *
 */

CREATE TABLE gd_globalstorage (
  id          dintkey,
  data        dblob4096,
  modified    dtimestamp NOT NULL
);

COMMIT;

ALTER TABLE gd_globalstorage ADD CONSTRAINT gd_pk_globalstorage_id
  PRIMARY KEY (id);

SET TERM ^ ;

CREATE TRIGGER gd_bi_gs FOR gd_globalstorage
  BEFORE INSERT
  POSITION 0
AS
BEGIN
  NEW.id = 880000;
  IF (NEW.modified IS NULL) THEN
    NEW.modified = CURRENT_TIMESTAMP;
END
^

CREATE TRIGGER gd_bu_gs FOR gd_globalstorage
  BEFORE UPDATE
  POSITION 0
AS
BEGIN
  NEW.id = 880000;
  IF (NEW.modified IS NULL) THEN
    NEW.modified = CURRENT_TIMESTAMP;

  IF ((NEW.data IS NULL) OR (CHAR_LENGTH(NEW.data) = 0)) THEN
  BEGIN
    NEW.data = OLD.data;

    INSERT INTO gd_journal (source)
      VALUES ('������� ������� ���������� ���������.');
  END
END
^

CREATE EXCEPTION gd_e_cannot_delete_gs
  'Cannot delete global storage'
^

CREATE TRIGGER gd_bd_gs FOR gd_globalstorage
  BEFORE DELETE
  POSITION 0
AS
BEGIN
  IF (OLD.id = 880000) THEN
  BEGIN
    EXCEPTION gd_e_cannot_delete_gs;
  END
END
^

SET TERM ; ^

COMMIT;

/*
 *  ��������� ��� ������� ������������
 *  �������� �� ����� ������ ��� ������� ������������
 *
 */

CREATE TABLE gd_userstorage (
  userkey      dintkey,
  data         dblob4096,
  modified     dtimestamp NOT NULL
);

ALTER TABLE gd_userstorage ADD CONSTRAINT gd_pk_userstorage_uk
  PRIMARY KEY (userkey);

ALTER TABLE gd_userstorage ADD CONSTRAINT gd_fk_userstorage_uk
  FOREIGN KEY (userkey) REFERENCES gd_user (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

COMMIT;

/*
 *  ��������� ��� ������ ����� �����
 *  �������� �� ����� ������ ��� ������ �����
 *
 */

CREATE TABLE gd_companystorage (
  companykey   dintkey,
  data         dblob4096,
  modified     dtimestamp NOT NULL
);

ALTER TABLE gd_companystorage ADD CONSTRAINT gd_pk_companystorage_ck
  PRIMARY KEY (companykey);

ALTER TABLE gd_companystorage ADD CONSTRAINT gd_fk_companystorage_ck
  FOREIGN KEY (companykey) REFERENCES gd_ourcompany (companykey)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

COMMIT;

CREATE TABLE gd_storage_data (
  id           dintkey,
  storage_type CHAR(1) NOT NULL,  /* G, A, U, C, D */
  userkey      dforeignkey,
  companykey   dforeignkey,
  path         VARCHAR(255) NOT NULL,
  data         dblob4096
);

ALTER TABLE gd_storage_data ADD CONSTRAINT gd_pk_storage_data_id
  PRIMARY KEY (id);

/*

  ó������ SQL ������ � ���� SQL ��������� ������ ��������
  � ���� ��������, � �� � �������.

*/

CREATE TABLE gd_sql_history (
  id               dintkey,
  sql_text         dblobtext80_1251 not null,
  sql_params       dblobtext80_1251,
  bookmark         CHAR(1),
  creatorkey       dintkey,
  creationdate     dcreationdate,
  editorkey        dintkey,
  editiondate      deditiondate,
  exec_count       dinteger_notnull DEFAULT 1
);

ALTER TABLE gd_sql_history ADD CONSTRAINT gd_pk_sql_history
  PRIMARY KEY (id);

ALTER TABLE gd_sql_history ADD CONSTRAINT gd_fk_sql_history_creatorkey
  FOREIGN KEY (creatorkey) REFERENCES gd_contact (id)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

ALTER TABLE gd_sql_history ADD CONSTRAINT gd_fk_sql_history_editorkey
  FOREIGN KEY (editorkey) REFERENCES gd_contact (id)
  ON DELETE NO ACTION
  ON UPDATE CASCADE;

SET TERM ^ ;

CREATE TRIGGER gd_bi_sql_history FOR gd_sql_history
  BEFORE INSERT
  POSITION 0
AS
BEGIN
  IF (NEW.ID IS NULL) THEN
    NEW.ID = GEN_ID(gd_g_unique, 1) + GEN_ID(gd_g_offset, 0);
END
^

CREATE TRIGGER gd_bu_sql_history FOR gd_sql_history
  BEFORE UPDATE
  POSITION 0
AS
BEGIN
  IF (NEW.editiondate <> OLD.editiondate) THEN
    NEW.exec_count = NEW.exec_count + 1;
END
^

SET TERM ; ^

COMMIT;



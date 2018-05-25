DECLARE
  l_version V$VERSION.BANNER%TYPE;
BEGIN
  SELECT REGEXP_REPLACE(BANNER, '^(CORE[[:space:]])([^[:space:]]+)(.+)$', '\2')
  INTO l_version
  FROM V$VERSION
  WHERE BANNER LIKE 'CORE%';
  IF TO_NUMBER(REGEXP_REPLACE(l_version, '^([[:digit:]]+)(.+)$', '\1')) < 12
  THEN
    EXECUTE IMMEDIATE
    'CREATE TABLE KOLECKIJ.VISITS (' ||
    'ID NUMBER(19) NOT NULL, ' ||
    'CONSTRAINT VISITS_PK PRIMARY KEY (ID) USING INDEX' ||
    ')';
  ELSE
    EXECUTE IMMEDIATE
    'CREATE TABLE KOLECKIJ.VISITS (' ||
    'ID NUMBER(19) GENERATED BY DEFAULT AS IDENTITY (START WITH 100001 INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20 NOCYCLE NOORDER) NOT NULL, '
    ||
    'CONSTRAINT VISITS_PK PRIMARY KEY (ID) USING INDEX TABLESPACE TS_RAW_IDX' ||
    ') TABLESPACE TS_RAW';
  END IF;
END;
/

ALTER TABLE KOLECKIJ.VISITS
  ADD (
  AUDIT_CD TIMESTAMP(6) DEFAULT SYSDATE NOT NULL,
  AUDIT_MD TIMESTAMP(6) DEFAULT SYSDATE NOT NULL,
  DOCTOR_ID NUMBER(19),
  PATIENT_ID NUMBER(19),
  HEALTH_CENTER_ID NUMBER(19),
  PRECIPTION_ID NUMBER(19),
    CONSTRAINT DOCTOR_P_HC_P_FK1 FOREIGN KEY (DOCTOR_ID) REFERENCES KOLECKIJ.DOCTORS (ID),
    CONSTRAINT PATIENT_D_HC_P_FK1 FOREIGN KEY (PATIENT_ID) REFERENCES KOLECKIJ.PATIENTS (ID),
    CONSTRAINT HEALTH_CENTER_P_D_P_FK1 FOREIGN KEY (HEALTH_CENTER_ID) REFERENCES KOLECKIJ.HEALTH_CENTER (ID),
    CONSTRAINT PRECIPTION_P_HC_D_FK1 FOREIGN KEY (PRECIPTION_ID) REFERENCES KOLECKIJ.PRESCIPTIONS (ID)
  )
/
DECLARE
  l_count   NUMBER;
  l_version V$VERSION.BANNER%TYPE;
BEGIN
  SELECT count(1)
  INTO l_count
  FROM ALL_SEQUENCES
  WHERE SEQUENCE_OWNER = 'KOLECKIJ' AND SEQUENCE_NAME = 'VISITS_SEQ';
  IF l_count != 0
  THEN
    EXECUTE IMMEDIATE 'DROP SEQUENCE KOLECKIJ.VISITS_SEQ';
  END IF;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE KOLECKIJ.VISITS_SEQ';
  EXECUTE IMMEDIATE
  'CREATE OR REPLACE TRIGGER KOLECKIJ.VISITS_TRG ' ||
  'BEFORE INSERT ON KOLECKIJ.VISITS ' ||
  'FOR EACH ROW ' ||
  'BEGIN ' ||
  'IF :new.ID IS NULL THEN ' ||
  ':NEW.ID := KOLECKIJ.VISITS_SEQ.NEXTVAL; ' ||
  'END IF; ' ||
  'END;';
END;
/
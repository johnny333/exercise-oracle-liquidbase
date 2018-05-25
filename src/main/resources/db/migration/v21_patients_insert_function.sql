CREATE OR REPLACE Function KOLECKIJ.insertPatient(
  p_FIRST_NAME  IN KOLECKIJ.USERS.FIRST_NAME%TYPE,
  p_LASTNAME_NAME  IN KOLECKIJ.USERS.LASTNAME_NAME%TYPE,
  p_BIRTH_DATE  IN KOLECKIJ.USERS.BIRTH_DATE%TYPE,
  p_PESEL IN KOLECKIJ.USERS.PESEL%TYPE)
  RETURN KOLECKIJ.PATIENTS.ID%TYPE
IS

  nexUserIDSeq NUMBER;
  currPatientIDSeq NUMBER;
  BEGIN
    select KOLECKIJ.USERS_SEQ.nextval INTO nexUserIDSeq from dual;
    INSERT INTO KOLECKIJ.USERS ("ID","FIRST_NAME", "LASTNAME_NAME", "BIRTH_DATE","PESEL")
    VALUES (nexUserIDSeq,p_FIRST_NAME, p_LASTNAME_NAME,p_BIRTH_DATE,p_PESEL);
    COMMIT;
    INSERT INTO KOLECKIJ.PATIENTS("USER_ID") values (nexUserIDSeq);
    COMMIT;
    select KOLECKIJ.PATIENTS_SEQ.CURRVAL INTO currPatientIDSeq from dual;

    RETURN currPatientIDSeq;
  END;
/


declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertPatient('Tomasz','Janusz','01.09.1993','12212121211');
end;
/

declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertPatient('Janusz','Tomaszek','01.09.1993','12289892211');
end;
/

declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertPatient('Ramon','Rumun','01.09.1993','32412121211');
end;
/

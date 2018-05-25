CREATE OR REPLACE Function KOLECKIJ.insertDoctor(
  p_FIRST_NAME  IN KOLECKIJ.USERS.FIRST_NAME%TYPE,
  p_LASTNAME_NAME  IN KOLECKIJ.USERS.LASTNAME_NAME%TYPE,
  p_BIRTH_DATE  IN KOLECKIJ.USERS.BIRTH_DATE%TYPE,
  p_PESEL IN KOLECKIJ.USERS.PESEL%TYPE,
  p_SPECIALIZATION IN KOLECKIJ.DOCTORS.SPECIALIZATION%TYPE)
  RETURN KOLECKIJ.DOCTORS.ID%TYPE
IS

  nexUserIDSeq NUMBER;
  currDoctorIDSeq NUMBER;
  BEGIN
    select KOLECKIJ.USERS_SEQ.nextval INTO nexUserIDSeq from dual;
    INSERT INTO KOLECKIJ.USERS ("ID","FIRST_NAME", "LASTNAME_NAME", "BIRTH_DATE","PESEL")
    VALUES (nexUserIDSeq,p_FIRST_NAME, p_LASTNAME_NAME,p_BIRTH_DATE,p_PESEL);
    COMMIT;
    INSERT INTO KOLECKIJ.DOCTORS("SPECIALIZATION","USER_ID") values (p_SPECIALIZATION,nexUserIDSeq);
    COMMIT;
    select KOLECKIJ.DOCTORS_SEQ.CURRVAL INTO currDoctorIDSeq from dual;

    RETURN currDoctorIDSeq;
  END;
/


declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertDoctor('Jakub','Kołecki','22.07.1993','93072201217','psychiatra');
end;
/


declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertDoctor('Damian','Likszo','12.07.1993','12121212121','psychiatra');
end;
/


declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertDoctor('Tomasz','Rogalski','22.03.1993','93072898989','psychiatra');
end;
/

CREATE OR REPLACE Function KOLECKIJ.insertHealthCenter(
  p_NAME KOLECKIJ.HEALTH_CENTER.NAME%TYPE,
  p_ADDRESS KOLECKIJ.HEALTH_CENTER.ADDRESS%TYPE,
  p_PHONE KOLECKIJ.HEALTH_CENTER.PHONE%TYPE)
  RETURN KOLECKIJ.HEALTH_CENTER.ID%TYPE
IS
  nexUHealthCenterIDSeq NUMBER;
  BEGIN
    select KOLECKIJ.HEALTH_CENTER_SEQ.nextval INTO nexUHealthCenterIDSeq from dual;
    INSERT INTO KOLECKIJ.HEALTH_CENTER ("ID","NAME", "ADDRESS", "PHONE")
    VALUES (nexUHealthCenterIDSeq, p_NAME, p_ADDRESS, p_PHONE);
    RETURN nexUHealthCenterIDSeq;
  END;
/


declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertHealthCenter('Rodzina','Słoneczna 2', '123123123');
end;
/



declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertHealthCenter('Sztywna','Nogami do przodu 2', '987987987');
end;
/

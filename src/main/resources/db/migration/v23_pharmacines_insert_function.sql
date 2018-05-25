
CREATE OR REPLACE Function KOLECKIJ.insertPharmacies(
  p_ADDRESS IN KOLECKIJ.PHARMACIES.ADDRESS%TYPE,
  p_NAME IN KOLECKIJ.PHARMACIES.NAME%TYPE)
  RETURN KOLECKIJ.PHARMACIES.ID%TYPE
IS
  currIDSeq NUMBER;
  BEGIN
    INSERT INTO KOLECKIJ.PHARMACIES ("ADDRESS","NAME") VALUES (p_ADDRESS,p_NAME);
    COMMIT;
    select KOLECKIJ.PHARMACIES_SEQ.CURRVAL INTO currIDSeq from dual;
    RETURN currIDSeq;
  END;
/

/
declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertPharmacies('Rurowa','Zdrowie');
end;
/


declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertPharmacies('Stalowa','Gemini');
end;
/


declare
  result number;
begin
  -- Call the function
  result :=KOLECKIJ.insertPharmacies('Patologii','AptExpres');
end;
/
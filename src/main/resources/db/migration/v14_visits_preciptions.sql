CREATE TABLE  KOLECKIJ.VISITS_PRECIPTIONS(
  VISIT_ID NUMBER(19),
  PRECIPTION_ID NUMBER(19),
  CONSTRAINT VISIT_P_FK1 FOREIGN KEY (VISIT_ID) REFERENCES KOLECKIJ.VISITS(ID),
  CONSTRAINT PRECIPTION_V_FK2 FOREIGN KEY (PRECIPTION_ID) REFERENCES KOLECKIJ.PRESCIPTIONS(ID)

)
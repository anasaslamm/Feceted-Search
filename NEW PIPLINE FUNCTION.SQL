--OPTION   1    

create or replace TYPE apex_developer AS OBJECT (
      APEX_ID number,
      NAME varchar(100),
      JOB_ID VARCHAR2(100),
      CITY VARCHAR2(100),
      DISCRIPTION varchar2(100),
      SALERY number
);
-- OPTION 2 
create or replace TYPE  apex_developer_type AS TABLE  OF apex_developer
/

-- OPTION 3 
CREATE OR REPLACE FUNCTION APEX_DEVELOPERS_FUNCTION
RETURN apex_developer_type PIPELINED
IS  V_APEX_DEV     apex_developer;
BEGIN
    FOR R IN (
        SELECT 
            AP.APEX_ID, 
            AP.NAME, 
            OC.JOB_ID, 
            AP.CITY, 
            OC.DISCRIPTION, 
            AP.SALERY
        FROM 
            APEX AP
        JOIN 
            ORACLE OC 
        ON 
            OC.ORACLE_ID = AP.ORACLE_ID
        WHERE 
            AP.NAME IS NOT NULL
    )
    LOOP
     
           V_APEX_DEV  :=  apex_developer(
                R.APEX_ID,
                R.NAME,
                R.JOB_ID,
                R.CITY,
                R.DISCRIPTION,
                R.SALERY
            );
       
        PIPE ROW(V_APEX_DEV);
    END LOOP;

    RETURN;
END APEX_DEVELOPERS_FUNCTION;
/

-- OPTION   4 

 create or replace package "AB_APEX_PACAKGE" as
  TYPE  apex_developer_type IS TABLE  OF apex_developer; --<----  ye ham ne pehly type di ha phir hm ne object diya ha  is ka matlb ye ha ke jo object me jo value ha wo type me jay gi

  FUNCTION APEX_DEVELOPERS_FUNCTION RETURN apex_developer_type PIPELINED;  --<<--------- ab hm ne function ka name ur promt idr de diya ha ur ye function phir type return kry ga us type me alredy object ki value aa rhi ha 
end "AB_APEX_PACAKGE";
/  


-- OPTION 5 


create or replace package body "AB_APEX_PACAKGE" as
FUNCTION APEX_DEVELOPERS_FUNCTION
RETURN apex_developer_type PIPELINED
IS  V_APEX_DEV     apex_developer;
BEGIN
    FOR R IN (
        SELECT 
            AP.APEX_ID, 
            AP.NAME, 
            OC.JOB_ID, 
            AP.CITY, 
            OC.DISCRIPTION, 
            AP.SALERY
        FROM 
            APEX AP
        JOIN 
            ORACLE OC 
        ON 
            OC.ORACLE_ID = AP.ORACLE_ID
        WHERE 
            AP.NAME IS NOT NULL
    )
    LOOP
     
           V_APEX_DEV  :=  apex_developer(
                R.APEX_ID,
                R.NAME,
                R.JOB_ID,
                R.CITY,
                R.DISCRIPTION,
                R.SALERY
            );
       
        PIPE ROW(V_APEX_DEV);
    END LOOP;

    RETURN;
END APEX_DEVELOPERS_FUNCTION;
END AB_APEX_PACAKGE
;


OPTION   6   RUN QUERY 

SELECT * FROM 
               TABLE(AB_APEX_PACAKGE.APEX_DEVELOPERS_FUNCTION);


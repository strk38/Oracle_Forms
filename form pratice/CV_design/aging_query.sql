select 
ACNAME as "CONTROL HEAD", 
EMP_NAME as "EMPLOYEE", 
DRCR_CODE as "SUB HEAD", 
CURR_AMOUNT as "CURRENT AMOUNT", 
FIST_30_AMOUNT as "1-30 Days", 
FIST_60_AMOUNT as "31-60 Days", 
FIST_90_AMOUNT as "<=90 Days"
from
ACT_COA, HR_EMPLOYEE, ACT_DEBCRIMT,ACT_AGING_BUCKET;

--SELECT CONTROL_CODE, EMP_CODE, ACSUB_CODE, CURR_AMOUNT, FIST_30_AMOUNT, FIST_60_AMOUNT, FIST_90_AMOUNT
--FROM ACT_AGING_BUCKET;


SELECT CONTROL_CODE,  ACSUB_CODE, (SELECT DRCR_NAME FROM ACT_DEBCRIMT WHERE DRCR_CODE=A.ACSUB_CODE) SUB_HEAD, CURR_AMOUNT, FIST_30_AMOUNT, FIST_60_AMOUNT, FIST_90_AMOUNT,FIST_90_ABOVE_AMOUNT
FROM ACT_AGING_BUCKET A
ORDER BY TRIM(UPPER(SUB_HEAD));

select *  from abc_company;


------------------------------------
declare
company varchar2(200);
begin
  select company_name into company
  from abc_company where company_code = :p_company_code;
  
  return(company);
exception
    when others then
    return null;
end;

SELECT CONTROL_CODE,  ACSUB_CODE, (SELECT DRCR_NAME FROM ACT_DEBCRIMT WHERE DRCR_CODE=A.ACSUB_CODE) SUB_HEAD, 
CURR_AMOUNT, FIST_30_AMOUNT, FIST_60_AMOUNT, FIST_90_AMOUNT,FIST_90_ABOVE_AMOUNT
FROM ACT_AGING_BUCKET A
ORDER BY TRIM(UPPER(SUB_HEAD));


select 
CURR_AMOUNT, FIST_30_AMOUNT, FIST_60_AMOUNT, 
FIST_90_AMOUNT,FIST_90_ABOVE_AMOUNT, 
(nvl(CURR_AMOUNT,0)+nvl(FIST_30_AMOUNT,0)+nvl(FIST_60_AMOUNT,0)+ nvl(FIST_90_AMOUNT,0)+nvl(FIST_90_ABOVE_AMOUNT,0)) as "TOTAL" 
from ACT_AGING_BUCKET;


/*
CREATE TABLE Persons (
    ID int NOT NULL UNIQUE,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT PK_Person PRIMARY KEY (ID,LastName)
);

ALTER TABLE Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID,LastName);

ALTER TABLE Persons
ADD PRIMARY KEY (ID);

*/


create table C_UserName(
    U_Id number NOT NULL,
    F_Name varchar(255) NOT NULL,
    Gender varchar(6),
    Email varchar(255) UNIQUE,
    Phone varchar(11) UNIQUE,
    DateOfBirth Date,
 
    Primary Key (U_Id)
    );
    
create table C_EdBackground(
    E_Sl number NOT NULL,
    D_gree varchar(200) NOT NULL,
    G_roup varchar(190),
    University varchar(250),
    Start_year int,
    End_year int,
    Fk_U_Id number,
    Primary Key (E_Sl),
    FOREIGN KEY (Fk_U_Id)
    REFERENCES C_UserName(U_Id)
    );

create table C_Skill(
    S_Types varchar(200),
     Fk_S_Id number,
    FOREIGN KEY (Fk_S_Id)
    REFERENCES C_UserName(U_Id)
);

drop table C_Skill;

alter table C_Skill
drop column S_SL;

alter table C_Skill
add column S_SL ;

create table C_W_Exp(
    W_Sl number Null,
    C_Name varchar(200)  NULL,
    Position varchar(190),
    Duration int,
    Fk_U_Id number,
    Primary Key (W_Sl),
    FOREIGN KEY (Fk_U_Id)
    REFERENCES C_UserName(U_Id)
    );
    
create table C_Year(
    Y_Year int,
    Primary Key (Y_Year)
    );
    
insert into C_Year
    values('1990');
    
insert into C_Year
    values('1991');
    
insert into C_Year
    values('1992');
    
insert into C_Year
    values('1993');


--declare
--v_num number;
--begin
--
--   select nvl(max(U_Id),0)+1 into v_num from C_UserName;
--        
--  :C_UserName.U_Id:=v_char;
--  
--exception
--    when others then
--        null;
--end;

 select nvl(max(U_Id),0)+1 from C_UserName;
 
 
select EXTRACT(YEAR from SYSDATE) from dual;

--------------------------------Entering automate Year DATA :STARTS
SET SERVEROUTPUT ON;

declare
v_year int;
v_dbYear int;
begin
    select to_number(EXTRACT(YEAR from SYSDATE))  into v_year from dual;
--   dbms_output.put_line('Current year '||v_year);
    
    select to_number(max(Y_Year)) into  v_dbYear from C_Year;
--    v_dbYear :=v_year; 
    v_dbYear := v_dbYear + 1;
    
--    dbms_output.put_line('Y in Database+1 '||v_dbYear);
    
    while v_dbYear<= v_year loop
        Insert into C_Year values (v_dbYear);
--        dbms_output.put_line(v_dbYear);
        v_dbYear := v_dbYear + 1;
   end loop;
  commit;    

end;

--------------------------------Entering automate Year DATA : ENDS

/*
    if v_year < v_dbYear then
        dbms_output.put_line('Exit loop');
    else
        while v_dbYear<= v_year loop
            Insert into C_Year values (v_dbYear);
----           dbms_output.put_line(v_dbYear);
            v_dbYear := v_dbYear + 1;
        end loop;
        commit;
    end if;

*/


---------------------------------------------------------------

/*
declare
v_year int;
v_dbYear int;
begin
    select to_number(EXTRACT(YEAR from SYSDATE)) into v_year from dual;
   --dbms_output.put_line('Current year '||v_year);
    
    select to_number(max(Y_Year)) into v_dbYear from C_Year;
    v_dbYear := v_dbYear + 1;
    
   --dbms_output.put_line('Y in Database+1 '||v_dbYear);
    
    if v_year < v_dbYear then
        null;
      --  dbms_output.put_line('Exit loop');
    else
        while v_dbYear<= v_year loop
            Insert into C_Year values (v_dbYear);
            v_dbYear := v_dbYear + 1;
        end loop;
        commit;
    end if;
end;
*/

/*
declare
v_year number;
v_dbYear number;
v_date number;
     
     
   begin    
    select to_number(EXTRACT(YEAR from SYSDATE)) into v_year from dual;
    
    select to_number(max(Y_Year))+1 into v_dbYear from C_Year; 
     
    declare
    start_date number :=v_dbYear;---2
    end_date number :=v_year;--30
    begin

            for i in (start_date, 'j')..(end_date, 'j') loop
            v_date:=((i, 'j'));
            Insert into C_Year values (v_date);
            end loop;

    exception
        when others then
        message(sqlerrm||'-----1');
    end;
             
   exception
        when others then
        message(sqlerrm||'-----2');
    end;
             
*/             

             
---------------------------------------------------------------

SELECT ALL a.U_ID, 
a.F_NAME, a.GENDER, a.EMAIL, a.PHONE, 
a.DATEOFBIRTH, b.D_GREE, b.G_ROUP, b.UNIVERSITY, 
b.START_YEAR, b.END_YEAR
FROM C_USERNAME a, C_EDBACKGROUND b
WHERE (b.FK_U_ID = a.U_ID) 

SELECT c.C_NAME, c.POSITION, c.DURATION, c.FK_U_ID
FROM C_W_EXP c

SELECT ALL d.S_TYPES, d.FK_S_ID
FROM C_SKILL d

---------------------------------------------------
SELECT DISTINCT A.U_ID, 
A.F_NAME, A.GENDER, A.EMAIL, A.PHONE, 
A.DATEOFBIRTH, B.D_GREE, B.G_ROUP, 
B.UNIVERSITY, B.START_YEAR, B.END_YEAR, 
C.C_NAME, C.POSITION, C.DURATION, D.S_TYPES
FROM C_USERNAME A, C_EDBACKGROUND B, C_W_EXP C, C_SKILL D
WHERE A.U_ID=B.FK_U_ID
AND B.FK_U_ID=C.FK_U_ID
AND C.FK_U_ID=D.FK_S_ID
AND A.U_ID=:P_ID
------------------------------------------------------------------------------------
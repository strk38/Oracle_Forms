-----------------------------------------------------------------

create table Equipments
    (
    equi_name varchar2(30) not null, 
    qty integer not null, 
    price number not null
    );

drop table Equipments;

insert into Equipments
values ('Books',12,125);

select * from Equipments;

----------------------------------------------------
create table i_employee
    (e_Id number not null, 
    e_name varchar2(60) not null, 
    email varchar2(30),
    age int,
    i_job_type varchar2(30) not null,
    primary key (e_Id)
    );
    
insert into i_employee 
    values (101,'Mark','mark@mail',35,'Sales Agent');
    
insert into i_employee 
    values (102,'Thomas','thomas@mail',35,'Marketing Agent');

select * from i_employee;

-------------------------------------------------------
select * from i_job;

drop table i_job;

create table i_job
    (
        j_Id number not null,
        j_type varchar2(30) not null,
        primary key (j_type)
    )
    
insert into i_job
    values 
    (110, 'Sales Agent');

insert into i_job
    values 
    (210,'Marketing Agent');
    
-- --------------------------Addign foreign key    
ALTER TABLE i_employee
ADD FOREIGN KEY (i_job_type) REFERENCES i_job(j_type);

SELECT DISTINCT i_job_type FROM i_employee WHERE i_job_type NOT IN (
    SELECT j_type FROM i_job);
    
    
select j_Id, j_type from i_job;

------------------------------------------------------
create table i_department
    (Dept_no varchar2(20) not null, 
    Dept_name varchar2(60) not null, 
    primary key (Dept_no)
    );

ALTER TABLE i_employee
    ADD Fk_Dept_no varchar2(20);
    
ALTER TABLE i_employee
    Add FOREIGN KEY (Fk_Dept_no) REFERENCES i_department(Dept_no);
    
insert into i_department
    values ('Dep_101','Human Resource');
    
insert into i_department
    values ('Dep_201','Management');

insert into i_department
    values ('Dep_301','Sales');         

-----------------------------------------------------
delete from i_employee;

select *  from i_employee;

select *  from i_department;

insert into i_employee 
    values (101,'Mark','mark@mail',35,'Sales Agent','Dep_201' );
    
insert into i_employee 
    values (102,'Thomas','thomas@mail',35,'Marketing Agent','Dep_301' );
    
insert into i_employee 
    values (103,'Hank','hank@mail',30,'Sales Agent','Dep_101');
    


--SELECT col_name(s) FROM Table_Name
--ORDER BY appr_col_name DESC
--WHERE ROWNUM <= 1;


select max(Dept_no) as new_num
    from i_department
    order by Dept_no DESC;

select substr(new_num,5,7) +100
    from
    (
    select max(Dept_no) as new_num
    from i_department
    order by Dept_no DESC
    );
    
select concat('Dep_', (select substr(new_num,5,7) +100
    from
    (
    select max(Dept_no) as new_num
    from i_department
    order by Dept_no DESC
    ))
    ) from i_department;

select concat('Dep_',(select substr(max(Dept_no),5)+100 from i_department))
    from i_department;
    
select substr(max(Dept_no),5)+100 from i_department;

SET Serveroutput ON;

declare
v_num number;
v_char varchar2(30);
begin
    select substr(max(Dept_no),5)+100 into v_num from i_department;
    
    v_char := 'Dep_'||v_num;
    
--    dbms_output.put_line(v_char);
--    select v_char into :I_DEPARTMENT.DEPT_NAME from i_department;

    :i_department.Dept_no:=v_char;

exception
    when others then
    null;
end;



/*
declare
v_num number;
v_char varchar2(30);
begin
    select substr(max(Dept_no),5)+100 into v_num from i_department;
    
    v_char := 'Dep_'||v_num;
    
--    dbms_output.put_line(v_char);
    select v_char into :I_DEPARTMENT.DEPT_NO
    from i_department;

exception
    when others then
    null;
end;
*/



  select nvl(max( to_number(substr(Dept_no,5)) ),0)+100  into v_num from i_department;
  
ALTER TABLE I_department
ADD UNIQUE (DEPT_NAME);

--ALTER TABLE I_Job
--ADD UNIQUE (J_Type);
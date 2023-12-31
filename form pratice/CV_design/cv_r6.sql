SELECT ALL C_USERNAME.U_ID, 
C_USERNAME.F_NAME, C_USERNAME.GENDER, C_USERNAME.EMAIL, C_USERNAME.PHONE, 
C_USERNAME.DATEOFBIRTH, C_EDBACKGROUND.D_GREE, C_EDBACKGROUND.G_ROUP, 
C_EDBACKGROUND.UNIVERSITY, C_EDBACKGROUND.START_YEAR, C_EDBACKGROUND.END_YEAR, 
C_W_EXP.C_NAME, C_W_EXP.POSITION, C_W_EXP.DURATION, C_SKILL.S_TYPES
FROM C_USERNAME, C_EDBACKGROUND, C_W_EXP, C_SKILL
WHERE ((C_EDBACKGROUND.FK_U_ID = C_USERNAME.U_ID)
 AND (C_W_EXP.FK_U_ID = C_USERNAME.U_ID)
 AND (C_SKILL.FK_S_ID = C_USERNAME.U_ID)) ;
 
 
SELECT ALL C_USERNAME.U_ID,C_USERNAME.F_NAME, C_USERNAME.GENDER, C_USERNAME.EMAIL, C_USERNAME.PHONE, 
C_USERNAME.DATEOFBIRTH, C_W_EXP.C_NAME, C_W_EXP.POSITION, C_W_EXP.DURATION
FROM C_USERNAME, C_W_EXP
WHERE  (C_W_EXP.FK_U_ID = C_USERNAME.U_ID) ;
 
 SELECT ALL C_SKILL.S_TYPES
FROM C_USERNAME,  C_SKILL
WHERE  (C_SKILL.FK_S_ID = C_USERNAME.U_ID);



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
-- ((C_EDBACKGROUND.FK_U_ID = C_USERNAME.U_ID)
-- AND (C_W_EXP.FK_U_ID = C_USERNAME.U_ID))
 
 select * from C_W_EXP
 
 --select * from hr_
 
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
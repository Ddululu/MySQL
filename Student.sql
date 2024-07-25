CREATE TABLE student(
	hakbun CHAR(4),
    name	VARCHAR(20) NOT NULL,
    kor		TINYINT NOT NULL CHECK(kor BETWEEN 0 AND 100),
    eng		TINYINT NOT NULL,
    mat		TINYINT NOT NULL,
    edp		TINYINT NOT NULL,
    tot		TINYINT,
    avg		FLOAT(5,2),
    grade	CHAR(1),
    deptno	TINYINT,
    CONSTRAINT student_hakbun_pk 	PRIMARY KEY(hakbun),
	CONSTRAINT student_name_uk		UNIQUE(name),
    CONSTRAINT   student_grade_ck	CHECK(grade IN('A','B','C','D','F')),
	CONSTRAINT	student_deptno_fk 	FOREIGN KEY(deptno)
							REFERENCES dept(deptno)
)DEFAULT CHARSET utf8;
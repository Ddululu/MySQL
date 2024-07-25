/*DDL : Query -> Auto Commit
DML: (Query ->Memory Buffer -> Commit) = 트랜잭션, 
트랜잭션은 다수의 쿼리가 모두 Table에 적용되기까지 메모리 버퍼에 잠시 저장 후, Commit 될 때 DB에 반영하는 것. */

START TRANSACTION;
UPDATE emp SET deptno = 10 WHERE empno = 7782;
SAVEPOINT a;

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES (7999, 'TOM', 'SALESMAN', 7782, CURDATE(), 2000, 2000, 10);

ROLLBACK TO a;
commit;

select * from emp where deptno=10;

CREATE TABLE emp20
AS
SELECT empno, ename, sal
FROM emp
WHERE deptno=20;

ALTER TABLE emp20
ADD age TINYINT AFTER ename;

ALTER TABLE emp20
DROP COLUMN sal;

ALTER TABLE emp20
MODIFY ename VARCHAR(4);

SELECT * FROM emp20;

CREATE TABLE Jusorok
( 
bunho SMALLINT,
gender CHAR(6) DEFAULT '남자'
);

INSERT INTO Jusorok VALUES (1, '여자');
INSERT INTO Jusorok VALUES (2,DEFAULT);
SELECT * FROM Jusorok;

INSERT INTO dept
VALUES(10, 'TEST', 'SEOUL');

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

ALTER TABLE student
MODIFY edp TINYINT NOT NULL;

ALTER TABLE student
ADD CONSTRAINT student_tot_ck CHECK(tot BETWEEN 0 AND 400);

ALTER TABLE student
MODIFY eng TINYINT;

/* 제약조건 이름을 지정했다면 제약조건을 제거할 때 이름으로 지울 수 있다.*/
ALTER TABLE student
DROP CONSTRAINT student_name_uk;
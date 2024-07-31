/* 단일 행을 View로 구성하면 미리 조건이 들어간 테이블을 만들지 않아도 됨. *.
CREATE VIEW mycompany.empview10
AS
SELECT empno,ename, job
FROM emp
WHERE deptno =10;


/* 다중 행을 View로 구성하면 호출할 때마다 JOIN을 하거나 새로운 테이블을 만들지 않아도 됨.*/
CREATE VIEW mycompany.bbb 
AS
SELECT empno,ename,dname,loc
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE dept.deptno =30;

/*INFORMATION_SCHEMA.VIEWS에서 만들어진 뷰를 확인할 수 있다. */
SELECT * FROM INFORMATION_SCHEMA.VIEWS;

/*단순 뷰에서는 데이터 추가가 가능하다.*/
CREATE VIEW EMP_30_VU
AS
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno = 30;

INSERT INTO EMP_30_VU
VALUES(1111, 'Jimin', 500, 30);

/*view에 등록한 데이터가 기존 테이블에서도 추가된 것을 볼 수 있다.*/
select * from emp where empno = 1111;

CREATE OR REPLACE VIEW emp_20
AS
SELECT * FROM emp
WHERE empno = 30
WITH CHECK OPTION;

select * from emp_20;

UPDATE emp_20
SET empno = 50
WHERE empno = 30;

select * from emp_20;

create view views
as
select * from information_schema.views;

delimiter //
create procedure if_test()
BEGIN
	SET var := 51 INT;
    if var%2 =0 THEN
		select 'even number';
    else
		select 'odd number';
    end if;
END
//
delimiter ;

call if_test();

delimiter //
create procedure call_test2(IN arg1 INT, IN arg2 INT, out output INT)
BEGIN
	ouput = arg1+arg2;
END
//
delimiter ;

call call_test(1,2);

select *
from emp
where ename LIKE('B%') AND ename LIKE('J%');
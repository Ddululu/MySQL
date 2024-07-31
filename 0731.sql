/*OUT을 이용해 데이터를 반환하려면 INTO를 이용해 데이터를 담아줘야 한다.*/
DELIMITER //
CREATE PROCEDURE sp_test(
    OUT v_now DATETIME,
    OUT v_version VARCHAR(30)
)
BEGIN
    SELECT NOW(), VERSION() 
    INTO v_now, v_version;
END
//
DELIMITER;

/* 프로시저 상의 v_now와 v_version은 지역변수 취급, 
바깥에서 사용하기 위해서는 바인딩이 필요함. 
out으로 사용된 변수는 @를 이용해 Output임을 알려줌 */
CALL sp_test(@t_now1, @t_version1);
select @t_now1, @t_version1;


/*====================================================*/
/* 입력과 출력 파라미터가 없는 프로시저 */

CREATE TABLE dept_clone
AS
SELECT * FROM dept;

delimiter //
create procedure sp_deleteDept()
BEGIN
    truncate table dept_clone;
END
//
DELIMITER ;

drop table dept_clone;

/*======================================================*/
/* 입력 파라미터로 Insert를 하는 프로시저 */

DELIMITER //
create procedure sp_insertDept(
    IN v_deptno TINYINT,
    IN v_dname  VARCHAR(14),
    IN v_loc    VARCHAR(13)
)
BEGIN
    INSERT INTO dept_clone(deptno, dname, loc)
    VALUE (v_deptno, v_dname, v_loc);
    COMMIT;
END
// delimiter ;

call sp_insertDept(50,'Design','Seoul');

/*====================================================*/
/* 사원 번호를 입력받아 부서이름과 부서 위치를 출력하는 프로시저 */
DELIMITER //
create procedure sp_selectEmp(
    IN v_empno INT,
    OUT v_dname  VARCHAR(14),
    OUT v_loc    VARCHAR(13)
)
BEGIN
    SELECT dname, loc INTO v_dname, v_loc
    FROM emp JOIN dept on (emp.deptno = dept.deptno)
    where empno = v_empno;
END
// delimiter ;

/* 테스트 */
call sp_selectEmp(7369, @t_dname, @t_loc);
select @t_dname, @t_loc;

/*===============================================*/
/* 부서이름이 일력되면 부서의 위치로 바꿔 출력하는 프로시저*/
DELIMITER //
create procedure sp_selectDname(
    INOUT v_name  VARCHAR(14)
)
BEGIN
	DECLARE v_str VARCHAR(14);
    SELECT loc INTO v_str
    FROM dept
    where dname = v_name;
    SET v_name:=v_str;
END
// delimiter ;
/* DECLARE로 임시변수 선언 -> 임시변수에 쿼리 결과를 저장 -> SET으로 임시변수의 값을 입력받은 파라미터에 저장.*/ 

/* 테스트, 입력 값이 출력이기 때문에 마찬가지로 변수에 담아서 보내야 한다. */
SET @t_str = 'RESEARCH';
call sp_selectDname(@t_str);
select @t_str;

/*=============================================*/
/* 부서 번호로 입력받아 부서 구성원의 정보를 여러 레코드로 출력 될 때 */
delimiter //
CREATE PROCEDURE sp_select_emp_dept(
	IN v_deptno TINYINT
)
BEGIN
	SELECT empno, ename, dname, loc, dept.deptno
    FROM emp NATURAL JOIN dept
    where dept.deptno = v_deptno;
END
// delimiter ;

/* 테스트 */
call sp_select_emp_dept(40);

/*=============================================*/
/* patient 테이블에서 모든 환자의 정보를 출력하는 프로시저 */
delimiter //
CREATE PROCEDURE sp_select_all_patient()
BEGIN
	SELECT number, dept, operfee, hospitalfee, money 
    FROM patient
    ORDER BY number DESC;
END
// delimiter ;

/*===========================================*/
/* 환자 번호를 입력받아 환자의 모든 정보를 출력하는 프로시저 */
delimiter //
CREATE PROCEDURE sp_select_one_patient(
	IN v_number INT
)
BEGIN
	SELECT *
    FROM patient
    where number = v_number
    ORDER BY number DESC;
END
// delimiter ;

call sp_select_one_patient(3);

/*===========================================*/
/* 환자 번호로 환자의 정보를 수정하는 프로시저 */
delimiter //
CREATE PROCEDURE sp_update_patient(
	IN v_number INT,
    IN v_code CHAR(2),
    In v_days  SMALLINT,
    IN v_age  TINYINT,
    IN v_dept  VARCHAR(20),
    IN v_operfee  INT,
    IN v_hospitalfee INT,
    IN v_money  INT
)
BEGIN
	UPDATE patient
    SET code = v_code, days = v_days, age =v_age, dept=v_dept, operfee=v_operfee, hospitalfee=v_hospitalfee, money = v_money
    where number = v_number;
	COMMIT;
END
// delimiter ;
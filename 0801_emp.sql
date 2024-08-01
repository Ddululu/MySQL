
/*=================================================*/
/* 테이블 생성 */
create table dept
(	code 		CHAR(1) 	PRIMARY KEY,
	name 		VARCHAR(10)	NOT NULL);

    create table sal_ho
(	ho 			TINYINT PRIMARY KEY,
	money		INT		NOT NULL);
    
create table grade
(	grade 		TINYINT PRIMARY KEY,
	money		INT		NOT NULL);
    
create table overtime
(	time 		TINYINT PRIMARY KEY,
	money		INT		NOT NULL);

create table emp
(	empno		VARCHAR(4) PRIMARY KEY,
	ename		varchar(10) NOT NULL,
    grade		TINYINT		NOT NULL,
    overtime	TINYINT	NOT NULL,
    family		TINYINT	NOT NULL);
    
/*=================================================*/
/* 데이터 삽입 */    
insert into dept values 
('A','영업부'),('B','업무부'),('C','홍보부'),
('D','인사부'),('E','경리부'),('F','판촉부'),
('G','총무부');

insert into sal_ho values
(1,900000),(2,400000),(3,600000),
(4,800000),(5,300000),(6,800000),
(7,800000);

insert into grade values
(1,15000),(2,25000),
(3,35000),(4,45000);

insert into overtime values
(1,1500),(2,2500),
(3,3500),(4,4500);

insert into emp values
('A522','조성모', 3 , 4 ,4),
('C122','이미자', 2 , 1 ,3),
('A512','설운도', 1 , 1 ,1);


/*=================================================*/
/* 프로시저 선언 */
/* 사원번호를 입력받아 기본급을 출력 */
delimiter //
CREATE PROCEDURE grade_money( IN v_empno char(5), OUT v_money INT )
BEGIN
	select money into v_money
    from grade,emp
    where empno=v_empno AND grade.grade=emp.grade;
END
// delimiter ;

/* 사원번호를 입력받아 야간수당을 출력 */
delimiter //
CREATE PROCEDURE overtime_money( IN v_empno char(5), OUT v_money INT )
BEGIN
	select money into v_money
    from overtime,emp
    where empno=v_empno AND overtime.time=emp.overtime;
END
// delimiter ;

/* 사원번호를 입력받아 이릅에서 호급을 찾아 해당하는 수당을 출력 */
delimiter //
CREATE PROCEDURE ho_money(IN v_empno char(5), OUT v_money INT)
BEGIN
	select money into v_money
    from sal_ho
    where ho=substring(v_empno,2,1);
END
// delimiter ;

/* 사원번호를 입력받아 이릅에서 부서코드를 찾아 해당하는 부서 명을 출력 */
delimiter //
CREATE PROCEDURE dept_name( IN v_empno char(5), OUT v_name VARCHAR(10) )
BEGIN
	select name into v_name
    from dept
    where code=substring(v_empno,1,1);
END
// delimiter ;

/*====================================================*/
/* 프로시저 테스트 */
call grade_money('A522', @money); select @money;
call ho_money('A522', @money); select @money;
call overtime_money('A522',@money); select @money;
call dept_name('A522',@name); select @name;

select * from emp;

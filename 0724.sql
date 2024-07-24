select * from dept;

/* 기본적인 INSERT 구문
INSERT INTO 테이블 VALUE(컬럼값1, 컬럼값2, ...)
*/

INSERT INTO dept
VALUE(50,'Design','Busan');

/* dept(컬럼명)을 사용하는 이유는 어떤 데이터가 들어가는지 명시하기 위함
컬럼 순서는 실제 테이블 순서와 무관하지만, 컬럼값은 순서를 따라가야한다.*/
INSERT INTO dept(loc,deptno,dname)
ValUE('Taejeon',60,'Development');

/* 명시적 NuLL 값 */
INSERT INTO dept(deptno,dname,loc)
VALUE(70, NULL, 'Inchon');

/*암묵적 NULL 값: 컬럼과 값을 명시하지 않으면 자동으로 NULL*/
INSERT INTO dept(deptno, loc)
ValUE(80,'Seoul');

/*테이블에 컬럼이 PRIMARY KEY라면, NULL이 허용되지 않는다.
>> 반드시 포함해야하는 컬럼이 있을 수 있다. */
INSERT INTO dept(dname,loc)
VALUE('Account','Yongin');

INSERT INTO emp(empno, ename, hiredate, deptno)
VALUES(9999, 'jimin', CURDATE(), 10);

/* emp 테이블에서 부서번호가 10번인 사원의 번호, 이름, 급여, 입사일로 새로운 테이블 생성*/
create table emp_copy
as
select empno, ename, sal, hiredate
from emp
where deptno = 10;

/* 데이터가 하나도 없다면 스키마(컬럼 구조)만 복사한다. */
create table emp_copy1
as
select *
from emp
where 0=1;

INSERT INTO emp_copy1(empno,ename)
VALUE(1111,'한지민');


/*날짜를 스트링 타입으로 받았다면 str_to_date를 이용해 입력할 수 있다. */
INSERT INTO emp(empno, ename, hiredate, deptno)
VALUES (6666, '한라산', STR_TO_DATE('20080501', '%Y%m%d'), 30);

select *FROM emp where empno=6666;


/* 레코드를 수정하기 위한 UPDATE 문 */
update dept
set dname = 'FINANCE'
where deptno = 70;

/* 레코드의 여러 컬럼을 수정할때는 ,로 구분*/
update dept
set dname = 'HR', loc ='Busan'
WHERE deptno = 70;

select * from dept;
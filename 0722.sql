/*
	Author : 황신욱
    Date : 2024-07-22
    Objective : BASIC SELECT
    Evironment : Microsoft Windows 10, MySQL Workbench 8.0.38, MySQL 8.0.63
*/
SELECT CONCAT(ename, ' 의 봉급은 ' ,sal, '입니다.') AS "봉급" FROM emp;

/* MySQL은 From을 생락해도 SELECT이 동작한다.
From을 사용하게 되면 테이블에 포함된 레코드 수 만큼 Select를 반복한다.*/
SELECT  'aaa';

/*DISTINCT 비교 샘플 코드*/
SELECT job FROM emp;
SELECT DISTINCT job FROM emp;


/* Where 절 샘플코드, 윈도우는 대소문자를 가리지 않음.*/
select * from emp where ename=('SmITh');
/* date_format은 %Y 4자리 연도, %y 2자리 연도, %M 영문 월, %m 두자리 월.. 기타 등등*/
select date_format(hiredate,"%y년-%m월-%d일") from emp;

select * from emp WHERE sal>ifnull(comm,0);

/* 아래 조건은 동일한 동작 */
select ename,sal,hiredate FROM emp WHERE hiredate>='1987-01-01' ANd hiredate<='1987-12-31';
select ename,sal,hiredate FROM emp WHERE hiredate BETWEEN '1987-01-01' ANd '1987-12-31';
SELECT ename,sal,hiredate FROM emp WHERE hiredate LIKE "1987%";

select ename, job From emp where job='CLERK' OR job='MANAGER';
SELECT ename, job FROM emp WHERE job IN('CLERK','MANAGER');

SELECT deptno, ename * 12 + IFNULL(comm, 0) AS "Annual"
FROM emp 
WHERE deptno IN(20,30)
ORDER BY Annual DESC;

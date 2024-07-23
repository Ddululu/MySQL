/*1.emp table에서 이름의 첫 글자가 'K'보다 크고 'Y'보다 작은 사원의 정보를 사원번호, 이름, 업무
, 급여, 부서번호를 출력하고, 이름순으로 정렬하시오(단, SUBSTR()사용할 것)*/
select empno, ename, job, sal, deptno
from emp 
where substr(ename,1) BETWEEN 'K' AND 'Y'
order by ename;

/* 다중행 함수 : 그룹 단위로 입력받아 하나의 결과를 도출하는 함수들*/
/*2. 세일즈 직무를 가진 사람들의 평균 임금, 최대 임금, 최소 임금, 총 임금*/
SELECT AVG(sal), MAX(sal), MIN(sal), SUM(sal) FROM emp WHERE job LIKE 'SALES%';

/*3. Null을 포함한다 or 포함하지 않을 때의 결과
=> 그냥 AVG를 했을때는 NULL을 전체 셀 수에 포함하지 않음.*/
SELECT AVG(comm), AVG(ifnull(comm,0)), SUM(comm)/COUNT(*) FROM emp;

/*4. "부서 그룹 단위" 평균 임금, 최대 임금, 최소 임금, 총 임금*/
SELECT deptno, AVG(sal), MAX(sal), MIN(sal), SUM(sal) FROM emp GROUP BY deptno ORDER BY deptno;

/*5. "입사년도 별" 입사자 수*/
SELECT YEAR(hiredate), COUNT(*) AS "입사자 수" FROM emp GROUP BY Year(hiredate);

/*6. "부서 별, 직무 별" 부서번호, 업무, 인원수, 급여의 평균, 급여의 합 */
SELECT deptno, job, COUNT(*), AVG(sal), SUM(sal) 
FROM emp GROUP BY deptno, job 
ORDER BY deptno ASC, job DESC;

/*7. 부서 구성원이 4명 이상인 부서의 부서 번호, 구성원 수, 급여의 합 */
/*SELECT deptno, COUNT(*), SUM(sal) FROM emp WHERE COUNT(*) >= 4
GROUP BY deptno;
--> WHERE로는 GROUP BY를 제어할 수 없다.*/

/*SELECT은 WHERE로 제어 / GROUP은 HAVING으로 제어 */
SELECT deptno, COUNT(*), SUM(sal) FROM emp
GROUP BY deptno HAVING COUNT(*) >= 4;

/*8. 직무별로 급여 합계와 총계를 구하자*/
SELECT job, SUM(sal) FROM emp
GROUP BY job
WIth ROlLUP; /*WITH ROLLUP은 모든 요소를 더하라는 지시어. 자바에서는 잘 사용 X */



/* 조인(JOIN)은 두 개 이상의 테이블을 하나의 테이블로 결합하여 조회하는 것 */
/* 1. CROSS JOIN (카테시안 Product), 모든 경우의 수를 표현한다.
테이블1의 요소 * 테이블2의 요소 만큼의 테이블 크기를 갖는다. 
따라서 큰 의미가 없어 잘 사용 X, 아무 조건 없이 두개의 테이블을 가져온다면 기본적으로 CROSS JOiN */
SELECT empno, ename, dname FROM emp,dept;
SELECT empno, ename, dname FROM emp CROSS JOIN dept;

/* 2. INNER JOIN (= Equal Join, Simple Join, Natueral Join)
WHERE을 이용해 두 테이블의 공통 요소만 논리적으로 결합할 경우 INNER JOIN 
두 테이블이 같은 컬럼명을 공유한다면 테이블명.컬럼명으로 어떤 컬럼인지 명시해야 한다.*/
SELECT emp.deptno, dname, empno, ename FROM emp CROSS JOIN dept
WHERE emp.deptno = dept.deptno;

/* JOIN USING과 JOIN ON을 이용한 Inner JOIN도 가능하다.*/
/* 3. Join table USING (공통 컬럼)*/

SELECT empno, ename, dname FROM emp 
JOIN dept USING (deptno); 

/* 4. Join table ON (조건)*/
SELECT empno, ename, dname FROM emp 
JOIN dept ON (emp.deptno = dept.deptno); 

/* 일반적으로 Using은 공통 컬럼이 필수적이기 때문에, 사용처가 한정적이다.
대신 JOIN TABLE1 ON (조건 1) JOIN TABLE2 ON (조건 2)과 같이 
다른 테이블, 다른 조건을 적용해 값을 가져올 수 있기 때문에 많이 사용하는 방식*/

/* 5. world DB의 3개 테이블을 Join하는 구문*/
SELECT city.name, city.Population, country.name, country.IndepYear, countrylanguage.Language
FROM world.city AS city JOIN world.country AS country ON (city.Countrycode= country.code) JOIN world.countrylanguage as countrylanguage ON (country.code = Countrylanguage.Countrycode)
WHERE city.name = 'SEOUL';

/* 6. RIGHT OUTER JOIN
사원 테이블에는 사원이 있는 부서만 deptno를 갖는데, 부서 테이블에는 사원이 없는 deptno가 있다.
왼쪽 테이블과 오른쪽 테이블의 deptno가 공통인 요소로 조인하는데, 오른쪽 테이블을 모두 가져오기"*/
SELECT e.ename, e.deptno, d.dname
FROM emp e RIGHT OUTER JOIN dept d
ON e.deptno= d.deptno;

/* 7. SELF JOIN
같은 테이블 내에 찾고자 하는 정보가 있을 때 동일한 테이블을 다른 별칭으로 사용하여 두 개의 테이블처럼 호출
그 다음 필요한 정보를 찾아 JOIN 한다.*/
SELECT worker.ename, manager.ename
FROM emp worker, emp manager
WHERE worker.mgr = manager.empno;

/* emp table에서 self join하여 관리자를 출려하되, 아래의 형식에 맞게 출력하시오.
"BLAKE 의 관리자는 KING 이다." */
SElECT CONCAT(f.ename,'의 관리자는 ',b.ename,'이다.') 
FROM emp f, emp b
where f.mgr = b.empno;

/*사원테이블에서 그들의 관리자보다 먼저 입사한 사원에 대해 이름, 입사일, 관리자 이름, 관리자 입사일을 출력하시오.*/
SELECT e.ename, e.hiredate, mgr.ename as mgr_name, mgr.hiredate as mgr_hire
FROM emp e, emp mgr
where e.hiredate < mgr.hiredate;

/* 9. UNION과 UNION ALL 
2개의 쿼리를 위, 아래로 붙여 출력하는 쿼리
위, 아래로 잇기 때문에 컬럼의 갯수는 동일해야 함.
마찬가지로 컬럼이 동일한 속성을 가져야 함. 
UNION은 중복 제거, UNION ALL은 중복 허용*/
SELECT job, deptno
FROM emp
WHERE sal >= 3000

UNION ALL

SELECT job, deptno
FROM emp
WHERE deptno = 10;

/* 1.서브쿼리 */
SELECT ename
FROM emp
WHERE sal > (
			SELECT sal
			FROM emp
			WHERE empno = 7566 ); 

/* SUB Query와 SELF JOIN 비교
서브 쿼리가 탐색하는 플로우를 파악하기 쉽다.*/
SELECT b.ename, b.sal
FROM emp a, emp b
WHERE a.empno =7566 AND (a.sal <b.sal);


/*--부서 별 최소 급여를 받는 사원*/
SELECT ename, sal, deptno
FROM emp
WHERE sal IN (	SELECT MIN(sal) 
				FROM emp 
                GROUP BY deptno	);



/*--급여가 사무원보다 적으면서 직무가 사무원이 아닌 사원*/
select ename, deptno
FROM emp
WHERE sal< ANY (SELECT sal
				FROM emp
				WHERE job='CLERK');

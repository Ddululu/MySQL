/* 현재 사용자명, 로그인 IP 출력 'user'@'ip addr' */
select user(); 

/* 모든 사용자의 권한 및 정보 */
select * from mysql.user;

/* 패스워드 정책을 확인하고 바꾸는 명령어 */
show variables like 'validate%';
set global validate_password.policy = LOW; 
set global validate_password.length = 0;

/* 계정을 생성하는 명령어, 접근 위치를 %로 하면 어디서나 접근 가능. */
create USER 'jimin'@'%' identified by '1234';

/* 지민에게 mycompany 하위의 emp 테이블에 대해 SELECT 권한을 부여*/
GRANT SELECT on mycompany.emp to 'jimin'@'%';
FLUSH PRIVILEGES;

/* 지민에게 mycompany 하위의 sp_select_all_patient라는 Procedure를 실행할 수 있는 권한을 부여*/
GRANT SELECT ON mycompany.patient to 'jimin'@'%';
GRANT EXECUTE ON PROCEDURE mycompany.sp_select_all_patient to 'jimin'@'%';
FLUSH PRIVILEGES;

/* 지민에게 mycompany 하위의 모든 요소에 대해 모든 권한을 부여, Procedure와 Table 모두 포함*/
GRANT ALL privileges ON mycompany.* to 'jimin'@'%';
FLUSH PRIVILEGES;

/* 사용자에게 주어진 권한을 확인할 때 SHOW GRANTS FOR 명령어를 사용*/
SHOW GRANTS FOR 'jimin'@'%';

revoke ALL privileges on *.* FROM 'jimin'@'%';
FLUSH PRIVILEGES;
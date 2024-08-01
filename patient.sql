CREATE TABLE mycompany.patient(
	number 		TINYINT,
    code		CHAR(2) NOT NULL,
    days		SMALLINT NOT NULL,	
    age			TINYINT NOT NULL,
    dept		VARCHAR(20),
    operfee		INT,
    hospitalfee	INT,
    money 		INT,
    CONSTRAINT patient_number_pk PRIMARY KEY(number)
)DEFAULT CHARSET utf8;

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
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
CREATE TABLE patient(
	p_no TINYINT PRIMARY KEY,
    p_code	VARCHAR(10) NOT NULL,
    days	INT NOT NULL,	
    age		TINYINT NOT NULL,
    dept	VARCHAR(10),
    operfee	INT,
    hospitalfee	INT,
    money INT
)DEFAULT CHARSET utf8;
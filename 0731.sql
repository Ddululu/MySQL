DELIMITER //
CREATE PROCEDURE sp_test()
BEGIN
    SELECT NOW(), VERSION();
END
//
DELIMITER;

CALL sp_test();
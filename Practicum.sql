ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

--Enable Oracle to display results of Query and block execution in results plane

SET SERVEROUTPUT ON;

--Create a user called SchemaName to be assigned a schemma role

CREATE USER Practicum IDENTIFIED BY Password1;
GRANT ALL PRIVILEGES TO Practicum;
COMMIT;

--Question 1
CREATE TABLE Instructor (
  INS_ID CHAR(3) NOT NULL,
  INS_FNAME VARCHAR2(50) NOT NULL,
  INS_SNAME VARCHAR2(50) NOT NULL,
  INS_CONTACT VARCHAR(10) NOT NULL,
  INS_LEVEL INTEGER NOT NULL,
  CONSTRAINT PK_Instructor PRIMARY KEY(INS_ID)  
);

CREATE TABLE Customer (
  CUST_ID CHAR(4) NOT NULL,
  CUST_NAME VARCHAR2(50) NOT NULL,
  CUST_SNAME VARCHAR2(50) NOT NULL,
  CUST_ADDRESS VARCHAR2(100) NOT NULL,
  CUST_CONTACT VARCHAR(10) NOT NULL,
  CONSTRAINT PK_Customer PRIMARY KEY(CUST_ID)  
);


CREATE TABLE Dive (
  DIVE_ID CHAR(3) NOT NULL,
  DIVE_NAME VARCHAR2(50) NOT NULL,
  DIVE_DURATION INTERVAL DAY TO SECOND NOT NULL,
  DIVE_LOCATION VARCHAR2(100) NOT NULL,
  DIVE_EXP_LEVEL INTEGER,
  DIVE_COST INTEGER NOT NULL,
  CONSTRAINT PK_Dive PRIMARY KEY(DIVE_ID)  
);

CREATE TABLE DIVE_EVENT (
  DIVE_EVENT_ID CHAR(6) NOT NULL,
  DIVE_DATE DATE NOT NULL,
  DIVE_PARTICIPANTS INTEGER NOT NULL,
  INS_ID CHAR(3) NOT NULL,
  CUST_ID CHAR(4) NOT NULL,
  DIVE_ID CHAR(3) NOT NULL,
  CONSTRAINT PK_Dive_Event PRIMARY KEY(DIVE_EVENT_ID),
  CONSTRAINT FK_Instructor_Dive_Event FOREIGN KEY(INS_ID) REFERENCES INSTRUCTOR(INS_ID),
  CONSTRAINT FK_Customer_Dive_Event FOREIGN KEY(CUST_ID) REFERENCES CUSTOMER(CUST_ID),
  CONSTRAINT FK_Dive_Dive_Event FOREIGN KEY(DIVE_ID) REFERENCES DIVE(DIVE_ID)
);
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
INSERT ALL
INTO instructor VALUES('101', 'James', 'Willis', '0843569851' , '7')
INTO instructor VALUES('102', 'Sam', 'Wait', '0763698521' , '2')
INTO instructor VALUES('103', 'Sally', 'Gumede', '0786598521' , '8')
INTO instructor VALUES('104', 'Bob', 'Du Preez', '0796369857' , '3')
INTO instructor VALUES('105', 'Simon', 'Jones', '0826598741' , '9')
SELECT * FROM DUAL;
SELECT * FROM instructor;
-------------------------------------------------------------------------------------------
INSERT ALL
INTO customer VALUES('C115', 'Heinrich', 'Willis', '3 Main Road', '0821253659')
INTO customer VALUES('C116', 'David', 'Watson', '13 Cape Road ', '0769658547')
INTO customer VALUES('C117', 'Waldo', 'Smith', '3 Mountain Road', '0863256574')
INTO customer VALUES('C118', 'Alex', 'Hanson', '8 Circle Road', '0762356587')
INTO customer VALUES('C119', 'Kuhle', 'Bitterhout', '15 Main Road ', '0821235258')
INTO customer VALUES('C120', 'Thando', 'Zolani', '88 Summer Road ', '0847541254')
INTO customer VALUES('C121', 'Philip', 'Jackson', '3 Long Road', '0745556658')
INTO customer VALUES('C122', 'Sarah', 'Jones', '7 Sea Road', '0814745745')
INTO customer VALUES('C123', 'Catherine', 'Howard', '31 Lake Side Road ', '0822232521')
SELECT * FROM DUAL;
SELECT * FROM customer;
----------------------------------------------------------------------------------------------------------------
INSERT ALL
INTO dive VALUES('550', 'Shark Dive', INTERVAL '0 03:00:00' DAY TO SECOND, 'Shark Point', '8', '500')
INTO dive VALUES('551', 'Coral Dive', INTERVAL '0 01:00:00' DAY TO SECOND, 'Break Point', '7', '300')
INTO dive VALUES('552', 'Wave Crescent', INTERVAL '0 02:00:00' DAY TO SECOND, 'Ship wreck ally', '3', '800')
INTO dive VALUES('553', 'Underwater Exploration', INTERVAL '0 01:00:00' DAY TO SECOND, 'Coral ally', '2', '250')
INTO dive VALUES('554', 'Underwater Adventure', INTERVAL '0 03:00:00' DAY TO SECOND, 'Sandy Beach', '3', '750')
INTO dive VALUES('555', 'Deep Blue Ocean', INTERVAL '0 00:30:00' DAY TO SECOND, 'Lazy Waves', '2', '120')
INTO dive VALUES('556', 'Rough Seas', INTERVAL '0 01:00:00' DAY TO SECOND, 'Pipe', '9', '700')
INTO dive VALUES('557', 'White water', INTERVAL '0 02:00:00' DAY TO SECOND, 'Drifts', '5', '200')
INTO dive VALUES('558', 'Current Adventure', INTERVAL '0 02:00:00' DAY TO SECOND, 'Rock Lands', '3', '150')
SELECT * FROM DUAL;
------------------
SELECT dive_id, dive_name, 
CASE 
    WHEN EXTRACT(HOUR FROM dive_duration) = 0 THEN 
         EXTRACT(MINUTE FROM dive_duration) || ' minute' || CASE WHEN EXTRACT(MINUTE FROM dive_duration) = 1 THEN '' ELSE 's' END
    WHEN EXTRACT(MINUTE FROM dive_duration) = 0 THEN 
         EXTRACT(HOUR FROM dive_duration) || ' hour' || CASE WHEN EXTRACT(HOUR FROM dive_duration) = 1 THEN '' ELSE 's' END
    ELSE TO_CHAR(EXTRACT(HOUR FROM dive_duration)) || ' hour'|| CASE WHEN EXTRACT(HOUR FROM dive_duration) = 1 THEN '' ELSE 's' END || '' ||
    TO_CHAR(EXTRACT(MINUTE FROM dive_duration)) || ' minute' || CASE WHEN EXTRACT(MINUTE FROM dive_duration) = 1 THEN '' ELSE 's' END
END AS dive_duration, dive_location, dive_exp_level, dive_cost
FROM dive;
-----------------------------------------------
INSERT ALL
INTO dive_event VALUES('de_101', '15 July 2017', '5', '103', 'C115', '558')
INTO dive_event VALUES('de_102', '16 July 2017', '7', '102', 'C117', '555')
INTO dive_event VALUES('de_103', '18 July 2017', '8', '104', 'C118', '552')
INTO dive_event VALUES('de_104', '19 July 2017', '3', '101', 'C119', '551')
INTO dive_event VALUES('de_105', '21 July 2017', '5', '104', 'C121', '558')
INTO dive_event VALUES('de_106', '22 July 2017', '8', '105', 'C120', '556')
INTO dive_event VALUES('de_107', '25 July 2017', '10', '105', 'C115', '554')
INTO dive_event VALUES('de_108', '27 July 2017', '5', '101', 'C122', '552')
INTO dive_event VALUES('de_109', '28 July 2017', '3', '102', 'C123', '553')
SELECT * FROM DUAL;
SELECT dive_event_id, TO_CHAR(dive_date,'DD/MON/YY'), dive_participants, ins_id, cust_id, dive_id  FROM dive_event;

--Question 2

-- Step 1: Create the roles
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE ROLE administrator;
-- Granting privileges to the administrator role
GRANT ALL PRIVILEGES TO administrator;
-- Creating an administrator user
CREATE USER admin1 IDENTIFIED BY Password1;
GRANT administrator TO admin1;
COMMIT;

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE ROLE general_user;
-- Granting specific privileges to the general user role
GRANT SELECT, INSERT, UPDATE, DELETE ON instructor TO general_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON customer TO general_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON dive TO general_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON dive_event TO general_user;
-- Creating a general user
CREATE USER user1 IDENTIFIED BY Password2;
GRANT general_user TO user1;
COMMIT;

--Question 3

SELECT 
    i.ins_fname || ', ' || i.ins_sname AS INSTRUCTOR,
    c.cust_fname || ', ' || c.cust_sname AS CUSTOMER,
    d.dive_location,
    de.dive_participants
FROM 
  dive_event de
JOIN 
    instructor i ON de.INS_ID = i.INS_ID
JOIN 
    customer c ON de.CUST_ID = c.CUST_ID
JOIN 
    dive d ON de.DIVE_ID = d.DIVE_ID
WHERE 
    de.dive_participants BETWEEN 8 AND 10;
--
--Question 4
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c1 IS
        SELECT 
            d.DIVE_NAME,
            TO_CHAR(e.DIVE_DATE, 'DD/MON/YY') AS DIVE_DATE,
            e.DIVE_PARTICIPANTS
        FROM 
            DIVE_EVENT e
        JOIN 
            DIVE d ON e.DIVE_ID = d.DIVE_ID
        WHERE 
            e.DIVE_PARTICIPANTS >= 10;

    v_dive_name       DIVE.DIVE_NAME%TYPE;
    v_dive_date       VARCHAR2(11);
    v_participants    DIVE_EVENT.DIVE_PARTICIPANTS%TYPE;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_dive_name, v_dive_date, v_participants;
        EXIT WHEN c1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('DIVE NAME:      ' || v_dive_name);
        DBMS_OUTPUT.PUT_LINE('DIVE DATE:      ' || v_dive_date);
        DBMS_OUTPUT.PUT_LINE('PARTICIPANTS:   ' || v_participants);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------');
    END LOOP;
    CLOSE c1;
END;
/

--Question 5
DECLARE
    -- Cursor declaration
    CURSOR c1 IS
        SELECT 
            c.CUST_FNAME || ', ' || c.CUST_SNAME AS CUSTOMER,
            d.DIVE_NAME,
            e.DIVE_PARTICIPANTS,
            d.DIVE_COST
        FROM 
            DIVE_EVENT e
        JOIN 
            CUSTOMER c ON e.CUST_ID = c.CUST_ID
        JOIN 
            DIVE d ON e.DIVE_ID = d.DIVE_ID
        WHERE 
            d.DIVE_COST > 500;

    -- Variables for hold cursor output
    v_customer       VARCHAR2(100);
    v_dive_name      VARCHAR2(50);
    v_participants   INTEGER;
    v_dive_cost      INTEGER;
    v_instructors    INTEGER;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO v_customer, v_dive_name, v_participants, v_dive_cost;
        EXIT WHEN c1%NOTFOUND;
        
        -- 
        IF v_participants <= 4 THEN
            v_instructors := 1;
        ELSIF v_participants BETWEEN 5 AND 7 THEN
            v_instructors := 2;
        ELSE
            v_instructors := 3;
        END IF;
        
        -- Display the results
        DBMS_OUTPUT.PUT_LINE('CUSTOMER: ' || v_customer);
        DBMS_OUTPUT.PUT_LINE('DIVE NAME: ' || v_dive_name);
        DBMS_OUTPUT.PUT_LINE('PARTICIPANTS: ' || v_participants);
        DBMS_OUTPUT.PUT_LINE('STATUS: ' || v_instructors || ' instructor' || CASE WHEN v_instructors > 1 THEN 's' ELSE '' END || ' required.');
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
    CLOSE c1;
END;
/
--Question 6

CREATE OR REPLACE VIEW Vw_Dive_Event AS
SELECT 
    e.INS_ID,
    e.CUST_ID,
    c.CUST_ADDRESS,
    CASE 
        WHEN EXTRACT(HOUR FROM d.DIVE_DURATION) = 0 THEN 
             EXTRACT(MINUTE FROM d.DIVE_DURATION) || ' minute' || CASE WHEN EXTRACT(MINUTE FROM d.DIVE_DURATION) = 1 THEN '' ELSE 's' END
        WHEN EXTRACT(MINUTE FROM d.DIVE_DURATION) = 0 THEN 
             EXTRACT(HOUR FROM d.DIVE_DURATION) || ' hour' || CASE WHEN EXTRACT(HOUR FROM d.DIVE_DURATION) = 1 THEN '' ELSE 's' END
        ELSE TO_CHAR(EXTRACT(HOUR FROM d.DIVE_DURATION)) || ' hour'|| CASE WHEN EXTRACT(HOUR FROM d.DIVE_DURATION) = 1 THEN '' ELSE 's' END || '' ||
        TO_CHAR(EXTRACT(MINUTE FROM d.DIVE_DURATION)) || ' minute' || CASE WHEN EXTRACT(MINUTE FROM d.DIVE_DURATION) = 1 THEN '' ELSE 's' END
    END AS DIVE_DURATION,
    TO_CHAR(e.DIVE_DATE, 'DD/MON/YY') AS DIVE_DATE
FROM 
    DIVE_EVENT e
JOIN 
    CUSTOMER c ON e.CUST_ID = c.CUST_ID
JOIN 
    DIVE d ON e.DIVE_ID = d.DIVE_ID
WHERE 
    e.DIVE_DATE < TO_DATE('19-JUL-2017', 'DD-MON-YYYY');
 SELECT*FROM vw_dive_event;
 
 --Question 7
-- Create the trigger
CREATE OR REPLACE TRIGGER New_Dive_Event
BEFORE INSERT OR UPDATE ON DIVE_EVENT
FOR EACH ROW
DECLARE
    Participants_Error EXCEPTION;
BEGIN
    IF :NEW.DIVE_PARTICIPANTS <= 0 OR :NEW.DIVE_PARTICIPANTS > 20 THEN
        RAISE Participants_Error;
    END IF;
EXCEPTION
    WHEN Participants_Error THEN
        RAISE_APPLICATION_ERROR(-20001, 'Participants must be between 1 and 20.');
END;
/
--Test triggers
--Successful
INSERT INTO DIVE_EVENT (DIVE_EVENT_ID, DIVE_DATE, DIVE_PARTICIPANTS, INS_ID, CUST_ID, DIVE_ID)
VALUES ('DE_110', '29 July 2017', 10, '103', 'C115', '558');
--Less than or equal to 0
INSERT INTO DIVE_EVENT (DIVE_EVENT_ID, DIVE_DATE, DIVE_PARTICIPANTS, INS_ID, CUST_ID, DIVE_ID)
VALUES ('DE_110', '29 July 2017', 0, '103', 'C115', '558');

-- More than 20
INSERT INTO DIVE_EVENT (DIVE_EVENT_ID, DIVE_DATE, DIVE_PARTICIPANTS, INS_ID, CUST_ID, DIVE_ID)
VALUES ('DE111', '30 July 2017', 25, '104', 'C118', '552');










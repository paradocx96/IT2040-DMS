--DATABASE Programming--

--VIEW--
--Ex1--
CREATE VIEW dept_info(DepName,Budget,Manager)
AS
SELECT d.did, d.budget, e.eid
FROM Dept d, Emp e
WHERE e.eid = d.managerid

SELECT * from dept_info
SELECT DepName, Budget from dept_info WHERE Manager = 1000

UPDATE dept_info SET Budget = 25000 WHERE DepName = 'SESD' 

--we cannot update aggregate functions--

--or--

CREATE VIEW dept_info
AS
SELECT d.did, d.budget, e.eid
FROM Dept d, Emp e
WHERE e.eid = d.managerid

DROP VIEW dept_info

--Ex2--
CREATE VIEW emp_info(ID,NAME,SALARY,Percentage)
AS
SELECT e.eid, e.ename, e.salary, SUM(w.pct_time)
FROM Emp e, Works w
WHERE e.eid = w.eid
GROUP BY e.eid, e.ename, e.salary

SELECT * FROM emp_info

--or--

CREATE VIEW emp_info
AS
SELECT e.eid, e.ename, e.salary, SUM(w.pct_time) as 'Percentage'
FROM Emp e, Works w
WHERE e.eid = w.eid
GROUP BY e.eid, e.ename, e.salary

SELECT * FROM emp_info
SELECT eid, ename FROM emp_info WHERE salary > 100000


--T SQL--

--Declare variable--
DECLARE @ID INT
DECLARE @Sal INT

--Assign value to variable--
SET @ID = 1000
PRINT CONCAT('ID : ', @ID)


SELECT @Sal = salary FROM Emp WHERE eid = @ID

IF @Sal > 100000
    PRINT 'Salary is > 100000'
ELSE
BEGIN
    PRINT 'inside the else clause'
    PRINT 'Salary is < 100000'
END

--While--
SELECT * FROM Emp

DECLARE @EID INT
DECLARE @AGE INT
DECLARE @SALA INT

SET @EID = 1010
SET @AGE = 18
SET @SALA = 15000

WHILE @EID <= 1015
BEGIN
    INSERT INTO Emp VALUES (@EID,'Employee',@AGE,@SALA)
    SET @EID = @EID + 1
    SET @AGE = @AGE + 2
    SET @SALA = @SALA + 5000
END


-- Functions -- 

CREATE FUNCTION fn_getEmpCount(@did varchar(20))
RETURNS INT
AS
BEGIN
DECLARE @count INT
SELECT @count = COUNT(*)
FROM Works
WHERE did = @did
RETURN @count
END

DECLARE @result int
EXEC @result = fn_getEmpCount 'Admin'
print @result


-- Procedure -- 

CREATE PROCEDURE increseSalary(@pct float)
AS
BEGIN
UPDATE Emp
SET salary = salary + salary * (@pct / 100)
END

EXEC increseSalary 10

Select * from Emp


--Ex2--
CREATE PROCEDURE get_stats(@did varchar(20), @maxm int output, @minm int output)
AS
BEGIN
SELECT @minm = MIN(e.salary), @maxm = MAX(e.salary)
FROM Emp e, Works w
WHERE e.eid = w.eid AND w.did = @did
END


DECLARE @max INT, @min INT
EXEC get_stats 'ITSD', @max output, @min output
PRINT CONCAT('Max : ', @max)
PRINT CONCAT('Min : ', @min)

--Ex3--
CREATE PROCEDURE get_managerInfo(@did varchar(20),@name varchar(20) output, @sall int output)
AS
BEGIN
SELECT @name = e.ename, @sall =  e.salary
FROM Emp e, Dept d
WHERE d.did = @did AND d.managerid = e.eid
END

DECLARE @MngName VARCHAR(20)
DECLARE @Salary INT
EXEC get_managerInfo 'Academic',@MngName output,@Salary output
PRINT CONCAT('Name : ', @MngName)
PRINT CONCAT('Salary : ', @Salary)
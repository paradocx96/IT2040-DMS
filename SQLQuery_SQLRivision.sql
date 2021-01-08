create table Emp(
eid integer,
ename varchar(50) NOT NULL,
age integer,
salary float,
constraint Emp_pk primary key(eid),
constraint salary_ck CHECK (salary > 0));


create table Dept(
did char(12),
budget float,
managerid int,
constraint Dept_pk primary key(did),
constraint Dept_fk foreign key(managerid) references Emp);


create table Works(
eid int, 
did char(12), 
pct_time integer,
constraint Works_pk primary key(eid,did),
constraint Works1_fk foreign key(eid) references Emp,
constraint Works2_fk foreign key(did) references Dept);


insert into Emp values(1000,'Lakmal',33,90000);
insert into Emp values(1001,'Nadeeka',24,28000);
insert into Emp values(1002,'Amila',26,35000);
insert into Emp values(1003,'Nishani',28,60000);
insert into Emp values(1004,'Krishan',36,95000);
insert into Emp values(1005,'Surangi',37,22000);
insert into Emp values(1006,'Shanika',24,18000);
insert into Emp values(1007,'Amali',21,20000);
insert into Emp values(1008,'Charith',28,35000);
insert into Emp values(1009,'Prasad',40,95000);


insert into Dept values('Academic',900000,1002);
insert into Dept values('Admin',120000,1000);
insert into Dept values('Finance',3000000,1008);
insert into Dept values('ITSD',4500000,1000);
insert into Dept values('Maintenance',40000,1004);
insert into Dept values('SESD',20000,1004);
insert into Dept values('Marketing',90000,1008);


insert into Works values(1000,'Admin',40);
insert into Works values(1000,'ITSD',50);
insert into Works values(1001,'Admin',100);
insert into Works values(1002,'Academic',100);
insert into Works values(1003,'Academic',20);
insert into Works values(1003,'Admin',20);
insert into Works values(1003,'ITSD',45);
insert into Works values(1004,'Academic',60);
insert into Works values(1004,'Finance',30);
insert into Works values(1006,'Finance',30);
insert into Works values(1006,'Maintenance',52);
insert into Works values(1008,'Finance',35);
insert into Works values(1008,'ITSD',30);
insert into Works values(1008,'Maintenance',30);
insert into Works values(1009,'Admin',100);


select * from Emp

select * from Dept

select * from Works


--4--
insert into Emp values(1000,'Ruwan',33,40000);

--5--
ALTER TABLE Emp add hireDate datetime default getdate();
UPDATE Emp SET hireDate = getdate() WHERE hireDate IS NULL;

--6--
UPDATE Emp 
SET hireDate = '01/01/2010'
WHERE eid = 1000;

--7--
delete Emp
where eid = 1000

--8--
alter table Emp drop column hireDate 

--9--
DROP TABLE Emp 

--10--
select ename,salary
from Emp

--11--
select ename,salary
from Emp
order by salary DESC

--12--
select ename,salary
from Emp
where salary > 50000

--13--
select ename
from Emp
where ename LIKE 'S%'

--14--
select d.did, e.ename
from Emp e, Dept d
where d.managerid = e.eid

--OR--
select d.did, e.ename
from Emp e INNER JOIN Dept d on d.managerid = e.eid

--15--
select e.ename, d.managerid
from Emp e, Dept d, Works w
where e.salary > 75000 and e.eid = w.eid and d.did = w.did

--16--
select ename
from Emp
where eid NOT IN (select eid
					from Works)

--17--
select e.ename, e.age
from Emp e, Works w
where e.eid = w.eid and w.did = 'Academic' OR w.did = 'ITSD'

--18--
select e.ename, e.age
from Emp e, Works w
where e.eid = w.eid and w.did = 'Academic' and e.eid IN (select eid
															from Works
															where did = 'ITSD')

--19--
select e.ename, w.did
from Emp e, Works w
where e.eid = w.eid

--20--
select MIN(salary) AS 'MinSal', MAX(salary) AS 'MaxSal'
from Emp

--21--
select e.ename, SUM(w.pct_time) as 'Percentage'
from Emp e, Works w
where e.eid = w.eid
group by e.ename

--22--
select did, COUNT(eid) AS 'Count'
from Works
group by did

--23--
select e.ename, SUM(w.pct_time) as 'Percentage'
from Emp e, Works w
where e.eid = w.eid
group by e.ename
having SUM(w.pct_time) > 90

--24--
select w.did, SUM(e.salary)
from Emp e, Works w
where e.eid = w.eid
GROUP BY w.did
having SUM(e.salary) > 100000

--25--
select e.ename
from Emp e
where e.salary > ALL (select budget
                        from Dept d, Works w
                        where e.eid = w.eid and w.did = d.did)
AND e.eid IN (select eid
                from Works)

--26--
select d.managerid
from Dept d
GROUP BY d.managerid
having MIN(budget) > 100000

--27--
select e.ename
from Dept d, Emp e
WHERE d.managerid = e.eid and d.budget IN (select MAX(budget)
                                            from Dept)

--28--
select managerid, SUM(budget)
from Dept
GROUP BY managerid
HAVING SUM(budget) > 500000

--29--
select managerid
from Dept
GROUP BY managerid
HAVING SUM(budget) >= ALL(select SUM(budget)
                            from Dept
                            group by managerid)

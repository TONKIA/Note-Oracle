--事务
--ACID 
--Atomicity:要么都做，要么都不做
--Consistency
--Isolation
--Durability

COMMIT 

ROLLBACK

SAVEPOINT savepoint01;

ROLLBACK TO savepoint01;


--并发事务（多个用户同时和数据库交互）

--幻读：两次select 其过程中有人insert
--不可重复读：两次select 其过程中有人update
--脏读：读到rollback的数据

--SQL标准中定义的事务隔离级别
--Read Uncommitted ：幻读、不可重复读、脏读都会出现 所以 oracle mysql 都不支持
--Read Committed(Oracle默认 MySQL)：避免了脏读 只能读别人commit过的数据
--Read Repeatable(MySQL)：避免了脏读和不可重复读,读取的数据是一致的
--Serializable(Oracle MySQL)：避免了所有问题，相当于串行

ALTER SESSION SET Isolation_Level=SERIALIZABLE





--      **设计范式**

--1NF    最低要求  字段不可再分
--2NF    消除部分依赖   非关键字段必须完全依赖于主键
--                        |-减少冗余
--                        |-消除插入、删除和修改异常
--3NF    消除传递依赖   非关键字段必须直接依赖于主键
--BCNF
--4NF
--5NF











--权限
--权限分为两类：系统特权 和 对象特权
--系统特权：执行 DDL 存储过程 对对象的DML操作
--对象特权：特定用户模式下对具体对象执行 增删查改 操作

--系统特权：
-- CREATE SESSION
-- CREATE USER
-- CREATE VIEW

-- 在任意的用户模式下：
-- CREATE ANY TABLE
-- ALTER ANY TABLE
-- DROP ANY TABLE
-- SELETE ANY TABLE
-- UPDATE ANY TABLE
-- EXECUTE ANY PROCEDURE
-- ...

-- SYSDBA

--授予系统特权
-- GRANT sysprivilegeList TO userNameList [WITH ADMIN OPTION]
-- [WITH ADMIN OPTION]:是否可以继续授予第三方

--撤销特权 ****系统特权不能连锁撤销****
--REVOKE sysprivilegeList FROM userNameList

--对象特权： 5个
--SELECT INSERT UPDATE DELETE EXECUTE
--对象的拥有者自动具有全部对象特权

-- GRANT objPrivilegeList ON objName TO userNameList [WITH GRANT OPTION]
-- 对象特权是连锁撤销
-- REVOKE objPrivilegeList ON objName FROM userNameList

--角色 role
--角色是具有名称的一组特权，角色中可以包含系统特权也可以包含对象特权
--dba_roles预定义的角色

SELECT * FROM dba_roles

SELECT * FROM Role_Sys_Privs WHERE LOWER(ROLE)='connect'
SELECT * FROM Role_tab_Privs WHERE LOWER(ROLE)='connect'

SELECT * FROM Role_Sys_Privs WHERE LOWER(ROLE)='resource'
SELECT * FROM Role_tab_Privs WHERE LOWER(ROLE)='resource'

--查询当前用户具有的角色
SELECT * FROM User_Role_Privs
--查询当前用户系统特权
SELECT * FROM User_Sys_Privs
SELECT * FROM User_Tab_Privs

SELECT * FROM user_tables

--GRANT role TO user
--REVOKE role FROM user

CREATE ROLE tonkiaRole;
GRANT CONNECT,RESOURCE TO tonkiaRole WITH ADMIN OPTION;

CREATE USER user1 IDENTIFIED BY user1
CREATE USER user2 IDENTIFIED BY user2

GRANT tonkiaRole TO user1 WITH ADMIN OPTION;

--角色和系统特权操作基本相等 
--撤销角色 ****角色特权不是连锁撤销****
REVOKE tonkiaRole FROM user1
DROP ROLE tonkiaRole

DROP USER user1;
DROP USER user2;
























--Ȩ��
--Ȩ�޷�Ϊ���ࣺϵͳ��Ȩ �� ������Ȩ
--ϵͳ��Ȩ��ִ�� DDL �洢���� �Զ����DML����
--������Ȩ���ض��û�ģʽ�¶Ծ������ִ�� ��ɾ��� ����

--ϵͳ��Ȩ��
-- CREATE SESSION
-- CREATE USER
-- CREATE VIEW

-- ��������û�ģʽ�£�
-- CREATE ANY TABLE
-- ALTER ANY TABLE
-- DROP ANY TABLE
-- SELETE ANY TABLE
-- UPDATE ANY TABLE
-- EXECUTE ANY PROCEDURE
-- ...

-- SYSDBA

--����ϵͳ��Ȩ
-- GRANT sysprivilegeList TO userNameList [WITH ADMIN OPTION]
-- [WITH ADMIN OPTION]:�Ƿ���Լ������������

--������Ȩ ****ϵͳ��Ȩ������������****
--REVOKE sysprivilegeList FROM userNameList

--������Ȩ�� 5��
--SELECT INSERT UPDATE DELETE EXECUTE
--�����ӵ�����Զ�����ȫ��������Ȩ

-- GRANT objPrivilegeList ON objName TO userNameList [WITH GRANT OPTION]
-- ������Ȩ����������
-- REVOKE objPrivilegeList ON objName FROM userNameList

--��ɫ role
--��ɫ�Ǿ������Ƶ�һ����Ȩ����ɫ�п��԰���ϵͳ��ȨҲ���԰���������Ȩ
--dba_rolesԤ����Ľ�ɫ

SELECT * FROM dba_roles

SELECT * FROM Role_Sys_Privs WHERE LOWER(ROLE)='connect'
SELECT * FROM Role_tab_Privs WHERE LOWER(ROLE)='connect'

SELECT * FROM Role_Sys_Privs WHERE LOWER(ROLE)='resource'
SELECT * FROM Role_tab_Privs WHERE LOWER(ROLE)='resource'

--��ѯ��ǰ�û����еĽ�ɫ
SELECT * FROM User_Role_Privs
--��ѯ��ǰ�û�ϵͳ��Ȩ
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

--��ɫ��ϵͳ��Ȩ����������� 
--������ɫ ****��ɫ��Ȩ������������****
REVOKE tonkiaRole FROM user1
DROP ROLE tonkiaRole

DROP USER user1;
DROP USER user2;
























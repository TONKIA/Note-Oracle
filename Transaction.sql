--����
--ACID 
--Atomicity:Ҫô������Ҫô������
--Consistency
--Isolation
--Durability

COMMIT 

ROLLBACK

SAVEPOINT savepoint01;

ROLLBACK TO savepoint01;


--�������񣨶���û�ͬʱ�����ݿ⽻����

--�ö�������select �����������insert
--�����ظ���������select �����������update
--���������rollback������

--SQL��׼�ж����������뼶��
--Read Uncommitted ���ö��������ظ��������������� ���� oracle mysql ����֧��
--Read Committed(OracleĬ�� MySQL)����������� ֻ�ܶ�����commit��������
--Read Repeatable(MySQL)������������Ͳ����ظ���,��ȡ��������һ�µ�
--Serializable(Oracle MySQL)���������������⣬�൱�ڴ���

ALTER SESSION SET Isolation_Level=SERIALIZABLE





--      **��Ʒ�ʽ**

--1NF    ���Ҫ��  �ֶβ����ٷ�
--2NF    ������������   �ǹؼ��ֶα�����ȫ����������
--                        |-��������
--                        |-�������롢ɾ�����޸��쳣
--3NF    ������������   �ǹؼ��ֶα���ֱ������������
--BCNF
--4NF
--5NF











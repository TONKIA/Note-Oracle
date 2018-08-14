
--DML��Data Manipulation Language�����ݲ�������
--DDL��Data Definition Language�����ݿⶨ������
--DCL��Data Control Language�����ݿ��������

--С�ܽ�
--���ֿͻ��������sql plus / plsql developer
--�����������ͣ�char(n),varchar2(max),number(p,s),clob,blob,date,timestamp
--�û�����
--CREATE USER xxx INDENTIFIED BY pwd
--ALTER USER xxx INDENTIFIED BY pwd
--ALTER USER xxx ACCOUNT LOCK/UNLOCK
--DROP USER xxx CASCADE
--GRANT CONNECT,RESOURCE TO xxx

--DML
--���к���
--����;ۺϺ���





--��ѯ��ǰ�û���
SELECT table_name FROM user_tables
--��ѯ��ǰ�Ự��nls����
SELECT * FROM v$nls_parameters

SELECT to_char(TIMESTAMP'1996-10-3 5:6:7.123456')
FROM dual

SELECT SYSDATE FROM dual
SELECT SYSTIMESTAMP FROM dual

SELECT * FROM dual

--SQL��仮��Ϊ5����
--01.��ѯ��� select
--02.���ݲ������ insert update delete������ͨ��������ƣ�
--03.���ݶ������ create alter drop rename truncate���ضϣ����ݶ�������ǲ���������Ƶģ�
--04.���������� commit rollback savepoint
--05.Ȩ�޿������ grant revoke


--�û��������SQL
--01.�����û�
CREATE USER checkout IDENTIFIED BY checkout_pwd
--����/�����û�
ALTER USER checkout ACCOUNT LOCK
ALTER USER checkout ACCOUNT UNLOCK
--02.��Ȩ�û�
GRANT CONNECT,RESOURCE TO checkout
--03.�޸��û�����
ALTER USER checkout IDENTIFIED BY Txk19961003
--04.ɾ���û�
DROP USER checkout CASCADE

--�޸�nls
SELECT * FROM USERS
ALTER SESSION SET nls_date_format='YYYY-MM-DD'

--��������
--char(length)length�ֽ� �����ַ��� length 1-2000������length��ѧ�ţ��ֻ��ţ�ʡ��֤�ţ�
--char(length char) ����λָ��length���ַ� �Զ����ݱ�������ֽ�
--varchar2(length) �䳤�ַ�����length 1-4000
--nchar(length)����unicode�ַ��� length��ʾ�ַ��� length 1-1000
--nvarchar2(length) �䳤unicode�ַ��� length 1-2000
--blob Binary Large Object�����ƴ����� ���4G
--clob Charater Large Object�ַ������� ���4G
--nclob Unicode�ַ����� ���4G
--date ʱ�����ͣ������ں�ʱ��
--number(precision,scale) �����������22�ֽڣ�precision������Чλ������38 scaleС�����λ��
--timestamp(n)

CREATE TABLE TEST(
       ID INT PRIMARY KEY,
       NAME VARCHAR2(10 CHAR),
       phone CHAR(11),
       score NUMBER(4,2)
)

INSERT INTO TEST VALUES(1,'����','18399999999',1234.5)
--123.50(����Ϊ5)
INSERT INTO TEST VALUES(1,'����','18399999999',123.5)
INSERT INTO TEST VALUES(1,'����','18399999999',12.5)

SELECT * FROM TEST
--����������
--binary_float 32λ������ 5�ֽ�
--binary_double 64λ������ 9�ֽ� 
--�ŵ㣺�洢�ռ�С�������ٶȿ죬��ֵ��Χ��  ȱ�㣺����С

--����ôʹ�õ�����
--raw(n) �䳤���������� n 1-2000
--long �䳤�ַ��� ���2G�ֽ� clob���
--long raw �䳤���������� ���2Gֱ�� blob���

--Oracleͬ��֧�����ͣ����ͱ�����
--dec(p,s) numberic(p,s) = number(p,s)
--smallint int integer = number(38)
--float real doule precision = number��������

--����where����
--���� ͶӰ

SELECT * FROM product

SELECT product_id,product_name
FROM product

SELECT * 
FROM product
WHERE product_price>50

SELECT product.*,product_price*0.8 discount
FROM product

--�����������as ���������������as
SELECT 10*5-6 AS "final res"
FROM dual

--�������������ʡ��as
SELECT 10*5-6 "final res"
FROM dual

--���ġ�xxx��
SELECT 10*5-6 "������"
FROM dual

--������أ�dualֻ��һ��
SELECT 10*5 res
FROM product

--α�� rowid rownum
--rowid ����洢λ�� base64 (A-Z a-z 0-9 + /) (ÿ6λ��һ�����ű�ʾ 2^6=64 26+26+10+2=64)
--rownum �ڽ�����е��кţ���ҳ��ѯ��

SELECT 10*5 res,ROWID,ROWNUM
FROM product

SELECT USERS.*,ROWID,ROWNUM 
FROM USERS

--��ҳ��ѯ,��Ч
SELECT product.*,ROWNUM
FROM product
WHERE ROWNUM>2 AND ROWNUM<=5
--********��ҳ��ѯ,����ʹ���Ӳ�ѯ********
SELECT * 
FROM (SELECT t.*,ROWID ri,ROWNUM rn FROM product t)
WHERE rn>2 AND rn<=5

INSERT INTO product VALUES(seq_product_id.nextval,1,150,'�ٷֱ�100%')

--�ַ�����xxx��||��xxx��
--�ַ������ӷ� ||
SELECT product_type_id,product_name||product_price
FROM product

--is null/is not null
SELECT *
FROM product
WHERE product_price=NULL

--ֻҪʹ��=null ���һ��Ϊfalse
SELECT *
FROM product
WHERE product_price IS NULL

SELECT *
FROM product
WHERE product_price IS NOT NULL

--distinct �����ظ���
SELECT DISTINCT product_type_id
FROM product

SELECT DISTINCT product_type_id,product_price
FROM product

--�Ƚϲ�����
-- = , <> , != , ^= , < , > , <= , >= , any , some , all
-- any���some
-- any������ȷ

SELECT *
FROM product
WHERE product_id=ANY(41,31,35)

SELECT *
FROM product
WHERE product_id>ALL(1,34,29)

--like�ַ���ģʽƥ�������
--����ͨ���
--'_':�������ⵥ���ַ�
--'%':�������ⳤ���ַ�

SELECT *
FROM product
WHERE product_name LIKE '%��%'

--ת���

SELECT *
FROM product
WHERE product_name LIKE '%\%%' ESCAPE '\'

--����null like �� not like ��Ϊfalse

--in �൱�� =any
--in �����null ��Ч
SELECT *
FROM product
WHERE product_id IN (41,31,35,NULL)

--not in �൱�� !=all
SELECT *
FROM product
WHERE product_id NOT IN (41,31,35)

--*******�п� not in �в��ܳ���null ����һ�ж�����������*******
SELECT *
FROM product
WHERE product_id NOT IN (41,31,35��null)

--between x and y : >=x and <=y
--not between x and y 

--����������ѯ and / or

SELECT *
FROM USERS
WHERE born_date>DATE'1995-10-03' AND NAME LIKE 't%1'

--�߼��� not

--��������ȼ�:
--�Ƚ������>not>and>or





--�Բ�ѯ�������
--order by asc/desc Ĭ��Ϊasc
--ʹ������
SELECT *
FROM product
ORDER BY product_price
--ʹ�����
SELECT *
FROM product
ORDER BY 3 DESC,2 DESC

--order by Ĭ��nullΪ�����
--null last , null first
SELECT *
FROM product
ORDER BY 3 DESC NULLS LAST,2 DESC

SELECT *
FROM product
ORDER BY 3 ASC NULLS LAST,2 DESC










--�ѿ�������û������������m*n��û��ʵ�����壬����
--where��������Ҫ n-1������������n����
SELECT *
FROM product,product_type

--������� �������� ������ ������
SELECT *
FROM product,product_type
WHERE product.product_type_id=product_type.type_id

--������
--���⡢���⡢ȫ��
--���⣺�������ʧ�ܵ� ����
--���⣺�ұ�����ʧ�ܵ� ����

--oracle���б�ʾ��ʽ ����
SELECT *
FROM product,product_type
WHERE product.product_type_id=product_type.type_id(+)
--oracle���б�ʾ��ʽ ����
SELECT *
FROM product,product_type
WHERE product.product_type_id(+)=product_type.type_id

--SQL/99�﷨��׼
--������
--table1 INNER JOIN table2 ON ... AND ...
--table1 INNER JOIN table2 USING(col1,col2,...) ͬ����
SELECT p.product_id pid,p.product_price price,t.type_name TYPE
FROM product p INNER JOIN product_type t ON p.product_type_id=t.type_id
ORDER BY 1 ASC


--������
--table1 [LEFT|RIGHT|FULL] OUTER JOIN table2 ON ...
SELECT p.product_id pid,p.product_name pname,t.type_name tname
FROM product p LEFT OUTER JOIN product_type t ON p.product_type_id=t.type_id
ORDER BY pid

--�������ӣ��ѿ������� table1 CROSS JOIN table2
--��Ȼ���ӣ��Զ�ʹ��ͬ���У������ã� table1 NATURAL JOIN table2










--Oracle�������������ݿ�û��ͳһ��׼������һ����
--���к��� �ۺϺ���







--���к��� ����ÿ����¼����һ�� �õ�һ�н��
--���к������ַ���������ֵ���͡���ֵ���ַ���֮���ת������
-- ������غ��� �������ַ���֮���ת������

--�ַ�������
--01. lower upper
--02. ascii chr
--03. length lengthb
--04. lpad rpad
--05. ltrim rtrim trim
--06. substr instr
SELECT *
FROM USERS
WHERE LOWER(NAME)='tonkia'

--instr(����Դ,�����ַ���)
SELECT u.*,INSTR(LOWER(NAME),'on') idx
FROM USERS u
ORDER BY idx ASC

--ascii �ַ�->ascii
--chr ascii->�ַ�
SELECT ASCII('A'),CHR(65)
FROM dual

INSERT INTO product(product_id,product_price,product_name)
VALUES(47,100.5,'��һ��'||CHR(13)||CHR(10)||'�ڶ���')
--0D0A����

SELECT *
FROM product
--rtf ���ı�
--hex 16����

--length �ַ�
SELECT LENGTH('tonkia')
FROM dual

SELECT p.*,LENGTH(p.product_name) LEN
FROM product p

--lengthb �ֽ�
SELECT p.*,LENGTHB(p.product_name) LEN
FROM product p

--lpad rpad ���������ָ���ַ�
--����һ��2 width
--lpad(x,width,[paddingstr])
SELECT p.*,LPAD(p.product_name,20,'*')
FROM product p

--ltrim rtrim trim
--ltrim(x,[trimstr])
SELECT p.*,LTRIM(p.product_name,'t')
FROM product p

--substr
--substr(x,start,[length])
SELECT p.*,SUBSTR(p.product_name,3,2)
FROM product p

--NVL(����,Ϊnull���val)
--NVL(x,val)

SELECT p.*,NVL(p.product_price,0) price
FROM product p

--��ֵ������
--01. round ��������
--02. trunc �ض�
--03. mod
--04. power
--05. sqrt

--round(n,p)
SELECT p.*,ROUND(p.product_price,1) price
FROM product p

--trunc(n,p)
SELECT p.*,TRUNC(p.product_price,0) price
FROM product p

--mod(x,y)
SELECT MOD(13,7)
FROM dual

SELECT MOD(-13,7)
FROM dual

SELECT MOD(-13,-7)
FROM dual
--   -13/-7=1
--   -13-1*(-7)=-6
SELECT MOD(13,-7)
FROM dual
--   13/-7=-1
--   13-(-1)*(-7)=6

--power(x,y)
SELECT POWER(2,5)
FROM dual

--sqrtƽ����
SELECT SQRT(3)
FROM dual

--��ֵ���ַ���֮���ת��������
--01. to_char(x,[format])
--02. to_number(x,[format])

--to_char
-- 0������ʾ��û����ʾ0
-- 9��ʾ��ֵ 
-- S������
-- DС����
SELECT to_char(23456.789,'s000000d9999') 
FROM dual
--�������� ########
SELECT to_char(23456.789,'s00d9999') 
FROM dual
--С������ ��������
SELECT to_char(23456.789,'s000000d9') 
FROM dual

--to_number
SELECT to_number('456.123')
FROM dual

--�ۺϺ���
--�ۺϺ�������һ�����ݽ��в�����������һ���������
--sum avg ��ֵ
--max min count ��ֵ���ַ������ֵ����򣩡�������ֵ
--����count(*) �����ľۺϺ����������null

SELECT AVG(p.product_price),MAX(p.product_price),MIN(p.product_price),COUNT(p.product_id)
FROM product p

--�ۺϺ������group byʹ��
--ʹ��group by��select�������б�ֻ��ʹ��group by�Ӿ��г��ֵ����� �� �ۺϺ���
SELECT t.type_name,AVG(p.product_price),COUNT(*) COUNT
FROM product p LEFT OUTER JOIN product_type t ON p.product_type_id=t.type_id
GROUP BY t.type_name,t.type_id
HAVING COUNT(*)>=4
--��group by��������having

--ִ�й���
--where->group by->having->����ۺ�

--where �����ڱ�
--having ��������





--�����в����������͵�����

--insert
SELECT *
FROM USERS
--����date ����ʹ��YYYY-MM-DD�ĸ�ʽ
INSERT INTO USERS VALUES(DATE'2018-10-3','f','mike',10)
COMMIT

SELECT *
FROM USERS
WHERE born_date>DATE'1996-10-03'


--�������ַ���֮���ת������
--to_char(x,[parameter])
--to_date(x,[parameter])

--YYYY ��λ�����
--YY ��λ�����
--MM ��λ���·�
--MONTH Month
--MON Mon
--DD
--DAY Day
--Dy
--HH24
--HH
--MI
--SS
--am pm ������ʾ������

--to_char
SELECT NAME,to_char(born_date,'YYYY-Month-Dy')
FROM USERS

SELECT to_char(DATE'1996-10-03','YYYY/MM/DD HH24:MI:SS')
FROM dual

--to_date
SELECT to_date('1996/10/03','YYYY/MM/DD')
FROM dual

--������غ���
--01. add_month(x,y) x����y���� yΪ�����ȥ
--02. last_day(x) x�µ����һ������
--03. months_between(x,y) �������ڵ��·ݲ�
--04. round(x,[unit]) �����ڽ����������� Ĭ���Ƕ��죨DD��������������
--05. trunc(x,[unit])

SELECT to_char(last_day(SYSDATE),'YYYY-MM-DD')
FROM dual

--sysdate
SELECT u.*,trunc(months_between(SYSDATE,u.born_date)/12) "����"
FROM USERS u

SELECT u.*,trunc(months_between(u.born_date,sysdate)/12) "����"
FROM USERS u

SELECT u.*,ROUND(u.born_date,'YYYY'),ROUND(u.born_date,'MM')
FROM USERS u

--ʱ��� ʱ������ timestamp(n) ��С�����nλ
-- timestap'YYYY-MM-DD HH24:MI:SS.ff4'
SELECT *
FROM v$nls_parameters

--to_char
--to_timestap()

CREATE TABLE purchase_timestamp(
       purchase_name VARCHAR2(5 CHAR),
       purchase_time timestamp(6)
)

INSERT INTO purchase_timestamp 
VALUES('���ݿ���',TIMESTAMP'2018-7-30 01:20:30.12345678')





--�Ӳ�ѯ ���Ƕ��255��
--�����Ӳ�ѯ �� һ��һ����Ϊ�����Ӳ�ѯ
--�����Ӳ�ѯ


SELECT * FROM product
SELECT * FROM product_type

--�����Ӳ�ѯ
SELECT p.product_id,p.product_type_id,p.product_name
FROM product p
WHERE p.product_type_id=(SELECT t.type_id 
                         FROM product_type t WHERE t.type_name
                         ='��Ϸ'
                         )
                          
SELECT p.product_name,p.product_price
FROM product p
WHERE p.product_price>(SELECT AVG(product_price)
                       FROM product
                       )
                       
SELECT p.product_type_id,t.type_name,AVG(p.product_price)
FROM product p,product_type t
WHERE p.product_type_id=t.type_id(+)
GROUP BY p.product_type_id,t.type_name
HAVING AVG(p.product_price)>(SELECT AVG(product_price)
                            FROM product
                            )
                            
SELECT p.product_type_id,t.type_name,AVG(p.product_price)
FROM product p LEFT OUTER JOIN product_type t ON p.product_type_id=t.type_id(+)
GROUP BY p.product_type_id,t.type_name
HAVING AVG(p.product_price)>(SELECT AVG(product_price)
                            FROM product
                            )
                            
--�����Ӳ�ѯ
SELECT *
FROM product p
WHERE p.product_type_id IN (SELECT t.type_id
                            FROM product_type t
                            )
ORDER BY 1

SELECT *
FROM product p
WHERE p.product_type_id = ANY(SELECT t.type_id
                            FROM product_type t
                            )
ORDER BY 1
                       
--from ������Ӳ�ѯ��������ͼ
SELECT nvl(type_id,0) "��Ʒ����id",nvl(type_name,'������') "��Ʒ����",tcount "��Ʒ����"
FROM (SELECT p.product_type_id type_id,COUNT(p.product_id)tcount
      FROM product p 
      GROUP BY p.product_type_id
      ) LEFT OUTER JOIN product_type USING (type_id)

--ÿ�����������ͼ۸�
SELECT p.*
FROM product p
ORDER BY p.product_type_id ASC,p.product_price ASC
--���� ��in ����nullֵ  �����
SELECT p.*
FROM product p
WHERE (p.product_type_id,p.product_price) IN (SELECT p.product_type_id,MIN(p.product_price)
                                              FROM product p
                                              GROUP BY p.product_type_id
                                              )
ORDER BY p.product_type_id ASC

--�����Ӳ�ѯ�������ⲿ��ѯ�е�ÿһ�У��Ӳ�ѯ��������һ��
--ÿ��������Ĵ���ƽ���۸����Ʒ
SELECT x.*,(SELECT AVG(p.product_price)
                      FROM product p
                      WHERE p.product_type_id=x.product_type_id
                      ) "avg"
FROM  product x
WHERE x.product_price>(SELECT AVG(p.product_price)
                      FROM product p
                      WHERE p.product_type_id=x.product_type_id
                      )

--exist �� not exist ֻ������û�м�¼����
SELECT p.*
FROM product p
WHERE NOT EXISTS (SELECT * FROM product_type t WHERE t.type_id=p.product_type_id)

SELECT p.*
FROM product p
WHERE EXISTS (SELECT * FROM product_type t WHERE t.type_id=p.product_type_id)

SELECT p.*
FROM product p
WHERE p.product_type_id IN (SELECT t.type_id FROM product_type t)

--�޸� id31 �۸� ���� id34
UPDATE product p SET p.product_price=(SELECT product_price
                                      FROM product
                                      WHERE product_id=34
                                      )
WHERE p.product_id=31
COMMIT

--ɾ����ͼ۸�
SELECT * FROM product ORDER BY product_price

DELETE FROM product p
WHERE p.product_price=(SELECT MIN(product_price)
                        FROM product 
                        )   
   
ROLLBACK                       



--���ϲ�����
--���ϵļ�¼���������ͬ���к��������ͱ���ƥ��
--����Ϊ��һ�����ϵ�����


--union all �����ظ���¼
--union �������ظ���¼
--intersect 
--minus

SELECT * FROM product
UNION ALL
SELECT * FROM product 

SELECT * FROM product
UNION
SELECT * FROM product 

SELECT * FROM product
INTERSECT
SELECT * FROM product 

SELECT * FROM product
MINUS
SELECT * FROM product 
--�������ʹ��

--decode���� oracle���к���
--����ʵ��  if then else ���߼�����
--��ʽ decode(expr,vlue,result,default)
--nvl

--decode(user.gender,'M','Male','Female')
SELECT u.*,DECODE(u.user_gender,0,'��','Ů')
FROM user_info u

--SQL/99��׼ 
--case���ʽ01
-- case exp
-- when exp1 then res1
-- when exp2 then res2
-- when exp3 then res3
-- ...
-- else default
-- end

SELECT * FROM product_type

SELECT p.*,CASE p.product_type_id 
          WHEN 1 THEN '��Ӱ' 
          WHEN 2 THEN '��Ϸ' 
          ELSE '��' 
          END 
FROM product p

--SQL/99��׼ 
--case���ʽ02
-- case
-- when exp1 then res1
-- when exp2 then res2
-- when exp3 then res3
-- ...
-- else default
-- end


SELECT * FROM product_type

SELECT p.*,CASE  
           WHEN p.product_type_id=1 THEN '��Ӱ' 
           WHEN p.product_type_id=2 THEN '��Ϸ' 
           ELSE '��' 
           END TYPE,
           CASE
           WHEN p.product_price>100 THEN '��'  
           WHEN p.product_price>50 THEN '���Խ���' 
           WHEN p.product_price>0 THEN '����'
           ELSE '�޸�'
           END 
FROM product p

--��ת��

--����׼��
CREATE TABLE sale_info(
       YEAR INT,
       MONTH INT,
       amount NUMBER(6,1)
)
SELECT * FROM sale_info
DELETE FROM sale_info

INSERT INTO sale_info VALUES(2014,1,123.2);
INSERT INTO sale_info VALUES(2014,2,56.2);
INSERT INTO sale_info VALUES(2014,3,83.2);
INSERT INTO sale_info VALUES(2014,4,5.2);
INSERT INTO sale_info VALUES(2014,5,45.2);
INSERT INTO sale_info VALUES(2014,6,22.2);
INSERT INTO sale_info VALUES(2014,7,53.2);
INSERT INTO sale_info VALUES(2014,8,434.2);
INSERT INTO sale_info VALUES(2014,9,256.2);
INSERT INTO sale_info VALUES(2014,10,2567.2);
INSERT INTO sale_info VALUES(2014,11,643.2);
INSERT INTO sale_info VALUES(2014,12,85.2);

INSERT INTO sale_info VALUES(2015,1,123.2);
INSERT INTO sale_info VALUES(2015,2,56.2);
INSERT INTO sale_info VALUES(2015,3,83.2);
INSERT INTO sale_info VALUES(2015,4,5.2);
INSERT INTO sale_info VALUES(2015,5,45.2);
INSERT INTO sale_info VALUES(2015,6,22.2);
INSERT INTO sale_info VALUES(2015,7,53.2);
INSERT INTO sale_info VALUES(2015,8,434.2);
INSERT INTO sale_info VALUES(2015,9,256.2);
INSERT INTO sale_info VALUES(2015,10,2567.2);
INSERT INTO sale_info VALUES(2015,11,643.2);
INSERT INTO sale_info VALUES(2015,12,85.2);
COMMIT

SELECT s.year YEAR,SUM(CASE MONTH WHEN 1 THEN s.amount ELSE 0 END) "1��",
                   SUM(CASE MONTH WHEN 2 THEN s.amount ELSE 0 END) "2��",
                   SUM(CASE MONTH WHEN 3 THEN s.amount ELSE 0 END) "3��",
                   SUM(CASE MONTH WHEN 4 THEN s.amount ELSE 0 END) "4��",
                   SUM(CASE MONTH WHEN 5 THEN s.amount ELSE 0 END) "5��",
                   SUM(CASE MONTH WHEN 6 THEN s.amount ELSE 0 END) "6��",
                   SUM(CASE MONTH WHEN 7 THEN s.amount ELSE 0 END) "7��",
                   SUM(CASE MONTH WHEN 8 THEN s.amount ELSE 0 END) "8��",
                   SUM(CASE MONTH WHEN 9 THEN s.amount ELSE 0 END) "9��",
                   SUM(CASE MONTH WHEN 10 THEN s.amount ELSE 0 END) "10��",
                   SUM(CASE MONTH WHEN 11 THEN s.amount ELSE 0 END) "11��",
                   SUM(CASE MONTH WHEN 12 THEN s.amount ELSE 0 END) "12��"
FROM sale_info s
GROUP BY s.year

--*******��β�ѯ******* ��oracle���У�
--*******��������*******

--���롢���º�ɾ��
CREATE TABLE tb_insert(
       ID INT CONSTRAINT pk_insert_id PRIMARY KEY,
       NAME VARCHAR2(50) DEFAULT 'default name'
);

INSERT INTO tb_insert VALUES(1,NULL);
--ʹ��Ĭ��ֵ
INSERT INTO tb_insert VALUES(2,DEFAULT);
INSERT INTO tb_insert(ID) VALUES(3);
--���뵥���� ��''
INSERT INTO tb_insert VALUES(4,'xi''an')
SELECT * FROM tb_insert

--��������
INSERT INTO tb_insert 
       SELECT p.product_id,p.product_name
       FROM product p
       WHERE p.product_id IN (4,5,6,7,40,41,42,50,51,52)

DELETE FROM tb_insert WHERE NAME IS NULL

--������ ����=null
ALTER TABLE tb_insert MODIFY NAME NOT NULL
INSERT INTO tb_insert VALUES(1,'');
INSERT INTO tb_insert VALUES(1,NULL);

--update
--UPDATE tableName SET colName = value

UPDATE tb_insert SET ID=10 WHERE ID=2
UPDATE tb_insert SET NAME=NULL WHERE ID=10

--ɾ��
--DELETE FROM tableName WHERE ...
--DELETE FROM tableName WHERE ... (ON DELETE CASCADE ����ɾ��)
--DELETE FROM tableName WHERE ... (ON DELETE SET NULL �����ÿ�)
CREATE TABLE tb_delete_type(
       type_id INT PRIMARY KEY,
       type_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE tb_delete(
       ID INT PRIMARY KEY,
       NAME VARCHAR2(50) NOT NULL UNIQUE,
       type_id INT REFERENCES tb_delete_type(type_id) /*ON DELETE CASCADE*/
);

INSERT INTO tb_delete_type VALUES(1,'type1');
INSERT INTO tb_delete_type VALUES(2,'type2');
INSERT INTO tb_delete_type VALUES(3,'type3');

INSERT INTO tb_delete VALUES(1,'item1',1);
INSERT INTO tb_delete VALUES(2,'item2',2);
INSERT INTO tb_delete VALUES(3,'item3',3);

COMMIT 

SELECT * FROM tb_delete;

SELECT * FROM tb_delete_type;

DELETE FROM tb_delete_type WHERE type_id=1

DROP TABLE tb_delete;
DROP TABLE tb_delete_type;

--һ�����ݿⲻ����Լ�����ڴ����ʹ������ ��Ȼ��Ҫд���״���
--��Ҫ���������׳����쳣��û�б�Ҫ��
--�����ڲ�������ǰ������У��

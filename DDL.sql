--������
--������1-30���ַ� ���ַ���������ĸ ���� ��ĸ�����֡�#��$��_
--CREATE TABLE tablename(
--       colName colType [DEFAULT defValue CONSTRAINT constraintDef]
--       ...
--)

--constraintԼ������
--01. ����Լ�� 
--02. ���Լ��������Ϊnull�� 
--03. ΨһԼ��������Ϊnull�� 
--04. ���Լ��������Ϊnull�� 
--05. �ǿ�Լ��

--constraintԼ���Ķ���
--01. �м�Լ��
--02. ��Լ�������ã�

--Լ��Ҳ��һ�����ݿ����
--CONSTRAINT constraintName [ѡ������Լ��]   �����Բ������֣����ݿ��Զ����ɣ�ʡ�Ը��У�
--������primary key
--�����references otherTableName(colName...)
--Ψһ��unique
--��飺check(exp)
--�ǿգ�not null

--�����淶
--pk_table_column
--fk_table_column
--uq_table_column
--ck_table_column
--nn_table_column

CREATE TABLE tb_students(
       stu_id INT CONSTRAINT pk_stu_id PRIMARY KEY,
       stu_num VARCHAR2(11) CONSTRAINT uq_stu_num UNIQUE CONSTRAINT nn_stu_num NOT NULL,
       stu_name VARCHAR2(10 CHAR) CONSTRAINT nn_stu_name NOT NULL,
       stu_gender CHAR(1) CONSTRAINT ck_stu_gender CHECK(stu_gender='M' OR stu_gender='F'),
       stu_age INT CONSTRAINT ck_stu_age CHECK(stu_age>0 AND stu_age<150)
)

CREATE TABLE tb_courses(
       cou_id INT PRIMARY KEY,
       cou_name VARCHAR(20 CHAR) NOT NULL UNIQUE,
       cou_credit NUMBER(3,1) CHECK(cou_credit>0)
)


CREATE TABLE tb_scores(
       stu_id INT CONSTRAINT fk_sco_stu_id REFERENCES tb_students(stu_id) NOT NULL,
       cou_id INT CONSTRAINT fk_sco_cou_id REFERENCES tb_courses(cou_id) NOT NULL,
       score NUMBER(4,1) CONSTRAINT ck_sco_score CHECK(score>0 AND score<200)
)


ALTER TABLE tb_students MODIFY stu_name VARCHAR2(20)
INSERT INTO tb_students VALUES(1,'41509060104','tongxiaokai','F',22)
SELECT * FROM tb_students

INSERT INTO tb_courses VALUES(1,'gaoshu',3.5)
SELECT * FROM tb_courses

DROP TABLE tb_scores;
DROP TABLE tb_courses;
DROP TABLE tb_students;

--��Լ���﷨
--CONSTRAINT pk_tbName_colName PRIMARY KEY(colName)
--CONSTRAINT fk_tbName_colName FOREIGN KEY(colName) REFERENCES tbName(colName)
--CONSTRAINT ck_tbName_colName CHECK(exp)
--CONSTRAINT uq_tbName_colName UNIQUE(colName)

--�ǿ�Լ��ֻ�ܶ������м���
--��������ֻ�ܶ����ڱ���

CREATE TABLE tb_students(
       stu_id INT,
       stu_num VARCHAR2(11) CONSTRAINT nn_stu_num NOT NULL,
       stu_name VARCHAR2(10 CHAR) CONSTRAINT nn_stu_name NOT NULL,
       stu_gender CHAR(1),
       stu_age INT,
       CONSTRAINT pk_stu_id PRIMARY KEY(stu_id),
       CONSTRAINT uq_stu_num UNIQUE(stu_num),
       CONSTRAINT ck_stu_gender CHECK(stu_gender='M' OR stu_gender='F'),
       CONSTRAINT ck_stu_age CHECK(stu_age>0 AND stu_age<150)
)
--������
CREATE TABLE tb_courses(
       cou_id INT,
       cou_name VARCHAR(20 CHAR) NOT NULL,
       cou_credit NUMBER(3,1),
       PRIMARY KEY(cou_id),
       UNIQUE(cou_name),
       CHECK(cou_credit>0)
)

--��������
CREATE TABLE tb_scores(
       stu_id INT NOT NULL,
       cou_id INT NOT NULL,
       score NUMBER(4,1),
       CONSTRAINT fk_sco_stu_id FOREIGN KEY(stu_id) REFERENCES tb_students(stu_id),
       CONSTRAINT fk_sco_cou_id FOREIGN KEY(cou_id) REFERENCES tb_courses(cou_id),
       PRIMARY KEY(stu_id,cou_id),
       CONSTRAINT ck_sco_score CHECK(score>0 AND score<200)
)



ALTER TABLE tb_students MODIFY stu_name VARCHAR(20 CHAR)

INSERT INTO tb_students VALUES(1,'41509060104','tongxiaokai','F',22);
INSERT INTO tb_courses VALUES(1,'gaoshu',3.5);
INSERT INTO tb_scores VALUES(1,1,100);

SELECT * FROM tb_scores

--default Ĭ��ֵ ע����constraint��˳��
--��default��constraint










--�޸ı�
--�����
--ALTER TABLE tableName ADD columnName type [DEFAULT ... CONSTRAINT ...]
--��������Ѿ������� �����ӵ��µ��в��ܼ�not nullԼ��

ALTER TABLE tb_students ADD stu_phone VARCHAR2(11) 
SELECT * FROM tb_students

--�޸��е���������
-- ALTER TABLE tableName MODIFY columnName newType
--�Ѿ������� ��Ҫ���������ܹ�ת����ȥ �������ܹ����ݵ���������
--û�����ݵĻ� ����
--�޸��е�Ĭ��ֵ
--ALTER TABLE tableName MODIFY colName DEFAULT def
--ɾ����
--ALTER TABLE tableName DROP COLUMN columnName
--�������Լ��
--ALTER TABLE tableName ADD CONSTRAINT consName[��Լ��]
--ALTER TALBE tableName MODIFY colName CONSTRAINT consName[�м�Լ��]
--ɾ��Լ��
--ALTER TABLE tableName DROP CONSTRAINT consName

ALTER TABLE tb_courses ADD CONSTRAINT ck_cou_credit CHECK(cou_credit<10)
ALTER TABLE tb_courses DROP CONSTRAINT ck_cou_credit
ALTER TABLE tb_courses MODIFY cou_credit CHECK(cou_credit<10)

--�޸�column  ��ӡ��޸ġ�ɾ��
ALTER TABLE tb_scores ADD score NUMBER(4,1) 
ALTER TABLE tb_scores MODIFY score NUMBER(5,2)
ALTER TABLE tb_scores DROP COLUMN score
--�޸�constraint  ��ӡ�ɾ��
ALTER TABLE tb_scores MODIFY score CHECK(score>0 AND score<200)/*�м�Լ��*/
ALTER TABLE tb_courses ADD CONSTRAINT ck_cou_credit CHECK(cou_credit<10)/*��Լ��*/
ALTER TABLE tb_courses DROP CONSTRAINT ck_cou_credit










--���� ��Ӧʵ��mysql���auto increase
--CREATE SEQUENCE seq_name
--[START WITH n] [INCREMENT BY]
--[MAXVALUE max_n] [MINVALUE min_n]
--[CYCLE|NOCYCLE] [CACHE count|NOCACHE]



--CYCLE ���� max��min֮��ѭ��
CREATE SEQUENCE seq_test
START WITH 7 INCREMENT BY 1
MAXVALUE 20
CYCLE NOCACHE

SELECT seq_test.nextval FROM dual

CREATE SEQUENCE seq_test_de
START WITH 7 INCREMENT BY -1
MAXVALUE 20 MINVALUE -10
CYCLE NOCACHE

SELECT seq_test_de.nextval FROM dual

CREATE SEQUENCE seq_test_dee
START WITH -5 INCREMENT BY -1
MINVALUE -10
CYCLE NOCACHE

SELECT seq_test_dee.nextval FROM dual

SELECT seq_test_dee.currval FROM dual

CREATE SEQUENCE seq_def

SELECT seq_def.nextval FROM dual

DROP SEQUENCE seq_def

--��ѯ��ǰֵ
xxx.currval

--��һ��ֵ
xxx.nextval

--ɾ������
--DROP SEQUENCE xxx












--���� ʹ��������Ŀ����Ϊ��������ݲ�ѯ���ٶ�

--Oracle��� ���� �� ����ΨһԼ�� �����Զ���������

--����������Ҫ��
--01.����ȡֵ��Χ�� ������ ��Ů ��ΧС������ѯ�Ľ��������
--02.�����ڼ���
--03.������select����DML������

--��������
--CREATE [UNIQUE] INDEX index_name ON tableName(columnName,...)
--unique ����unique���� ��������ǲ��ظ��� �Զ�����ΨһԼ��

--���������ĸ���Ӱ��
--01.������ά����Ҫ��ʱ���ʴ�DML����ִ�����ʽ���
--02.������Ҫռ��һ���Ĵ洢�ռ�


SELECT * FROM product WHERE product_id=31;
--F5ִ�� ִ�мƻ�
--�Ż�����ѡ��ͬ���Ż��� ִ�мƻ��п��ܻ᲻һ��
--������������һ����������







--��ͼ
--����ͼ�м������ݺʹӱ��м������ݵķ�����ȫһ��
--��ͼ�������ڣ��ǽ����ڻ����ϵ�***Ԥ�����ѯ***

--��ͼ���ŵ�
--01.���β�ѯ�ĸ�����
--02.���û����β�������
--03.���ػ���

--������ͼ
--CREATE [OR REPLACE] VIEW  view_name [(aliasName...)]
--AS
--sub_query
--[WITH {CHECK OPTION|READ ONLY}]

--check option ȷ��ͨ����ͼ��������ݼ�¼������ͼ�п���
--read only ����ͼ��ֻ���ģ�����ִ��DML���

CREATE OR REPLACE VIEW v_product
AS
SELECT *
FROM product p
WHERE p.product_price>30

--Ȩ�޲���
--grant create view to tonkia

SELECT * FROM v_product

INSERT INTO v_product VALUES(61,2,10.5,'��ͼ������')

SELECT * FROM product

--��Ӽ��ѡ��
CREATE OR REPLACE VIEW v_product
AS
SELECT *
FROM product p
WHERE p.product_price>50
WITH CHECK OPTION

INSERT INTO v_product VALUES(62,2,10.5,'��ͼ���ò���')


--�����
CREATE OR REPLACE VIEW v_product(pid,tid,pprice,pname)
AS
SELECT *
FROM product p
WHERE p.product_price>50
WITH CHECK OPTION

--������ӽ�����ͼ
CREATE OR REPLACE VIEW v_prd_info(pid,pname,ptype)
AS
SELECT p.product_id,p.product_name,t.type_name
FROM product p LEFT OUTER JOIN product_type t ON p.product_type_id=t.type_id

SELECT * FROM v_prd_info

--���������ͼ�Ĳ���
--����������Ϣ����һ����� ����
--����������Ϣ�����ڶ���� ������ û������
--������Ҳ���� on ...

--������ӽ�����ͼͨ����with read only
CREATE OR REPLACE VIEW v_prd_info(pid,pname,ptype)
AS
SELECT p.product_id,p.product_name,t.type_name
FROM product p LEFT OUTER JOIN product_type t ON p.product_type_id=t.type_id
WITH READ ONLY

















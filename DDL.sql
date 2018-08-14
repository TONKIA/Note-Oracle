--创建表
--表名：1-30个字符 首字符必须是字母 包括 字母、数字、#、$、_
--CREATE TABLE tablename(
--       colName colType [DEFAULT defValue CONSTRAINT constraintDef]
--       ...
--)

--constraint约束种类
--01. 主键约束 
--02. 外键约束（可以为null） 
--03. 唯一约束（可以为null） 
--04. 检查约束（可以为null） 
--05. 非空约束

--constraint约束的定义
--01. 列级约束
--02. 表级约束（常用）

--约束也是一种数据库对象
--CONSTRAINT constraintName [选择以下约束]   （可以不给名字，数据库自动生成，省略该行）
--主键：primary key
--外键：references otherTableName(colName...)
--唯一：unique
--检查：check(exp)
--非空：not null

--命名规范
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

--表级约束语法
--CONSTRAINT pk_tbName_colName PRIMARY KEY(colName)
--CONSTRAINT fk_tbName_colName FOREIGN KEY(colName) REFERENCES tbName(colName)
--CONSTRAINT ck_tbName_colName CHECK(exp)
--CONSTRAINT uq_tbName_colName UNIQUE(colName)

--非空约束只能定义在列级；
--联合主键只能定义在表级。

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
--不命名
CREATE TABLE tb_courses(
       cou_id INT,
       cou_name VARCHAR(20 CHAR) NOT NULL,
       cou_credit NUMBER(3,1),
       PRIMARY KEY(cou_id),
       UNIQUE(cou_name),
       CHECK(cou_credit>0)
)

--联合主键
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

--default 默认值 注意与constraint的顺序
--先default后constraint










--修改表
--添加列
--ALTER TABLE tableName ADD columnName type [DEFAULT ... CONSTRAINT ...]
--如果表中已经有数据 则增加的新的列不能加not null约束

ALTER TABLE tb_students ADD stu_phone VARCHAR2(11) 
SELECT * FROM tb_students

--修改列的数据类型
-- ALTER TABLE tableName MODIFY columnName newType
--已经有数据 需要数据类型能够转换过去 必须是能够兼容的数据类型
--没有数据的话 随便改
--修改列的默认值
--ALTER TABLE tableName MODIFY colName DEFAULT def
--删除列
--ALTER TABLE tableName DROP COLUMN columnName
--给列添加约束
--ALTER TABLE tableName ADD CONSTRAINT consName[表级约束]
--ALTER TALBE tableName MODIFY colName CONSTRAINT consName[列级约束]
--删除约束
--ALTER TABLE tableName DROP CONSTRAINT consName

ALTER TABLE tb_courses ADD CONSTRAINT ck_cou_credit CHECK(cou_credit<10)
ALTER TABLE tb_courses DROP CONSTRAINT ck_cou_credit
ALTER TABLE tb_courses MODIFY cou_credit CHECK(cou_credit<10)

--修改column  添加、修改、删除
ALTER TABLE tb_scores ADD score NUMBER(4,1) 
ALTER TABLE tb_scores MODIFY score NUMBER(5,2)
ALTER TABLE tb_scores DROP COLUMN score
--修改constraint  添加、删除
ALTER TABLE tb_scores MODIFY score CHECK(score>0 AND score<200)/*列级约束*/
ALTER TABLE tb_courses ADD CONSTRAINT ck_cou_credit CHECK(cou_credit<10)/*表级约束*/
ALTER TABLE tb_courses DROP CONSTRAINT ck_cou_credit










--序列 对应实现mysql里的auto increase
--CREATE SEQUENCE seq_name
--[START WITH n] [INCREMENT BY]
--[MAXVALUE max_n] [MINVALUE min_n]
--[CYCLE|NOCYCLE] [CACHE count|NOCACHE]



--CYCLE 是在 max和min之间循环
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

--查询当前值
xxx.currval

--下一个值
xxx.nextval

--删除序列
--DROP SEQUENCE xxx












--索引 使用索引的目的是为了提高数据查询的速度

--Oracle会给 主键 和 具有唯一约束 的列自动建立索引

--建立索引的要点
--01.该列取值范围大 （反例 男女 范围小），查询的结果条数少
--02.常用于检索
--03.多用于select，而DML操作少

--建立索引
--CREATE [UNIQUE] INDEX index_name ON tableName(columnName,...)
--unique 创建unique索引 代表该列是不重复的 自动加上唯一约束

--创建索引的负面影响
--01.创建和维护需要耗时，故此DML语句的执行速率降低
--02.索引需要占用一定的存储空间


SELECT * FROM product WHERE product_id=31;
--F5执行 执行计划
--优化器，选择不同的优化器 执行计划有可能会不一样
--创建了索引不一定会走索引







--视图
--从视图中检索数据和从表中检索数据的方法完全一样
--视图并不存在，是建立在基表上的***预定义查询***

--视图的优点
--01.屏蔽查询的复杂性
--02.对用户屏蔽部分数据
--03.隐藏基表

--创建视图
--CREATE [OR REPLACE] VIEW  view_name [(aliasName...)]
--AS
--sub_query
--[WITH {CHECK OPTION|READ ONLY}]

--check option 确保通过视图插入的数据记录能在视图中看到
--read only 该视图是只读的，不能执行DML语句

CREATE OR REPLACE VIEW v_product
AS
SELECT *
FROM product p
WHERE p.product_price>30

--权限不足
--grant create view to tonkia

SELECT * FROM v_product

INSERT INTO v_product VALUES(61,2,10.5,'视图看不见')

SELECT * FROM product

--添加检查选项
CREATE OR REPLACE VIEW v_product
AS
SELECT *
FROM product p
WHERE p.product_price>50
WITH CHECK OPTION

INSERT INTO v_product VALUES(62,2,10.5,'视图不让插入')


--起别名
CREATE OR REPLACE VIEW v_product(pid,tid,pprice,pname)
AS
SELECT *
FROM product p
WHERE p.product_price>50
WITH CHECK OPTION

--多表连接建立视图
CREATE OR REPLACE VIEW v_prd_info(pid,pname,ptype)
AS
SELECT p.product_id,p.product_name,t.type_name
FROM product p LEFT OUTER JOIN product_type t ON p.product_type_id=t.type_id

SELECT * FROM v_prd_info

--多表连接视图的插入
--如果插入的信息都是一个表的 可以
--如果插入的信息来自于多个表 不可以 没法处理
--连接列也不行 on ...

--多表连接建立视图通常加with read only
CREATE OR REPLACE VIEW v_prd_info(pid,pname,ptype)
AS
SELECT p.product_id,p.product_name,t.type_name
FROM product p LEFT OUTER JOIN product_type t ON p.product_type_id=t.type_id
WITH READ ONLY

















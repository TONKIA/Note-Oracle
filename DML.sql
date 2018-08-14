
--DML（Data Manipulation Language）数据操纵语言
--DDL（Data Definition Language）数据库定义语言
--DCL（Data Control Language）数据库控制语言

--小总结
--两种客户端软件：sql plus / plsql developer
--常用数据类型：char(n),varchar2(max),number(p,s),clob,blob,date,timestamp
--用户管理：
--CREATE USER xxx INDENTIFIED BY pwd
--ALTER USER xxx INDENTIFIED BY pwd
--ALTER USER xxx ACCOUNT LOCK/UNLOCK
--DROP USER xxx CASCADE
--GRANT CONNECT,RESOURCE TO xxx

--DML
--单行函数
--分组和聚合函数





--查询当前用户表
SELECT table_name FROM user_tables
--查询当前会话的nls参数
SELECT * FROM v$nls_parameters

SELECT to_char(TIMESTAMP'1996-10-3 5:6:7.123456')
FROM dual

SELECT SYSDATE FROM dual
SELECT SYSTIMESTAMP FROM dual

SELECT * FROM dual

--SQL语句划分为5大类
--01.查询语句 select
--02.数据操作语句 insert update delete（可以通过事务控制）
--03.数据定义语句 create alter drop rename truncate（截断，数据定义语句是不受事务控制的）
--04.事务控制语句 commit rollback savepoint
--05.权限控制语句 grant revoke


--用户管理相关SQL
--01.创建用户
CREATE USER checkout IDENTIFIED BY checkout_pwd
--锁定/解锁用户
ALTER USER checkout ACCOUNT LOCK
ALTER USER checkout ACCOUNT UNLOCK
--02.授权用户
GRANT CONNECT,RESOURCE TO checkout
--03.修改用户密码
ALTER USER checkout IDENTIFIED BY Txk19961003
--04.删除用户
DROP USER checkout CASCADE

--修改nls
SELECT * FROM USERS
ALTER SESSION SET nls_date_format='YYYY-MM-DD'

--数据类型
--char(length)length字节 定长字符串 length 1-2000（补足length，学号，手机号，省份证号）
--char(length char) 带单位指定length个字符 自动根据编码计算字节
--varchar2(length) 变长字符串，length 1-4000
--nchar(length)定长unicode字符串 length表示字符数 length 1-1000
--nvarchar2(length) 变长unicode字符串 length 1-2000
--blob Binary Large Object二进制大数据 最大4G
--clob Charater Large Object字符大数据 最大4G
--nclob Unicode字符数据 最大4G
--date 时间类型，存日期和时间
--number(precision,scale) 数字类型最多22字节，precision精度有效位不超过38 scale小数点后位数
--timestamp(n)

CREATE TABLE TEST(
       ID INT PRIMARY KEY,
       NAME VARCHAR2(10 CHAR),
       phone CHAR(11),
       score NUMBER(4,2)
)

INSERT INTO TEST VALUES(1,'张三','18399999999',1234.5)
--123.50(精度为5)
INSERT INTO TEST VALUES(1,'张三','18399999999',123.5)
INSERT INTO TEST VALUES(1,'张三','18399999999',12.5)

SELECT * FROM TEST
--不常用类型
--binary_float 32位浮点数 5字节
--binary_double 64位浮点数 9字节 
--优点：存储空间小，运算速度快，数值范围大  缺点：精度小

--不怎么使用的类型
--raw(n) 变长二进制数据 n 1-2000
--long 变长字符列 最大2G字节 clob替代
--long raw 变长二进制数据 最大2G直接 blob替代

--Oracle同样支持类型（类型别名）
--dec(p,s) numberic(p,s) = number(p,s)
--smallint int integer = number(38)
--float real doule precision = number的子类型

--横向where过滤
--纵向 投影

SELECT * FROM product

SELECT product_id,product_name
FROM product

SELECT * 
FROM product
WHERE product_price>50

SELECT product.*,product_price*0.8 discount
FROM product

--列名起别名用as 表名起别名不能用as
SELECT 10*5-6 AS "final res"
FROM dual

--列名起别名可以省略as
SELECT 10*5-6 "final res"
FROM dual

--中文“xxx”
SELECT 10*5-6 "运算结果"
FROM dual

--与行相关，dual只有一行
SELECT 10*5 res
FROM product

--伪列 rowid rownum
--rowid 物理存储位置 base64 (A-Z a-z 0-9 + /) (每6位用一个符号表示 2^6=64 26+26+10+2=64)
--rownum 在结果集中的行号（分页查询）

SELECT 10*5 res,ROWID,ROWNUM
FROM product

SELECT USERS.*,ROWID,ROWNUM 
FROM USERS

--分页查询,无效
SELECT product.*,ROWNUM
FROM product
WHERE ROWNUM>2 AND ROWNUM<=5
--********分页查询,必须使用子查询********
SELECT * 
FROM (SELECT t.*,ROWID ri,ROWNUM rn FROM product t)
WHERE rn>2 AND rn<=5

INSERT INTO product VALUES(seq_product_id.nextval,1,150,'百分比100%')

--字符串‘xxx’||‘xxx’
--字符串连接符 ||
SELECT product_type_id,product_name||product_price
FROM product

--is null/is not null
SELECT *
FROM product
WHERE product_price=NULL

--只要使用=null 结果一定为false
SELECT *
FROM product
WHERE product_price IS NULL

SELECT *
FROM product
WHERE product_price IS NOT NULL

--distinct 消除重复行
SELECT DISTINCT product_type_id
FROM product

SELECT DISTINCT product_type_id,product_price
FROM product

--比较操作符
-- = , <> , != , ^= , < , > , <= , >= , any , some , all
-- any替代some
-- any语义明确

SELECT *
FROM product
WHERE product_id=ANY(41,31,35)

SELECT *
FROM product
WHERE product_id>ALL(1,34,29)

--like字符串模式匹配操作符
--两个通配符
--'_':代表任意单个字符
--'%':代表任意长度字符

SELECT *
FROM product
WHERE product_name LIKE '%我%'

--转义符

SELECT *
FROM product
WHERE product_name LIKE '%\%%' ESCAPE '\'

--对于null like 和 not like 均为false

--in 相当于 =any
--in 里出现null 无效
SELECT *
FROM product
WHERE product_id IN (41,31,35,NULL)

--not in 相当于 !=all
SELECT *
FROM product
WHERE product_id NOT IN (41,31,35)

--*******有坑 not in 中不能出现null 否则一行都检索不出来*******
SELECT *
FROM product
WHERE product_id NOT IN (41,31,35，null)

--between x and y : >=x and <=y
--not between x and y 

--多重条件查询 and / or

SELECT *
FROM USERS
WHERE born_date>DATE'1995-10-03' AND NAME LIKE 't%1'

--逻辑求反 not

--运算符优先级:
--比较运算符>not>and>or





--对查询结果排序
--order by asc/desc 默认为asc
--使用列名
SELECT *
FROM product
ORDER BY product_price
--使用序号
SELECT *
FROM product
ORDER BY 3 DESC,2 DESC

--order by 默认null为无穷大
--null last , null first
SELECT *
FROM product
ORDER BY 3 DESC NULLS LAST,2 DESC

SELECT *
FROM product
ORDER BY 3 ASC NULLS LAST,2 DESC










--笛卡尔积，没有连接条件，m*n，没有实际意义，避免
--where里至少需要 n-1个连接条件（n个表）
SELECT *
FROM product,product_type

--多表连接 ：内连接 外连接 自连接
SELECT *
FROM product,product_type
WHERE product.product_type_id=product_type.type_id

--外连接
--左外、右外、全外
--左外：左表连接失败的 保留
--右外：右表连接失败的 保留

--oracle特有表示方式 左外
SELECT *
FROM product,product_type
WHERE product.product_type_id=product_type.type_id(+)
--oracle特有表示方式 右外
SELECT *
FROM product,product_type
WHERE product.product_type_id(+)=product_type.type_id

--SQL/99语法标准
--内连接
--table1 INNER JOIN table2 ON ... AND ...
--table1 INNER JOIN table2 USING(col1,col2,...) 同名列
SELECT p.product_id pid,p.product_price price,t.type_name TYPE
FROM product p INNER JOIN product_type t ON p.product_type_id=t.type_id
ORDER BY 1 ASC


--外连接
--table1 [LEFT|RIGHT|FULL] OUTER JOIN table2 ON ...
SELECT p.product_id pid,p.product_name pname,t.type_name tname
FROM product p LEFT OUTER JOIN product_type t ON p.product_type_id=t.type_id
ORDER BY pid

--交叉连接（笛卡尔积） table1 CROSS JOIN table2
--自然连接（自动使用同名列，不常用） table1 NATURAL JOIN table2










--Oracle函数（各个数据库没有统一标准，都不一样）
--单行函数 聚合函数







--单行函数 对于每条记录运算一次 得到一行结果
--单行函数：字符函数、数值类型、数值和字符串之间的转换函数
-- 日期相关函数 日期与字符串之间的转换函数

--字符函数：
--01. lower upper
--02. ascii chr
--03. length lengthb
--04. lpad rpad
--05. ltrim rtrim trim
--06. substr instr
SELECT *
FROM USERS
WHERE LOWER(NAME)='tonkia'

--instr(查找源,查找字符串)
SELECT u.*,INSTR(LOWER(NAME),'on') idx
FROM USERS u
ORDER BY idx ASC

--ascii 字符->ascii
--chr ascii->字符
SELECT ASCII('A'),CHR(65)
FROM dual

INSERT INTO product(product_id,product_price,product_name)
VALUES(47,100.5,'第一行'||CHR(13)||CHR(10)||'第二行')
--0D0A换行

SELECT *
FROM product
--rtf 富文本
--hex 16进制

--length 字符
SELECT LENGTH('tonkia')
FROM dual

SELECT p.*,LENGTH(p.product_name) LEN
FROM product p

--lengthb 字节
SELECT p.*,LENGTHB(p.product_name) LEN
FROM product p

--lpad rpad 左右填充至指定字符
--中文一个2 width
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

--NVL(常用,为null输出val)
--NVL(x,val)

SELECT p.*,NVL(p.product_price,0) price
FROM product p

--数值函数：
--01. round 四舍五入
--02. trunc 截断
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

--sqrt平方根
SELECT SQRT(3)
FROM dual

--数值和字符串之间的转换函数：
--01. to_char(x,[format])
--02. to_number(x,[format])

--to_char
-- 0有数显示数没数显示0
-- 9表示数值 
-- S正负号
-- D小数点
SELECT to_char(23456.789,'s000000d9999') 
FROM dual
--整数不足 ########
SELECT to_char(23456.789,'s00d9999') 
FROM dual
--小数不足 四舍五入
SELECT to_char(23456.789,'s000000d9') 
FROM dual

--to_number
SELECT to_number('456.123')
FROM dual

--聚合函数
--聚合函数：对一组数据进行操作，并返回一条操作结果
--sum avg 数值
--max min count 数值、字符串（字典排序）、日期数值
--除了count(*) 其他的聚合函数都会忽略null

SELECT AVG(p.product_price),MAX(p.product_price),MIN(p.product_price),COUNT(p.product_id)
FROM product p

--聚合函数配合group by使用
--使用group by：select中列名列表只能使用group by子句中出现的列名 和 聚合函数
SELECT t.type_name,AVG(p.product_price),COUNT(*) COUNT
FROM product p LEFT OUTER JOIN product_type t ON p.product_type_id=t.type_id
GROUP BY t.type_name,t.type_id
HAVING COUNT(*)>=4
--对group by进行限制having

--执行过程
--where->group by->having->输出聚合

--where 作用于表
--having 作用于组





--给表中插入日期类型的数据

--insert
SELECT *
FROM USERS
--插入date 必须使用YYYY-MM-DD的格式
INSERT INTO USERS VALUES(DATE'2018-10-3','f','mike',10)
COMMIT

SELECT *
FROM USERS
WHERE born_date>DATE'1996-10-03'


--日期与字符串之间的转换函数
--to_char(x,[parameter])
--to_date(x,[parameter])

--YYYY 四位的年份
--YY 两位的年份
--MM 两位的月份
--MONTH Month
--MON Mon
--DD
--DAY Day
--Dy
--HH24
--HH
--MI
--SS
--am pm 均能显示上下午

--to_char
SELECT NAME,to_char(born_date,'YYYY-Month-Dy')
FROM USERS

SELECT to_char(DATE'1996-10-03','YYYY/MM/DD HH24:MI:SS')
FROM dual

--to_date
SELECT to_date('1996/10/03','YYYY/MM/DD')
FROM dual

--日期相关函数
--01. add_month(x,y) x加上y个月 y为负则减去
--02. last_day(x) x月的最后一天日期
--03. months_between(x,y) 两个日期的月份差
--04. round(x,[unit]) 对日期进行四舍五入 默认是对天（DD）进行四舍五入
--05. trunc(x,[unit])

SELECT to_char(last_day(SYSDATE),'YYYY-MM-DD')
FROM dual

--sysdate
SELECT u.*,trunc(months_between(SYSDATE,u.born_date)/12) "年龄"
FROM USERS u

SELECT u.*,trunc(months_between(u.born_date,sysdate)/12) "年龄"
FROM USERS u

SELECT u.*,ROUND(u.born_date,'YYYY'),ROUND(u.born_date,'MM')
FROM USERS u

--时间戳 时间类型 timestamp(n) 秒小数点后n位
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
VALUES('敏捷开发',TIMESTAMP'2018-7-30 01:20:30.12345678')





--子查询 最多嵌套255层
--单列子查询 ： 一行一列则为标量子查询
--多列子查询


SELECT * FROM product
SELECT * FROM product_type

--标量子查询
SELECT p.product_id,p.product_type_id,p.product_name
FROM product p
WHERE p.product_type_id=(SELECT t.type_id 
                         FROM product_type t WHERE t.type_name
                         ='游戏'
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
                            
--多列子查询
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
                       
--from 后面跟子查询：内联视图
SELECT nvl(type_id,0) "商品类型id",nvl(type_name,'无类型') "商品类型",tcount "商品数量"
FROM (SELECT p.product_type_id type_id,COUNT(p.product_id)tcount
      FROM product p 
      GROUP BY p.product_type_id
      ) LEFT OUTER JOIN product_type USING (type_id)

--每个类型里的最低价格
SELECT p.*
FROM product p
ORDER BY p.product_type_id ASC,p.product_price ASC
--问题 ：in 里有null值  不输出
SELECT p.*
FROM product p
WHERE (p.product_type_id,p.product_price) IN (SELECT p.product_type_id,MIN(p.product_price)
                                              FROM product p
                                              GROUP BY p.product_type_id
                                              )
ORDER BY p.product_type_id ASC

--关联子查询：对于外部查询中的每一行，子查询都会运行一次
--每个类型里的大于平均价格的商品
SELECT x.*,(SELECT AVG(p.product_price)
                      FROM product p
                      WHERE p.product_type_id=x.product_type_id
                      ) "avg"
FROM  product x
WHERE x.product_price>(SELECT AVG(p.product_price)
                      FROM product p
                      WHERE p.product_type_id=x.product_type_id
                      )

--exist 和 not exist 只关心有没有记录返回
SELECT p.*
FROM product p
WHERE NOT EXISTS (SELECT * FROM product_type t WHERE t.type_id=p.product_type_id)

SELECT p.*
FROM product p
WHERE EXISTS (SELECT * FROM product_type t WHERE t.type_id=p.product_type_id)

SELECT p.*
FROM product p
WHERE p.product_type_id IN (SELECT t.type_id FROM product_type t)

--修改 id31 价格 等于 id34
UPDATE product p SET p.product_price=(SELECT product_price
                                      FROM product
                                      WHERE product_id=34
                                      )
WHERE p.product_id=31
COMMIT

--删除最低价格
SELECT * FROM product ORDER BY product_price

DELETE FROM product p
WHERE p.product_price=(SELECT MIN(product_price)
                        FROM product 
                        )   
   
ROLLBACK                       



--集合操作符
--集合的记录必须具有相同的列和数据类型必须匹配
--列名为第一个集合的列名


--union all 包括重复记录
--union 不包括重复记录
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
--可以组合使用

--decode函数 oracle特有函数
--可以实现  if then else 的逻辑功能
--格式 decode(expr,vlue,result,default)
--nvl

--decode(user.gender,'M','Male','Female')
SELECT u.*,DECODE(u.user_gender,0,'男','女')
FROM user_info u

--SQL/99标准 
--case表达式01
-- case exp
-- when exp1 then res1
-- when exp2 then res2
-- when exp3 then res3
-- ...
-- else default
-- end

SELECT * FROM product_type

SELECT p.*,CASE p.product_type_id 
          WHEN 1 THEN '电影' 
          WHEN 2 THEN '游戏' 
          ELSE '无' 
          END 
FROM product p

--SQL/99标准 
--case表达式02
-- case
-- when exp1 then res1
-- when exp2 then res2
-- when exp3 then res3
-- ...
-- else default
-- end


SELECT * FROM product_type

SELECT p.*,CASE  
           WHEN p.product_type_id=1 THEN '电影' 
           WHEN p.product_type_id=2 THEN '游戏' 
           ELSE '无' 
           END TYPE,
           CASE
           WHEN p.product_price>100 THEN '贵'  
           WHEN p.product_price>50 THEN '可以接受' 
           WHEN p.product_price>0 THEN '便宜'
           ELSE '无感'
           END 
FROM product p

--行转置

--数据准备
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

SELECT s.year YEAR,SUM(CASE MONTH WHEN 1 THEN s.amount ELSE 0 END) "1月",
                   SUM(CASE MONTH WHEN 2 THEN s.amount ELSE 0 END) "2月",
                   SUM(CASE MONTH WHEN 3 THEN s.amount ELSE 0 END) "3月",
                   SUM(CASE MONTH WHEN 4 THEN s.amount ELSE 0 END) "4月",
                   SUM(CASE MONTH WHEN 5 THEN s.amount ELSE 0 END) "5月",
                   SUM(CASE MONTH WHEN 6 THEN s.amount ELSE 0 END) "6月",
                   SUM(CASE MONTH WHEN 7 THEN s.amount ELSE 0 END) "7月",
                   SUM(CASE MONTH WHEN 8 THEN s.amount ELSE 0 END) "8月",
                   SUM(CASE MONTH WHEN 9 THEN s.amount ELSE 0 END) "9月",
                   SUM(CASE MONTH WHEN 10 THEN s.amount ELSE 0 END) "10月",
                   SUM(CASE MONTH WHEN 11 THEN s.amount ELSE 0 END) "11月",
                   SUM(CASE MONTH WHEN 12 THEN s.amount ELSE 0 END) "12月"
FROM sale_info s
GROUP BY s.year

--*******层次查询******* （oracle特有）
--*******分析函数*******

--插入、更新和删除
CREATE TABLE tb_insert(
       ID INT CONSTRAINT pk_insert_id PRIMARY KEY,
       NAME VARCHAR2(50) DEFAULT 'default name'
);

INSERT INTO tb_insert VALUES(1,NULL);
--使用默认值
INSERT INTO tb_insert VALUES(2,DEFAULT);
INSERT INTO tb_insert(ID) VALUES(3);
--插入单引号 用''
INSERT INTO tb_insert VALUES(4,'xi''an')
SELECT * FROM tb_insert

--插入结果集
INSERT INTO tb_insert 
       SELECT p.product_id,p.product_name
       FROM product p
       WHERE p.product_id IN (4,5,6,7,40,41,42,50,51,52)

DELETE FROM tb_insert WHERE NAME IS NULL

--字面量 ‘’=null
ALTER TABLE tb_insert MODIFY NAME NOT NULL
INSERT INTO tb_insert VALUES(1,'');
INSERT INTO tb_insert VALUES(1,NULL);

--update
--UPDATE tableName SET colName = value

UPDATE tb_insert SET ID=10 WHERE ID=2
UPDATE tb_insert SET NAME=NULL WHERE ID=10

--删除
--DELETE FROM tableName WHERE ...
--DELETE FROM tableName WHERE ... (ON DELETE CASCADE 级联删除)
--DELETE FROM tableName WHERE ... (ON DELETE SET NULL 级联置空)
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

--一般数据库不创建约束，在代码层就处理掉， 不然需要写两套代码
--还要处理数据抛出的异常是没有必要的
--不如在插入数据前就做好校验

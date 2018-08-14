-- K M G T P E Z


--PL/SQL(Oracle特有，Oracle对SQL**过程化扩充**而形成的**程序开发语言**)
--过程化程序开发语言：c语言

--PL/SQL只能在oracle里运行
--PL/SQL的特点：
--01. 是一种块结构语言，块中可以嵌小块
--02. 每个块中可以定义变量，变量范围仅限于该块
--03. PL/SQL中 能且只能 执行 *1*查询 *2*DML *3*事务处理语句
--04. 大小写不敏感
--05. Oracle中 PL/SQL引擎 -> PL/SQL程序 ，且PL/SQL程序可以与SQL引擎进行交互

--PL/SQL块 由一下三个部分组成：
--        声明部分（可选）
--        执行部分（必选）
--        异常处理部分（可选）

DECLARE
          /* 声明部分 */
BEGIN 
          /* 执行部分 */
EXCEPTION
          /* 异常处理部分 */
END 

--dbms_output.put_line('xxx')
--SQLPlus 需设置 set serveroutput on
--SQLPlus 以‘/’结束

BEGIN
  dbms_output.put_line('hello world');
END;

--PL/SQL 支持Oracle数据库支持的所有数据类型
--此外还支持如下：
--* binary_integer 性能高，不抛异常
--* pls_integer 性能比binary_integer高，溢出抛异常
--* boolean true、false、null

--变量和操作符
--必须在declare中定义 才能使用 先定义后使用（落后）

--identifier [CONSTANT] datatype [NOT NULL] [:= | DEFAULT expr]
--identifier变量名
--[NOT NULL]不能为空
--[CONSTANT] 常量，必须指定初始值

DECLARE 
  v_name VARCHAR2(100);
  v_age INT DEFAULT 0;
  c_id CONSTANT BINARY_INTEGER :=100;
BEGIN
  dbms_output.put_line(v_name);
  v_name:='zhangsan';
  dbms_output.put_line(v_name);
  dbms_output.put_line(v_age);
  dbms_output.put_line(c_id);
END;
               
--变量名规范 ：字母 数字 _ # $   len<=30   v_变量 c_常量
--没有显示初始化 为null

--嵌套块
--嵌套块中的同名变量优先于外部变量
DECLARE 
  v1 INT := 10**3;
  --10^3
BEGIN
  DECLARE 
    v1 INT := 2;
  BEGIN
    NULL;
    dbms_output.put_line(v1);
  END;
  dbms_output.put_line(v1);
END;

--操作符
--赋值 ：=
--属性提示符 %
--运算符 **
--成员访问符 .
--列名、变量名界定符 “xxx”
--字符串界定和连接符 ‘xxx’||‘xxx’

--使用 %type 来获取变量或者列的数据类型

DECLARE 
  v_prd_name tonkia.product.product_name%TYPE;
  v_1 BINARY_INTEGER NOT NULL :=1;
  v_2 v_1%TYPE :=2;
BEGIN
  dbms_output.put_line(v_1||v_2);
END;

--程序流程控制语句

--判断结构
--IF conditon THEN
--   exp;
--END IF;

--IF condition THEN
--   exp;
--ELSE
--   exp;
--END IF;

--IF condition01 THEN
--   exp01;
--ELSIF conditon02 THEN
--   exp02;
--ELSIF conditon03 THEN
--   exp03;
--...
--END IF;

DECLARE 
  v_prd_name tonkia.product.product_name%TYPE DEFAULT 'tonkia';
BEGIN
  IF v_prd_name IS NULL THEN
     dbms_output.put_line('v_prd_name IS NULL');
  ELSE
     dbms_output.put_line('v_prd_name:'||v_prd_name);
  END IF;
END;

--分支结构
--CASE exp
--WHEN val01 THEN exp01;
--WHEN val02 THEN exp02;
--ELSE def;
--END CASE;

--CASE 
--WHEN condition01 THEN exp01;
--WHEN condition02 THEN exp02;
--ELSE def;
--END CASE;

DECLARE 
      v_date DATE := SYSDATE;
BEGIN
      dbms_output.put_line(to_char(v_date,'YYYY-MM-DD SS:MI:SS'));
END;

--循环结构

--LOOP
--    ...
--    EXIT WHEN condition;
--END LOOP

--LOOP
--    ...
--    IF conditon THEN
--       EXIT;
--    END IF;
--END LOOP;

DECLARE 
      v_count INT :=1;
      v_sum INT :=0;
BEGIN
      LOOP
            v_sum:=v_sum+v_count;
            v_count:=v_count+1;
            EXIT WHEN v_count>100;
      END LOOP;
      dbms_output.put_line('sum is '||v_sum);
END;
--WHILE循环
--WHILE conditon LOOP
--      exp;
--END LOOP;

DECLARE
      v_count INT :=1;
      v_sum INT :=0;
BEGIN
      WHILE v_count<=100 LOOP
            v_sum:=v_sum+v_count;
            v_count:=v_count+1;
      END LOOP;
      dbms_output.put_line('sum is '||v_sum);
END;

--FOR循环
--FOR 计数器 IN 低界..高界 LOOP
--    exp;
--END LOOP;

DECLARE
      v_count INT :=1;
      v_sum INT :=0;
BEGIN
      FOR v_count IN 1..100 LOOP
           v_sum:=v_sum+v_count;
      END LOOP;
      dbms_output.put_line('sum is '||v_sum);
END;

--从表中检索单行数据 into
--      结果集->变量
--      只能返回一条变量 不然会报错

DECLARE 
    v_prd_id tonkia.product.product_id%TYPE;
    v_prd_name tonkia.product.product_name%TYPE;       
BEGIN
    SELECT p.product_id,p.product_name
    INTO v_prd_id,v_prd_name
    FROM tonkia.product p
    WHERE p.product_id=41;
    dbms_output.put_line('id:'||v_prd_id||CHR(10)||'name:'||v_prd_name);
END;

DECLARE 
    v_prd_id tonkia.product.product_id%TYPE;
    v_prd_name tonkia.product.product_name%TYPE;
    v_count INT;       
BEGIN
    --先判断查询结果的条数
    SELECT COUNT(*)
    INTO v_count
    FROM tonkia.product p
    WHERE p.product_id=41;
    
    IF v_count=1 THEN
      SELECT p.product_id,p.product_name
      INTO v_prd_id,v_prd_name
      FROM tonkia.product p
      WHERE p.product_id=41;
      dbms_output.put_line('id:'||v_prd_id||CHR(10)||'name:'||v_prd_name);
    ELSE
      dbms_output.put_line('查询错误！');
    END IF;
END;

--记录类型 相当于类、结构体...
--定义RECORD类型的语法
--TYPE typeName IS RECORD(memberDefineList)

--建议 t_ 前缀 _record_type 后缀
--记录类型变量 _record 后缀

DECLARE 
--定义记录类型
         TYPE t_prd_record_type IS RECORD(
              m_prd_id tonkia.product.product_id%TYPE,
              m_prd_name tonkia.product.product_name%TYPE
         );
--定义记录类型的变量
         v_prd_record t_prd_record_type;          
BEGIN
         SELECT p.p.product_id,p.product_name
         INTO v_prd_record
         FROM product p
         WHERE p.product_id=61;
         
         dbms_output.put_line(v_prd_record.m_prd_id||':'||v_prd_record.m_prd_name);
END;

--记录类型变量互相赋值时均为值拷贝

DECLARE
         TYPE t_my_record_type IS RECORD(
              m1 INT,
              m2 VARCHAR(50)
         );
         
         v1_record t_my_record_type;
         v2_record t_my_record_type;
BEGIN
         v1_record.m1:=100;
         v1_record.m2:='tonkia';
         
         v2_record:=v1_record;
         
         dbms_output.put_line(v2_record.m1||':'||v2_record.m2);
         
         v2_record.m1:=200;
         dbms_output.put_line(v2_record.m1||':'||v2_record.m2);
END;


-- %ROWTYPE 行类型

DECLARE 
   v_prd_record product%ROWTYPE;
BEGIN 
  SELECT *
  INTO v_prd_record
  FROM product p
  WHERE p.product_id=61;
  
  dbms_output.put_line(v_prd_record.product_id||':'||v_prd_record.product_name);
END;

--SELECT INTO只能检索一行 不然会报错
--游标 相当于结果集

--显示游标
--隐式游标（SQL游标）

--显示游标的定义
--CURSOR cursor_name IS select_statemanet
--OPEN cursor_name 
--CLOSE cursor_name
--FETCH cursor_name INTO variableList
--获取游标状态
--cursor_name%NOTFOUND
--cursor_name%FOUND
--cursor_name%ISOPEN
--cursor_name%ROWCOUNT

DECLARE 
        --定义游标
        CURSOR v_prd_cursor IS SELECT * FROM product;
        --定义变量
        v_prd_record product%ROWTYPE;
BEGIN
        --打开游标
        OPEN v_prd_cursor;
        FETCH v_prd_cursor INTO v_prd_record;
        --提取游标
        WHILE v_prd_cursor%FOUND LOOP
          dbms_output.put_line(v_prd_record.product_id||':'||v_prd_record.product_name);
          FETCH v_prd_cursor INTO v_prd_record;
        END LOOP;
        --关闭游标
        CLOSE v_prd_cursor;
END;

--列名的优先级高于变量  变量一定要用V_开头

--游标的For循环
--自动打开 提取 和关闭游标

-- FOR v_xxx_record IN v_product_cursor LOOP
--      ...
-- END LOOP

DECLARE 
        --定义游标
        CURSOR v_prd_cursor IS SELECT * FROM product;
        --定义变量
        v_prd_record product%ROWTYPE;
BEGIN
        FOR v_prd_record IN v_prd_cursor LOOP
          dbms_output.put_line(v_prd_record.product_id||':'||v_prd_record.product_name);
        END LOOP;
END;

--隐式游标 SQL游标
DECLARE 
        CURSOR v_prd_cursor IS SELECT * FROM product p WHERE p.product_price<10;
        v_prd_record v_prd_cursor%ROWTYPE;
        v_count INT DEFAULT 0;
BEGIN
        FOR v_prd_record IN v_prd_cursor LOOP
          UPDATE product p SET p.product_price=p.product_price*10 WHERE p.product_id=v_prd_record.product_id; 
          v_count:=v_count+SQL%ROWCOUNT;
        END LOOP;
        COMMIT;
        dbms_output.put_line('count:'||v_count);
END;

--借助显示游标进行DML操作
--CURSOR cursor_name IS select_query FOR UPDATE [NOWAIT]
--给查询到的记录行加锁，NOWAIT选项是指加锁失败则直接抛出错误

--****更新或删除游标所指向的当前行，使用WHERE CURRENT OF ... 子句****
DECLARE 
        CURSOR v_prd_cursor IS SELECT * FROM product FOR UPDATE;
        v_prd_record v_prd_cursor%ROWTYPE;
        v_count INT DEFAULT 0;
BEGIN
        FOR v_prd_record IN v_prd_cursor LOOP
            IF v_prd_record.product_price<15 THEN
              UPDATE product p SET p.product_price= p.product_price*1.5 WHERE CURRENT OF v_prd_cursor;
              v_count:=v_count+SQL%ROWCOUNT;      
            ELSIF v_prd_record.product_price<100 THEN 
              UPDATE product p SET p.product_price= p.product_price*1.1 WHERE CURRENT OF v_prd_cursor;
              v_count:=v_count+SQL%ROWCOUNT;      
            END IF;
        END LOOP;
        COMMIT;
        dbms_output.put_line('count:'||v_count);
END;

DECLARE 
        CURSOR v_prd_cursor IS SELECT * FROM product FOR UPDATE;
        v_prd_record v_prd_cursor%ROWTYPE;
        v_count INT DEFAULT 0;
BEGIN
        FOR v_prd_record IN v_prd_cursor LOOP
            dbms_output.put_line(v_prd_cursor%ROWCOUNT);
        END LOOP;
        COMMIT;
        dbms_output.put_line('count:'||v_count);
END;

DECLARE 
        CURSOR v_prd_cursor IS SELECT * FROM product FOR UPDATE;
        v_prd_record v_prd_cursor%ROWTYPE;
        v_count INT DEFAULT 0;
BEGIN
        OPEN v_prd_cursor;
        dbms_output.put_line(v_prd_cursor%ROWCOUNT);
        FETCH v_prd_cursor INTO v_prd_record;
        dbms_output.put_line(v_prd_cursor%ROWCOUNT);
        CLOSE v_prd_cursor;
END;

--在PL/SQL语法的基础上
--PL/SQL 块分为两种：匿名块和命名块

--匿名块：以上写的都是匿名块，每次都由客户端发送给Oracle数据库，经过分析编译运行。
--命名块：存储在数据库中，编译一次，以后可多次执行。
--           如：存储过程、存储函数、包、触发器等...
--           存储过程：无返回值
--           存储函数：有返回值
--           包：可以容纳多个过程或函数的容器 相当于类
--           触发器：在合适时机被自动执行

--存储过程 有名称，没有返回值的PL/SQL块
--CREATE OR REPLACE PROCEDURE proc_name
--[(para1 [IN|OUT|IN OUT] type,...)]
--{IS|AS}
--proc_body

--proc_body，不使用DECLARE END后面可以带有过程名

--调用 
--PL/SQL中 直接proc_name(...)
--SQL PLUS中 使用exec proc_name(...)
--如果没有参数 括号可以带或者不带

CREATE OR REPLACE PROCEDURE pr_test
AS

BEGIN
  dbms_output.put_line('Hello TONKIA');
END pr_test;

--调用
BEGIN
  pr_test;
  pr_show_prd(2);
END;

--指定类型编号 输出产品

CREATE OR REPLACE PROCEDURE pr_show_prd(prd_type_id product.product_type_id%TYPE)
AS
       CURSOR v_prd_cursor IS SELECT * FROM product p WHERE p.product_type_id=prd_type_id;
       v_prd_record v_prd_cursor%ROWTYPE;
BEGIN
       FOR v_prd_record IN v_prd_cursor LOOP
         dbms_output.put_line(v_prd_record.product_id||':'||v_prd_record.product_name);
       END LOOP;
END pr_show_prd;

--参数的三种模式（默认为IN）
--IN：实参传给形参，形参为常量，不能修改
--OUT：实参的值被忽略，形参为NULL，调用后形参赋值给实参
--IN OUT：以上两者融合

--根据编号获取价格

CREATE OR REPLACE PROCEDURE pr_get_price(p_prd_id IN product.product_id%TYPE,p_prd_price OUT product.product_price%TYPE)
AS

BEGIN
  --select into 必须且只能返回一行数据
  SELECT NVL(p.product_price,0)
  INTO p_prd_price
  FROM product p
  WHERE p.product_id=p_prd_id;
END pr_get_price;

DECLARE 
    v_prd_id product.product_id%TYPE :=41;
    v_prd_price product.product_price%TYPE;
BEGIN 
    pr_get_price(v_prd_id,v_prd_price);
    dbms_output.put_line(v_prd_id||':'||v_prd_price);
END;

--如果参数使用了out 或者 in out模式，则该参数不能传入字面量或者是表达式
--参数传递时 约束也传递 形参不能有约束 否则报错

CREATE OR REPLACE VIEW v_test
AS --IS 不能用IS
SELECT * FROM product;

DROP VIEW v_test;

--
CREATE OR REPLACE PROCEDURE pr_test_constraint(p_int IN OUT NUMBER/*不能有精度约束*/)
IS

BEGIN
  dbms_output.put_line('p_int:'||p_int);
  p_int:=123456;
END pr_test_constraint;

--参数传递时 约束也传递
DECLARE 
  v_int NUMBER(3.1);
BEGIN
  v_int:=12.5;
  pr_test_constraint(v_int);
  dbms_output.put_line('v_int:'||v_int);
END;

--参数还能默认转换 字符->数值

CREATE OR REPLACE PROCEDURE pr_number(p_int NUMBER)
IS
BEGIN
  dbms_output.put_line('p_int:'||p_int);
END pr_number;

DECLARE 
BEGIN
  pr_number('123');
END;


--调用的时候还能显示的指明实参和形参的对应形式
--         proc(p_1=>v_1,p_2=>v_2)

DECLARE 
  v_int NUMBER:=123;
BEGIN
  pr_test_constraint(p_int=>v_int);
  dbms_output.put_line('v_int:'||v_int);
END;

--函数 function 有返回值的命名块
--创建存储函数
--CREATE [OR REPLACE] FUNCTION func_name
--[(par1 type,...)]
--RETURN return_type
--{IS|AS}
--func_body

--parameter list 是可选的 没有parameter则不需要括号
--return_type 不能有精度和宽度限制

CREATE OR REPLACE FUNCTION f_get_prd_price(p_prd_id product.product_id%TYPE)
RETURN product.product_price%TYPE
IS
       v_count INT :=0;
       v_price product.product_price%TYPE :=0;
BEGIN
       SELECT COUNT(*)
       INTO v_count
       FROM product
       WHERE product_id=p_prd_id;
       
       IF v_count>0 THEN
         SELECT p.product_price
         INTO v_price
         FROM product p
         WHERE product_id=p_prd_id;
       END IF;
       
       RETURN v_price;
END f_get_prd_price;

BEGIN 
  dbms_output.put_line(f_get_prd_price(42));
END;

--函数可以用于SQL语句中 存储过程不行
SELECT f_get_prd_price(41) FROM dual;

CREATE OR REPLACE FUNCTION f_test
RETURN product.product_price%TYPE
IS
       v_price product.product_price%TYPE :=0;
BEGIN
         SELECT p.product_price
         INTO v_price
         FROM product p
         WHERE product_id=31;
       RETURN v_price;
END f_test;

SELECT f_test() FROM dual;

--删除过程和函数
--DROP PROCEDURE proc_name
--DROP FUNCTION func_name

--以上的是全局过程和函数
--局部过程和局部函数
--局部过程和函数应放置在PL/SQL的声明部分，***且只能定义在最后面***

DECLARE
       PROCEDURE pr_show_info(p_type_id INT)
       IS
                 CURSOR v_prd_cursor IS SELECT * FROM product p WHERE p.product_type_id=p_type_id;
                 v_prd_record v_prd_cursor%ROWTYPE;
       BEGIN
                 FOR v_prd_record IN v_prd_cursor LOOP
                   dbms_output.put_line(v_prd_record.product_id||':'||v_prd_record.product_name);
                 END LOOP;
       END pr_show_info;
BEGIN
       pr_show_info(1);
       dbms_output.put_line('--------------------');
       pr_show_info(2);
END;

--包 容器： 类型、变量、游标、过程、函数的逻辑组合
--相当于java里类的概念
--包头 包体

--包头 用来对外公开包内部的组件  供其他程序使用
--     是包与程序其他部分之间的接口
--包头中定义的变量和常量类似于全局变量
--在其他地方均可以使用包名前置使用的变量
--包头的定义只包含过程和函数的首部，没有代码体

--包体 用于提供包头中定义的过程和函数的实现代码

--包体名称必须和包头名称相同 两者配合定义了一个包

--除非包头创建成功 才能创建包体

--创建包头
--CREATE OR REPLACE PACEAGE pkg_name
--{IS|AS}
--  ...
--END pkg_name;


--创建包体
--CREATE OR REPLACE PACKAGE BODY pkg_name
--{IS|AS}
--  ...
--END pkg_name;

--创建包头
CREATE OR REPLACE PACKAGE product_package
IS
       FUNCTION f_get_name(p_id product.product_id%TYPE)
       RETURN VARCHAR2;
       
       PROCEDURE pr_modify(p_id product.product_id%TYPE,p_name product.product_name%TYPE);
       
       e_not_exist EXCEPTION;
END product_package;
--创建包体
CREATE OR REPLACE PACKAGE BODY product_package
IS 
       FUNCTION f_get_name(p_id product.product_id%TYPE)
       RETURN VARCHAR2
       IS
              v_count INT :=0;
              v_name product.product_name%TYPE;
       BEGIN
              SELECT COUNT(*) INTO v_count FROM product p WHERE p.product_id=p_id;
              IF v_count>0 THEN
                SELECT p.product_name INTO v_name FROM product p WHERE p.product_id=p_id;
              END IF;
              RETURN v_name;
       END f_get_name;
       
       PROCEDURE pr_modify(p_id product.product_id%TYPE,p_name product.product_name%TYPE)
       IS
               v_count INT :=0;
       BEGIN
               SELECT COUNT(*) INTO v_count FROM product p WHERE p.product_id=p_id;
               IF v_count >0 THEN
                 UPDATE product p SET p.product_name=p_name WHERE p.product_id=p_id;
               ELSE
                 INSERT INTO product(product_id,product_name) VALUES(p_id,p_name);
               END IF;
               COMMIT;
       END;
END product_package;

SELECT * FROM product;

BEGIN 
  dbms_output.put_line(product_package.f_get_name(34));
  product_package.pr_modify(1,'xian modify');
END;

--不用写包体
CREATE OR REPLACE PACKAGE demo_pkg
IS
       TYPE t_prd_record IS RECORD(m_prd_id product.product_id%TYPE,m_prd_name product.product_name%TYPE);
       CURSOR v_prd_cursor IS SELECT product_id,product_name FROM product;
END demo_pkg;





DECLARE 
   v_prd_record demo_pkg.t_prd_record;
BEGIN
   OPEN demo_pkg.v_prd_cursor;
   FETCH demo_pkg.v_prd_cursor INTO v_prd_record;
   WHILE demo_pkg.v_prd_cursor%FOUND LOOP
      dbms_output.put_line( v_prd_record.m_prd_id||':'||v_prd_record.m_prd_name);
      FETCH demo_pkg.v_prd_cursor INTO v_prd_record;
   END LOOP;
   CLOSE demo_pkg.v_prd_cursor;
END;


--有问题啊...
DECLARE 
  -- v_prd_record demo_pkg.v_prd_cursor%ROWTYPE;
   v_prd_record demo_pkg.t_prd_record;
BEGIN
   FOR v_prd_record IN demo_pkg.v_prd_cursor LOOP
       dbms_output.put_line( v_prd_record.m_prd_id||':'||v_prd_record.m_prd_name);
   -- dbms_output.put_line( v_prd_record.product_id||':'||v_prd_record.product_name);
   END LOOP;
END;


--包内过程和函数的重载


--包的初始化
CREATE OR REPLACE PACKAGE test_init
IS
       v_text VARCHAR2(50);
       PROCEDURE pr_show_text;
END test_init;

CREATE OR REPLACE PACKAGE BODY test_init
IS
       PROCEDURE pr_show_text
       IS
       BEGIN
           dbms_output.put_line(v_text);
       END pr_show_text;
BEGIN
       --初始化
       v_text:='hello world';
END test_init;

BEGIN
  test_init.pr_show_text;
END;


--异常处理
--预定义异常
--非预定义异常
--用户自定义异常

--触发器

--导入导出
--exp SYSTEM/PWD[@SID] file=xxx.dmp full=y              (完全模式)
--exp SYSTEM/pwD[@SID] file=xxx.dmp owner=(u1,u2,...)   (用户模式)
--exp USER/PWD[@SID] file=xxx.dmp table=(t1,t2,...)     (表模式)

--imp SYSTEM/PWD file=xxx.dmp full=y
--imp SYSTEM/PWD file=xxx.dmp fromuser=(...) touser=(...)
--imp USER/PWD file=xxx.dmp table=(...)







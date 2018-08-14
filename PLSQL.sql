-- K M G T P E Z


--PL/SQL(Oracle���У�Oracle��SQL**���̻�����**���γɵ�**���򿪷�����**)
--���̻����򿪷����ԣ�c����

--PL/SQLֻ����oracle������
--PL/SQL���ص㣺
--01. ��һ�ֿ�ṹ���ԣ����п���ǶС��
--02. ÿ�����п��Զ��������������Χ�����ڸÿ�
--03. PL/SQL�� ����ֻ�� ִ�� *1*��ѯ *2*DML *3*���������
--04. ��Сд������
--05. Oracle�� PL/SQL���� -> PL/SQL���� ����PL/SQL���������SQL������н���

--PL/SQL�� ��һ������������ɣ�
--        �������֣���ѡ��
--        ִ�в��֣���ѡ��
--        �쳣�����֣���ѡ��

DECLARE
          /* �������� */
BEGIN 
          /* ִ�в��� */
EXCEPTION
          /* �쳣������ */
END 

--dbms_output.put_line('xxx')
--SQLPlus ������ set serveroutput on
--SQLPlus �ԡ�/������

BEGIN
  dbms_output.put_line('hello world');
END;

--PL/SQL ֧��Oracle���ݿ�֧�ֵ�������������
--���⻹֧�����£�
--* binary_integer ���ܸߣ������쳣
--* pls_integer ���ܱ�binary_integer�ߣ�������쳣
--* boolean true��false��null

--�����Ͳ�����
--������declare�ж��� ����ʹ�� �ȶ����ʹ�ã����

--identifier [CONSTANT] datatype [NOT NULL] [:= | DEFAULT expr]
--identifier������
--[NOT NULL]����Ϊ��
--[CONSTANT] ����������ָ����ʼֵ

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
               
--�������淶 ����ĸ ���� _ # $   len<=30   v_���� c_����
--û����ʾ��ʼ�� Ϊnull

--Ƕ�׿�
--Ƕ�׿��е�ͬ�������������ⲿ����
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

--������
--��ֵ ��=
--������ʾ�� %
--����� **
--��Ա���ʷ� .
--�������������綨�� ��xxx��
--�ַ����綨�����ӷ� ��xxx��||��xxx��

--ʹ�� %type ����ȡ���������е���������

DECLARE 
  v_prd_name tonkia.product.product_name%TYPE;
  v_1 BINARY_INTEGER NOT NULL :=1;
  v_2 v_1%TYPE :=2;
BEGIN
  dbms_output.put_line(v_1||v_2);
END;

--�������̿������

--�жϽṹ
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

--��֧�ṹ
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

--ѭ���ṹ

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
--WHILEѭ��
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

--FORѭ��
--FOR ������ IN �ͽ�..�߽� LOOP
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

--�ӱ��м����������� into
--      �����->����
--      ֻ�ܷ���һ������ ��Ȼ�ᱨ��

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
    --���жϲ�ѯ���������
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
      dbms_output.put_line('��ѯ����');
    END IF;
END;

--��¼���� �൱���ࡢ�ṹ��...
--����RECORD���͵��﷨
--TYPE typeName IS RECORD(memberDefineList)

--���� t_ ǰ׺ _record_type ��׺
--��¼���ͱ��� _record ��׺

DECLARE 
--�����¼����
         TYPE t_prd_record_type IS RECORD(
              m_prd_id tonkia.product.product_id%TYPE,
              m_prd_name tonkia.product.product_name%TYPE
         );
--�����¼���͵ı���
         v_prd_record t_prd_record_type;          
BEGIN
         SELECT p.p.product_id,p.product_name
         INTO v_prd_record
         FROM product p
         WHERE p.product_id=61;
         
         dbms_output.put_line(v_prd_record.m_prd_id||':'||v_prd_record.m_prd_name);
END;

--��¼���ͱ������ำֵʱ��Ϊֵ����

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


-- %ROWTYPE ������

DECLARE 
   v_prd_record product%ROWTYPE;
BEGIN 
  SELECT *
  INTO v_prd_record
  FROM product p
  WHERE p.product_id=61;
  
  dbms_output.put_line(v_prd_record.product_id||':'||v_prd_record.product_name);
END;

--SELECT INTOֻ�ܼ���һ�� ��Ȼ�ᱨ��
--�α� �൱�ڽ����

--��ʾ�α�
--��ʽ�α꣨SQL�α꣩

--��ʾ�α�Ķ���
--CURSOR cursor_name IS select_statemanet
--OPEN cursor_name 
--CLOSE cursor_name
--FETCH cursor_name INTO variableList
--��ȡ�α�״̬
--cursor_name%NOTFOUND
--cursor_name%FOUND
--cursor_name%ISOPEN
--cursor_name%ROWCOUNT

DECLARE 
        --�����α�
        CURSOR v_prd_cursor IS SELECT * FROM product;
        --�������
        v_prd_record product%ROWTYPE;
BEGIN
        --���α�
        OPEN v_prd_cursor;
        FETCH v_prd_cursor INTO v_prd_record;
        --��ȡ�α�
        WHILE v_prd_cursor%FOUND LOOP
          dbms_output.put_line(v_prd_record.product_id||':'||v_prd_record.product_name);
          FETCH v_prd_cursor INTO v_prd_record;
        END LOOP;
        --�ر��α�
        CLOSE v_prd_cursor;
END;

--���������ȼ����ڱ���  ����һ��Ҫ��V_��ͷ

--�α��Forѭ��
--�Զ��� ��ȡ �͹ر��α�

-- FOR v_xxx_record IN v_product_cursor LOOP
--      ...
-- END LOOP

DECLARE 
        --�����α�
        CURSOR v_prd_cursor IS SELECT * FROM product;
        --�������
        v_prd_record product%ROWTYPE;
BEGIN
        FOR v_prd_record IN v_prd_cursor LOOP
          dbms_output.put_line(v_prd_record.product_id||':'||v_prd_record.product_name);
        END LOOP;
END;

--��ʽ�α� SQL�α�
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

--������ʾ�α����DML����
--CURSOR cursor_name IS select_query FOR UPDATE [NOWAIT]
--����ѯ���ļ�¼�м�����NOWAITѡ����ָ����ʧ����ֱ���׳�����

--****���»�ɾ���α���ָ��ĵ�ǰ�У�ʹ��WHERE CURRENT OF ... �Ӿ�****
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

--��PL/SQL�﷨�Ļ�����
--PL/SQL ���Ϊ���֣��������������

--�����飺����д�Ķ��������飬ÿ�ζ��ɿͻ��˷��͸�Oracle���ݿ⣬���������������С�
--�����飺�洢�����ݿ��У�����һ�Σ��Ժ�ɶ��ִ�С�
--           �磺�洢���̡��洢������������������...
--           �洢���̣��޷���ֵ
--           �洢�������з���ֵ
--           �����������ɶ�����̻��������� �൱����
--           ���������ں���ʱ�����Զ�ִ��

--�洢���� �����ƣ�û�з���ֵ��PL/SQL��
--CREATE OR REPLACE PROCEDURE proc_name
--[(para1 [IN|OUT|IN OUT] type,...)]
--{IS|AS}
--proc_body

--proc_body����ʹ��DECLARE END������Դ��й�����

--���� 
--PL/SQL�� ֱ��proc_name(...)
--SQL PLUS�� ʹ��exec proc_name(...)
--���û�в��� ���ſ��Դ����߲���

CREATE OR REPLACE PROCEDURE pr_test
AS

BEGIN
  dbms_output.put_line('Hello TONKIA');
END pr_test;

--����
BEGIN
  pr_test;
  pr_show_prd(2);
END;

--ָ�����ͱ�� �����Ʒ

CREATE OR REPLACE PROCEDURE pr_show_prd(prd_type_id product.product_type_id%TYPE)
AS
       CURSOR v_prd_cursor IS SELECT * FROM product p WHERE p.product_type_id=prd_type_id;
       v_prd_record v_prd_cursor%ROWTYPE;
BEGIN
       FOR v_prd_record IN v_prd_cursor LOOP
         dbms_output.put_line(v_prd_record.product_id||':'||v_prd_record.product_name);
       END LOOP;
END pr_show_prd;

--����������ģʽ��Ĭ��ΪIN��
--IN��ʵ�δ����βΣ��β�Ϊ�����������޸�
--OUT��ʵ�ε�ֵ�����ԣ��β�ΪNULL�����ú��βθ�ֵ��ʵ��
--IN OUT�����������ں�

--���ݱ�Ż�ȡ�۸�

CREATE OR REPLACE PROCEDURE pr_get_price(p_prd_id IN product.product_id%TYPE,p_prd_price OUT product.product_price%TYPE)
AS

BEGIN
  --select into ������ֻ�ܷ���һ������
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

--�������ʹ����out ���� in outģʽ����ò������ܴ��������������Ǳ��ʽ
--��������ʱ Լ��Ҳ���� �ββ�����Լ�� ���򱨴�

CREATE OR REPLACE VIEW v_test
AS --IS ������IS
SELECT * FROM product;

DROP VIEW v_test;

--
CREATE OR REPLACE PROCEDURE pr_test_constraint(p_int IN OUT NUMBER/*�����о���Լ��*/)
IS

BEGIN
  dbms_output.put_line('p_int:'||p_int);
  p_int:=123456;
END pr_test_constraint;

--��������ʱ Լ��Ҳ����
DECLARE 
  v_int NUMBER(3.1);
BEGIN
  v_int:=12.5;
  pr_test_constraint(v_int);
  dbms_output.put_line('v_int:'||v_int);
END;

--��������Ĭ��ת�� �ַ�->��ֵ

CREATE OR REPLACE PROCEDURE pr_number(p_int NUMBER)
IS
BEGIN
  dbms_output.put_line('p_int:'||p_int);
END pr_number;

DECLARE 
BEGIN
  pr_number('123');
END;


--���õ�ʱ������ʾ��ָ��ʵ�κ��βεĶ�Ӧ��ʽ
--         proc(p_1=>v_1,p_2=>v_2)

DECLARE 
  v_int NUMBER:=123;
BEGIN
  pr_test_constraint(p_int=>v_int);
  dbms_output.put_line('v_int:'||v_int);
END;

--���� function �з���ֵ��������
--�����洢����
--CREATE [OR REPLACE] FUNCTION func_name
--[(par1 type,...)]
--RETURN return_type
--{IS|AS}
--func_body

--parameter list �ǿ�ѡ�� û��parameter����Ҫ����
--return_type �����о��ȺͿ������

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

--������������SQL����� �洢���̲���
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

--ɾ�����̺ͺ���
--DROP PROCEDURE proc_name
--DROP FUNCTION func_name

--���ϵ���ȫ�ֹ��̺ͺ���
--�ֲ����̺;ֲ�����
--�ֲ����̺ͺ���Ӧ������PL/SQL���������֣�***��ֻ�ܶ����������***

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

--�� ������ ���͡��������αꡢ���̡��������߼����
--�൱��java����ĸ���
--��ͷ ����

--��ͷ �������⹫�����ڲ������  ����������ʹ��
--     �ǰ��������������֮��Ľӿ�
--��ͷ�ж���ı����ͳ���������ȫ�ֱ���
--�������ط�������ʹ�ð���ǰ��ʹ�õı���
--��ͷ�Ķ���ֻ�������̺ͺ������ײ���û�д�����

--���� �����ṩ��ͷ�ж���Ĺ��̺ͺ�����ʵ�ִ���

--�������Ʊ���Ͱ�ͷ������ͬ ������϶�����һ����

--���ǰ�ͷ�����ɹ� ���ܴ�������

--������ͷ
--CREATE OR REPLACE PACEAGE pkg_name
--{IS|AS}
--  ...
--END pkg_name;


--��������
--CREATE OR REPLACE PACKAGE BODY pkg_name
--{IS|AS}
--  ...
--END pkg_name;

--������ͷ
CREATE OR REPLACE PACKAGE product_package
IS
       FUNCTION f_get_name(p_id product.product_id%TYPE)
       RETURN VARCHAR2;
       
       PROCEDURE pr_modify(p_id product.product_id%TYPE,p_name product.product_name%TYPE);
       
       e_not_exist EXCEPTION;
END product_package;
--��������
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

--����д����
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


--�����Ⱑ...
DECLARE 
  -- v_prd_record demo_pkg.v_prd_cursor%ROWTYPE;
   v_prd_record demo_pkg.t_prd_record;
BEGIN
   FOR v_prd_record IN demo_pkg.v_prd_cursor LOOP
       dbms_output.put_line( v_prd_record.m_prd_id||':'||v_prd_record.m_prd_name);
   -- dbms_output.put_line( v_prd_record.product_id||':'||v_prd_record.product_name);
   END LOOP;
END;


--���ڹ��̺ͺ���������


--���ĳ�ʼ��
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
       --��ʼ��
       v_text:='hello world';
END test_init;

BEGIN
  test_init.pr_show_text;
END;


--�쳣����
--Ԥ�����쳣
--��Ԥ�����쳣
--�û��Զ����쳣

--������

--���뵼��
--exp SYSTEM/PWD[@SID] file=xxx.dmp full=y              (��ȫģʽ)
--exp SYSTEM/pwD[@SID] file=xxx.dmp owner=(u1,u2,...)   (�û�ģʽ)
--exp USER/PWD[@SID] file=xxx.dmp table=(t1,t2,...)     (��ģʽ)

--imp SYSTEM/PWD file=xxx.dmp full=y
--imp SYSTEM/PWD file=xxx.dmp fromuser=(...) touser=(...)
--imp USER/PWD file=xxx.dmp table=(...)







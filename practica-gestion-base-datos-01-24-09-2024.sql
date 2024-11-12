-- Saldarriaga Morales Hugo Mauricio
-- 24/09/2024
-- Grupo: 1

-- Definir variables con cada uno de los tipos de datos soportados en PL/SQL
-- (NUMBER, DATE, CHAR, VARCHAR, VARCHAR2, BOOLEAN,..). Asignar
-- un valor a cada variable e imprimir en pantalla cada variable con su valor.

DECLARE
    num NUMBER(4, 0) := 3402;
    fecha DATE := '23/09/2024';
    ch CHAR(10) := 'Hola';
    varhc VARCHAR(10) := 'Lenguaje';
    varch2 VARCHAR2(10) := 'PL/SQL';
    bool BOOLEAN := TRUE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(num);
    DBMS_OUTPUT.PUT_LINE(fecha);
    DBMS_OUTPUT.PUT_LINE(ch);
    DBMS_OUTPUT.PUT_LINE(varhc);
    DBMS_OUTPUT.PUT_LINE(varch2);
END;

-- Utilizar sentencias Loop While para realizar un programa que sume “n” veces
-- un número aleatorio. Imprimir en pantalla la suma obtenida

DECLARE
    n NUMBER(4, 0) := 20;
    suma NUMBER(4, 0) := 0;
    i NUMBER(4, 0) := 1;
    num NUMBER(4, 0);
BEGIN
    WHILE i <= n LOOP
        num := DBMS_RANDOM.VALUE(1, 10);
        suma := suma + num;
        i := i + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Suma: ' || suma);
END;

-- Utilizando la sentencia FOR escribir un programa que devuelva la cantidad
-- de números múltiplos de 4 que existen del 1 al 100.

DECLARE
    cantidad NUMBER(4, 0) := 0;
BEGIN
    FOR i IN 1..100 LOOP
        IF MOD(i, 4) = 0 THEN
            cantidad := cantidad + 1;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Cantidad de numeros multiplos de 4: ' || cantidad);
END;

--Utilizando la sentencia IF, escribir un bloque anónimo PL/SQL que devuelva
-- un reporte de los empleados que tengan un salario mayor a 2800. El reporte
-- debe mostrarse agrupado por departamentos. Utilizar el esquema de base de
-- datos HR


DECLARE
    v_salario NUMBER(6, 2) := 2800;
    v_id_departamento EMPLOYEES.DEPARTMENT_ID%TYPE;
    v_nombre_departamento DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    v_nombre EMPLOYEES.FIRST_NAME%TYPE;
    v_salario_empleado EMPLOYEES.SALARY%TYPE;
BEGIN
    FOR i IN (SELECT DEPARTMENT_ID, FIRST_NAME, SALARY FROM EMPLOYEES) LOOP
        IF i.SALARY > v_salario THEN
            v_id_departamento := i.DEPARTMENT_ID;
            SELECT DEPARTMENT_NAME INTO v_nombre_departamento FROM DEPARTMENTS WHERE DEPARTMENT_ID = v_id_departamento;
            v_nombre := i.FIRST_NAME;
            v_salario_empleado := i.SALARY;
            DBMS_OUTPUT.PUT_LINE('Departamento: ' || v_nombre_departamento || ' Nombre: ' || v_nombre  || ' Salario: ' || v_salario_empleado);
        END IF;
    END LOOP;
END;

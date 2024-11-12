-- Saldarriaga Morales Hugo Mauricio
-- 08/10/2024

/*
 1.	Un negocio almacena los datos de sus productos en una tabla denominada "productos".
 Dicha tabla contiene el código de producto, el precio, el stock mínimo que se necesita y el stock actual. Si el stock actual es cero,
 es urgente reponer tal producto; menor al stock mínimo requerido, es necesario reponer tal producto; si el stock actual es igual o supera el stock mínimo, está en estado normal.
  - Cree la tabla e ingrese algunos registros.
  - Cree una función que reciba dos valores numéricos correspondientes a ambos stocks. Debe comparar ambos stocks y
 retornar una cadena de caracteres indicando el estado de cada producto, si stock actual es:
   cero: "faltante", menor al stock mínimo: "reponer", igual o superior al stock mínimo: "normal".
 */

CREATE TABLE productos
(
    codigo_producto INT PRIMARY KEY,
    precio          DECIMAL(10, 2),
    stock_minimo    INT,
    stock_actual    INT
);

INSERT INTO productos
VALUES (1, 100.00, 10, 0);

INSERT INTO productos
VALUES (2, 200.00, 10, 5);

INSERT INTO productos
VALUES (3, 300.00, 10, 10);

INSERT INTO productos
VALUES (4, 400.00, 10, 15);

INSERT INTO productos
VALUES (5, 500.00, 10, 20);

CREATE OR REPLACE FUNCTION estado_producto(stock_minimo INT DEFAULT 1, stock_actual INT)
    RETURN VARCHAR2
    IS
BEGIN
    IF stock_actual = 0 THEN
        RETURN 'faltante';
    ELSIF stock_actual < stock_minimo THEN
        RETURN 'reponer';
    ELSE
        RETURN 'normal';
    END IF;
END;
/

SELECT codigo_producto, precio, stock_minimo, stock_actual, estado_producto(stock_minimo, stock_actual) as estado
FROM productos;

/*
 2.	Una empresa almacena los datos de sus empleados en una tabla denominada "empleados".
Cree la tabla con la siguiente estructura:
 */

create table empleados
(
    nombre varchar2(40),
    sueldo number(6, 2)
);

insert into empleados
values ('Acosta Ana', 550);
insert into empleados
values ('Bustos Bernardo', 850);
insert into empleados
values ('Caseros Carolina', 900);
insert into empleados
values ('Dominguez Daniel', 490);
insert into empleados
values ('Fuentes Fabiola', 820);
insert into empleados
values ('Gomez Gaston', 740);
insert into empleados
values ('Huerta Hernan', 1050);

/*
 Realizar una función que incremente los sueldos en forma proporcional, en un 10% cada vez y controlar que la suma
 total de sueldos no sea menor a $7000, si lo es, el bucle debe continuar y volver a incrementar los sueldos, en caso
 de superarlo, se saldrá del ciclo repetitivo; es decir, este bucle continuará el incremento de
 sueldos hasta que la suma de los mismos llegue o supere los 7000.
 */

CREATE OR REPLACE FUNCTION incremento_sueldos
    RETURN NUMBER
    IS
    total_sueldos NUMBER := 0;
BEGIN
    LOOP
        total_sueldos := 0;
        FOR empleado IN (SELECT * FROM empleados)
        LOOP
            empleado.sueldo := empleado.sueldo + (empleado.sueldo * 0.10);
            total_sueldos := total_sueldos + empleado.sueldo;
        END LOOP;
        EXIT WHEN total_sueldos >= 7000;
    END LOOP;
    RETURN total_sueldos;
END;

SELECT incremento_sueldos() as total_sueldos FROM DUAL;


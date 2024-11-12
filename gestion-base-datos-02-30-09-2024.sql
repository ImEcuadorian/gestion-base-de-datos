CREATE TABLE products
(
    id          number PRIMARY KEY,
    name        varchar(50),
    description varchar(100),
    price       number
);

INSERT INTO products
VALUES (1, 'Laptop', 'Laptop HP', 1000);
INSERT INTO products
VALUES (2, 'Mouse', 'Mouse Logitech', 20);
INSERT INTO products
VALUES (3, 'Keyboard', 'Keyboard Genius', 30);
INSERT INTO products
VALUES (4, 'Monitor', 'Monitor Samsung', 500);
INSERT INTO products
VALUES (5, 'Headset', 'Headset Sony', 50);

CREATE OR REPLACE FUNCTION functionIncrement10(value number)
    RETURN number
    IS
BEGIN
    RETURN value + (value * 0.10);
END;

SELECT name, description, price, functionIncrement10(price) FROM products;

CREATE OR REPLACE FUNCTION functionIncrement(value number, incremente number)
    RETURN number
    IS
BEGIN
    RETURN value + (value * incremente / 100);
END;

SELECT name, description, price, functionIncrement(price, 20) FROM products;

CREATE OR REPLACE FUNCTION functionCost(value number)
    RETURN varchar2
    IS
    returnValue varchar2(20);
BEGIN
    returnValue := '';
    IF value < 20 THEN
        returnValue := 'Economico';
    ELSE
        returnValue := 'Caro';
    END IF;
    return returnValue;
END;
/

SELECT name, description, price, functionCost(price) as cost FROM products;

SELECT functionCost(10) FROM DUAL;

CREATE TABLE notas
(
    nombre varchar2(50),
    nota   number(4, 2)
);

insert into notas
values ('Acosta Ana', 67);
insert into notas
values ('Bustos Brenda', 95);
insert into notas
values ('Caseros Carlos', 37);
insert into notas
values ('Dominguez Daniel', 20);
insert into notas
values ('Fuente Federico', 80);
insert into notas
values ('Gonzalez Gaston', 70);
insert into notas
values ('Juarez Juana', 40);
insert into notas
values ('Lopez Luisa', 53);

CREATE OR REPLACE FUNCTION functionCondition(nota number)
    RETURN varchar2
    IS
    condicion varchar2(20);
BEGIN
    condicion := '';
    IF nota < 23 THEN
        condicion := 'Reprobado';
    ELSIF nota >= 23 AND nota < 70 THEN
        condicion := 'Examen Remedial';
    ELSE
        condicion := 'Aprobado';
    END IF;
    return condicion;
END;
/

SELECT nombre, nota, functionCondition(nota) as condicion FROM notas;

CREATE TABLE empleados
(
    document         char(8),
    nombre           varchar2(30),
    fecha_nacimiento date
);

insert into empleados
values ('20111111', 'Acosta Ana', '10/05/1968');
insert into empleados
values ('22222222', 'Bustos Bernardo', '09/07/1970');
insert into empleados
values ('23444444', 'Fuentes Fabiana', '25/01/1972');
insert into empleados
values ('23555555', 'Gomez Gaston', '28/03/1979');
insert into empleados
values ('24666666', 'Juarez Julieta', '18/02/1981');
insert into empleados
values ('25777777', 'Lopez Luis', '17/09/1978');
insert into empleados
values ('26888888', 'Morales Marta', '22/12/1975');

CREATE OR REPLACE FUNCTION functionMonth(fecha date)
    RETURN varchar2
    IS
        mes varchar2(20);
BEGIN
    mes := 'Enero';
    CASE EXTRACT(month from fecha)
        WHEN 1 THEN mes := 'Enero';
        WHEN 2 THEN mes := 'Febrero';
        WHEN 3 THEN mes := 'Marzo';
        WHEN 4 THEN mes := 'Abril';
        WHEN 5 THEN mes := 'Mayo';
        WHEN 6 THEN mes := 'Junio';
        WHEN 7 THEN mes := 'Julio';
        WHEN 8 THEN mes := 'Agosto';
        WHEN 9 THEN mes := 'Septiembre';
        WHEN 10 THEN mes := 'Octubre';
        WHEN 11 THEN mes := 'Noviembre';
        WHEN 12 THEN mes := 'Diciembre';
    END CASE;
    return mes;
end;

SELECT nombre, fecha_nacimiento, functionMonth(fecha_nacimiento) as cumple FROM empleados;

SELECT functionMonth('10/10/2008') FROM DUAL;

-- TSP.GBD

-- Quiero ver los table spaces que tengo en mi base de datos
-- no me acuerdo como se llama la tabla que tiene la informacion de los table spaces

SELECT * FROM dba_tablespaces;

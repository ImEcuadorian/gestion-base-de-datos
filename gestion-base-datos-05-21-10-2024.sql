/*
 Trigger control de que no se ingrese valores negativos en campos de tipo númerico
 Por ejemplo en campos como edad, ventas, etc.
 */

SELECT *
FROM SYSTEM.REPVENTAS;

CREATE OR REPLACE TRIGGER NEGATIVE_CONTROL_TRIGGER
    BEFORE INSERT OR UPDATE
    ON SYSTEM.REPVENTAS
    FOR EACH ROW
    WHEN ( NEW.EDAD < 0 OR NEW.VENTAS < 0 OR NEW.OFICINA_REP < 0 OR NEW.NUM_EMPL < 0 OR NEW.OFICINA_REP < 0 OR NEW
        .CUOTA < 0 OR NEW.DIRECTOR < 0)
BEGIN
    RAISE_APPLICATION_ERROR(-20000, 'No se puede ingresar valores negativos en edad o ventas');
END;

ALTER TRIGGER NEGATIVE_CONTROL_TRIGGER DISABLE;
ALTER TRIGGER NEGATIVE_CONTROL_TRIGGER ENABLE;

INSERT INTO SYSTEM.REPVENTAS
VALUES (112, 'Monica Chavez', -15, 13, 'VPREP', SYSDATE, 105, 5000, 0);

UPDATE SYSTEM.REPVENTAS
SET EDAD = -20
WHERE NUM_EMPL = 112;

UPDATE SYSTEM.REPVENTAS
SET VENTAS = -100
WHERE NUM_EMPL = 112;

/*
 Crear un trigger, solo donde se modifique ciertos cambios cuando se modifica cierto campo
 */

CREATE OR REPLACE TRIGGER UPDATE_PRICE_TRIGGER
    BEFORE UPDATE
        OF PRECIO
    ON SYSTEM.PRODUCTOS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Producto actualizado');
END;

SELECT *
FROM SYSTEM.PRODUCTOS;

UPDATE SYSTEM.PRODUCTOS
SET PRECIO = 60
WHERE ID_FAB = 'ACI'
  AND ID_PRODUCTO = '4100X';

UPDATE SYSTEM.PRODUCTOS
SET DESCRIPCION = 'ESFERO'
WHERE ID_FAB = 'BIC'
  AND ID_PRODUCTO = 'ABCDE';

CREATE OR REPLACE TRIGGER RESTRICT_UPDATE_TRIGGER
    BEFORE UPDATE
    ON SYSTEM.CLIENTES
BEGIN
    RAISE_APPLICATION_ERROR(-20000, 'No se puede modificar valores a la tabla clientes');
END;

SELECT *
FROM SYSTEM.CLIENTES;

UPDATE SYSTEM.CLIENTES
SET LIM_CREDITO = 70000
WHERE NUM_CLIE = 2101;

CREATE OR REPLACE TRIGGER MULTIPLE_CONTROL_TRIGGER
    BEFORE INSERT OR UPDATE OR DELETE
    ON SYSTEM.REPVENTAS
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('Ingreso de registros');
    END IF;
    IF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Actualización de registros');
    END IF;
    IF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('Eliminación de registros');
    END IF;
END;

SELECT *
FROM SYSTEM.REPVENTAS;

INSERT INTO SYSTEM.REPVENTAS
VALUES (113, 'Karla Vera', 19, 11, 'REPV', SYSDATE, 106, 1500, 2);

UPDATE SYSTEM.REPVENTAS
SET EDAD = 20
WHERE NUM_EMPL = 113;

DELETE
FROM SYSTEM.REPVENTAS
WHERE NUM_EMPL = 113;


SELECT TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH24')
FROM DUAL;

CREATE OR REPLACE TRIGGER DAYS_CONTROL_TRIGGER
    BEFORE INSERT OR UPDATE OR DELETE
    ON SYSTEM.OFICINAS

BEGIN
    IF (TRIM(TO_CHAR(SYSDATE, 'DAY')) = 'SABADO') OR (TRIM(TO_CHAR(SYSDATE, 'DAY')) = 'DOMINGO') THEN
        RAISE_APPLICATION_ERROR(-20000, 'No se puede insertar, actualizar o eliminar datos');
    END IF;
END;

SELECT *
FROM SYSTEM.OFICINAS;

INSERT INTO SYSTEM.OFICINAS
VALUES (31, 'Quito', 'Sierra', 106, 8000, 100);

UPDATE SYSTEM.OFICINAS
SET CIUDAD = 'Guayaquil'
WHERE OFICINA = 30;

DELETE
FROM SYSTEM.OFICINAS
WHERE OFICINA = 11;

CREATE OR REPLACE TRIGGER HOURS_CONTROL_TRIGGER
    BEFORE INSERT OR UPDATE OR DELETE
    ON SYSTEM.OFICINAS
BEGIN
    IF (TRIM(TO_CHAR(SYSDATE, 'HH24')) > 11) OR (TRIM(TO_CHAR(SYSDATE, 'HH24')) < 8) THEN
        RAISE_APPLICATION_ERROR(-20000, 'No se puede insertar, actualizar o eliminar datos despues de las 11 y antes de las 8');
    END IF;
END;

INSERT INTO SYSTEM.OFICINAS
VALUES (32, 'Quito', 'Sierra', 106, 8000, 100);


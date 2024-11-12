CREATE TABLE CONTROL
(
    USUARIO VARCHAR2(25),
    FECHA   DATE
);


CREATE OR REPLACE TRIGGER insertProductTrigger
    BEFORE INSERT
    ON PRODUCTOS
BEGIN
    INSERT INTO CONTROL VALUES (USER, SYSDATE);
END;

INSERT INTO PRODUCTOS
VALUES ('ZYX', 'P00-9', 'Celular', 10, 350);

SELECT *
FROM CONTROL;

SELECT *
FROM USER_OBJECTS
WHERE OBJECT_TYPE = 'TRIGGER';

SELECT *
FROM USER_TRIGGERS;

SELECT *
FROM USER_SOURCE
WHERE NAME = 'INSERTPRODUCTTRIGGER';

CREATE OR REPLACE TRIGGER insertPedidosTrigger
    BEFORE INSERT
    ON PEDIDOS
    FOR EACH ROW
DECLARE
    stock number(6, 0);
BEGIN
    SELECT EXISTENCIAS
    INTO stock
    FROM PRODUCTOS
    WHERE ID_FAB := :NEW.FAB
        AND ID_PRODUCTO := :NEW.PRODUCTO;
    IF stock < (:NEW.CANT)
    THEN
        RAISE_APPLICATION_ERROR(-20001, 'No hay suficiente stock');
    ELSE
        UPDATE PRODUCTOS
        SET EXISTENCIAS = EXISTENCIAS - :NEW.CANT
        WHERE ID_FAB := :NEW.FAB
            AND ID_PRODUCTO := :NEW.PRODUCTO;
    END IF;
END;

SELECT *
FROM PEDIDOS;

SELECT MAX(NUM_PEDIDO)
FROM PEDIDOS;

CREATE OR REPLACE TRIGGER deletePedidoTrigger
    BEFORE DELETE
    ON PEDIDOS
    FOR EACH ROW
BEGIN
   UPDATE PRODUCTOS SET EXISTENCIAS = EXISTENCIAS + :OLD.CANT
   WHERE ID_FAB = :OLD.FAB AND ID_PRODUCTO = :OLD.PRODUCTO;
END;

SELECT * FROM PEDIDOS;

DELETE FROM PEDIDOS WHERE NUM_PEDIDO = 113069;

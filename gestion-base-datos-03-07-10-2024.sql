/**
    * 1. Crear un procedimiento que incremente el precio de todos los productos en un 10%.
 */
CREATE OR REPLACE PROCEDURE procedureProducts
AS
BEGIN
    UPDATE PRODUCTOS SET PRECIO = PRECIO + PRODUCTOS.PRECIO * 0.1;
END;
/

SELECT *
FROM PRODUCTOS;

EXECUTE procedureProducts;

/**
    * 2. Crear un procedimiento que incremente el precio de todos los productos de un fabricante en un 10%.
 */
CREATE OR REPLACE PROCEDURE procedureProducts2(FAB IN VARCHAR2)
AS
BEGIN
    UPDATE PRODUCTOS
    SET PRECIO = PRECIO * 1.10
    WHERE ID_FAB = FAB;
END;

CALL procedureProducts2('BIC');

SELECT *
FROM PRODUCTOS;

/**
    3. Crear un procedimiento que incremente el precio de todos los productos de un fabricante en un porcentaje determinado.
 */

CREATE OR REPLACE PROCEDURE procedureProducts3(FAB IN VARCHAR2, PORCENTAJE IN NUMBER DEFAULT 10)
AS
    BEGIN
        UPDATE PRODUCTOS
        SET PRECIO = PRECIO + (PRECIO * PORCENTAJE / 100)
        WHERE ID_FAB = FAB;
    END;
SELECT * FROM PRODUCTOS;
CALL procedureProducts3('BIC', 20);


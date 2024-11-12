/*
 Saldarriaga Morales Hugo
 */

/*
1.	Hacer un trigger que pueda controlar que un estudiante no se pueda matricular en más de 5 materias en un mismo
    periodo.
 */

CREATE OR REPLACE TRIGGER TRG_MAX_MATRICULAS
    BEFORE INSERT OR UPDATE
    ON SYSTEM.DETALLE
    FOR EACH ROW
DECLARE
    NUM_MATERIAS NUMBER;
BEGIN
    SELECT COUNT(*) INTO NUM_MATERIAS FROM SYSTEM.DETALLE WHERE CEDULA = :NEW.CEDULA AND PERIODO = :NEW.PERIODO;
    IF NUM_MATERIAS >= 5 THEN
        RAISE_APPLICATION_ERROR(-20000, 'No se puede matricular en más de 5 materias en un mismo periodo');
    END IF;
END;

INSERT INTO SYSTEM.DETALLE
VALUES (1,
        45419,
        7560,
        21,
        0, 0, 0, 0, 0, 0, 0, 1, 0401142146);
INSERT INTO SYSTEM.DETALLE
VALUES (2,
        45419,
        7560,
        21,
        0, 0, 0, 0, 0, 0, 0, 1, 0401142146);
INSERT INTO SYSTEM.DETALLE
VALUES (3,
        45419,
        7560,
        21,
        0, 0, 0, 0, 0, 0, 0, 1, 0401142146);
INSERT INTO SYSTEM.DETALLE
VALUES (4,
        45419,
        7560,
        21,
        0, 0, 0, 0, 0, 0, 0, 1, 0401142146);
INSERT INTO SYSTEM.DETALLE
VALUES (5,
        45419,
        7560,
        21,
        0, 0, 0, 0, 0, 0, 0, 1, 0401142146);


/*2. Hacer un triggers que cada vez que un estudiante se inscribe en una nueva materia, le calcule el valor a
    cancelar por dicha materia, tomando en cuenta si es primera matricula, segunda matricula o tercera matricula.
•	Si es primera matricula el costo es de 3 dólares la hora.
•	Si es segunda matricula el costo aumenta en un 15%.
•	Si es tercera matricula el costo aumenta un 20%.
 */
CREATE OR REPLACE TRIGGER TRG_CALCULAR_COSTO
    BEFORE INSERT
    ON SYSTEM.DETALLE
    FOR EACH ROW
DECLARE
    COSTO_HORA NUMBER;
    NUM_VECES  NUMBER;
BEGIN
    SELECT COUNT(*) INTO NUM_VECES FROM SYSTEM.DETALLE WHERE CEDULA = :NEW.CEDULA AND ID_MATERIA = :NEW.ID_MATERIA;
    IF NUM_VECES = 0 THEN
        COSTO_HORA := 3;
    ELSIF NUM_VECES = 1 THEN
        COSTO_HORA := 3 * 1.15;
    ELSE
        COSTO_HORA := 3 * 1.20;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Costo por hora: ' || COSTO_HORA);
END;

iNSERT INTO SYSTEM.DETALLE
VALUES (1,
        45419,
        7560,
        21,
        0, 0, 0, 0, 0, 0, 0, 1, 0401142146);

SELECT * FROM GRUPO;
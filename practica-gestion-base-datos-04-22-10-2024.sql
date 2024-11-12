/*
 Saldarriaga Morales Hugo
 Grupo: 2
 Fecha: 22/10/2024
 */

/*
1.	Hacer un trigger que cada vez que se ingresa un pedido en la tabla Pedidos, controle que exista la cantidad
suficiente en stock para la venta, actualice la tabla productos disminuyendo la cantidad pedida de las existencias,
aumente las ventas al vendedor que tomó el pedido y aumente las ventas a la oficina en la cual trabaja el vendedor que tomó el pedido.
 */

CREATE OR REPLACE TRIGGER TRG_CONTROLAR_PEDIDO
    BEFORE INSERT ON PEDIDOS
    FOR EACH ROW
DECLARE
    v_existencias PRODUCTOS.EXISTENCIAS%TYPE;
    v_ventas_rep REPVENTAS.VENTAS%TYPE;
    v_ventas_oficina OFICINAS.VENTAS%TYPE;
BEGIN
    SELECT EXISTENCIAS INTO v_existencias
    FROM PRODUCTOS
    WHERE ID_FAB = :NEW.FAB AND ID_PRODUCTO = :NEW.PRODUCTO;

    IF v_existencias < :NEW.CANT THEN
        RAISE_APPLICATION_ERROR(-20001, 'Stock insuficiente para el producto.');
    END IF;

    UPDATE PRODUCTOS
    SET EXISTENCIAS = EXISTENCIAS - :NEW.CANT
    WHERE ID_FAB = :NEW.FAB AND ID_PRODUCTO = :NEW.PRODUCTO;

    SELECT VENTAS INTO v_ventas_rep
    FROM REPVENTAS
    WHERE NUM_EMPL = :NEW.REP;

    UPDATE REPVENTAS
    SET VENTAS = VENTAS + :NEW.IMPORTE
    WHERE NUM_EMPL = :NEW.REP;

    SELECT OFICINA_REP INTO v_ventas_oficina
    FROM REPVENTAS
    WHERE NUM_EMPL = :NEW.REP;

    UPDATE OFICINAS
    SET VENTAS = VENTAS + :NEW.IMPORTE
    WHERE OFICINA = v_ventas_oficina;

END;
/

/*
 5.	Hacer un trigger que evite que se ingresen o actualicen con valores negativos en los campos de tipo numérico de la tabla Repventas.
 */
CREATE OR REPLACE TRIGGER NEGATIVE_CONTROL_TRIGGER
    BEFORE INSERT OR UPDATE
    ON REPVENTAS
    FOR EACH ROW
    WHEN ( NEW.EDAD < 0 OR NEW.VENTAS < 0 OR NEW.OFICINA_REP < 0 OR NEW.NUM_EMPL < 0 OR NEW.OFICINA_REP < 0 OR
           NEW.CUOTA < 0 OR NEW.DIRECTOR < 0)
BEGIN
    RAISE_APPLICATION_ERROR(-20000, 'No se puede ingresar valores negativos en campos numéricos');
END;

/*
 2.	Hacer un trigger que evite que un estudiante se inscriba en una materia por tercera vez si su promedio
académico es menor a 75 puntos.
 */

CREATE OR REPLACE TRIGGER inscripcion_materia
    BEFORE INSERT
    ON CABECERA_HISTORICO
    FOR EACH ROW
DECLARE
    PROMEDIO NUMBER;
BEGIN
    SELECT NOTA INTO PROMEDIO FROM DETALLE WHERE CEDULA = :NEW.CEDULA;
    IF PROMEDIO < 75 THEN
        RAISE_APPLICATION_ERROR(-20000,
                                'No se puede inscribir en una materia por tercera vez si su promedio es menor a 75 puntos');
    END IF;
end;

/*
 3.		Hacer un trigger que evite que un estudiante se inscriba en una materia por tercera vez si ya ha tomado (inscrito) en 5 materias por tercera vez.
 */

CREATE OR REPLACE TRIGGER trg_limitar_inscripcion_tercera_vez
    BEFORE INSERT OR UPDATE ON DETALLE
    FOR EACH ROW
DECLARE
    veces_inscrita NUMBER;
    total_materias_tercera_vez NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO veces_inscrita
    FROM DETALLE
    WHERE CEDULA = :NEW.CEDULA
      AND ID_MATERIA = :NEW.ID_MATERIA;

    IF veces_inscrita >= 2 THEN
        SELECT COUNT(DISTINCT ID_MATERIA)
        INTO total_materias_tercera_vez
        FROM DETALLE
        WHERE CEDULA = :NEW.CEDULA
          AND (SELECT COUNT(*)
               FROM DETALLE d
               WHERE d.CEDULA = DETALLE.CEDULA
                 AND d.ID_MATERIA = DETALLE.ID_MATERIA) >= 3;

        IF total_materias_tercera_vez >= 5 THEN
            RAISE_APPLICATION_ERROR(-20002, 'El estudiante no puede inscribir una tercera vez en más de 5 materias.');
        END IF;
    END IF;
END;
/


/*
 4.	Hacer un trigger que evite que un docente este asignado a materias cuyos créditos sumen mas de 20 en un mismo periodo.
 */

CREATE OR REPLACE TRIGGER trg_limitar_creditos_docente
    BEFORE INSERT OR UPDATE ON MATERIAXDOCENTE
    FOR EACH ROW
DECLARE
    total_creditos NUMBER;
BEGIN
    SELECT SUM(m.NUMERO_CREDITOS)
    INTO total_creditos
    FROM MATERIAXDOCENTE mx
             JOIN MATERIA m ON mx.ID_MATERIA = m.ID_MATERIA
    WHERE mx.CEDULA = :NEW.CEDULA
      AND mx.ID_GRUPO = :NEW.ID_GRUPO;

    IF total_creditos + (SELECT NUMERO_CREDITOS FROM MATERIA WHERE ID_MATERIA = :NEW.ID_MATERIA) > 20 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El docente tiene asignadas materias que suman más de 20 créditos en el mismo periodo.');
    END IF;
END;

/*
 Saldarriaga Morales Hugo
 Grupo: 2
 Fecha: 15/10/2024
 */

/*
    Hacer un procedimiento almacenado que permita a un estudiante adicionar una nueva materia (inscribirse) los
    parámetros de entrada serían: cedula del estudiante, código de la materia a adicionar, grupo en el cual desea adicionar, período
 */


CREATE OR REPLACE PROCEDURE InscribirMateria(
    p_cedula CHAR(10),
    p_id_materia CHAR(6),
    p_id_grupo NUMBER(6),
    p_periodo NUMBER(6)
)
AS
    v_num_inscripciones INT;
BEGIN

    SELECT COUNT(*)
    INTO v_num_inscripciones
    FROM DETALLE
    WHERE CEDULA = p_cedula
      AND ID_MATERIA = p_id_materia
      AND ID_GRUPO = p_id_grupo
      AND PERIODO = p_periodo;

    IF v_num_inscripciones = 0 THEN
        INSERT INTO DETALLE (ID_GRUPO, CUR_CODIGO, ID_MATERIA, PERIODO, CEDULA)
        VALUES (p_id_grupo, NULL, p_id_materia, p_periodo, p_cedula);
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'El estudiante ya está inscrito en la materia');
    END IF;
END;

EXEC InscribirMateria('0401143649', '7469', 1, 24);


/*
    Hacer un procedimiento almacenado que permita saber cuántos alumnos están matriculados en una materia, en un
    determinado grupo y en un período. Los parámetros de entrada será el código de la materia, el grupo y el período.
 */


CREATE OR REPLACE PROCEDURE ContarEstudiantesMateria(
    p_id_materia CHAR(6),
    p_id_grupo NUMBER(6),
    p_periodo NUMBER(6)
)
AS
    v_num_estudiantes INT;
BEGIN

    SELECT COUNT(*)
    INTO v_num_estudiantes
    FROM DETALLE
    WHERE ID_MATERIA = p_id_materia
      AND ID_GRUPO = p_id_grupo
      AND PERIODO = p_periodo;

    DBMS_OUTPUT.PUT_LINE('Estudiantes inscritos: ' || v_num_estudiantes);
END;

EXEC ContarEstudiantesMateria('7469  ', 1, 24);

/*
 Crear una funcion para ver el prodmedio de un estudiante
 */

CREATE OR REPLACE FUNCTION PromedioEstudiante(
    p_cedula CHAR(10)
)
    RETURN NUMBER
AS
    v_promedio NUMBER;
BEGIN

    SELECT AVG(NOTA)
    INTO v_promedio
    FROM DETALLE
    WHERE CEDULA = p_cedula;

    RETURN v_promedio;
END;

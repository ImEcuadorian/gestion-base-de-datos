/*
 Saldarriaga Morales Hugo Mauricio
 Grupo: 2
 Fecha: 05/11/2024
 */

/*
    1. Hacer un procedimiento almacenado que devuelva(imprima) la cedula, los nombres y apellidos de los estudiantes
    que tengan el más alto promedio. (30 estudiantes)
*/

CREATE OR REPLACE PROCEDURE SP_ESTUDIANTES
AS
BEGIN
    DECLARE
        I NUMBER := 0;
        CURSOR C_ESTUDIANTES IS
            SELECT e.CEDULA, e.NOMBRES, e.APELLIDOS
            FROM ESTUDIANTES e
                     JOIN DETALLE d ON e.CEDULA = d.CEDULA
            GROUP BY e.CEDULA, e.NOMBRES, e.APELLIDOS
            ORDER BY AVG(d.NOTA) DESC;
    BEGIN
        FOR ESTUDIANTES IN C_ESTUDIANTES
            LOOP
                EXIT WHEN I = 30;
                DBMS_OUTPUT.PUT_LINE('Cédula: ' || ESTUDIANTES.CEDULA || ', Nombres: ' || ESTUDIANTES.NOMBRES ||
                                     ', Apellidos: ' || ESTUDIANTES.APELLIDOS);
                I := I + 1;
            END LOOP;
    END;
END;

BEGIN
    SP_ESTUDIANTES;
END;

/*
    2. Hacer un procedimiento almacenado que imprima el nombre de la materia, el grupo y el periodo de las materias en las
    cuales exista la mayor cantidad de estudiantes aprobados (una materia)
*/

CREATE OR REPLACE PROCEDURE SP_MATERIA_MAYOR_APROBADOS
AS
BEGIN
    DECLARE
        I NUMBER := 0;
        CURSOR C_MATERIA IS
            SELECT m.NOMBRE_MATERIA, d.ID_GRUPO, d.PERIODO
            FROM MATERIA m
                     JOIN DETALLE d ON m.ID_MATERIA = d.ID_MATERIA
            WHERE d.ESTADO = 1
            GROUP BY m.NOMBRE_MATERIA, d.ID_GRUPO, d.PERIODO
            ORDER BY COUNT(d.CEDULA) DESC;
    BEGIN
        FOR MATERIA IN C_MATERIA
            LOOP
                EXIT WHEN I = 1;
                DBMS_OUTPUT.PUT_LINE('Materia: ' || MATERIA.NOMBRE_MATERIA || ', Grupo: ' || MATERIA.ID_GRUPO ||
                                     ', Periodo: ' || MATERIA.PERIODO);
                I := I + 1;
            END LOOP;
    END;
END;
/

BEGIN
    SP_MATERIA_MAYOR_APROBADOS;
END;

/*
    3. Hacer un procedimiento almacenado que devuelva los nombres y apellidos de los estudiantes que tengan la más
    alta nota en cada materia, grupo y período.
*/

CREATE OR REPLACE PROCEDURE SP_ESTUDIANTES_MEJOR_NOTA
AS
BEGIN
    DECLARE
        CURSOR C_ESTUDIANTES IS
            SELECT e.NOMBRES, e.APELLIDOS, m.NOMBRE_MATERIA, d.ID_GRUPO, d.PERIODO, d.NOTA
            FROM ESTUDIANTES e
                     JOIN DETALLE d ON e.CEDULA = d.CEDULA
                     JOIN MATERIA m ON d.ID_MATERIA = m.ID_MATERIA
            WHERE d.NOTA = (SELECT MAX(d2.NOTA)
                            FROM DETALLE d2
                            WHERE d2.ID_MATERIA = d.ID_MATERIA
                              AND d2.ID_GRUPO = d.ID_GRUPO
                              AND d2.PERIODO = d.PERIODO)
            ORDER BY m.NOMBRE_MATERIA, d.ID_GRUPO, d.PERIODO;

    BEGIN
        FOR ESTUDIANTES IN C_ESTUDIANTES
            LOOP
                DBMS_OUTPUT.PUT_LINE('Nombres: ' || ESTUDIANTES.NOMBRES ||
                                     ', Apellidos: ' || ESTUDIANTES.APELLIDOS ||
                                     ', Materia: ' || ESTUDIANTES.NOMBRE_MATERIA ||
                                     ', Grupo: ' || ESTUDIANTES.ID_GRUPO ||
                                     ', Periodo: ' || ESTUDIANTES.PERIODO ||
                                     ', Nota: ' || ESTUDIANTES.NOTA);
            END LOOP;
    END;
END;
/

BEGIN
    SP_ESTUDIANTES_MEJOR_NOTA;
END;
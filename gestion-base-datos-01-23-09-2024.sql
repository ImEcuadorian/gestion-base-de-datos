CREATE TABLE Persona
(
    cedula           char(10)    NOT NULL PRIMARY KEY,
    nombres          varchar(50) NOT NULL,
    apellidos        varchar(50) NOT NULL,
    fecha_nacimiento date        NOT NULL,
    edad             number(4, 0),
    sueldo           number(6, 2)
);

INSERT INTO Persona
VALUES ('1234567890', 'Juan', 'Perez', '10/09/2000', 30, 1000);
INSERT INTO Persona
VALUES ('0987654321', 'Maria', 'Lopez', '10/11/2001', 25, 2000);
INSERT INTO Persona
VALUES ('1234567899', 'Pedro', 'Gomez', '13/12/2000', 20, 3000);

SELECT *
FROM Persona;

-- Declaracion de variables y asignacion de valores a las mismas

DECLARE
ci        Persona.cedula%TYPE;
    nom       Persona.nombres%TYPE;
    ape       nom%TYPE;
    fecha_nac DATE                := '23/07/1990';
    ed        NUMBER(4, 0)        := 100;
    sue       Persona.sueldo%TYPE := 5000;
    registro  Persona%ROWTYPE;
BEGIN
SELECT cedula, nombres, apellidos, fecha_nacimiento, edad, sueldo
INTO ci, nom, ape, fecha_nac, ed, sue
FROM Persona
WHERE cedula = '1234567890';

SELECT *
INTO registro
FROM Persona
WHERE cedula = '0987654321';

DBMS_OUTPUT.PUT_LINE(ci);
    DBMS_OUTPUT.PUT_LINE(nom);
    DBMS_OUTPUT.PUT_LINE(ape);
    DBMS_OUTPUT.PUT_LINE(fecha_nac);
    DBMS_OUTPUT.PUT_LINE(ed);
    DBMS_OUTPUT.PUT_LINE(sue);
    DBMS_OUTPUT.PUT_LINE(registro);
END;

-- Sentencia IF

DECLARE
X NUMBER(4, 0) := 10;
    Y NUMBER(4, 0) := 5;
BEGIN
    IF X > Y THEN
        DBMS_OUTPUT.PUT_LINE('X es mayor que Y');
    ELSIF X < Y THEN
        DBMS_OUTPUT.PUT_LINE('X es menor que Y');
ELSE
        DBMS_OUTPUT.PUT_LINE('X es igual a Y');
END IF;
end;

-- Sentencias loop

DECLARE
i NUMBER(4, 0) := 1;
BEGIN
    LOOP
DBMS_OUTPUT.PUT_LINE(i);
        i := i + 1;
        EXIT WHEN i > 20;
END LOOP;
END;

-- Sentencia WHILE

DECLARE
i NUMBER(4, 0) := 1;
BEGIN
    WHILE i <= 20
        LOOP
            DBMS_OUTPUT.PUT_LINE(i);
            i := i + 1;
END LOOP;
END;

-- Sentencia FOR

DECLARE
i NUMBER(4, 0);
BEGIN
    -- FOR i IN REVERSE 1..20
FOR i IN 1..20
        LOOP
            DBMS_OUTPUT.PUT_LINE(i * 2);
END LOOP;
END;


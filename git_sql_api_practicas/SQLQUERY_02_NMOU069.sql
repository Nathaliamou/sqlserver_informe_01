-- Crear vista a partir de la consulta del procedimiento almacenado
CREATE VIEW GanoMateria AS

SELECT DISTINCT
    CONCAT(T01.nombre1_estudiante, ' ', T01.nombre2_estudiante, ' ', T01.apellido1_estudiante, ' ', T01.apellido2_estudiante) AS NombreCompleto,
    T01.id_estudiante, 
    T01.clave_estudiante,
    T03.Ano,
    T03.Periodo,
    CONCAT(T03.NotaC1,'-', T03.NotaDp1,'-', T03.NotaPr1) AS Primer_Momento,
    CONCAT(T03.NotaC2,'-', T03.NotaDp2,'-', T03.NotaPr2) AS Segundo_Momento,
    CONCAT(T03.NotaC3,'-', T03.NotaDp3,'-', T03.NotaPr3) AS Tercer_Momento,
    SUM(T03.NotaC1+T03.NotaDp1+T03.NotaPr1)* 1 AS Nota1,
    SUM(T03.NotaC2+T03.NotaDp2+T03.NotaPr2)* 1.166 AS Nota2,
    SUM(T03.NotaC3+T03.NotaDp3+T03.NotaPr3)* 1.166 AS Nota3,	
    (SUM(T03.NotaC1+T03.NotaDp1+T03.NotaPr1) + SUM(T03.NotaC2+T03.NotaDp2+T03.NotaPr2)* 1.166 + SUM(T03.NotaC3+T03.NotaDp3+T03.NotaPr3)* 1.166) / 100 AS Promedio,
    IIF(SUM((T03.NotaC1 + T03.NotaDp1 + T03.NotaPr1)* 1.0 / 100.0 + (T03.NotaC2 + T03.NotaDp2 + T03.NotaPr2)* 1.166 / 100.0 + (T03.NotaC3 + T03.NotaDp3 + T03.NotaPr3)* 1.166 / 100.0) > 3.5, 'Es competente', 'A�n no es competente') AS Gano_Materia,
    T06.nombre_profesor,
    T06.Correo_Institucional,
    T07.descripcion_materia,
    T08.descripcion_programa
FROM 
    TABLA01 T01, -- Selecciona datos de la tabla de estudiantes.
    TABLA02 T02, -- Selecciona datos de la tabla de asesor�as.
    TABLA09 T09, -- Selecciona datos de la tabla de materias matriculadas.
    TABLA04 T04, -- Selecciona datos de la tabla de notas competencias.
    TABLA05 T05, -- Selecciona datos de la tabla de cupos.
    TABLA06 T06, -- Selecciona datos de la tabla de profesores.
    TABLA07 T07, -- Selecciona datos de la tabla de materias.
    TABLA08 T08 -- Selecciona datos de la tabla de programas.
WHERE 
    T01.codigo_hoja_vida = T02.codigo_hoja_vida
    AND T02.codigo_estudiante = T09.codigo_estudiante
    AND T09.codigo_estudiante = T04.Codigo_Estudiante
    AND T05.codigo_materia_cupo = T09.codigo_materia_cupo
    AND T06.id_profesor = T05.id_profesor
    AND T07.codigo_materia = T05.codigo_materia
    AND T02.codigo_programa = T08.codigo_programa
    AND T01.id1_estudiante IN ('11111', '2222')
    AND T06.Correo_Institucional = 'elprofe'
    AND T07.descripcion_materia = 'Introducci�n a la Programaci�n'
GROUP BY
    T01.nombre1_estudiante,
    T01.nombre2_estudiante,
    T01.apellido1_estudiante,
    T01.apellido2_estudiante,
    T01.id1_estudiante,
    T02.codigo_estudiante,
    T02.codigo_asesoria,
    T02.codigo_programa,
    T02.nivel_estudiante,
    T06.nombre_profesor,
    T06.Correo_Institucional,
    T07.descripcion_materia,
    T08.descripcion_programa,
    T03.Ano,
    T03.Periodo,
    T03.NotaC1,
    T03.NotaDp1,
    T03.NotaPr1,
    T03.NotaC2, 
    T03.NotaDp2, 
    T03.NotaPr2,
    T03.NotaC3,
    T03.NotaDp3,
    T03.NotaPr3;


/* Orden de  resultados ORDER BY NombreCompleto ASC despues al hacer select * from Gano Materia
select * from GanoMateria ORDER BY NombreCompleto ASC; */
SELECT DISTINCT
    CONCAT(HV.nombre1_estudiante, ' ', HV.nombre2_estudiante, ' ', HV.apellido1_estudiante, ' ', HV.apellido2_estudiante) AS NombreCompleto,
    HV.id1_estudiante, 
SELECT DISTINCT
    CONCAT(T01.nombre1_estudiante, ' ', T01.nombre2_estudiante, ' ', T01.apellido1_estudiante, ' ', T01.apellido2_estudiante) AS NombreCompleto,
    T01.id1_estudiante, 
	T01.clave_estudiante,
    T09.codigo_estudiante,
	T05.codigo_materia_cupo,
    T09.periodo,
	T07.descripcion_materia As Subm�dulo,
    T06.nombre_profesor AS nombreProfesor,
    T08.descripcion_programa
FROM 
    TABLA01 T01, -- Selecciona datos de la tabla de estudiantes.
    TABLA02 T02, -- Selecciona datos de la tabla de asesor�as.
    TABLA09 T09, -- Selecciona datos de la tabla de materias matriculadas.
	TABLA04 T04, -- Selecciona datos de la tabla de notas competencias.
    TABLA05 T05, -- Selecciona datos de la tabla de materias cupos.
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
	AND T01.id1_estudiante IN (
        '111111111'
       )

/* Ejemplo de resultados:
   NombreCompleto             | id1_estudiante | clave_estudiante | codigo_estudiante | codigo_materia_cupo         | periodo | Subm�dulo                                    | nombreProfesor | descripcion_programa
   Nathalia Orozco |11111     | 11111111        | 111111    |1111111   | 01      | Emprendedor (Grupos Regulares) | Pendiente      | T�cnico Laboral como Asistente en Desarrollo de Software
*/ 


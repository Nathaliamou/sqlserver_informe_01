CREATE PROCEDURE SP_notas_competentes
AS
BEGIN
    -- Evitar recuento de filas afectadas
    SET NOCOUNT ON;

    -- consulta
    SELECT DISTINCT
         HV.id1_estudiante, 
    CONCAT(HV.apellido1_estudiante, ' ', HV.apellido2_estudiante,' ',HV.nombre1_estudiante, ' ', HV.nombre2_estudiante) AS NombreCompleto,
    --Ase.codigo_estudiante,
	--Ase.codigo_asesoria,
	--Ase.codigo_programa,
	--Ase.nivel_estudiante,
	--faltas (este dato esta en la tabla de materias matrculadas)
	nc.Ano,
    nc.Periodo,
	CONCAT(nc.NotaC1,'-', nc.NotaDp1,'-', nc.NotaPr1) AS Primer_Momento,
	CONCAT(nc.NotaC2,'-', nc.NotaDp2,'-', nc.NotaPr2) AS Segundo_Momento,
	CONCAT(nc.NotaC3,'-', nc.NotaDp3,'-', nc.NotaPr3) AS Tercer_Momento,
	SUM(nc.NotaC1+nc.NotaDp1+nc.NotaPr1)* 1 AS Nota1,
	SUM(nc.NotaC2+nc.NotaDp2+nc.NotaPr2)* 1.166 AS Nota2,
	SUM(nc.NotaC3+nc.NotaDp3+nc.NotaPr3)* 1.166 AS Nota3,	
	(SUM(nc.NotaC1+nc.NotaDp1+nc.NotaPr1) + SUM(nc.NotaC2+nc.NotaDp2+nc.NotaPr2)* 1.166 + SUM(nc.NotaC3+nc.NotaDp3+nc.NotaPr3)* 1.166) / 100 AS Promedio,
	IIF(SUM((nc.NotaC1 + nc.NotaDp1 + nc.NotaPr1)* 1.0 / 100.0 + (nc.NotaC2 + nc.NotaDp2 + nc.NotaPr2)* 1.166 / 100.0 + (nc.NotaC3 + nc.NotaDp3 + nc.NotaPr3)* 1.166 / 100.0) > 3.5, 'Es competente', 'A�n no es competente') AS Gano_Materia,
    prof.nombre_profesor AS nombreProfesor,
	prof.nombre_profesor AS nombreProfesor,
    prof.Correo_Institucional AS correoProfesor,
    Ma.descripcion_materia,
    Pro.descripcion_programa

  --datos de las tablas...
    FROM 
        TABLA01 HV, -- Selecciona datos de la tabla de estudiantes.
        TABLA02 Ase, -- Selecciona datos de la tabla de asesor�as.
        TABLA03 nc, -- Selecciona datos de la tabla de notas competentes.
        TABLA05 cu, -- Selecciona datos de la tabla de materias cupos.
        TABLA06 prof, -- Selecciona datos de la tabla de profesores.
        TABLA07 ma, -- Selecciona datos de la tabla de materias.
        TABLA08 Pro -- Selecciona datos de la tabla de programas.
    
    -- Condiciones de uni�n
    WHERE 
        -- Condiciones (uni�n y filtrado)
		 HV.codigo_hoja_vida = Ase.codigo_hoja_vida -- Realiza una uni�n entre la tabla de estudiantes y la de asesor�as.
    AND Ase.codigo_estudiante = nc.codigo_estudiante -- Realiza una uni�n entre la tabla de asesor�as y la de notas competentes.
    AND cu.codigo_materia_cupo = nc.codigo_materia_cupo -- Realiza una uni�n entre la tabla de materias cupos y la de notas competentes.
    AND prof.id_profesor = cu.id_profesor -- Realiza una uni�n entre la tabla de profesores y la de materias cupos.
    AND ma.codigo_materia = cu.codigo_materia -- Realiza una uni�n entre la tabla de materias y la de materias cupos.
    AND Ase.codigo_programa = Pro.codigo_programa -- Realiza una uni�n entre la tabla de asesor�as y la de programas.
	AND HV.id1_estudiante IN (
    '11111111', -- Selecciona estudiantes por su identificaci�n.
    '22222222'
    )
    AND prof.Correo_Institucional = 'ELMEJOR@X.COM' -- Selecciona profesores por su correo institucional.
    AND Ma.descripcion_materia = 'Introducci�n a la Programaci�n' -- Selecciona materias por su descripci�n.

    -- Agrupar resultados ( columnas especificadas)
    -- Columnas a grupar 
		GROUP BY
    HV.nombre1_estudiante, -- Agrupa por el primer nombre del estudiante.
    HV.nombre2_estudiante, -- Agrupa por el segundo nombre del estudiante.
    HV.apellido1_estudiante, -- Agrupa por el primer apellido del estudiante.
    HV.apellido2_estudiante, -- Agrupa por el segundo apellido del estudiante.
    HV.id1_estudiante, -- Agrupa por la identificaci�n del estudiante.
    Ase.codigo_estudiante, -- Agrupa por el c�digo del estudiante en las asesor�as.
    Ase.codigo_asesoria, -- Agrupa por el c�digo de asesor�a.
    Ase.codigo_programa, -- Agrupa por el c�digo del programa en las asesor�as.
    Ase.nivel_estudiante, -- Agrupa por el nivel del estudiante en las asesor�as.
    prof.nombre_profesor, -- Agrupa por el nombre del profesor.
    prof.Correo_Institucional, -- Agrupa por el correo institucional del profesor.
    Ma.descripcion_materia, -- Agrupa por la descripci�n de la materia.
    Pro.descripcion_programa, -- Agrupa por la descripci�n del programa.
    nc.Ano, -- Agrupa por el a�o en las notas competentes.
    nc.Periodo, -- Agrupa por el per�odo en las notas competentes.
    nc.NotaC1,  -- Agrupa por la nota del primer corte del area evaluativa de CONOCIMIENTO.
    nc.NotaDp1, -- Agrupa por la nota del primer corte del area evaluativa de DESEMPE�O.
    nc.NotaPr1, -- Agrupa por la nota del primer corte del area evaluativa de PRODUCTO.
    nc.NotaC2,  -- Agrupa por la nota del 2do corte  del area evaluativa de CONOCIMIENTO.
    nc.NotaDp2, -- Agrupa por la nota del primer corte del area evaluativa de DESEMPE�O.
    nc.NotaPr2, -- Agrupa por la nota del primer corte del area evaluativa de PRODUCTO.
    nc.NotaC3,  -- Agrupa por la nota del 3er corte  del area evaluativa de CONOCIMIENTO.
    nc.NotaDp3, -- Agrupa por la nota del primer corte del area evaluativa de DESEMPE�O.
    nc.NotaPr3  -- Agrupa por la nota del primer corte del area evaluativa de PRODUCTO.

    -- Orden de  resultados
    ORDER BY NombreCompleto ASC;
END;
Exec  SP_notas_competentes

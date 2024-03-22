SELECT DISTINCT
    CONCAT(T01.nombre1_estudiante, ' ', 
    T01.nombre2_estudiante, ' ', 
    T01.apellido1_estudiante, ' ',     
    T01.apellido2_estudiante) AS NombreCompleto,
    T01.id_estudiante AS T01.ATRIBUTO01, 
    T01.clave_estudiante AS T01.ATRIBUTO02,
    T03.cod_estudiante AS T03.ATRIBUTO01,
    T05.cod_materia_cupo AS T05.ATRIBUTO01,
    T03.periodo AS T03.ATRIBUTO02,
    T07.materia AS T07.ATRIBUTO01,
    T06.nombre_profesor AS T06.ATRIBUTO01,
    T08.programa AS T08.ATRIBUTO01
FROM 
    TABLA_01 T01,
    TABLA_02 T02,
    TABLA_03 T03,
    TABLA_04 T04,
    TABLA_05 T05,
    TABLA_06 T06,
    TABLA_07 T07,
    TABLA_08 T08
WHERE 
    T01.codigo_hoja_vida = T02.codigo_hoja_vida
    AND T02.codigo_estudiante = T03.codigo_estudiante
    AND T03.codigo_estudiante = T04.Codigo_Estudiante
    AND T05.codigo_materia_cupo = T03.codigo_materia_cupo
    AND T06.id_profesor = T05.id_profesor
    AND T07.codigo_materia = T05.codigo_materia
    AND T02.codigo_programa = T08.codigo_programa
    AND T01.id1_estudiante IN ('111111111');

UPDATE T01
SET 
    T01.nota1 = (T02.NotaC1 + T02.NotaDp1 + T02.NotaPr1),
    T01.nota2 = ((T02.NotaC1 + T02.NotaDp1 + T02.NotaPr1) * 35 / 30),
    T01.nota3 = ((T02.NotaC2 + T02.NotaDp2 + T02.NotaPr2) * 35 / 30),
    T01.PC_PM = (SUM(T03.H2, T03.J2) * 1.0) / 100,
    T01.PD_SM = ((SUM(T03.K2, T03.M2) * 35.0 / 30.0) / 100),
    T01.PP_TM = ((SUM(T03.N2, T03.P2) * 35.0 / 30.0) / 100),
    T01.NotaTotal = T01.PC_PM + T01.PD_SM + T01.PP_TM,
    T01.Condicion = IIF(T01.NotaTotal > 3.5, 'Es competente', 'A�n no es competente')
FROM
    TblNotas_Competencias T01
JOIN
    tblMaterias_Matriculadas T02 ON T01.Codigo_Estudiante = T02.codigo_estudiante
    AND T01.Codigo_Materia_Cupo = T02.codigo_materia_cupo
    AND T01.Periodo = T02.periodo
    AND T01.Ano = T02.ano
JOIN
    TblNotas_Competencias T03 ON T01.Codigo_Estudiante = T03.Codigo_Estudiante
WHERE
    T03.Condicion_Establecida
    AND T01.Codigo_Materia_Cupo = '4444444444444'
    AND T01.Codigo_Estudiante IN (SELECT T03.Codigo_Estudiante FROM TblNotas_Competencias T03 WHERE T03.Condicion_Establecida);

SELECT DISTINCT
    T01.Codigo_Estudiante,
    T01.Codigo_Materia_Cupo,
    T01.Periodo,
    T01.Ano,
    T01.NotaC1,
    T01.NotaDp1,
    T01.NotaPr1,
    T01.NotaC2,
    T01.NotaDp2,
    T01.NotaPr2,
    T01.NotaC3,
    T01.NotaDp3,
    T01.NotaPr3,
    T02.nota1,
    T02.nota2,
    T02.nota3
FROM
    TblNotas_Competencias T01
JOIN
    tblMaterias_Matriculadas T02 ON T01.Codigo_Estudiante = T02.codigo_estudiante
    AND T01.Codigo_Materia_Cupo = T02.codigo_materia_cupo
    AND T01.Periodo = T02.periodo
    AND T01.Ano = T02.ano
WHERE
    T01.Codigo_Estudiante = '1111111111111';


Sub insumosFAM97(tipoFAM, insumo97_1, insumo97_2, plantilla97_1, plantilla97_2, plantilla97_3, plantilla97_4, plantilla97_6)

    Application.ScreenUpdating = False
    Application.EnableEvents = False
    Application.DisplayAlerts = False
    
    
    Dim plantillas As Variant
    Dim hojasPrecios As Variant
    
    
    
    Dim wbMacro As Workbook
    Dim plantilla As Variant
    Dim plantillaNombre As String
    
    Dim insumo As Workbook
    Dim insumoNombre As String
    
    
    Dim codTQ As String
    Dim linea As String
    Dim descripcion As String
    Dim presentacion As String
    Dim tipo As String 'tipo[ (vacio)=>REGULAR, (X)=> OFERTA ]
    
    Dim rango As Range
    

    'If tipoFAM = "Mayoristas Grandes" Then
    '    clases = Array("423", "821", "822", "823", "824", "825", "831", "851", "751", "826") '423 debe ir SIEMPRE DE PRIMERO / la 826 es SOLO PARA LA REGIONA 3
    '    plantillas = Array(plantilla97_1, plantilla97_2, plantilla97_3, plantilla97_4, plantilla97_6)
    '    hojasPrecios = Array("Precios REG01", "Precios REG02", "Precios REG03", "Precios REG04", "Precios REG06", "Precios Clases 826")
    'ElseIf tipoFAM = "Mayoristas Pequeños" Then
    '    clases = Array("331", "351", "421") '331 debe ir SIEMPRE DE PRIMERO
    '    plantillas = Array(plantilla97_1, plantilla97_2, plantilla97_3, plantilla97_4)
    '    hojasPrecios = Array("Precios REG01", "Precios REG02", "Precios REG03", "Precios REG04")
    'End If
    
    
    plantillas = Array(plantilla97_1, plantilla97_2, plantilla97_3, plantilla97_4, plantilla97_6)
    'hojasPrecios = Array("Precios REG01", "Precios REG02", "Precios REG03", "Precios REG04", "Precios REG06", "Precios Clases 826")
    
    
    
    Set wbMacro = ActiveWorkbook
    path = ActiveWorkbook.path
    pathBase = Dir(path & "\Bases_90\*.xlsx")
       
    'Workbooks.Open insumo97
    'Set insumo = ActiveWorkbook
    'insumoNombre = Right(insumo97, Len(insumo97) - InStrRev(insumo97, "\")) ' Nombre del archivo con extension
   
   '1. SE ABRE EL INSUMO 1: CLASES 371-471-486
    Workbooks.Open insumo97_1
    Set insumo1 = ActiveWorkbook
    'insumo1Nombre = Right(insumo97_1, Len(insumo97_1) - InStrRev(insumo97_1, "\")) ' Nombre del archivo con extension
   
   '1. SE ABRE EL INSUMO 2: CLASES 481-561
    Workbooks.Open insumo97_2
    Set insumo2 = ActiveWorkbook
    'insumo2Nombre = Right(insumo97_2, Len(insumo97_2) - InStrRev(insumo97_2, "\")) ' Nombre del archivo con extension
    
   
'Z=> para recorrer todas la plantillas
For Z = 0 To UBound(plantillas)

    Workbooks.Open plantillas(Z), False
    Set plantilla = ActiveWorkbook
    plantillaNombre = Right(plantillas(Z), Len(plantillas(Z)) - InStrRev(plantillas(Z), "\")) ' Nombre del archivo con extension
    
    'Se desocultan las hojas que estan en el array de la plantilla
    Dim clasesDesocultar As Variant
    clasesDesocultar = Array("521", "525")
    PlantillasFunciones.mostrarColumnasHojas clasesDesocultar
        
    
   

    '---------------------------------------------------------
    ' INICIO - SACAR PRODUCTOS UNICOS PARA TODAS LA PLANTILLAS
    '---------------------------------------------------------
    
    '-----------------------------------------------------------------------------------------------------------------------
    'HACER UN ARRAY DE insumo1(clase 521) E insumo2(clase 525 + resto clases)
    Dim arrayInsumos As Variant
    arrayInsumos = Array(insumo1, insumo2)
    '--------------------------------------------------
    
    
    '--------------------------------------------------
    Dim arrayHojasPrecios(0 To 1, 1 To 6) As String
    'Dim arrayHojasPrecios(5) As String
    
    'arrayHojasPrecios(0) = "Precios REG01"
    'arrayHojasPrecios(1) = "Precios REG02"
    'arrayHojasPrecios(2) = "Precios REG03"
    'arrayHojasPrecios(3) = "Precios REG04"
    'arrayHojasPrecios(4) = "Precios REG06"
    'arrayHojasPrecios(5) = "Precios Clases 826"
    
    'Hojas para los precios excel 521
    arrayHojasPrecios(0, 1) = "Precios REG01"
    arrayHojasPrecios(0, 2) = "Precios REG02"
    arrayHojasPrecios(0, 3) = "Precios REG03"
    arrayHojasPrecios(0, 4) = "Precios REG04"
    arrayHojasPrecios(0, 5) = "Precios REG06"
    
    
    'Hojas libro precios para 525 + monton clases
    arrayHojasPrecios(1, 1) = "Precios REG01"
    arrayHojasPrecios(1, 2) = "Precios REG02"
    arrayHojasPrecios(1, 3) = "Precios REG03"
    arrayHojasPrecios(1, 4) = "Precios REG04"
    arrayHojasPrecios(1, 5) = "Precios REG06"
    arrayHojasPrecios(1, 6) = "Precios Clases 726"
    '--------------------------------------------------
    
    
    
    
    
    For i = 0 To UBound(arrayInsumos) - 1
        
        arrayInsumos(i).Activate
    
        'Este procedimiento solo lo hace una vez
        'se trata de sacar todos los productos unicos de todas las regionales(1-2-3-4-6)
        'esto para que todas las plantillas tengan el mismo numero de filas sin importar que en una hay un producto y en la otra no este.
        'los productos que esten ena regional y no en la otra se muestra su fila con datos en blanco.
        
        'Nombre de las hojas en el excel de los precios que se actualizan mensualmente.
        'Las hojas deben tener OBLIGADO estos nombres:
        
        If Z = 0 Then
            Sheets.Add
            ActiveSheet.Name = "resumenTD"
            
            For P = 1 To 6 'Numero max. de hojas precios de lso exceles
                If arrayHojasPrecios(i, P) <> "" Then
                    hojaC = arrayHojasPrecios(i, P)
                    arrayInsumos(i).Activate
                    Sheets(hojaC).Select
                    If P = 1 Then
                        Range("B4:H4").Select
                    Else
                        Range("B5:H5").Select
                    End If
                    
                    Range(Selection, Selection.End(xlDown)).Select
                    Selection.Copy
                    Sheets("resumenTD").Select
                    
                    If P = 1 Then
                        Range("A1").Select
                        Selection.PasteSpecial xlPasteValues
                    Else
                        Range("A1").Select
                        Selection.End(xlDown).Offset(1, 0).Select
                        Selection.PasteSpecial xlPasteValues
                    End If
                End If
            Next
            
            'Insumos2: se ponen  en hoja resumenTD del insumo1
            For P = 1 To 6 'Numero max. de hojas precios de lso exceles
                If arrayHojasPrecios(1, P) <> "" Then
                    hojaC = arrayHojasPrecios(1, P)
                    arrayInsumos(1).Activate 'Insumo2: restos de clases + 525
                    Sheets(hojaC).Select
                    Range("B5:H5").Select
                    Range(Selection, Selection.End(xlDown)).Select
                    Selection.Copy
                    
                    arrayInsumos(0).Activate
                    Sheets("resumenTD").Select
                    Range("A1").Select
                    Selection.End(xlDown).Offset(1, 0).Select
                    Selection.PasteSpecial xlPasteValues
                End If
            Next
            
            arrayInsumos(i).Activate
            Sheets("resumenTD").Select
            Range("A1:G1").Select
            Range(Selection, Selection.End(xlDown)).Select
            rangoTD = Selection.Address(ReferenceStyle:=xlR1C1)
            
            
            '------------------------------------------------------------------------------------------
            '26-01-2021
            'Nota: Se agrego codigo para quitar espacios en blanco en la descripcion del producto y en la presentacion
            'esto debido a que en los precios comenzaron a venir el mismo producto pero en una regional con espacios vacios y en las otras sin espacios vacios
            'a la hora de agrupar todos los productos de las regionales para sacar un registro unico de productos estaba creando productos duplicados por los espacios en la descripcion de algunos productos.
            numDatosPre = Range("D" & Rows.Count).End(xlUp).Row
            
            'descripcion prod:
            Range("E:E").EntireColumn.Insert
            Range("E1:E" & numDatosPre).FormulaR1C1 = "=TRIM(RC[1])"
            Range("E:E").Copy
            Range("E:E").PasteSpecial xlPasteValues
            Range("F:F").EntireColumn.Delete
            
            'presentacion:
            Range("F:F").EntireColumn.Insert
            Range("F1:F" & numDatosPre).FormulaR1C1 = "=TRIM(RC[1])"
            Range("F:F").Copy
            Range("F:F").PasteSpecial xlPasteValues
            Range("G:G").EntireColumn.Delete
            '------------------------------------------------------------------------------------------
            
            
            Sheets.Add
            ActiveSheet.Name = "hojaTD"
            ActiveWorkbook.PivotCaches.Create(SourceType:=xlDatabase, SourceData:= _
                "resumenTD" & "!" & rangoTD, Version:=xlPivotTableVersion15).CreatePivotTable TableDestination:= _
                "hojaTD!R1C1", TableName:="TablaDinámica2", DefaultVersion:=xlPivotTableVersion15
            
                
            ActiveWorkbook.ShowPivotTableFieldList = True
            With ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Neg")
                .Orientation = xlRowField
                .Position = 1
            End With
            With ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Lin")
                .Orientation = xlRowField
                .Position = 2
            End With
            With ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Codigo Tq")
                .Orientation = xlRowField
                .Position = 3
            End With
            With ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Descripcion")
                .Orientation = xlRowField
                .Position = 4
            End With
            With ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Presentacion")
                .Orientation = xlRowField
                .Position = 5
            End With
            With ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Oferta")
                .Orientation = xlRowField
                .Position = 6
            End With
        
            ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Neg").Subtotals(1) = False
            ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Lin").Subtotals(1) = False
            ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Codigo Tq").Subtotals(1) = False
            ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Descripcion").Subtotals(1) = False
            ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Presentacion").Subtotals(1) = False
            ActiveSheet.PivotTables("TablaDinámica2").PivotFields("Oferta").Subtotals(1) = False
            
            With ActiveSheet.PivotTables("TablaDinámica2")
                .ColumnGrand = False
                .RowGrand = False
            End With
            
            ActiveSheet.PivotTables("TablaDinámica2").RowAxisLayout xlTabularRow
            ActiveSheet.PivotTables("TablaDinámica2").RepeatAllLabels xlRepeatLabels
            ActiveWorkbook.ShowPivotTableFieldList = False
            Columns("A:F").EntireColumn.AutoFit
            
            Range("A:F").Copy
            Range("A:F").PasteSpecial xlPasteValues
            Range("A:A").EntireColumn.Insert
            Range("G:G").Replace What:="(en blanco)", Replacement:="", LookAt:=xlPart, SearchOrder:=xlByRows, MatchCase:=False, SearchFormat:=False, ReplaceFormat:=False
            
            
            'ADICIONAL LA hojaTD se copia y pega enel otro excel apra que tenga los mismos prod. unicos y no afecte la ejecucion que ya se hizo
            'el codigo de abajo
            'Sheet("hojaTD","resumenTD").copy Destination:=
            'If i = 1 Then
            arrayInsumos(i).Activate
            Sheets("hojaTD").Copy Before:=arrayInsumos(1).Sheets(1)
            Sheets("resumenTD").Copy Before:=arrayInsumos(1).Sheets(2)
            'End If
            
        End If
    
    Next i  'fin de recorrido de 2 insumos
   
    '-----------------------------------------------------------------------------------------------------------------------
    
    
    
    repeticion = 0
    
    If Z = 2 Then
        repeticion = 2
    Else
        repeticion = 1
    End If
    
    
    'Este ciclo hace una repeticion para pasar los datos de precios a la plantilla
    'principalmente para la plantilla 3 que tiene san andres(726), para este caso pasa dos veces por el ciclo pues los datos de esta hoja son diferentes
    'a las de las otras hojas de la plantilla 3
    Dim clases As Variant
    
    For R = 1 To repeticion
        
        For i = 0 To UBound(arrayInsumos)
            arrayInsumos(i).Activate
            
            'Saltar la iteración actual si  r=2 (este actualzando San andres 827 - REG03)
            If R = 2 And i = 0 Then
               GoTo SiguienteIteracion
            End If
            
            If i = 0 Then
                clases = Array("521")
            Else
                 If R = 1 Then
                    clases = Array("525")
                 ElseIf R = 2 Then
                    clases = Array("726")
                 End If
                 
            End If

            Sheets("hojaTD").Select
            If ActiveSheet.AutoFilterMode = True Then
              Range("1:1").AutoFilter
            End If
            
            countInsumo = Range("B" & Rows.Count).End(xlUp).Row
            
            If R = 1 Then
                Range("A2:A" & countInsumo).FormulaR1C1 = "=IFERROR(VLOOKUP(RC[3],'[" & plantillaNombre & "]" & clases(0) & "'!C1,1,0),""NOESTA"")"
            ElseIf R = 2 Then
                Range("A2:A" & countInsumo).FormulaR1C1 = "=IFERROR(VLOOKUP(RC[3],'[" & plantillaNombre & "]726'!C1,1,0),""NOESTA"")"
            End If
            
        
                
            Range("A1").Value = "CodNuevos"
            ActiveSheet.Range("1:1").AutoFilter Field:=1, Criteria1:="=NOESTA"
            Range("I1").Clear
            Range("I1").FormulaR1C1 = "=SUBTOTAL(3,R[1]C1:R[" & countInsumo - 1 & "]C1)"
            filtrados = Range("I1").Value
                    
            If filtrados >= 1 Then
                Rows("2:2").Select
                Range(Selection, Selection.End(xlDown)).Select
                Selection.SpecialCells(xlCellTypeVisible).Select
                Selection.Copy
                Sheets.Add After:=ActiveSheet
                ActiveSheet.Name = "Nuevas"
                Range("A1").Select
                Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks:=False, Transpose:=False
                Application.CutCopyMode = False
                Rows("1:1").EntireRow.Insert
                Sheets("hojaTD").Rows("1:1").Copy Destination:=insumo.Sheets("Nuevas").Range("1:1")
                nuevasCount = Range("A" & Rows.Count).End(xlUp).Row - 1
                
                If nuevasCount >= 1 Then
                    Range("D:D").EntireColumn.Insert
                    Range("D1").Value = "LineaFinal"
                    Range("D2:D" & nuevasCount + 1).FormulaR1C1 = "=IF(LEN(RC[-1])=1,""00""&RC[-1],IF(LEN(RC[-1])=2,""0""&RC[-1],RC[-1]))"
                    Range("D2:D" & nuevasCount + 1).Copy
                    Range("D2:D" & nuevasCount + 1).PasteSpecial xlPasteValues
                    Range("C:C").EntireColumn.Delete
                    Range("C:C").EntireColumn.Insert
                    Range("C1").Value = "NegocioFinal"
                    Range("C2:C" & nuevasCount + 1).FormulaR1C1 = "=IF(LEN(RC[-1])=1,""00""&RC[-1],IF(LEN(RC[-1])=2,""0""&RC[-1],RC[-1]))"
                    Range("C2:C" & nuevasCount + 1).Copy
                    Range("C2:C" & nuevasCount + 1).PasteSpecial xlPasteValues
                    Range("B:B").EntireColumn.Delete
                    Application.CutCopyMode = False
                End If
                
                For a = 1 To nuevasCount
                    arrayInsumos(i).Activate
                    codTQ = Range("D" & (a + 1)).Value
                    linea = Range("C" & (a + 1)).Value
                    descripcion = Range("E" & (a + 1)).Value
                    presentacion = Range("F" & (a + 1)).Value
                    tipo0 = Trim(Range("G" & (a + 1)).Value)
                    negocio = Range("B" & (a + 1)).Value
                    
                    tipo = ""
                    If tipo0 = " " Or tipo0 = "" Or tipo0 = "(en blanco)" Then
                        tipo = "REGULAR"
                    ElseIf tipo0 = "X" Or tipo0 = "x" Then
                        tipo = "OFERTA"
                    End If
                    
                    plantilla.Activate
                    If R = 1 Then
                        Sheets(clases(0)).Select
                    ElseIf R = 2 Then
                        Sheets("726").Select 'Clase de la regional 3(San andres) r=> repeticion
                    End If
          
                    countInsumo = Range("C" & Rows.Count).End(xlUp).Row
                    
                    If tipo = "REGULAR" Then
                        Range("C:C").Select
                        Range("C:C").Find(What:=negocio & " - REGULAR", After:=ActiveCell, LookIn:=xlValues, LookAt:=xlPart, SearchOrder:=xlByRows, SearchDirection:=xlNext, MatchCase:=False, SearchFormat:=False).Offset(0, 0).Select
                        filaNeg = ActiveCell.Row
                        Range("C" & filaNeg & ":C" & countInsumo).Find(What:="Línea: " & linea, After:=ActiveCell, LookIn:=xlValues, LookAt:=xlPart, SearchOrder:=xlByRows, SearchDirection:=xlNext, MatchCase:=False, SearchFormat:=False).Offset(1, 0).Select
                        
                    ElseIf tipo = "OFERTA" Then
                        Range("C:C").Select
                        Range("C:C").Find(What:=negocio & " - OFERTAS", After:=ActiveCell, LookIn:=xlValues, LookAt:=xlPart, SearchOrder:=xlByRows, SearchDirection:=xlNext, MatchCase:=False, SearchFormat:=False).Offset(0, 0).Select
                        filaNeg = ActiveCell.Row
                        Range("C" & filaNeg & ":C" & countInsumo).Find(What:="Línea: " & linea, After:=ActiveCell, LookIn:=xlValues, LookAt:=xlPart, SearchOrder:=xlByRows, SearchDirection:=xlNext, MatchCase:=False, SearchFormat:=False).Offset(1, 0).Select
                        
                    End If
        
                    b = ActiveCell.Row
                    Set rango = Range("C" & b)
                    
                    Rows(b).Insert
                    
                    If b = 17 Then
                        Rows(18).Copy
                    Else
                        Rows(17).Copy 'Que siempre agarre la fila 17 que es donde empieza el primer producto para todas las plantillas, todas las fam.
                    End If
                
                    Rows(b).PasteSpecial Paste:=xlPasteFormulas, Operation:=xlNone, SkipBlanks:=False, Transpose:=False
                    Rows(b).PasteSpecial Paste:=xlPasteFormats, Operation:=xlNone, SkipBlanks:=False, Transpose:=False
                    
                    
                    Range("A" & b).Value = codTQ
                    Range("AI" & b).Value = tipo
                    Range("AJ" & b).Value = 0
                    Range("AY" & b).Value = descripcion
                    Range("BD" & b).Value = presentacion
                    Range("BF" & b).Value = 0
                    Range("BH" & b).Value = ""
            
                Next
                
                arrayInsumos(i).Activate
                arrayInsumos(i).Sheets("Nuevas").Delete
                
            End If
            
            
            arrayInsumos(i).Activate  'hacer un array de insumo1 e insumo2
            
            Select Case Z
                Case 0
                    hojaInsumo = "Precios REG01"
                Case 1
                    hojaInsumo = "Precios REG02"
                Case 2
                    If R = 2 Then
                        hojaInsumo = "Precios Clases 726"
                    Else
                        hojaInsumo = "Precios REG03"
                    End If
                Case 3
                    hojaInsumo = "Precios REG04"
                Case 4
                    hojaInsumo = "Precios REG06"
                
                 
            End Select
            
 
           
            Sheets(hojaInsumo).Select
        
            
            Columns("A:A").ColumnWidth = 13
            countInsumo = Range("B" & Rows.Count).End(xlUp).Row
                        
            Range("B:B").EntireColumn.Insert
            Range("B4").Value = "CLASE/CLIENTE"
        
        
            'FOCO
            
            Range("J:J").EntireColumn.Cut
            Range("AC:AC").Select
            Selection.Insert
                        
            
            
            Range("K:T").EntireColumn.Hidden = True
            
            Range("W4").FormulaR1C1 = "formula1"
            Range("X4").FormulaR1C1 = "formula2"
            Range("Y4").FormulaR1C1 = "formula3"
            Range("Z4").FormulaR1C1 = "Observaciòn"
            Range("AA4").FormulaR1C1 = "Valor Bonificación"
            
            Range("W5:W" & countInsumo).FormulaR1C1 = "=+IF(RC[-13]<>"""",(RIGHT(RC[-13],LEN(RC[-13])-6)),"""")"
            Range("X5:X" & countInsumo).FormulaR1C1 = "=+TRIM(LEFT(RC[-1],2))"
            Range("Y5:Y" & countInsumo).FormulaR1C1 = "=+TRIM(RIGHT(RC[-2],2))"
            Range("Z5:Z" & countInsumo).FormulaR1C1 = "=+IF(RC[-16]<>"""",UPPER(RC[-16]),"""")"
            Range("AA5:AA" & countInsumo).FormulaR1C1 = "=+IF(RC[-2]<>"""",(RC[-3]*RC[-6])/RC[-2],"""")"
        
            With Range("A5:A" & countInsumo)
                .FormulaR1C1 = "=IFERROR(VLOOKUP(RC[5],'[" & plantillaNombre & "]" & clases(0) & "'!C1,1,0),""NOESTA"")"
            End With
        
    
        
            '-------------------------------------------------------
            'PLANTILLA
            '-------------------------------------------------------
            'se valida si hay articulos en la plantilla que no hay en los insumos, para elimminarlos de la plantilla
            plantilla.Activate
            
            If R = 1 Then
            Sheets(clases(0)).Select
            ElseIf R = 2 Then
            Sheets("726").Select 'NUEVO SAN ANDRES
            End If
            
            Range("A:A").Insert
            Columns("A:A").ColumnWidth = 13
            countPlantilla = Range("D" & Rows.Count).End(xlUp).Row
            
            With Range("A17:A" & countPlantilla)
            .FormulaR1C1 = "=IF(OR(RC[1]=""Lin"",RC[1]=""Cod"",RC[1]=""Neg""),0,IFERROR(VLOOKUP(RC[1],'[" & arrayInsumos(i).Name & "]" & hojaInsumo & "'!C6,1,0),""NOESTA""))"
            .Copy
            .PasteSpecial xlPasteValues
            End With
                    
    
            
            'Se registran los datos de Precio Nto Inc. Iva de los insumos a la plantilla
            'aplica Unicamente para REGULARES Y OFERTAS
    
            ActiveSheet.Range("16:16").AutoFilter Field:=36, Criteria1:=Array("REGULAR", "OFERTA"), Operator:=xlFilterValues
            
            'Datos de Precio NTO INC IVA
            Range("AK17:AK" & countPlantilla).Select
            Range("AK17:AK" & countPlantilla).SpecialCells(xlCellTypeVisible).Select
            Range("AK17:AK" & countPlantilla).FormulaR1C1 = "=+IFERROR(VLOOKUP(RC2,'[" & arrayInsumos(i).Name & "]" & hojaInsumo & "'!C6:C52,16,0),"""")"
     
            
            'Datos de OBSERVACIONES
            Range("AL17:AL" & countPlantilla).Select
            Range("AL17:AL" & countPlantilla).SpecialCells(xlCellTypeVisible).Select
            Range("AL17:AL" & countPlantilla).FormulaR1C1 = "=+IFERROR(VLOOKUP(RC2,'[" & arrayInsumos(i).Name & "]" & hojaInsumo & "'!C6:C52,21,0),"""")"
    
            
            'Datos de PX BONIF.
            Range("AM17:AM" & countPlantilla).Select
            Range("AM17:AM" & countPlantilla).SpecialCells(xlCellTypeVisible).Select
            Range("AM17:AM" & countPlantilla).FormulaR1C1 = "=+IFERROR(VLOOKUP(RC2,'[" & arrayInsumos(i).Name & "]" & hojaInsumo & "'!C6:C52,22,0),"""")"
    
            
            
            'Se actualizan tipo (REGULAR / OFERTA)
            Range("AJ17:AJ" & countPlantilla).Select
            Range("AJ17:AJ" & countPlantilla).SpecialCells(xlCellTypeVisible).Select
            Range("AJ17:AJ" & countPlantilla).FormulaR1C1 = "=IFERROR(IF(TRIM(VLOOKUP(RC2,'[" & arrayInsumos(i).Name & "]hojaTD'!C4:C7,4,0))="""",""REGULAR"",IF(TRIM(VLOOKUP(RC2,'[" & arrayInsumos(i).Name & "]hojaTD'!C4:C7,4,0))=""X"",""OFERTA"",""NOEXISTE"")),""NOEXISTE"")"
    
            
            
            'SOLO Mayoristas grandes: Se actuaiza la informaciòn de FOCO.
            'SI EN FOCO TIENE 'SI' se pone la X en a plantilla sino, NO.
            Range("AC17:AC" & countPlantilla).Select
            Range("AC17:AC" & countPlantilla).SpecialCells(xlCellTypeVisible).Select
            Range("AC17:AC" & countPlantilla).FormulaR1C1 = "=IFERROR(IF(TRIM(VLOOKUP(RC2,'[" & arrayInsumos(i).Name & "]" & hojaInsumo & "'!C6:C52,23,0))=""SI"",""X"",""""),"""")"
            Range("AC17:AC" & countPlantilla).HorizontalAlignment = xlCenter
            Range("AC17:AC" & countPlantilla).VerticalAlignment = xlCenter
            Range("AC17:AC" & countPlantilla).Font.Bold = True
    
            
            
            '--------------------------------------------------------------------------------------------------
            'NUEVO: 27-ABRIL-2021
            'Datos de Precio NTO INC IVA(lado plantilla, parta tomar datos de zona gris)
            Range("K17:K" & countPlantilla).Select
            Range("K17:K" & countPlantilla).SpecialCells(xlCellTypeVisible).Select
            Range("K17:K" & countPlantilla).FormulaR1C1 = "=IF(RC[26]<>"""",RC[26],"""")"
            
            'Datos de Precio Bonificacion INC IVA(lado plantilla, parta tomar datos de zona gris)
            Range("L17:L" & countPlantilla).Select
            Range("L17:L" & countPlantilla).SpecialCells(xlCellTypeVisible).Select
            Range("L17:L" & countPlantilla).FormulaR1C1 = "=IF(RC[27]<>"""",RC[27],"""")"
            '--------------------------------------------------------------------------------------------------
        
    
            '--------------------------------------------------------------------------------------------------
            'NUEVO : 20 SEPTIEMBRE 2O21
            'Se actualiza la descripcion y presentacion de los productos, tomandolos del excel de precios del mes.
                    
            'Descripcion
            Range("AZ17:AZ" & countPlantilla).Select
            Range("AZ17:AZ" & countPlantilla).SpecialCells(xlCellTypeVisible).Select
            Range("AZ17:AZ" & countPlantilla).FormulaR1C1 = "=+IFERROR(TRIM(VLOOKUP(RC2,'[" & arrayInsumos(i).Name & "]" & hojaInsumo & "'!C6:C52,2,0)),"""")"
                  
            'Presentacion
            Range("BE17:BE" & countPlantilla).Select
            Range("BE17:BE" & countPlantilla).SpecialCells(xlCellTypeVisible).Select
            Range("BE17:BE" & countPlantilla).FormulaR1C1 = "=+IFERROR(TRIM(VLOOKUP(RC2,'[" & arrayInsumos(i).Name & "]" & hojaInsumo & "'!C6:C52,3,0)),"""")"
    
            'Se eliminan los prodctos sobrantes (que no estan en ninguna de las hojas de insumos)
            ActiveSheet.Range("16:16").AutoFilter Field:=36, Criteria1:=Array("NOEXISTE"), Operator:=xlFilterValues
            Range("A12").ClearContents
            Range("A12").FormulaR1C1 = "=SUBTOTAL(3,R[5]C36:R" & countPlantilla & "C36)"
            filtrados = Range("A12").Value
            Range("A12").ClearContents
            
            'insumo.Sheets("hojaTD").Delete
                
            If filtrados >= 1 Then
                Rows(17 & ":" & countPlantilla).SpecialCells(xlCellTypeVisible).Select
                Selection.EntireRow.Delete
            End If
            
            If ActiveSheet.AutoFilterMode = True Then
              Range("16:16").AutoFilter
            End If
              
            countPlantilla = Range("D" & Rows.Count).End(xlUp).Row
            Range("A:A").Delete
            Range("AI:AI").Select
            Selection.Copy
            Selection.PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            
            
            '--------------------------------------------------------------------------------------------------
            'NUEVO: 20-SEPTIEMBRE-2021
            'Se pega en valores la informacion de codigo Barras, Descripcion y presentacion de los productos
                                
            'descripcion
            Range("AY17:AY" & countPlantilla).Copy
            Range("AY17:AY" & countPlantilla).PasteSpecial xlPasteValues
                    
            'presentacion
            Range("BD17:BD" & countPlantilla).Copy
            Range("BD17:BD" & countPlantilla).PasteSpecial xlPasteValues
            
            Application.CutCopyMode = False
            Range("C2").Select
            '--------------------------------------------------------------------------------------------------
        
        
            'PEGO EL FOCO EN VALORES
            Range("AB:AB").Copy
            Range("AB:AB").PasteSpecial xlPasteValues
            
            Range("AI17:AL" & countPlantilla).Select
            Selection.Copy
            Selection.PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            
    
            'Range("AM15:AM" & countPlantilla).FormulaR1C1 = "=+IF(RC[-38]=R14C1,(LEFT(RC[-36],3)*1),R[-1]C)"
            Range("C2").Select
            
            
            
            '--------------------------------------------------------------------------------
            'NUEVO: 29 SEPT 2021
            'Este cod debe aplicar para todas las fam.
            'Se deben ordenar de  la a-z los productos por cada linea
            'Los paquetes generar un problema muy grande con el ordenamiento por lo cual como algo nuevo en mapas colombia...
            'deben de eliminarse al tirar los precios, y cuando se ejecute la macro de actualizar paquetes que los monte...
            'en la plantillas todos los paquetes como nuevos para no afectar el ordenamiento de datos
            ActiveSheet.Range("16:16").AutoFilter Field:=35, Criteria1:="PAQUETE"
            
            Range("AI15").FormulaR1C1 = "=SUBTOTAL(3,R[2]C35:R" & countPlantilla & "C35)"
            filtradosPaq = Range("AI15").Value
            
            If filtradosPaq >= 1 Then
                Range("17:" & countPlantilla).Select
                Selection.SpecialCells(xlCellTypeVisible).Select
                Selection.EntireRow.Delete
            End If
            
            ActiveSheet.ShowAllData
            ActiveSheet.Range("16:16").AutoFilter
            Range("AI15").ClearContents
            '--------------------------------------------------------------------------------
            
            
            If R = 1 Then
                PlantillasFunciones.ordenarProductosPlantillas clases(0)
                PlantillasFunciones.pintarPlantilla plantillaNombre, clases(0)
            ElseIf R = 2 Then 'Solo regional 3 clase 826(san andres)
                PlantillasFunciones.ordenarProductosPlantillas "726"
                PlantillasFunciones.pintarPlantilla plantillaNombre, "726"
            End If
            
SiguienteIteracion:
        Next i 'FIN DEL RECORRIDO PARA LAS HOJAS CLASES 521 - 525+MONTON
        
        
        'Este proceso solo se repite para la clase 525, la cual tiene los mismos datos para las clases:
        '711 - 721 - 723 - 751 - 781 - 821 - 823
        
        'Para las clases 521 y 726(REG03-SAN ANDRES) Como solo es una clase y no hay mas  ...
        'hojas clases que hereden sus datos no se le hace este proceso.
        
         plantilla.Activate
         If R = 1 Then
             Sheets("711").Name = "1"
             Sheets("721").Name = "2"
             Sheets("723").Name = "3"
             Sheets("751").Name = "4"
             Sheets("781").Name = "5"
             Sheets("821").Name = "6"
             Sheets("823").Name = "7"
            
        
             For h = 1 To 7
                 Sheets("525").Copy After:=ActiveSheet
                 If h = 1 Then
                 ActiveSheet.Name = "711"
                 ElseIf h = 2 Then
                 ActiveSheet.Name = "721"
                 ElseIf h = 3 Then
                 ActiveSheet.Name = "723"
                 ElseIf h = 4 Then
                 ActiveSheet.Name = "751"
                 ElseIf h = 5 Then
                 ActiveSheet.Name = "781"
                 ElseIf h = 6 Then
                 ActiveSheet.Name = "821"
                 ElseIf h = 7 Then
                 ActiveSheet.Name = "823"
                 End If
             Next
             
             Worksheets(Array("1", "2", "3", "4", "5", "6", "7")).Delete
             Sheets(clases(0)).Select
         End If
              
        If R = 1 Then
            PlantillasFunciones.acomodarResumenZona plantillaNombre, clases(0)
        End If
            
    
    Next R 'fin r (REPETICION - SOLO SE USA CUANDO SE ESTA EN PLANTILLA REG3(Z=2) PARA REPETIR PROCESO PERO AHORA EN SAN ANDRES)
        
        
        
        Set plantilla = Nothing
Next 'fin z (PASA A LA PLANTILLA DE LA REG. SIGUIENTE)
    
End Sub




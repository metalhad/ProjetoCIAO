<%
function Aspas(sStr)
	Aspas = Chr(34) & sStr & Chr(34)
end function

function Plics(sStr)
	Plics = Chr(39) & sStr & Chr(39)
end function

'Usar com LCID = 1046
'SetLocale(1046) Ou Session.LCID = 1046 (pt-br)

'fixCurrencyString - Pega uma string completamente formatada como 1.345,98 e transforma em uma string compatível
'com parâmetros de procedures e linguagem SQL: 1345,98
Function fixCurrencyString(sStr)
	'fixCurrencyString = sStr
	fixCurrencyString = Replace(Replace(sStr,".",""),",",".")
End Function

Function FormatExactNumber(sNum)
	If sNum = "" Or IsNull(sNum) Or IsEmpty(sNum) Then
		FormatExactNumber = ""
		Exit Function
	End If
	FormatExactNumber = FormatNumber(sNum,Len(Mid(sNum,InStrRev(sNum,",")+1)),0,0,-1)
End Function

Function openDiscRecordset(oConn,sSQL)
	'On error resume next
	Set openDiscRecordset = Server.CreateObject("ADODB.Recordset")
	With openDiscRecordset
		Set .ActiveConnection = oConn
		.Source = sSQL
		.CursorLocation = adUseClient
		.CursorType = adOpenStatic
		.Open
		Set .ActiveConnection = Nothing
		'If err.number Then
		'	Response.Write "<textarea>" & sSQL & "</textarea>"
		'	Response.End 
		'End If
	End With
End Function

Function openRecordsetForUpdate(oConn,sSQL)
	Set openRecordsetForUpdate = Server.CreateObject("ADODB.Recordset")
	With openRecordsetForUpdate
		Set .ActiveConnection = oConn
		.Source = sSQL
		.CursorLocation = adUseClient
		.CursorType = adOpenStatic
		.LockType = adLockOptimistic
		.Open
	End With
End Function

Function openRecordsetForInsert(oConn,sSQL)
	Set openRecordsetForInsert = Server.CreateObject("ADODB.Recordset")
	With openRecordsetForInsert
		Set .ActiveConnection = oConn
		.CursorLocation = adUseClient
		.LockType = adLockOptimistic
		.Properties("Update Resync") = adResyncAutoIncrement
		.CursorType = adOpenStatic
		.Source = sSQL
		.Open
	End With
End Function

Function createCommand(oConn,iCmdType,sCmdText)
	Set createCommand = Server.CreateObject("ADODB.Command")
	With createCommand
		Set .ActiveConnection = oConn
		.CommandType = iCmdType
		.CommandText = sCmdText
		.NamedParameters = True
	End With
End Function

'fastComboBox - utility function for construction of HTML select lists
'sName - name of the select form control
'sSource - SQL used to open recordset
'sValueField - string used to identify the name of the field that will be used for option values
'sDisplayField - string used to identify the name of the field that will be used for option text
'sSelected - string used to match the selected option, if any option value match this, the option be selected
'sBlankOption - string that contains text that will be used in the first line of select (i.e: --- SELECT BELOW ---)

function fastComboBox(sSource,sConnString,sValueField,sDisplayField,sSelected,sBlankOption,blBuffered)
	Dim iValueFieldIndex
	Dim iDisplayFieldIndex
	Dim sOutput
	Dim isSelected
	Dim i
	Dim rsFast
	Dim allData

	sOutput = ""
	iValueFieldIndex = 0
	iDisplayFieldIndex = 0
	If IsNull(sSelected) Then
		sSelected = ""
	End If
	Set rsFast = Server.CreateObject("ADODB.Recordset")
	rsFast.Open sSource, sConnString
	If Not rsFast.EOF Then
		For i = 0 to rsFast.Fields.Count - 1
			If iValueFieldIndex = 0 AND LCase(rsFast.Fields(i).Name) = LCase(sValueField) Then
				iValueFieldIndex = i
			End If
			If iDisplayFieldIndex = 0 AND LCase(rsFast.Fields(i).Name) = LCase(sDisplayField) Then
				iDisplayFieldIndex = i
			End If
		Next
		allData = rsFast.GetRows
		Set rsFast = nothing
		If sBlankOption <> "" Then
			sOutPut = sOutPut & "<option value="""">" & sBlankOption & "</option>" & vbNewLine
		End If
		For i = 0 to ubound(allData,2)
			If Not IsNull(allData(iValueFieldIndex,i)) Then
				If Cstr(Trim(allData(iValueFieldIndex,i))) = CStr(sSelected) Then
					isSelected = " SELECTED "
				Else
					isSelected = " "
				End If
				sOutput = sOutput & "<option" & isSelected & "value=" & Aspas(Trim(allData(iValueFieldIndex,i))) & ">" & allData(iDisplayFieldIndex,i) & "</option>" & vbNewLine
			End If
		Next
	ElseIf sBlankOption <> "" Then
		sOutPut = sOutPut & "<option value="""">--- ---</option>" & vbNewLine
	End If
	If blBuffered = 1 Then
		fastComboBox = sOutPut
	Else
		fastComboBox = sOutPut
		Response.Write sOutPut
	End If
end function

'/***********************/
'/*Início da Função*/
'/***********************/

'The same as above function, but has option to embed custom attributes to options tags
function fastCustomComboBox(sSource,sConnString,sValueField,sDisplayField,sSelected,sBlankOption,blBuffered,sCustomAttribsFields)
	Dim iValueFieldIndex
	Dim iDisplayFieldIndex
	Dim sOutput
	Dim isSelected
	Dim i
	Dim rsFast
	Dim allData
	Dim dtcCustomAttribs
	Dim iCommaPos
	Dim sKey
	Dim aryAttribs

	Set dtcCustomAttribs = Server.CreateObject("Scripting.Dictionary")
	aryAttribs = Split(sCustomAttribsFields,",")
	For i = 0 to ubound(aryAttribs)
		sKey = aryAttribs(i)
		dtcCustomAttribs.Add sKey,""
	Next
	sOutput = ""
	iValueFieldIndex = 0
	iDisplayFieldIndex = 0
	Set rsFast = Server.CreateObject("ADODB.Recordset")

	rsFast.Open sSource,sConnString
	If Not rsFast.EOF Then
		For i = 0 to rsFast.Fields.Count - 1
			If iValueFieldIndex = 0 AND LCase(rsFast.Fields(i).Name) = LCase(sValueField) Then
				iValueFieldIndex = i
			End If
			If iDisplayFieldIndex = 0 AND LCase(rsFast.Fields(i).Name) = LCase(sDisplayField) Then
				iDisplayFieldIndex = i
			End If
			If dtcCustomAttribs.Exists(rsFast.Fields(i).Name) Then
				dtcCustomAttribs.Item(rsFast.Fields(i).Name) = i
			End If

		Next
		allData = rsFast.GetRows
		Set rsFast = nothing

		If sBlankOption <> "" Then
			sOutPut = sOutPut & "<option value="""" "
			For Each sKey in dtcCustomAttribs.Keys
				sOutPut = sOutPut & UCASE(sKey) & "=" & Aspas("") & " "
			Next
			sOutPut = sOutPut & ">" & sBlankOption & "</option>" & vbNewLine
		End If

		For i = 0 to ubound(allData,2)
			If Not IsNull(allData(iValueFieldIndex,i)) Then
				If Cstr(Trim(allData(iValueFieldIndex,i))) = CStr(sSelected) Then
					isSelected = " SELECTED "
				Else
					isSelected = " "
				End If
				sOutput = sOutput & "<option " & isSelected & "value=" & Aspas(Trim(allData(iValueFieldIndex,i)))
				For Each sKey In dtcCustomAttribs.Keys
					sOutput = sOutPut & " " & UCASE(sKey) & "=" & Aspas(allData(dtcCustomAttribs.Item(sKey),i))
					if allData(dtcCustomAttribs.Item(sKey),i) = "Falso" or allData(dtcCustomAttribs.Item(sKey),i) = "False" then sOutPut = sOutPut & " style='background-color:#DDDDDD' "
				Next
				sOutPut = sOutPut & " >" & allData(iDisplayFieldIndex,i) & "</option>" & vbNewLine
			End If
		Next
	ElseIf sBlankOption <> "" Then
		sOutPut = sOutPut & "<option value="""">--- ---</option>" & vbNewLine
	End If

	If blBuffered = 1 Then
		fastCustomComboBox = sOutPut
	Else
		fastCustomComboBox = sOutPut
		Response.Write sOutPut
	End If
end function

'/***********************/
'/*Fim da Função*/
'/***********************/


'fastComboEof - utility function for construction of HTML select lists
'sName - name of the select form control
'sSource - SQL used to open recordset
'sValueField - string used to identify the name of the field that will be used for option values
'sDisplayField - string used to identify the name of the field that will be used for option text
'sSelected - string used to match the selected option, if any option value match this, the option be selected
'sBlankOption - string that contains text that will be used in the first line of select (i.e: --- SELECT BELOW ---)
'sEofDisplay  - string that will be the only option if the sBlankOption is not empty and the recordset is empty

function fastComboEof(sSource,sConnString,sValueField,sDisplayField,sSelected,sBlankOption,blBuffered,sEofDisplay)
	Dim iValueFieldIndex
	Dim iDisplayFieldIndex
	Dim sOutput
	Dim isSelected
	Dim i
	Dim rsFast
	Dim allData

	sOutput = ""
	iValueFieldIndex = 0
	iDisplayFieldIndex = 0
	If IsNull(sSelected) Then
		sSelected = ""
	End If
	Set rsFast = Server.CreateObject("ADODB.Recordset")
	rsFast.Open sSource,sConnString
	If Not rsFast.EOF Then
		For i = 0 to rsFast.Fields.Count - 1
			If iValueFieldIndex = 0 AND LCase(rsFast.Fields(i).Name) = LCase(sValueField) Then
				iValueFieldIndex = i
			End If
			If iDisplayFieldIndex = 0 AND LCase(rsFast.Fields(i).Name) = LCase(sDisplayField) Then
				iDisplayFieldIndex = i
			End If
		Next
		allData = rsFast.GetRows
		Set rsFast = nothing
		If sBlankOption <> "" Then
			sOutPut = sOutPut & "<option value="""">" & sBlankOption & "</option>" & vbNewLine
		End If
		For i = 0 to ubound(allData,2)
			If Not IsNull(allData(iValueFieldIndex,i)) Then
				If Cstr(Trim(allData(iValueFieldIndex,i))) = CStr(sSelected) Then
					isSelected = " SELECTED "
				Else
					isSelected = " "
				End If
				sOutput = sOutput & "<option" & isSelected & "value=" & Aspas(Trim(allData(iValueFieldIndex,i))) & ">" & allData(iDisplayFieldIndex,i) & "</option>" & vbNewLine
			End If
		Next
	ElseIf sBlankOption <> "" Then
		sOutPut = sOutPut & "<option value="""">" & sEofDisplay & "</option>" & vbNewLine
	End If
	If blBuffered = 1 Then
		fastComboEof = sOutPut
	Else
		fastComboEof = sOutPut
		Response.Write sOutPut
	End If
end function

'escapeClientString(sStr)
'Torna uma string segura pra se escrever no cliente javascript
'Carlos Vítor, 10-10-2003
Function escapeClientString(sStr)
	escapeClientString = Replace(Replace(Replace(sStr,"""","\"""),vbNewLine,"\n"),"'","\'")
End Function

'safeSQLStr(sStr)
'Torna uma string segura contra SQL Injections e syntax errors para concatenar no SQL
'Carlos Vítor, 14-11-2003
Function safeSQLStr(sStr)
	safeSQLStr = Replace(sStr,"'","''")
End Function

Function LimpaSql(sStr)

	sStr = lCase(sStr)

	sStr = Replace(sStr, "'","''")
	sStr = Replace(sStr, ";","")
	sStr = Replace(sStr, "--","")
	sStr = Replace(sStr, "select","")
	sStr = Replace(sStr, "insert","")
	sStr = Replace(sStr, "delete","")
	sStr = Replace(sStr, "drop","")
	sStr = Replace(sStr, "xp_","")

	LimpaSql = sStr

End Function

Function NullReplace(sValue,sReplaceString)
	If sValue = "" Or IsNull(sValue) Then
		NullReplace = sReplaceString
	Else
		NullReplace = sValue
	End If
End Function

function refreshEditData(oRs)
	Dim strExecute
	Dim i
	For i = 0 to oRs.Fields.Count - 1
		strExecute = oRs.Fields(i).Name & " = oRs.Fields(" & i & ").Value"
		EXECUTE(strExecute)
	Next
end function

'======================================================================
'Diz se o perfil do usuário atual é de apenas consulta
'Carlos Vítor em 15-07-2003
'======================================================================
Function isPerfilConsulta
	If Session("IntAdv_PerfilConsulta") = "1" Then
		isPerfilConsulta = True
	ElseIf Session("IntAdv_PerfilConsulta") = "0" Then
		isPerfilConsulta = False
	End If
End Function

'======================================================================
'esta sub mostra o conteudo de uma string formatando-a - inicio
' - uma vez mais, me recuso a comentar o parametro
'======================================================================
sub String_Show (pString)
	Response.Write "<hr><pre>" & pString & "</pre><hr>"
end sub
'======================================================================
'esta sub mostra o conteudo de uma string formatando-a - fim
'======================================================================



'esta funcao monta uma tabela com o resultado de um recordset - inicio
'pRS - objeto recordset ja aberto a ser exibido
'======================================================================
sub RecordSet_Show (pRS)
	dim Field

	'set pRS = Server.CreateObject("ADODB.RecordSet")

	Response.Write "<table cellspacing=0 cellpadding=2 border=1>" & vbCrLf

	if (pRS.State <> adStateOpen) then
		Response.Write "	<tr><td>RecordSet not opened.</td></tr>" & vbCrLf
		Response.Write "</table>" & vbCrLf
		exit sub
	end if

	Response.Write "	<tr>" & vbCrLf
	for each Field in pRS.Fields
		Response.Write "		<td>" & Field.Name & "</td>" & vbCrLf
	next
	Response.Write "	</tr>" & vbCrLf

	if (not pRS.BOF) then
		pRS.MoveFirst
	end if
	do while (not pRS.EOF)
		Response.Write "	<tr>" & vbCrLf
		for each Field in pRS.Fields
			if IsNull(Field.Value) then
				Response.Write "		<td>--null value--</td>" & vbCrLf
			else
				Response.Write "		<td>" & Field.Value & "&nbsp;</td>" & vbCrLf
			end if
		next
		Response.Write "	</tr>" & vbCrLf

		pRS.MoveNext
	loop

	Response.Write "</table>" & vbCrLf
end sub


'estas tres funcoes servem para criar variaveis texto formatadas
'de um modo mais facil, apenas para economizar codificacao - inicio
'- desculpe, me recuso a comentar o unico parametro
'======================================================================
'=========== funções para econimizar codificação e facilitar no debug
dim sSQL_Temp

sSQL_Temp = vbNullString

sub SQL_Clear
	sSQL_Temp = vbNullString
end sub

sub SQL_Add (psTemp)
	sSQL_Temp = sSQL_Temp & psTemp & vbCrLf
end sub

function SQL_Get
	SQL_Get = sSQL_Temp
end function
'======================================================================
'estas tres funcoes servem para criar variaveis texto formatadas
'de um modo mais facil, apenas para economizar codificacao - fim
'======================================================================

'======================================================================
'Esta sub mostra uma tabela com todos os campos enviados em um
'form - inicio
'======================================================================
sub Form_Show
	dim Item, Item2

	Response.Write "<table cellspacing=0 cellpadding=2 border=1>" & vbCrLf

	for each Item in Request.Form
		Response.Write "	<tr>" & vbCrLf
		Response.Write "		<td>" & Item & "</td>" & vbCrLf
		if (Request.Form(Item).Count > 1) then
			Response.Write "		<td>"
			for each Item2 in Request.Form(Item)
				 Response.Write Item2 & "<br>"
			next
			Response.Write "</td>" & vbCrLf
		else
			Response.Write "		<td>" & Request.Form(Item) & "</td>" & vbCrLf
		end if
		Response.Write "	</tr>" & vbCrLf
	next

	Response.Write "</table>" & vbCrLf
end sub
'======================================================================
'esta sub mostra uma tabela com todos os campos enviados em um
'form - fim
'======================================================================

'======================================================================
'esta sub mostra uma tabela com todos os campos de um command - inicio
'pCMD - objeto command do qual se quer exibir todos os parametros e
' valores
'======================================================================
sub CMD_Show (pCMD)
	dim Field

	Response.Write "<table cellspacing=0 cellpadding=2 border=1>" & vbCrLf

	for each Field in pCMD.Parameters
		Response.Write "	<tr>" & vbCrLf
		Response.Write "		<td>" & Field.Name & "</td>" & vbCrLf
		Response.Write "		<td>" & Field.Value & "</td>" & vbCrLf
		Response.Write "	</tr>" & vbCrLf
	next

	Response.Write "</table>" & vbCrLf
end sub
'======================================================================
'esta sub mostra uma tabela com todos os campos de um command - fim
'======================================================================

'======================================================================
'esta funcao escreve os campos enviados para a pagina atual atraves
'do metodo POST com seus respectivos valores em campos ocultos
'(hidden). Ela nao escreve as tags <form e </form de modo que a pagina
'que estiver chamando possa customizar o formulario conforme a
'necessidade.
'-pbTreatReOrder - se verdadeiro, a funcao escreve um campo sem valor
' com o nome "reorder". Se o campo ja existir no POST feito para esta
' pagina, apenas escrevo o enviado, nao criando assim campos
' com o mesmo nome mais de uma vez. Este campo serve para fazer a
' reordenacao da pagina pela coluna solicitada pelo usuario.
'======================================================================
sub Form_Write(byval pbTreatReOrder)
	dim Item, Item2, bReOrder

	bReOrder = false
	for each Item in Request.Form
		if (Request.Form(Item).Count > 1) then
			for each Item2 in Request.Form(Item)
				Response.Write "<input type='hidden' name='" & Item & "' value='" & Replace(Item2, "'", "&#39;") & "'>" & vbCrLf
			next
		else
			Response.Write "<input type='hidden' name='" & Item & "' value='" & Replace(Request.Form(Item), "'", "&#39;") & "'>" & vbCrLf
		end if

		if ((not bReOrder) and (lcase(Item) = "reorder")) then
			bReOrder = true
		end if
	next

	if ((pbTreatReOrder) and (not bReOrder)) then
		Response.Write "<input type='hidden' name='reorder' value=''>" & vbCrLf
	end if
end sub

'Função que me retorna qual a fase de Remuneração que uma Matriz de Resultado se encontra
Function FaseRemuneracao(pAvaliacao)

	SQL_Clear
	SQL_Add "   Select id_Evento_Remuneracao = Isnull(Max(id_Evento_Remuneracao),0) From Matriz_Resultado "
	SQL_Add "   Where id_Avaliacao = " & pAvaliacao & " "

	dim oRsFase
	Set oRsFase = openDiscRecordset(cnnSql,SQL_Get)

	if not oRsFase.EOF then
		FaseRemuneracao = oRsFase("id_Evento_Remuneracao")
	else
		FaseRemuneracao = 0
	end if

	Set oRsFase = nothing

End Function

'Função que me retorna qual a data de cadastramento da Causa
Function DataInicioCausa(pCausa)

	SQL_Clear
	SQL_Add "   Select dt_Inicio_Causa = Convert(Varchar(10),dt_Inicio_Causa,103) From Causa "
	SQL_Add "   Where cd_Causa = '" & pCausa & "' "

	dim oRsCausa
	Set oRsCausa = openDiscRecordset(cnnSql,SQL_Get)

	if not oRsCausa.EOF then
		DataInicioCausa = oRsCausa("dt_Inicio_Causa")
	else
		DataInicioCausa = 0
	end if

	Set oRsCausa = nothing

End Function

Function GetErrorSQL(obj)

   Dim IdErr
   Dim dsErr

   Dim i

   IdErr = 0
   dsErr = ""

   If obj.Count > 0 Then

       For i = 0 To obj.Count - 1

           If i = 0 Then
              IdErr = obj(i).Number
           End If

           dsErr = dsErr & "Mensagem Nº: " & obj(i).Number & " " & Chr(13)
           dsErr = dsErr & "Descrição   : " & obj(i).Description & " " & Chr(13)
       Next

   End If

   GetErrorSQL = dsErr

End Function

'função de erro de processamento
function Error(pMsg)%>
		<script language="JavaScript">
			//alert('<%= Replace(Replace(Replace(pMsg,"'",""""),chr(13)," "), Chr(10), " ")%>');
			alert('<%= Replace(Replace(Replace(pMsg,"'","\'"), chr(13),"\n"), Chr(10), " ") %>');
		</script>
		<%
end function

'função de erro de processamento
function MostraErros()%>
<script language="JScript">
   alert('Erro de processamento: \n Erro:<%= Err.Number%> \n Descrição: <%=    Replace(Replace(Err.Description,"'",""),Chr(13)+Chr(10), "")%>');
</script><%
end function

Public Function TiraAcentos(Nome)
    Dim intComp
    Dim strSemAcento
    Dim intponteiro
    Dim strLetra
    intComp = Len(Nome)
    For intponteiro = 1 To intComp
        strLetra = Mid(Nome, intponteiro, 1)
        Select Case strLetra
            Case "Ä", "Å", "Á", "Â", "À", "Ã"
                strSemAcento = strSemAcento & "A"
            Case "ä", "á", "â", "à", "ã"
                strSemAcento = strSemAcento & "a"
            Case "É", "Ê", "Ë", "È"
                strSemAcento = strSemAcento & "E"
            Case "é", "ê", "ë", "è"
                strSemAcento = strSemAcento & "e"
            Case "Í", "Î", "Ï", "Ì"
                strSemAcento = strSemAcento & "I"
            Case "í", "î", "ï", "ì"
                strSemAcento = strSemAcento & "i"
            Case "Ö", "Ó", "Ô", "Ò", "Õ"
                strSemAcento = strSemAcento & "O"
            Case "ö", "ó", "ô", "ò", "õ"
                strSemAcento = strSemAcento & "o"
            Case "Ü", "Ú", "Û"
                strSemAcento = strSemAcento & "U"
            Case "ü", "ú", "û", "ù"
                strSemAcento = strSemAcento & "u"
            Case "Ç"
                strSemAcento = strSemAcento & "C"
            Case "ç"
                strSemAcento = strSemAcento & "c"
            Case Else
                strSemAcento = strSemAcento & strLetra
        End Select
    Next
    TiraAcentos = strSemAcento
End Function

Function Mascara_CPF_CNPJ (pNumero, pTipo)
	If pTipo = 1 Then 'CPF
		Mascara_CPF_CNPJ = Mid(pNumero,1,3)&"."&Mid(pNumero,4,3)&"."&Mid(pNumero,7,3)&"-"&Mid(pNumero,10,2)
	Else'CNPJ
		Mascara_CPF_CNPJ = Mid(pNumero,1,2)&"."&Mid(pNumero,3,3)&"."&Mid(pnumero,6,3)&"/"&Mid(pnumero,9,4)&"-"&Mid(pNumero,13,2)
	End If
End Function

Function DataFormalizacao(pCausa, oConn)

	SQL_Clear
	SQL_Add " Select csr.dt_Formalizacao From COB_Servico csr "
	SQL_Add "  Inner Join Atendimento ate "
    SQL_Add "     On ate.id_servico = csr.id_servico "
	SQL_Add "  Where ate.cd_Causa = '" & pCausa & "' "
	SQL_Add "    And dt_Formalizacao Is Not Null"

	Dim oRs
	Set oRs = openDiscRecordset(oConn, SQL_Get)
	
	If Not oRs.EOF Then
		DataFormalizacao = True
	else
		DataFormalizacao = False
	end if

	Set oRs = Nothing

End Function

%>

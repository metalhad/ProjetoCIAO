<%
Option Explicit
%>
<!-- #include FILE = "..\inc\inc_Conexao.asp" -->
<!--#include file=..\inc\inc_dbFunctions.asp-->
<%

'form_show
'response.end
Response.Expires = 0

	Dim objConn, strSQL, sql_query, RsQuery, sql, ObjRs
	Dim objRs2
	Dim objConn2
	Dim strSQLSP                  : strSQLSP                = ""
	Dim qtdInsert                 : qtdInsert               = 0
	dim Desc_Procedimento         : Desc_Procedimento       = TRIM(request.form("Desc_Procedimento")) & ""
	dim Valor_Procedimento        : Valor_Procedimento      = TRIM(request.form("Valor_Procedimento")) & ""
	dim dtCad                     : dtCad                   = TRIM(request.form("dtCad")) & ""
	dim UserCad                   : UserCad                 = TRIM(request.form("UserCad")) & ""
	Dim checkbox                  : checkbox                = Trim(request.form("checkbox")) & ""
	Dim Cod_Servico               : Cod_Servico             = Trim(request.form("Cod_Servico")) & ""

	'Select
	Set objConn =  Server.CreateObject("ADODB.Connection")
	objConn.Open "DBQ=" & Server.MapPath(Caminho_Banco) & ";Driver={Microsoft Access Driver (*.mdb)}","username","password"

	'Insert
	Set objConn2 =  Server.CreateObject("ADODB.Connection")
	objConn2.Open "DBQ=" & Server.MapPath(Caminho_Banco) & ";Driver={Microsoft Access Driver (*.mdb)}","username","password"

	dim strSQLDel : strSQLDel = "" 
	strSQLDel = strSQLDel & " DELETE * FROM Servico_Procedimento WHERE cod_Servico = " & cod_Servico 
		
	Set ObjRs = objConn.Execute(strSQLDel)

	'Verifica se � para inserir tamb�m.
	If checkbox <> "" Then
	
		strSQL = "" 
		strSQL = strSQL & " SELECT (SELECT 1 FROM Servico_Procedimento as SP WHERE SP.Cod_Procedimento = PRO.Cod_Procedimento and SP.Cod_Servico = " & Cod_Servico & " )  as marca_combo, Pro.*"
		strSQL = strSQL & "   FROM Procedimento as Pro "
		strSQL = strSQL & "  where Pro.cod_procedimento in (" & checkbox & ") " 
		
		Set ObjRs = objConn.Execute(strSQL)
			
			Do While Not ObjRs.EOF
				if ucase(trim(ObjRs("cod_Procedimento"))) <> "" Then

					qtdInsert = qtdInsert + 1

					strSQLSP = ""
					strSQLSP = strSQLSP & "INSERT INTO Servico_Procedimento (cod_Procedimento, cod_Servico) VALUES "
					strSQLSP = strSQLSP & "("& objRs("cod_Procedimento") & ", "& cod_Servico & ")"
					
						Set objRs2 = objConn2.Execute(strSQLSP)
					On error Resume Next

				end if
				ObjRs.MoveNext
			Loop
			
	End If
	objConn2.close

	Set objRs2   = Nothing
	Set objConn2 = Nothing 
	Set objRs    = Nothing
	objConn.close
	Set objConn  = Nothing 
%>
<html>
	<title>
		Solar
	</title>
	<p>&nbsp;</p>
	<head>
		<link 		href="..\css\css002.css" 				type="text/css" 		rel="stylesheet" />
		<link 		href="..\css\style.css" 				type="text/css"  		rel="stylesheet" />
		<script 	src="..\js\boxOver.js" 					type="text/javascript" ></script>
		<script 	src="..\js\Contar_texto.js" 			type="text/javascript" ></script>

		<!-- Calendario -->
		<script 	src="..\js\calendar.js" 				type="text/javascript"></script>
		<script 	src="..\js\calendar-br.js"				type="text/javascript"></script>
		<script 	src="..\js\calendar-setup.js" 			type="text/javascript"></script>
		<!-- CALENDARIO FIM -->
		<script 	src="..\js\cpaint2.inc.compressed.js" 	type="text/javascript"></script>
	</head>
<script>
function refreshParent() {
  window.opener.location.href = window.opener.location.href;

  if (window.opener.progressWindow)
		
 {
    window.opener.progressWindow.close()
  }
  window.close();
}
</script>
<body onunload="opener.location=('Servico_pesquisa.asp')">
<br><br><br><br>
	<%if err = 0 Then %>
		<div align="center"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Total de Procedimentos incluidos "<b><%=qtdInsert%></b>"!</font></b><br><a href="javascript:history.back(-1)">Volta</a></div><br>
	<%else%>
		<div align="center"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Ocorreu algum erro!<br>Nenhum dado foi incluido!</font></b><br><a href="javascript:history.back(-1)" onclick="refreshParent();" >Volta</a></div><br>
	<%End if%>
</body>
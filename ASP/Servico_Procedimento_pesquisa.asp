<!-- #include FILE = "..\inc\inc_Conexao.asp" -->
<%
'Pesquisa de Procedimento

Dim strURL     
Dim cnnSearch 
Dim rstSearch  
Dim strDBPath  

Dim strSQL    
Dim strSearch
Dim strWhere
Dim tp_Filtro
Dim ds_mensagem
Dim Cod_Servico : Cod_Servico = request.queryString("Cod_Servico")
'response.write "Cod_Servico: " & Cod_Servico
'response.end
inicio = Timer


'#Funзгo que tira todos os acentos das palavras
function TiraAcento(StrAcento)
	for i = 1 to len(StrAcento) 
		Letra = mid(StrAcento, i, 1)
		Select Case Letra
			Case "б","Б","а","А","г","Г","в","В","в","д","Д"
				Letra = "A"
			Case "й","Й","к","К","Л","л","И","и"
				Letra = "E"
			Case "н","Н","п","П","М","м"
				Letra = "I"
			Case "у","У","ф","Ф","х","Х","ц","Ц","т","Т"
				Letra = "O"
			Case "ъ","Ъ","Щ","щ","ъ","ы","ь","Ь","Ы"
				Letra = "U"
			Case "з","З"
				Letra = "C"
			Case "с"
				Letra = "N"
		End Select
		texto = texto & Letra
	next
	TiraAcento = texto
end function 


strURL = Request.ServerVariables("URL")

strSearch   = Request.QueryString("search")
tp_Filtro   = Request.QueryString("tp_Filtro")
ds_mensagem = Request.QueryString("ds_mensagem")

'response.write "TTTTTTTTTTTTTTT:" & strSearch
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
		function Salvar() {
			document.form01.action = 'Servico_Procedimento_action_Incluir.asp';
			document.form01.submit();
		}
		
		function PesqUsuario() {
			document.getElementById("bt_Pesquisa").click();
		}
		
		function alterarLinha(oLinha) {
			document.getElementById("radio_" + oLinha).click();
		}
		
	</script>
<body>

	<form name="formPesquisa" method="get" >
		<div align="center" > 
			<input name="search" onBlur="PesqUsuario();" value="<%=strSearch%>" />
			<br><br>
			<input name="submit" id="bt_Pesquisa" type="submit" value="Pesquisar" />
		</div>	
	</form>

	<div align="center" > 
<%
		strDBPath = Server.MapPath(Caminho_Banco)
		Const adUseClient = 3
		Set cnnSearch = Server.CreateObject("ADODB.Connection")
		
		cnnSearch.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & ";"
		cnnSearch.CursorLocation = adUseClient

		strSQL = "" 
		strSQL = strSQL & " SELECT (SELECT 1 FROM Servico_Procedimento as SP WHERE SP.Cod_Procedimento = PRO.Cod_Procedimento and SP.Cod_Servico = " & Cod_Servico & " )  as marca_combo, Pro.*"
		strSQL = strSQL & "   FROM Procedimento as Pro "
		strSQL = strSQL & "  where Pro.desc_procedimento LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " 
		strSQL = strSQL & "  ORDER BY Pro.Desc_Procedimento;"

		Set rstSearch = cnnSearch.Execute(strSQL)
		intContador = rstSearch.RecordCount

%>
		<font size="1" face="Verdana, Arial, Helvetica, sans-serif">
			[ Foram encontradas&nbsp; <b><%=intContador%></b> ocorrкncias ] 
		</font> 
	</div>

	<div align="center"> 
		<form  name="form01" method="post">
			<div class="scroll" style="background-color:#FFFFFF; overflow: auto; height:270px; padding:5px; border: 1px solid #DEDEDE; margin-bottom:10px">
				<table width="100%" border="0" cellpadding="4" cellspacing="1" class="tab-estilo2" >
					<tr> 
						<th  height="1" bgcolor="#FF6600" align="center"> 
							<FONT color=black face=Tahoma size=2><STRONG><input type="button" onClick="Salvar();" name="Submit" value="Salvar"></strong></font>
						</th>
						<th width="100%" bgcolor="#FF6600"><FONT color=black face=Tahoma size=2><STRONG><font color="black">Procedimento:</font></STRONG></FONT></th>
					</tr>
					<%Do While Not rstSearch.EOF%>
						<% if ucase(trim(rstSearch.Fields("Desc_Procedimento").Value)) <> "" Then%>
						<tr> 
							<td  width="66" height="1" align="center"> <div align="center"><font size="1"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000"> 
								<input type="checkbox" name="checkbox"  <% if rstSearch("marca_combo") then response.write "checked" end if%> value="<%=rstSearch("Cod_Procedimento")%>">
								</font> </b></font></div>
							</td>
							
							<td onClick="alterarLinha('<%=rstSearch("Cod_Procedimento")%>')"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=ucase(trim(rstSearch.Fields("Desc_Procedimento").Value)) %></font></td>
						</tr>	
						<%end if%>
						<%rstSearch.MoveNext%>
					<%Loop%>
				</table>
			</div>
		<input type="hidden" name="qtd_Procedimento" value="<%=qtd_Procedimento%>" />
		<input type="hidden" name="Cod_Servico" value="<%=Cod_Servico%>" />
		</form>
		<font size="1" face="Verdana, Arial, Helvetica, sans-serif"><br>
			&nbsp;
			Sua busca foi processada em <%response.write FormatNumber( Timer - inicio, 2 )%> segundos.
		</font><br>
	<%
		rstSearch.Close
		Set rstSearch = Nothing
		cnnSearch.Close
		Set cnnSearch = Nothing
	%>
	</div>
</body>
</html>
<!-- #include FILE = "..\inc\inc_Conexao.asp" -->
<%
'Pesquisa de Servico

Dim strURL     
Dim cnnSearch 
Dim rstSearch  
Dim strDBPath  

Dim strSQL    
Dim strSearch
Dim strWhere
Dim tp_Filtro
Dim ds_mensagem
Dim Cod_Pacote : Cod_Pacote = request.queryString("Cod_Pacote")
'response.write "Cod_Pacote: " & Cod_Pacote
'response.end
inicio = Timer


'#Função que tira todos os acentos das palavras
function TiraAcento(StrAcento)
	for i = 1 to len(StrAcento) 
		Letra = mid(StrAcento, i, 1)
		Select Case Letra
			Case "á","Á","à","À","ã","Ã","â","Â","â","ä","Ä"
				Letra = "A"
			Case "é","É","ê","Ê","Ë","ë","È","è"
				Letra = "E"
			Case "í","Í","ï","Ï","Ì","ì"
				Letra = "I"
			Case "ó","Ó","ô","Ô","õ","Õ","ö","Ö","ò","Ò"
				Letra = "O"
			Case "ú","Ú","Ù","ù","ú","û","ü","Ü","Û"
				Letra = "U"
			Case "ç","Ç"
				Letra = "C"
			Case "ñ"
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
			document.form01.action = 'Pacote_Servico_action_Incluir.asp';
			document.form01.submit();
		}
		
		function PesqUsuario() {
			document.getElementById("bt_Pesquisa").click();
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
		strSQL = strSQL & " SELECT (SELECT 1 FROM Pacote_Servico as PS WHERE PS.Cod_Servico = Ser.Cod_Servico and PS.Cod_Pacote = " & Cod_Pacote & " )  as marca_combo, Ser.*"
		strSQL = strSQL & "   FROM Servico as Ser "
		strSQL = strSQL & "  where Ser.desc_Servico LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " 
		strSQL = strSQL & "  ORDER BY Ser.Desc_Servico;"

		Set rstSearch = cnnSearch.Execute(strSQL)
		intContador = rstSearch.RecordCount

%>
		<font size="1" face="Verdana, Arial, Helvetica, sans-serif">
			[ Foram encontradas&nbsp; <b><%=intContador%></b> ocorrências ] 
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
						<th width="100%" bgcolor="#FF6600"><FONT color=black face=Tahoma size=2><STRONG><font color="black">Serviço:</font></STRONG></FONT></th>
					</tr>
					<%Do While Not rstSearch.EOF%>
						<% if ucase(trim(rstSearch.Fields("Desc_Servico").Value)) <> "" Then%>
						<tr> 
							<td  width="66" height="1" align="center"> <div align="center"><font size="1"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000"> 
								<input type="checkbox" name="checkbox"  <% if rstSearch("marca_combo") then response.write "checked" end if%> value="<%=rstSearch("Cod_Servico")%>">
								</font> </b></font></div>
							</td>
							
							<td><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=ucase(trim(rstSearch.Fields("Desc_Servico").Value)) %></font></td>
						</tr>	
						<%end if%>
						<%rstSearch.MoveNext%>
					<%Loop%>
				</table>
			</div>
		<input type="hidden" name="qtd_Servico" value="<%=qtd_Servico%>" />
		<input type="hidden" name="Cod_Pacote" value="<%=Cod_Pacote%>" />
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
<!-- #include FILE = "..\inc\inc_Conexao.asp" -->
<%
'Pesquisa de Servicos

Dim strURL     
Dim cnnSearch 
Dim rstSearch  
Dim strDBPath
Dim rstServicoCad  

Dim strSQL    
Dim strSearch
Dim strWhere
Dim tp_Filtro
Dim ds_mensagem
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
<script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/easyTooltip.js"></script>

</meta>
 
<style> 

 
#easyTooltip{
	padding:5px 10px;
	border:1px solid #195fa4;
	background:#195fa4 url(../img/bg.gif) repeat-x;
	color:#fff;
	}
 
#easyTooltip2{
	padding:5px 10px;
	border:1px solid #5e5e5e;
	background:#5e5e5e url(../img/bg2.gif) repeat-x;
	color:#fff;
	width:550px;
	}
#easyTooltip2 h4, #easyTooltip2 p{
	margin:.5em 0;
	}	
					
 
/* // Easy Tooltip */
 
</style>
	<script>
		function Alterar() {
			document.form01.action = 'servico_altera.asp';
			document.form01.submit();
		}
		
		function Excluir() {
			document.form01.action = 'servico_action_excluir.asp';
			document.form01.submit();
		}

		function PesqUsuario() {
			document.getElementById("bt_Pesquisa").click();
		}
		
		function alterarLinha(oLinha) {
			document.getElementById("radio_" + oLinha).click();
		}
		function openPopup(oCodServico) {
		
			window.open('Servico_Procedimento_pesquisa.asp?Cod_Servico='+oCodServico, 'janela', 'width=715, height=500, menubar=no, resizable=yes, scrollbars=yes, top=115, left=180');
			//window.open('Servico_Procedimento_pesquisa.asp','pop1','toolbar=no,location=no,directories=no,status=no,menubar=no,resiza ble=no,copyhistory=no,scrollbars=no,width=800,height=500');
			 
		}
	</script>
	
	<body>
		<div id="main_container">
			<div id="header">
				<div class="top_right">
					<div class="languages">
					</div>
					<div class="big_banner">
					<!-- <a href="#"><img src="images/banner728.jpg" alt="" title="" border="0" /></a>-->
					</div>
				</div>
				<div id="logo">
					<a href="index.asp"><img src="..\img\solar.gif" alt="" title="" border="0" width="120" height="120" /></a>
				</div>
			</div>
			
			<div id="main_content"> 
				<div id="menu_tab">
					<!-- #include FILE = "..\inc\menu_principal.asp" -->
				</div>
				<div class="left_content">
					<div class="title_box">
						Ações
					</div>
					<!-- #include FILE = "..\inc\menu_acoes_servico.asp" -->
					<div class="banner_adds">
						<br><br><br><br><br><br><br><br><br><br>
					</div>    
				</div>
				<div class="center_content">
					<div class="center_title_bar">
						Cadastro de Serviços
					</div>
					<br><br><br><br>
					<fieldset>
						<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" > <!--bgcolor="#E4E9ED"-->
							<tr>
								<td>
									
																		<table width="100%" border="0" cellspacing="0" cellpadding="0"  height="18" bgcolor="#CEDFE7">
										<tr> 
											<td width="734" height="1" align="center">  <!--bgcolor="#FFFFE6"-->
												<font face="Verdana, Arial, Helvetica, sans-serif" color="#000099" size="3">
													<b><br>
													</b>
												</font>
												<font size="2">
													<b>
														<font face="Verdana, Arial, Helvetica, sans-serif" color="#000000">
															:: PESQUISA ::
														</font>
													</b>
												</font>                  
											</td>
										</tr>
									</table>
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
										strSQL = "SELECT * " _
												& "FROM Servico where " _
												& "     Desc_Servico LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " 
												'& "  or Sigla_Servico LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " 
															
										'if tp_Filtro = "Email" then
										'	strSQL = strSQL & "email LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " 
										'elseif tp_Filtro = "Nome" then
										'	strSQL = strSQL & "nome LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " 
										'elseif tp_Filtro = "Titulo" then
										'	strSQL = strSQL & "nm_titulo LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " 
										'else
										'	strSQL = strSQL & "Telefone_Escritorio LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " _
										'					& "OR email LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " _
										'					& "OR nome LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " _
										'					& "OR nm_titulo LIKE '%" & TiraAcento(Replace(strSearch, "'", "''")) & "%' " 
										'
										'end if
										'strSQL = strSQL & "ORDER BY Desc_Servico;"
										
										'response.write strSQL
										'response.end
										
										Set rstSearch = cnnSearch.Execute(strSQL)
										intContador = rstSearch.RecordCount
				
	%>
										<font size="1" face="Verdana, Arial, Helvetica, sans-serif">
											[ Foram encontradas&nbsp; <b><%=intContador%></b> ocorrências ] 
										</font> 
									</div>
								</td>
							</tr>
						</table>

						<div align="center"> 
							<form  name="form01" method="get">
								<div class="scroll" style="background-color:#FFFFFF; overflow: auto; height:270px; padding:5px; border: 1px solid #DEDEDE; margin-bottom:10px">
									<table width="100%" border="0" cellpadding="4" cellspacing="1" class="tab-estilo2" >
										<tr> 
											<th width="10%" bgcolor="#FF6600"><FONT color=black face=Tahoma size=2><STRONG><font color="black">Procedimentos:</font></STRONG></FONT></th>
											<th width="10%" bgcolor="#FF6600"><FONT color=black face=Tahoma size=2><STRONG><font color="black">Sigla:</font></STRONG></FONT></th>
											<th width="70%" bgcolor="#FF6600"><FONT color=black face=Tahoma size=2><STRONG><font color="black">Serviços:</font></STRONG></FONT></th>
											<th width="20%" bgcolor="#FF6600"><FONT color=black face=Tahoma size=2><STRONG><font color="black">Valor:</font></STRONG></FONT></th>
											<th width="20%" bgcolor="#FF6600"><FONT color=black face=Tahoma size=2><STRONG><font color="black">Alterar:</font></STRONG></FONT></th>
											<th  height="1" bgcolor="#FF6600" align="center"> 
											<FONT color=black face=Tahoma size=2><STRONG><input type="button" onClick="Excluir();" name="Submit" value="Excluir"></strong></font></th>
										</tr>
										<%Do While Not rstSearch.EOF
										strSQL = " " 
										strSQL = strSQL & " SELECT pro.* " 
										strSQL = strSQL & "   FROM Procedimento Pro, Servico_Procedimento SP where " 
										strSQL = strSQL & "        Pro.Cod_Procedimento = SP.Cod_Procedimento   " 
										strSQL = strSQL & "    AND SP.Cod_Servico =  " & rstSearch("Cod_Servico") 
										strSQL = strSQL & "  ORDER BY Pro.Desc_Procedimento;"

										'response.write strSQL
										'response.end
										
										Set rstServicoCad = cnnSearch.Execute(strSQL)

				%>
<script type="text/javascript"> 
	$(document).ready(function(){	
		$("a").easyTooltip();
		$("a#link_<%=rstSearch("Cod_Servico")%>").easyTooltip({
			tooltipId: "easyTooltip2",
			content: '<% if rstServicoCad.EOF then response.write "Serviço não possui procedimento" else Do While Not rstServicoCad.EOF : response.write "<img src=../img/arrow_right.png />" & " - " & ucase(rstServicoCad.Fields("Desc_Procedimento").Value) & "<br>" : rstServicoCad.MoveNext : loop end if%>'
		});
	});
</script>
											<tr > 
												<td><a id="link_<%=rstSearch("Cod_Servico")%>" onclick="openPopup(<%=rstSearch("Cod_Servico")%>);" onmouseover="this.style.cursor='hand'" onmouseout="this.style.cursor='default'"><img src=../img/system_procedure.gif /></a></td>
												<td onClick="alterarLinha('<%=rstSearch("Cod_Servico")%>')" onmouseover="this.style.cursor='hand'" onmouseout="this.style.cursor='default'"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=ucase(rstSearch.Fields("Sigla_Servico").Value) %></font></td>
												<td onClick="alterarLinha('<%=rstSearch("Cod_Servico")%>')" onmouseover="this.style.cursor='hand'" onmouseout="this.style.cursor='default'"><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=ucase(rstSearch.Fields("Desc_Servico").Value) %></font></td>
												<td onClick="alterarLinha('<%=rstSearch("Cod_Servico")%>')" onmouseover="this.style.cursor='hand'" onmouseout="this.style.cursor='default'"><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">R$ <%=rstSearch.Fields("valor_Servico").Value %></font></div></td>
                                                <td onClick="alterarLinha('<%=rstSearch("Cod_Servico")%>')" onmouseover="this.style.cursor='hand'" onmouseout="this.style.cursor='default'"><div align="center"><input type="radio" name="radio" id="radio_<%=rstSearch("Cod_Servico")%>" onClick="Alterar();" value="<%=rstSearch("Cod_Servico")%>"></div></td>
												<td width="66" height="1" align="center"> <div align="center"><font size="1"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000"> 
													<input type="checkbox" name="checkbox" value="<%=rstSearch("Cod_Servico")%>">
													</font> </b></font></div>
												</td>
											</tr>	
											<%rstSearch.MoveNext%>
										<%Loop%>
									</table>
								</div>
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
					</fieldset>
				</div><!-- end of center content -->
			</div><!-- end of main content -->
			<div class="footer">
				<div class="left_footer">
				</div>
				<div class="center_footer">
					SOLAR
				</div>
				<div class="right_footer">
				<!--
				<a href="index.html">home</a>
				<a href="details.html">about</a>
				<a href="details.html">sitemap</a>
				<a href="details.html">rss</a>
				<a href="contact.html">contact us</a>
				<a href="http://www.criarsite.com">criar site</a>
				-->
				</div>   
			</div>                 
		</div>
		<!-- end of main_container -->
	</body>
</html>
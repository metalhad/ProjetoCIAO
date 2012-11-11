<%
' Exclusao de Procedimentos

Option Explicit
%>
<!-- #include FILE = "..\inc\inc_Conexao.asp" -->
<%
Response.Expires = 0
Dim objConn, objRs, strQuery
Dim strConnection

'Conectando com o banco de dados CIAO_FE.mdb
Set objConn =  Server.CreateObject("ADODB.Connection")
objConn.Open "DBQ=" & Server.MapPath(Caminho_Banco) & ";Driver={Microsoft Access Driver (*.mdb)}","username","password"

'Seleciona da tabela Dados_Adriana
strQuery = "SELECT * FROM Procedimento order by Desc_Procedimento"
Set ObjRs = objConn.Execute(strQuery)
%>
<html>
	<title>Solar</title>
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
					<a href="index.html"><img src="..\img\solar.gif" alt="" title="" border="0" width="120" height="120" /></a>
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
					<!-- #include FILE = "..\inc\menu_acoes_Procedimento.asp" -->
					<div class="banner_adds">
						<br><br><br><br><br><br><br><br><br><br>
					</div>
				</div>
				<div class="center_content">
					<div class="center_title_bar">
						Cadastro de Procedimentos
					</div>
					<br><br><br><br>
					<fieldset>
						<div align="center" >
							<table width="100%" border="0" cellspacing="0" cellpadding="0" height="1">
								<tr>
									<td width="100%" valign="top" height="136"> 
										<table border="0" cellpadding="0" cellspacing="0" width="740">
											<tr bgcolor="ffffff"> 
												<td colspan="3">
												</td>
											</tr>
											<tr> 
												<td colspan="3"> 
													<table width="100%" border="0" cellspacing="0" cellpadding="0"  height="18">
														<tr> 
															<td width="734" height="1" align="center"> 
																<font face="Verdana, Arial, Helvetica, sans-serif" color="#000099" size="3"><b><br>
																	</b></font><font size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000">:: Excluir ::</font></b></font></td>
														</tr>
													</table>
													<form method="GET" action="..\asp\Procedimento_action_excluir.asp">
														<table width="736" border="0" cellspacing="0" cellpadding="0"  height="1">
															<tr> 
																<td height="1" align="center" width="734"> 
																	<table border="0" width="100%" height="63"  class="tab-estilo2"  cellpadding="2">
																		<tr > 
																			<td width="100%" height="1" bgcolor="#FF6600" align="center"> <font size="1" color="black"><b><font face="Verdana">Descrição do Procedimento:</font></b> 
																				</font>
																			</td>
																			<td  height="1" bgcolor="#FF6600" align="center"> <font size="1" color="black"> 
																				<input type="submit" name="Submit" value="Excluir">
																					</font>
																			</td>
																		</tr>
																		<%While Not objRS.EOF %>
																			<tr> 
																				<td  height="1" align="center"> <div align="left"><font size="1"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000"> 
																						<%Response.write objRS("Desc_Procedimento")%>
																					</font> </b></font></div>
																				</td>
																				<td " height="1" align="center"> <div align="center"><font size="1"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000"> 
																					<input type="checkbox" name="checkbox" value="<%=objRS("cod_Procedimento")%>">
																					</font> </b></font></div>
																				</td>
																			</tr>
																			<%objRS.MoveNext%>
																		<%Wend%>
																		<%
																			'Fechando as conexões
																			objRs.close
																			objConn.close
																			Set objRs = Nothing
																			Set objConn = Nothing
																		%>
																	</table>
																</td>
															</tr>
														</table>
													</form>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
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
		</div> <!-- end of main_container -->
	</body>
</html>
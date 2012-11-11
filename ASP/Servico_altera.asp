<!-- #include FILE = "..\inc\inc_Conexao.asp" -->
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
		<script 	src="..\js\inc0000_1.js"				type="text/javascript"></script>
		<!-- CALENDARIO FIM -->
		<script 	src="..\js\cpaint2.inc.compressed.js" 	type="text/javascript"></script>
	</head>
	<script language="javascript">
		function valida_campo()
		{
			var desc_servico = document.form.desc_servico.value
			if (desc_servico==""){
				alert("Entre com a descrição do servico!");
				document.form.desc_servico.focus()
				return false
			}
		}
		function confere()
		{
			if (document.form.email.value.indexOf('@', 0) == -1 || document.form.email.value.indexOf('.', 0) == -1){ 
				alert("E-mail invalido!");
				document.form.email.focus()
			}
		}
		function acao_Salvar()
		{
			document.form.action = 'servico_action_alterar.asp';
			document.form.submit();
		}

		function acao_Duplicar()
		{
			document.form.action = 'servico_action_incluir.asp';
			document.form.submit();
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
					<!-- #include FILE = "..\inc\menu_acoes_servico.asp" -->
					<div class="banner_adds">
						<br><br><br><br><br><br><br><br><br><br>
					</div>
				</div>
				<div class="center_content">
					<div class="center_title_bar">
						Cadastro de servicos
					</div>
					<br><br><br><br>
					<fieldset>
						<form method="post" name="form"> <!-- action="salva_duplica()" name="form" onSubmit="return valida_campo()">-->
<%
							'On error resume Next
							Dim objConn, stringSQL, strConnection, cod_servico
							cod_servico = Request.QueryString("radio")

							Set objConn =  Server.CreateObject("ADODB.Connection")
							Set objRS   =  Server.CreateObject("ADODB.Connection")
							objConn.Open "DBQ=" & Server.MapPath(Caminho_Banco) & ";Driver={Microsoft Access Driver (*.mdb)}","username","password"
							stringSQL = "SELECT * FROM servico WHERE cod_servico = "&cod_servico
							Set objRS = objConn.Execute(stringSQL)
%>
							<%if err <> 0 Then%>
								<div align="center"><b><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></b><font color="#FF0000" size="1" face="Verdana, Arial, Helvetica, sans-serif">Ocorreu 
									algum erro!</font><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><br>
									<a href="javascript:history.back(-1)">Volta</a></font><font face="Verdana, Arial, Helvetica, sans-serif"><a href="javascript:history.back(-1)"></a></font>
								</div>
							<%else%>
								<div align="center">
									<center>
										<table width="46%" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
											<tr > 
												<td height="34" colspan="4"> 
													<table width="100%" border="0" cellspacing="0" cellpadding="0"  height="18">
														<tr> 
															<td width="734" height="1" align="center"> 
																<font face="Verdana, Arial, Helvetica, sans-serif" color="#000099" size="3"><b><br>
																</b></font><font size="2"><b><font face="Verdana, Arial, Helvetica, sans-serif" color="#000000">:: ALTERAR ::</font></b></font>
															</td>
														</tr>
													</table>
												</td>
											</tr>

											<tr> 
												<td width="115">
													<font size="2" face="Verdana" color="0000cc">
														Sigla:
													</font>
												</td>
												<td width="181"> 
												<input type="text" name="Sigla_Servico" value="<%=objRS("Sigla_Servico")%>" maxlength="255" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											  </td>
											</tr>
											<tr> 
												<td width="115">
													<font size="2" face="Verdana" color="0000cc">
														Valor:
													</font>
												</td>
												<td width="181"> 
												<input type="text" name="valor_Servico" value="<%=objRS("valor_Servico")%>" maxlength="255" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											  </td>
											</tr>
											<tr> 
												<td width="115">
													<font size="2" face="Verdana" color="0000cc">
														Descrição servico:
													</font>
												</td>
												<td width="181"> 
													<textarea name="desc_servico" rows="4" cols="80" onKeyUp="ContarTexto(this, 100, 'desc_servico')"><%=trim(objRS("desc_servico"))%></textarea>
													<div id="desc_servico" class="label_left"><%=(100 - len(desc_servico))%> caracteres restantes</div>
													<input type="hidden" name="cod_servico" value="<%=objRS("cod_servico")%>"> 
												</td>
											</tr>
											
											<tr> 
												<td colspan="4"> 
                                                <table align="center">
                                                	<tr>
                                                    	<td>                                                        
                                                            <p align="center"> 
                                                                <input type="button" value= "Salvar" name="Salvar" onClick="acao_Salvar()"/>
                                                                <!--<input type="submit" value="Salvar" name="salvar">-->
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p align="center"> 
                                                                <input type="button" value= "Duplicar" name="Duplicar" onClick="acao_Duplicar()"/>
                                                                <!--<input type="submit" value="Duplicar" name="duplicar">-->
                                                            </p>
                                                		</td>
                                                    </tr>
                                                 </table>
											</tr>
										</table>
									</center>
								</div>
							<%end if%>							
						</form>
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
<!-- #include FILE = "..\inc\inc_Conexao.asp" -->
<%
' Inclusão de Procedimentos
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
		<script 	src="..\js\inc0000_1.js"				type="text/javascript"></script>
		<!-- CALENDARIO FIM -->
		<script 	src="..\js\cpaint2.inc.compressed.js" 	type="text/javascript"></script>

	</head>
	<script language="javascript">
	
		function valida_campo()
			{
				var Desc_Procedimento = document.form.Desc_Procedimento.value
				if (Desc_Procedimento==""){
					alert("Campo descrição do procedimento obrigatório!");
					Desc_Procedimento.focus()
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
						<form method="post" action="..\asp\Procedimento_action_incluir.asp" name="form" onSubmit="return valida_campo()">
							<div align="center">
								<center>
									<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
										<tr> 
											<td height="34" colspan="4"> 
												<table width="100%" border="0" cellspacing="0" cellpadding="0"  height="18">
													<tr> 
														<td width="734" height="1" align="center"> 
															<font face="Verdana, Arial, Helvetica, sans-serif" color="#000099" size="3">
																<b>
																	<br>
																</b>
															</font>
															<font size="2">
																<b>
																	<font face="Verdana, Arial, Helvetica, sans-serif" color="#000000">
																		:: INCLUIR ::
																	</font>
																</b>
															</font>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										
										<tr> 
											<td colspan="4"><font size="2" face="Verdana" color="0000cc">Descrição:</font><br>
												<textarea name="Desc_Procedimento" rows="4" cols="60" onKeyUp="ContarTexto(this, 100, 'qtd_caracteres')" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;"></textarea>
												<div id="qtd_caracteres" class="label_left">
													<%=(100 - len(Desc_Procedimento))%> caracteres restantes
												</div>
											</td>
										</tr>
										<tr> 
											<td colspan="4"> 
												<p align="center"> 
													<input type="submit" value="Incluir" name="incluir">
											</td>
										</tr>
									</table>
								</center>
							</div>
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
		</div>	<!-- end of main_container -->
	</body>
</html>
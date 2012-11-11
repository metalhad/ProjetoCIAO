<!-- #include FILE = "..\inc\inc_Conexao.asp" -->
<%
' Inclusão de Contatos
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
				var nome = document.form.nome.value
				if (nome==""){
					alert("Entre com seu nome!");
					document.form.nome.focus()
					return false
				}
				var Telefone_Escritorio = document.form.Telefone_Escritorio.value
				if (Telefone_Escritorio==""){
					alert("Entre com seu Telefone do Escritorio!");
					document.form.Telefone_Escritorio.focus()
					return false
				}
				var email=document.form.email.value;
				if (email==""){
					alert("Entre com seu email!")
					document.form.email.focus()
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
					<!-- #include FILE = "..\inc\menu_acoes_contato.asp" -->
					<div class="banner_adds">
						<br><br><br><br><br><br><br><br><br><br>
					</div>
				</div>
				<div class="center_content">
					<div class="center_title_bar">
						Cadastro de Contatos
					</div>
					<br><br><br><br>
					<fieldset>
						<form method="post" action="..\asp\contato_action_incluir.asp" name="form" onSubmit="return valida_campo()">
							<div align="center">
								<center>
									<!--
									<table width="100%" border="0" cellspacing="2" cellpadding="2">
										<tr align="center"> 
											<td width="33%" bgcolor="#f5f5f5">
												<div align="center">
													<font color="#000099">
														<b>
															<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
																<a href="..\asp\contato_pesquisa.asp" class="menu">
																	Pesquisar
																</a>
															</font>
														</b>
													</font>
												</div>
											</td>
											<td bgcolor="#f5f5f5" width="33%">
												<div align="center">
														<font color="#000099">
															<b>
																<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
																	<font color="#CCCCCC">
																		Incluir
																	</font>
																</font>
															</b>
														</font>
												</div>
											</td>
											<td bgcolor="#f5f5f5" width="33%">
												<div align="center">
													<font color="#000099">
														<b>
															<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
																<a href="..\asp\contato_exclui.asp" class="menu">
																	Excluir
																</a>
															</font>
														</b>
													</font>
												</div>
											</td>
										</tr>
									</table>
									-->
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
											<td width="136">
												<font size="2" face="Verdana" color="0000cc">
													Tipo Contato:
												</font>
											</td>
											<td colspan="4"> 
												<select name="Tipo_Contato"> 
													<option value=""            >-- Selecione --</option> 
													<option value="Autonomo"    >Autonomo</option> 
													<option value="Cliente"     >Cliente</option> 
													<option value="Colaborador" >Colaborador</option> 
													<option value="Fornecedor"  >Fornecedor</option> 
													<option value="Terceiro"    >Terceiro</option> 
												</select>
											</td>
										</tr>
										<tr> 
											<td width="136">
												<font size="2" face="Verdana" color="0000cc">
													Nome:
												</font>
											</td>
											<td width="151"> 
												<input type="text" name="nome" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
          
											<td width="153">
												<font size="2" face="Verdana" color="0000cc">
													Nome Conta:
												</font>
											</td>
											<td width="295"> 
												<input type="text" name="Nome_Conta" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
										</tr>
										<tr> 
											<td width="136">
												<font size="2" face="Verdana" color="0000cc">
													Celular:
												</font>
											</td>
											<td width="151"> 
												<input type="text" name="celular" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
											<td width="153">
												<font size="2" face="Verdana" color="0000cc">
													Tel Escritório:
												</font>
											</td>
											<td width="295"> 
												<input type="text" name="telefone_excritorio" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
										</tr>
										<tr> 
											<td width="136">
												<font size="2" face="Verdana" color="0000cc">
													ID NEXTEL:
												</font>
											</td>
											<td width="151"> 
												<input type="text" name="telefone_alternativo" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
											<td width="153">
												<font size="2" face="Verdana" color="0000cc">
													Tel Residencial:
												</font>
											</td>
											<td width="295"> 
												<input type="text" name="telefone_residencial" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>	
										</tr>
										<tr> 
											<td width="136">
												<font size="2" face="Verdana" color="0000cc">
													Email:
												</font>
											</td>
											<td width="151"> 
												<input type="text" name="email" size="20" style="font-family: Verdana; font-size: 8 pt; COLOR: 0000CC;" onBlur="confere()">
											</td>
											<td width="153">
												<font size="2" face="Verdana" color="0000cc">
													Data de Nasc:
												</font>
											</td>
											<td width="295"> 
												<input type="text" name="data_nascimento" size="20" maxlength="10"  onKeyPress ="MascData('dd/mm/yyyy')"  onBlur="ValidaAnoData(this)" >
											</td>
										</tr>
										<tr> 
											<td width="136"><font size="2" face="Verdana" color="0000cc">Título:</font></td>
											<td width="151"> 
												<input type="text" name="nm_titulo" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
											<td width="153"><font size="2" face="Verdana" color="0000cc">Assistente:</font></td>
											<td width="295"> 
												<input type="text" name="nm_assistente" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
										</tr>
										<tr> 
											<td width="136"><font size="2" face="Verdana" color="0000cc">E-mail alternativo:</font></td>
											<td colspan="3"> 
												<input type="text" name="email_2" size="40"  onBlur="confere();" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
										</tr>
										<tr> 
											<td width="136"><font size="2" face="Verdana" color="0000cc">Endereço:</font></td>
											<td colspan="3"> 
												<input type="text" name="ds_endereco_correspondencia" size="40" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
											
										</tr>
										<tr> 
											<td width="136"><font size="2" face="Verdana" color="0000cc">Cidade:</font></td>
											<td width="151"> 
												<input type="text" name="Estado_Correspondencia" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
											<td width="153"><font size="2" face="Verdana" color="0000cc">Município:</font></td>
											<td width="295"> 
												<input type="text" name="ds_UF" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
										</tr>
										<tr> 
											<td width="136"><font size="2" face="Verdana" color="0000cc">CEP:</font></td>
											<td width="151"> 
												<input type="text" name="CEP_Correspondencia" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
											<td width="153"><font size="2" face="Verdana" color="0000cc">País:</font></td>
											<td width="295"> 
												<input type="text" name="Pais_Correspondencia" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
										</tr>
										<tr> 
											<td width="136"><font size="2" face="Verdana" color="0000cc">Descrição:</font></td>
											<td width="151"> 
												<input type="text" name="Descricao" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
											</td>
										  <td><font size="2" face="Verdana" color="0000cc">Foto/URL:</font></td>
										  <td> 
											<input name="foto" type="text" id="foto" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;" value="" size="20">
										  </td>
										</tr>
										<tr> 
											<td colspan="4"><font size="2" face="Verdana" color="0000cc">Comentário:</font><br>
												<textarea name="ds_comentario" rows="4" cols="60" onKeyUp="ContarTexto(this, 100, 'qtd_caracteres')"></textarea>
												<div id="qtd_caracteres" class="label_left">
													<%=(100 - len(ds_comentario))%> caracteres restantes
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
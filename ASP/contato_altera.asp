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
		function acao_Salvar()
		{
			document.form.action = 'contato_action_alterar.asp';
			document.form.submit();
		}

		function acao_Duplicar()
		{
			document.form.action = 'contato_action_incluir.asp';
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
						<form method="post" name="form"> <!-- action="salva_duplica()" name="form" onSubmit="return valida_campo()">-->
<%
							'On error resume Next
							Dim objConn, stringSQL, strConnection, id_contato
							id_contato = Request.QueryString("radio")

							Set objConn =  Server.CreateObject("ADODB.Connection")
							Set objRS   =  Server.CreateObject("ADODB.Connection")
							objConn.Open "DBQ=" & Server.MapPath(Caminho_Banco) & ";Driver={Microsoft Access Driver (*.mdb)}","username","password"
							stringSQL = "SELECT * FROM Dados_Adriana WHERE id_contato = "&id_contato
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
										<!--
										<table width="100%" border="0" cellspacing="2" cellpadding="2">
											<tr> 
												<td width="33%" >
													<div align="center"><font color="#000099"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"  color="#CCCCCC"><a href="..\asp\contato_pesquisa.asp" class="menu">Pesquisar</a></font></b></font></div>
												</td>
												<td width="33%" height="21" >
													<div align="center"><font color="#000099"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="form_inclusao.asp" class="menu">Incluir</a></font></b></font></div>
												</td>
												<td width="33%" >
													<div align="center"><font color="#000099"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#CCCCCC"><a href="..\asp\contato_exclui.asp" class="menu"><font color="#000099">Excluir</font></a></font></b></font></div>
												</td>
											</tr>
										</table>	
										-->
										<table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
											<tr> 
												<td width="115">
													<font size="2" face="Verdana" color="0000cc">
														Tipo Contato:
													</font>
												</td>
												<td colspan="4"> 
													<select name="Tipo_Contato"> 
														<option value="">-- Selecione --</option> 
														<option <%IF objRS("Tipo_Contato") = "Autonomo"    THEN RESPONSE.Write("SELECTED") END IF%> value="Autonomo"    >Autonomo</option> 
														<option <%IF objRS("Tipo_Contato") = "Cliente"     THEN RESPONSE.Write("SELECTED") END IF%> value="Cliente"     >Cliente</option> 
														<option <%IF objRS("Tipo_Contato") = "Colaborador" THEN RESPONSE.Write("SELECTED") END IF%> value="Colaborador" >Colaborador</option> 
														<option <%IF objRS("Tipo_Contato") = "Fornecedor"  THEN RESPONSE.Write("SELECTED") END IF%> value="Fornecedor"  >Fornecedor</option> 
														<option <%IF objRS("Tipo_Contato") = "Terceiro"    THEN RESPONSE.Write("SELECTED") END IF%> value="Terceiro"    >Terceiro</option> 
													</select>
												</td>
											</tr>
											<tr> 
												<td width="115">
													<font size="2" face="Verdana" color="0000cc">
														Nome:
													</font>
												</td>
												<td width="181"> 
													<input type="text" name="nome" VALUE="<%=objRS("nome")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
												<td width="159"><font size="2" face="Verdana" color="0000cc">Nome Conta:</font></td>
												<td width="280" colspan="2"> 
													<input type="text" name="Nome_Conta" VALUE="<%=objRS("Nome_Conta")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
											</tr>
											<tr> 
												<td width="115"><font size="2" face="Verdana" color="0000cc">Celular:</font></td>
												<td width="181"> 
													<input type="text" name="celular" VALUE="<%=objRS("celular")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
												<td width="159"><font size="2" face="Verdana" color="0000cc">Tel Escritório:</font></td>
												<td width="280"> 
													<input type="text" name="telefone_excritorio" VALUE="<%=objRS("Telefone_Escritorio")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
											</tr>
											<tr> 
												<td width="115"><font size="2" face="Verdana" color="0000cc">ID NEXTEL:</font></td>
												<td width="181"> 
													<input type="text" name="telefone_alternativo" VALUE="<%=objRS("telefone_alternativo")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
												<td width="159"><font size="2" face="Verdana" color="0000cc">Tel Residencial:</font></td>
												<td width="280"> 
													<input type="text" name="telefone_residencial" VALUE="<%=objRS("telefone_residencial")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>	
											</tr>
											<tr> 
												<td width="115"><font size="2" face="Verdana" color="0000cc">Email:</font></td>
												<td width="181"> 
													<input type="text" name="email" VALUE="<%=objRS("email")%>" size="20" style="font-family: Verdana; font-size: 8 pt; COLOR: 0000CC;" onBlur="confere()">
												</td>
												<td width="159"><font size="2" face="Verdana" color="0000cc">Data de Nasc:</font></td>
												<td width="280"> 
													<input type="text" name="data_nascimento" VALUE="<%=objRS("data_nascimento")%>"  onKeyPress ="MascData('dd/mm/yyyy')"  onBlur="ValidaAnoData(this)"  size="20" maxlength="10"  style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
											</tr>
											<tr> 
												<td width="115"><font size="2" face="Verdana" color="0000cc">Título:</font></td>
												<td width="181"> 
													<input type="text" name="nm_titulo" VALUE="<%=objRS("nm_titulo")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
												<td width="159"><font size="2" face="Verdana" color="0000cc">Assistente:</font></td>
												<td width="280"> 
													<input type="text" name="nm_assistente" VALUE="<%=objRS("nm_assistente")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
											</tr>
											<tr> 
												<td width="115"><font size="2" face="Verdana" color="0000cc">E-mail alternativo:</font></td>
												<td colspan="3"> 
													<input type="text" name="email_2" VALUE="<%=objRS("nm_assistente")%>" size="40" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
											</tr>
											<tr> 
												<td width="115"><font size="2" face="Verdana" color="0000cc">Endereço:</font></td>
												<td colspan="3"> 
													<input type="text" name="ds_endereco_correspondencia" VALUE="<%=objRS("ds_endereco_correspondencia")%>" size="40" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
												
											</tr>
											<tr> 
												<td width="115"><font size="2" face="Verdana" color="0000cc">Estado:</font></td>
												<td width="181"> 
													<input type="text" name="Estado_Correspondencia" VALUE="<%=objRS("Estado_Correspondencia")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
												<td width="159"><font size="2" face="Verdana" color="0000cc">Município:</font></td>
												<td width="280"> 
													<input type="text" name="ds_UF" size="20" VALUE="<%=objRS("ds_UF")%>" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
											</tr>
											<tr> 
												<td width="115"><font size="2" face="Verdana" color="0000cc">CEP:</font></td>
												<td width="181"> 
													<input type="text" name="CEP_Correspondencia" VALUE="<%=objRS("CEP_Correspondencia")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
												<td width="159"><font size="2" face="Verdana" color="0000cc">País:</font></td>
												<td width="280"> 
													<input type="text" name="Pais_Correspondencia" VALUE="<%=objRS("Pais_Correspondencia")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
											</tr>
											<tr> 
												<td width="115"><font size="2" face="Verdana" color="0000cc">Descrição:</font></td>
												<td width="181"> 
													<input type="text" name="Descricao" VALUE="<%=objRS("Descricao")%>" size="20" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;">
												</td>
											  <td><font size="2" face="Verdana" color="0000cc">Foto/URL:</font></td>
											  <td> 
												<input name="foto" type="text" id="foto" VALUE="<%=objRS("foto")%>" style="font-family: Verdana; font-size: 8 pt;COLOR: 0000CC;"  size="20"/>
											  </td>
											</tr>
											<tr> 
											  <td colspan="4"><font size="2" face="Verdana" color="0000cc">Comentário:</font><br>
												<textarea name="ds_comentario" rows="4" cols="80" onKeyUp="ContarTexto(this, 100, 'ds_comentario')">
												<%=trim(objRS("ds_comentario"))%>
												</textarea>
												<div id="ds_comentario" class="label_left"><%=(100 - len(ds_comentario))%> caracteres restantes</div>
												<input type="hidden" name="id_contato" value="<%=objRS("id_contato")%>"> 
											  </td>
											</tr>
											<tr> 
												<td colspan="2"> 
													<p align="center"> 
														<input type="button" value= "Salvar" name="Salvar" onClick="acao_Salvar()"/>
														<!--<input type="submit" value="Salvar" name="salvar">-->
													</p>
												</td>
												<td colspan="2"> 
													<p align="center"> 
														<input type="button" value= "Duplicar" name="Duplicar" onClick="acao_Duplicar()"/>
														<!--<input type="submit" value="Duplicar" name="duplicar">-->
													</p>
												</td>
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
<%
'Força o programador a declarar todas as variáveis, evitando erro de digitação no uso das variéveis
Option Explicit
%>
<!-- #include FILE = "..\inc\inc_Conexao.asp" -->
<%
'Não deixa informações no Cache
Response.Expires = 0

'Declaração das variáveis
Dim objConn, strQuery, sql_query, RsQuery, campo, sql, cod_Pacote, ObjRs

'Atrubuição dos valores as respectivas variáveis
	dim desc_Pacote    : desc_Pacote         = TRIM(request.form("desc_Pacote")) & ""
	dim valor_Pacote   : valor_Pacote        = TRIM(request.form("valor_Pacote")) & ""
	

'--------------------------------------------------
cod_Pacote          = trim(Request.Form("cod_Pacote"))

Set objConn =  Server.CreateObject("ADODB.Connection")
objConn.Open "DBQ=" & Server.MapPath(Caminho_Banco) & ";Driver={Microsoft Access Driver (*.mdb)}","username","password"

                       strQuery = "UPDATE Pacote "
            strQuery = strQuery & "   SET desc_Pacote      = '" & desc_Pacote & "',"
            strQuery = strQuery & "       valor_Pacote     = '" & valor_Pacote & "'"
            strQuery = strQuery & " WHERE cod_Pacote       =  " & cod_Pacote

Set ObjRs = objConn.Execute(strQuery)
objConn.close
Set objRs = Nothing
Set objConn = Nothing 
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
    <div class="title_box">Ações</div>
        <!-- #include FILE = "..\inc\menu_acoes_Pacote.asp" -->

     <div class="banner_adds">
     <br><br><br><br><br><br><br><br><br><br>
     </div>
    </div>

   <div class="center_content">
		<div class="center_title_bar">Cadastro de serviços</div>
		<br><br><br><br>
	<fieldset>


	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
		<td>
			<%if err = 0 Then%>
			<table border="0" width="100%" height="8" cellpadding="2" align="center">
				<tr bgcolor="#0099FF"> 
					<td colspan="7" height="1" align="center"> <font size="2" color="FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif"> 
						O Pacote <b>"<%=desc_Pacote%>"</b> foi alterado com sucesso!</font></b></font> 
					</td>
				</tr>
			</table>
			<%else%>
			  <div align="center"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Ocorreu algum erro!<br>Nenhum dado foi alterado!</font></b><br><a href="javascript:history.back(-1)">Volta</a></div><br>
			<%End if%>
		</td>
	  </tr>
      <tr>
      	<td align="center"><img src="..\img\solar.gif" width="200" height="200" border="0"/></td>
      </tr>
	</table>

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

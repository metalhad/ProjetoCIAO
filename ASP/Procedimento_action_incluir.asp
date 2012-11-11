<%
Option Explicit
%>
<!-- #include FILE = "..\inc\inc_Conexao.asp" -->
<!--#include file=..\inc\inc_dbFunctions.asp-->
<%

'form_show
'response.end
Response.Expires = 0

	Dim objConn, strQuery, sql_query, RsQuery, sql, ObjRs

	dim Desc_Procedimento         : Desc_Procedimento       = TRIM(request.form("Desc_Procedimento")) & ""
	dim Valor_Procedimento        : Valor_Procedimento      = TRIM(request.form("Valor_Procedimento")) & ""
	dim dtCad                     : dtCad                   = TRIM(request.form("dtCad")) & ""
	dim UserCad                   : UserCad                 = TRIM(request.form("UserCad")) & ""
	
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
        <!-- #include FILE = "..\inc\menu_acoes_procedimento.asp" -->

     <div class="banner_adds">
     <br><br><br><br><br><br><br><br><br><br>
     </div>
    </div>

   <div class="center_content">
		<div class="center_title_bar">Cadastro de Procedimentos</div>
		<br><br><br><br>
	<fieldset>


	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr> 
		<td>
			<%
				Set objConn =  Server.CreateObject("ADODB.Connection")
				objConn.Open "DBQ=" & Server.MapPath(Caminho_Banco) & ";Driver={Microsoft Access Driver (*.mdb)}","username","password"
				strQuery = "INSERT INTO Procedimento (Desc_Procedimento) VALUES ('"&Desc_Procedimento& "')"
					
				On error Resume Next
					'response.write strQuery
					'response.end
				Set ObjRs = objConn.Execute(strQuery)

				objConn.close

				Set objRs = Nothing
				Set objConn = Nothing 
				if err = 0 Then
			%>
			<table border="0" width="100%" height="8" cellpadding="2" align="center">
				<tr bgcolor="#0099FF"> 
					<td colspan="7" height="1" align="center"> <font size="2" color="FFFFFF"><b><font face="Verdana, Arial, Helvetica, sans-serif">Seus 
						A descrição "<b><%=Desc_Procedimento%></b>" foi incluida com sucesso!</font></b></font> 
					</td>
				</tr>
			</table>
			<%else%>
			  <div align="center"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">Ocorreu algum erro!<br>Nenhum dado foi incluido!</font></b><br><a href="javascript:history.back(-1)">Volta</a></div><br>
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
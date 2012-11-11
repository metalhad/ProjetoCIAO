<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Easy Tooltip jQuery Plugin Demo</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/easyTooltip.js"></script>
<script type="text/javascript"> 
	$(document).ready(function(){	
		$("a").easyTooltip();
		$("a#link").easyTooltip({
			tooltipId: "easyTooltip2",
			content: 'Ricardo bola!'
		});
	});
</script>
</meta>
 
<style> 

 
#easyTooltip{
	padding:5px 10px;
	border:1px solid #195fa4;
	background:#195fa4 url(img/bg.gif) repeat-x;
	color:#fff;
	}
 
#easyTooltip2{
	padding:5px 10px;
	border:1px solid #5e5e5e;
	background:#5e5e5e url(img/bg2.gif) repeat-x;
	color:#fff;
	width:250px;
	}
#easyTooltip2 h4, #easyTooltip2 p{
	margin:.25em 0;
	}	
					
 
/* // Easy Tooltip */
 
</style>
</head>
<body>
 <br><br><br><br><br><br>
<a id="link">VER</a> 
 
</body>
</html>


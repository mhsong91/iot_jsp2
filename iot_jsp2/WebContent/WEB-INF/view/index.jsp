<%
if(user==null){
	//response.sendRedirect("/view/user/login");
}else{
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IOT_TEST</title>
</head>people
<link href="https://fonts.googleapis.com/css?family=Sedgwick+Ave+Display" rel="stylesheet">

<body style="font-family:'Sedgwick Ave Display', cursive;background:url('https://yt3.ggpht.com/-40idQSHbE9w/AAAAAAAAAAI/AAAAAAAAAAA/YFYGNM4KG34/s900-c-k-no-mo-rj-c0xffffff/photo.jpg')">
	<jsp:include page="/WEB-INF/view/common/header.jspf" flush="false" />
    <div class="container">

      <div class="starter-template">
        <h1 style="color:white" ><%=user.getUiName()%>WelCome</h1>
        <p style="color:white" class="lead">Use this document as a way to quickly start any new project.<br> All you get is this text and a mostly barebones HTML document.</p>
      </div>
    </div><!-- /.container -->
</body>
</html>
<%
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<link rel="stylesheet" href="<%=rootPath%>/ui/css/lonin2.css" />
<link href="https://fonts.googleapis.com/css?family=Sedgwick+Ave+Display" rel="stylesheet">
<body style="background:url('https://t1.daumcdn.net/thumb/R1280x0/?fname=http://t1.daumcdn.net/brunch/service/user/H9i/image/nu1ONAy2csYfnCxOSsE_xIAKn0o.jpg');
font-family: 'Sedgwick Ave Display', cursive;">
	<jsp:include page="/WEB-INF/view/common/header.jspf" flush="false" />
        <div class="contact-section">
            <div class="container">
            <form action="" method="post" name="Login_Form" class="form-signin">  
              <h2 style="color:white">hi people</h2>
              <p style="color:white">login please</p>
              <div class="row">
                <div class="col-md-8 col-md-offset-2">
                  <form class="form-horizontal">
                    <div class="form-group">
                      <label for="userId" class="sr-only">Name</label>
                      <input type="text" id="userId" name="userId" class="form-control"
					placeholder="ID" autofocus>
                    </div>
                    <div class="form-group">
                      <label label for="userPwd" class="sr-only">Password</label>
                      <input type="password" id="userPwd" name="userPwd" class="form-control"
					placeholder="Password">
                    </div>
                    <input type="checkbox" id="saveId"><a style="color:white">IdSave</a>
                    <input type="button"
					id="loginBtn" value="LogIn" onclick="checkValue()">
					<a style="color:white" href="<%=rootPath%>/view/user/signin"
					id="loginBtn">SingIn</a>
                  </form>
	
                  <hr>
                    
                  </form>	
                </div>
              </div>
            </div>
        </div>
     
</body>
<script>

function checkValue(){
	var objs = $(".container");
	var userId = $("#userId").val().trim();
	var userPwd = $("#userPwd").val().trim();
	var saveId=$("#saveId").prop("checked");
	
	
	if(userId.length<1){
		alert("유저아이디 확인해!!");
		$("#userId").focus();
		return;
	}
	if(userPwd.length<1){
		alert("비밀번호 확인해!!");
		$("#userPwd").focus();
		return;
	}
	
	var param = {uiId:userId, uiPwd:userPwd, isSaveId:saveId};
	
	param = "param=" + encodeURIComponent(JSON.stringify(param));
	$.ajax({
		url : '<%=rootPath%>/user/login',
		data : param,
		type :'get',
		success:function(res){
			var obj = JSON.parse(res);
			alert(obj.msg);
			if(obj.login=="ok"){
				location.href="<%=rootPath%>/";
			}
		}
	})
}

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

$(document).ready(function(){
   var userId = getCookie("userId");
   var saveId = getCookie("saveId");
   if(userId){
      $("#userId").val(userId);
      $("#saveId").prop("checked",true);
   }
});


</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body style="font-family: 'Sedgwick Ave Display', cursive;background:url('https://frontview.files.wordpress.com/2011/10/black-fax.jpg')">
	<jsp:include page="/WEB-INF/view/common/header.jspf" flush="false" />

	<div class="container">
		<div class="starter-template">

			<form class="form-signin">
				<table class="table" style="color:white">
					
					<tr>
						<th>ClassName</th>
						<td><input type="text" id="ciName" name="ciName"
							class="form-control" placeholder="ClassName"></td>
					</tr>
					<tr>
						<th>Description</th>
						<td><input type="text" id="ciDesc" name="ciDesc"
							class="form-control" placeholder="Description"></td>
					</tr>
				
					<tr>
						<td colspan="2"> 
							<input class="btn btn-lg btn-primary btn-block" type="button"
								id="singnBtn" value="Success" onclick="insert()">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
<script>
function insert(){
	//"uiName,uiAge,uiId,uiPwd,ciNo,address"
	
	var ciName = $("#ciName").val().trim();
	var ciDesc = $("#ciDesc").val().trim();
	
	var param= {ciName:ciName, ciDesc:ciDesc};
	
	param = "param=" + JSON.stringify(param);
	
	$.ajax({
		url : '/class/insert',
		type : 'post',
		data : param,
		success:function(res){
			var obj = JSON.parse(res);
			alert(obj.msg);
			if(obj.result=="ok"){
				location.href="/view/class/list";
			}
		},
		error:function(xhr,status,error){
			
		}		
	})
}
$(document).ready(function(){
	$.ajax({
		url : '/class/list',
		type : 'get',
		success:function(res){
			var list = JSON.parse(res);
			var str = "";
			for(var ci of list){
				str += "<option value='" + ci.ciNo + "'>" + ci.ciName +"</option>";
			}
			//document.getElementById("ciNo").insertAdjacentHTML("beforeend",str);
			$("#ciNo").html(str);
		},
		error:function(xhr,status,error){
			
		}
	});
	
});
</script>
</html>
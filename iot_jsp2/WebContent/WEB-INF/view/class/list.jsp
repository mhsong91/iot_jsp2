<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link href="https://fonts.googleapis.com/css?family=Sedgwick+Ave+Display" rel="stylesheet">
<body style="font-family: 'Sedgwick Ave Display', cursive; background:url('http://cfs13.tistory.com/image/15/tistory/2009/02/24/20/40/49a3dcab401a9')">
<jsp:include page="/WEB-INF/view/common/header.jspf" flush="false" />

	<div>
	<button style="background:white; display:block; margin-left: 90%; width:100px " type="button" class="btn btn-sm btn-primary btn-create">Search</button>
	</div>
	<style>
#grid1 th{
text-align:center;

}
</style>
	<table style="background-color:black;color:white;width:100%; text-align:center; " id="grid1" data-key="ciNo">
	
	<thead >
	<tr>
		
<th data-field="ciNo,ro">ClassNo</th>
<th data-field="ciName,txt">ClassName</th>
<th data-field="ciDesc,txt">Description</th>
<th data-field="BTN"><em class="glyphicon glyphicon-asterisk"></em></th>
	</tr>
		</thead>
		
		<tbody  id="result_tb" style="background-color:black;color:white"	>
		</tbody>
</table>
	<a style="color:white" href="<%=rootPath%>/view/class/newclass"	id="loginBtn"><h3>NewClass</h3></a>
</body>
<script>

function deleteClass(ciNo){
	var isDelete = confirm("진짜 지울거야?");
	alert(isDelete);
	var param="ciNo="+ciNo;
	if(isDelete){
		$.ajax({
			url : '/class/delete',
			type : 'post',
			data: param,
			dataType:"json",
			success:function(res){
				alert(res.msg);
				if(res.result=='ok'){
					location.reload();
				}
			},
			error:function(xhr,status,error){
				
			}
		})
	}
}
function updateClass(ciNo){
	var isupdate =confirm("수정할꺼야?");
	alert(isupdate);
	if(isupdate){
	var ciName=$("#ciName"+ciNo).val().trim();
	var ciDesc=$("#ciDesc"+ciNo).val().trim();
	var param={ciNo:ciNo,ciName:ciName,ciDesc:ciDesc};
	param="param="+JSON.stringify(param);

	$.ajax({
		url : '/class/update',
		type : 'post',
		data: param,
		dataType:"json",
		success:function(res){
			alert(res.msg);
			if(res.result=='ok'){
				location.reload();
			}
		},
		error:function(xhr,status,error){
			
		}
	})
	}
}

var colsInfo = [];
$(document).ready(function(){
	var colList = $("#grid1 th[data-field]");
	for(var i=0;i<colList.length;i++){
		colsInfo.push(colList[i].getAttribute("data-field"));
	}
	var keyCol = $("#grid1").attr("data-key");
	
	$.ajax({
		url : '/class/list',
		type : 'get',
		success:function(res){
			var list = JSON.parse(res);
			var str ="";
			for(var uc of list){
				var key = uc[keyCol];
				str += "<tr>";
				for(var field of colsInfo){
					str += "<td class='text-center'>";
					if(field=="BTN"){
						str += '<a class="btn btn-default"onclick="updateClass(' + key + ')"><em class="glyphicon glyphicon-refresh"></em></a>';
						str += '<a class="btn btn-danger"  onclick="deleteClass(' + key + ')"><em class="glyphicon glyphicon-trash"></em></a>';
					}else{
						var colName=field.split(",")[0];
						var colType=field.split(",")[1];
						if(colType=="ro"){
							str += uc[colName];
						}else{
							str +=  "<input style='background:black; color: white; type ='text' id='"+colName+key+"' value='"+uc[colName]+"'>";
						}
						//str +=  "<input type ='text' value='"+uc[field]+"''>";
					}
					str += "</td>";
				}
				str += "</tr>";
			}
			$("#result_tb").html(str);
		},
		error:function(xhr,status,error){
		}
	});
	
});
</script>
</html>
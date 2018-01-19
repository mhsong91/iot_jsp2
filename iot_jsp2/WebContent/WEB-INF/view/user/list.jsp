<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link href="https://fonts.googleapis.com/css?family=Sedgwick+Ave+Display" rel="stylesheet">
<link rel="stylesheet" href="<%=rootPath%>/ui/css/list.css" />
<jsp:include page="/WEB-INF/view/common/header.jspf" flush="false" />
<style>
#grid1 th{
text-align:center;

}
</style>
<body style="font-family: 'Sedgwick Ave Display', cursive; background:url('http://cfs13.tistory.com/image/15/tistory/2009/02/24/20/40/49a3dcab401a9')">

	<div>
	<button style="background:white; display:block; margin-left: 90%; width:100px " type="button" class="btn btn-sm btn-primary btn-create">Search</button>
	</div>
	
	
	<table style="background-color:black;color:white;width:100%; text-align:center;" id="grid1" data-key="uiNo" >
	
	<thead >
	<tr>
		<th  data-field="uiNo,ro">Number</th>
		<th  data-field="uiName,txt">Name</th>
		<th  data-field="uiId,ro">ID</th>
		<th  data-field="uiAge,txt">Age</th>
		<th  data-field="uiRegdate,ro">Date</th>
		<th  data-field="address,txt">Address</th>
		<th  data-field="BTN"><em class="glyphicon glyphicon-cog"></em></th>
	</tr>
		</thead>
		
		<tbody  id="result_tb" style="background-color:black;color:white"	>
		</tbody>
</table>
	

</body>
<script>
function deleteUser(uiNo){
	var isDelete = confirm("진짜 지울거야?");
	alert(isDelete);
	var param="uiNo="+uiNo;
	if(isDelete){
		$.ajax({
			url : '/user/delete',
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
function updateUser(uiNo){
	var isupdate=confirm("수정할꺼야?");
	alert(isupdate);
	if(isupdate){
	var uiName=$("#uiName"+uiNo).val().trim();
	var uiAge=$("#uiAge"+uiNo).val().trim();
	var address=$("#address"+uiNo).val().trim();
	var param={uiNo:uiNo,uiName:uiName,uiAge:uiAge,address:address};
	param="param="+JSON.stringify(param);

	$.ajax({
		url : '/user/update',
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
		url : '/user/list',
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
						str += '<a class="btn btn-default"onclick="updateUser(' + key + ')"><em class="glyphicon glyphicon-repeat"></em></a>';
						str += '<a class="btn btn-danger"  onclick="deleteUser(' + key + ')"><em class="glyphicon glyphicon-remove"></em></a>';
					}else{
						var colName=field.split(",")[0];
						var colType=field.split(",")[1];
						if(colType=="ro"){
							str += uc[colName];
						}else{
							str +=  "<input style='background:black; color: white;'type ='text' id='"+colName+key+"' value='"+uc[colName]+"'>";
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
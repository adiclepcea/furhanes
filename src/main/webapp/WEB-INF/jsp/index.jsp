<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link type="text/css" rel="stylesheet" href="<spring:url value='/resources/css/bootstrap.min.css'/>" />
    <link type="text/css" rel="stylesheet" href="<spring:url value='/resources/css/main.css'/>" />
    <script src="<spring:url value='/resources/js/jquery-3.2.1.min.js'/>" ></script>
    <script src="<spring:url value='/resources/js/bootstrap.min.js'/>" ></script>
    
    <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">-->
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
  <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
  
<title>Hanes - Suppliers</title>
</head>
<body>
	<c:url value="/furhanes-logout" var="logoutUrl" />
	<c:url value="/login/" var="loginUrl" />
	<nav class="navbar navbar-default">
	  <div class="container-fluid">
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>                        
	      </button>
	      <a class="navbar-brand" href="#">Hanes -Suppliers</a>
	    </div>
	    <div class="collapse navbar-collapse" id="myNavbar">
	      <ul class="nav navbar-nav">
	      	<li class="active menu-item" id="mnuHome"><a href="#" onclick="goHome()">Home</a></li>
	        <li class="menu-item" id="mnuSuppliers"><a href="#"onclick="showSuppliersList()">Suppliers</a></li>
	        <li class="menu-item" id="mnuPOs"><a href="#">POs</a></li>
	        <li class="menu-item" id="mnuReceptions"><a href="#">Receptions</a></li>
	        <li class="menu-item" id="mnuStock"><a href="#">Stock</a></li>
	      </ul>
	      <ul class="nav navbar-nav navbar-right">
	        <li><a href="#"><span class="glyphicon glyphicon-user"></span> Users </a></li>
	        <%  if(request.getRemoteUser()==null) {%>
	        	<li><a href="${loginUrl}" ><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
	        <%}else{ %>
	        	<li><a href="#" onclick="logout()"><span class="glyphicon glyphicon-log-out"></span>Logout <%=request.getRemoteUser()%> </a></li>
	        <%} %>
	      </ul>
	    </div>
	  </div>
	</nav>
	
	<div id="container" class="container-fluid">
	
		
	</div>
	<div class="">
		<ul class="pager">
			<li><a href="#">Previous</a></li>
			<li><a href="#">Next</a></li>
		</ul>
	</div>
	<form id="f-logout" action="${logoutUrl}" method="post">
	  <input type="hidden" id="csrf"
		name="${_csrf.parameterName}"
		value="${_csrf.token}" />
	</form>
	
	<script type="text/javascript">
		function showSuppliersList(){			
			$.ajax({
				url:"suppliers/list",
				error:function(err){
					if(err.status==403){
						window.location.replace("${loginUrl}?error=Please%20login%20to%20access%20this%20area");
					}
					else{
						alert(JSON.stringify(err));
					}
				}
			}).done(function(data){
				$("#container").html(data);
				$(".menu-item").removeClass("active");
				$("#mnuSuppliers").addClass("active");
			});
			
		}
		
		function logout(){
			$("#f-logout").submit();
		}
		
		function populateSupplierEdit(id){
			//if the element is not shown yet, then populate it
			if(!$("#edit_"+id).is(":visible")){
				$("#supplier_edit_"+id).html("<img src="+"<spring:url value='/resources/images/Loading_icon.gif'/>"+"/>");
				$.ajax({
					url:"suppliers/input?id="+id,
					error:function(err){
						alert("Error requesting supplier data:\r\n"+err);
					},
					success:function(data){
						$("#supplier_edit_"+id).html(data);
					}
				});
			}
		}
		function saveSupplier(){
			
			var supplier={};
			supplier.id = $("#supplier_id").val();
			supplier.name = $("#supplier_name").val();
			supplier.address = $("#supplier_address").val();
			supplier.cui = $("#supplier_cui").val();
			supplier.j = $("#supplier_j").val();
			supplier.mail = $("#supplier_mail").val();
			supplier.fax = $("#supplier_fax").val();
			supplier.iban = $("#supplier_iban").val();
			supplier.bank = $("#supplier_bank").val();
			supplier.swift = $("#supplier_swift").val();
			supplier.phone = $("#supplier_phone").val();
			alert(JSON.stringify(supplier));
			$.ajax({
				url:("suppliers/"+((supplier.id==0)?"":supplier.id)),
				headers: {"Accept":"application/json","Content-Type": "application/json","X-CSRF-TOKEN":$("#csrf").val()},
				type: ((supplier.id==0)?"POST":"PUT"),
				contentType: "application/json; charset=utf-8",
				data:JSON.stringify(supplier),
				
				cache:false,
				processData:false,				
				error:function(err){
					console.log(err);
					alert("Error saving supplier:\r\n"+JSON.stringify(err));
				},
				success:function(data){
					alert(JSON.stringify(data));
				}
			});
		}
		
	</script>
</body>
</html>
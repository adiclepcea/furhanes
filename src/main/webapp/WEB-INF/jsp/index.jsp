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
 	<link type="text/css" rel="stylesheet" href="<spring:url value='/resources/css/jquery-ui.min.css'/>" />
    <link type="text/css" rel="stylesheet" href="<spring:url value='/resources/css/main.css'/>" />
    <script src="<spring:url value='/resources/js/jquery-3.2.1.min.js'/>" ></script>
    <script src="<spring:url value='/resources/js/bootstrap.min.js'/>" ></script>
    <script src="<spring:url value='/resources/js/jquery-ui.min.js'/>" ></script>
    <script src="<spring:url value='/resources/js/Chart.bundle.min.js'/>" ></script>
    <script src="<spring:url value='/resources/js/suppliers.js'/>" ></script>
    
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
	        <li class="dropdown menu-item" id="mnuSuppliers">
	        	<a href="#" class="drowpdown-toggle" data-toggle="dropdown" role="button" area-hashpopup="true" area-expanded="false">
	        	Suppliers<span class="caret"></span></a>
	        	<ul class="dropdown-menu">
	        		<li><a href="#" onclick="startPositionSupplier=0;showSuppliersList()">Supplier list</a></li>
	        		<li><a href="#" onclick="startPositionContract=0;showContractsList()">Contract list</a></li>
	        	</ul>
	        </li>
	        <li class="menu-item" id="mnuPOs"><a href="#" onclick="notYetImplemented('mnuPOs')">POs</a></li>
	        <li class="menu-item" id="mnuReceptions" onclick="notYetImplemented('mnuReceptions')"><a href="#">Receptions</a></li>
	        <li class="menu-item" id="mnuStock" onclick="notYetImplemented('mnuStock')"><a href="#">Stock</a></li>
	      </ul>
	      <ul class="nav navbar-nav navbar-right">
	        <li><a href="#" onclick="showUsers()"><span class="glyphicon glyphicon-user"></span> Users </a></li>
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
		<div class="col-md-3 col-sm-6">
			<div class="panel panel-default">
				<div class="panel-heading">
					Contracts
				</div>
				<div class="panel-body">
					<canvas id="contractsGraph"></canvas>					
				</div>
			</div>
		</div>
		<div  class="col-md-4 col-sm-6">
		<div class="panel panel-default">
		  <div class="panel-heading">Done</div>
		  <div class="panel-body">
		  	<ul>
		  		<li>Background for security (database, and setup in config)</li>
		  		<li>Database layout for:
		  			<ul>
		  				<li>Security (users, roles, rigts)</li>
		  				<li>Suppliers</li>
		  				<li>Contacts</li>
		  				<li>Contracts</li>
		  			</ul>
		  		</li>
		  		<li>Add, modify and delete suppliers</li>
		  		<li>Add, modify and delete contacts</li>
		  		<li>Add, modify and delete contracts</li>
		  		<li>Show notifications for expiring/expired contracts</li>
		  	</ul>
		  </div>
		</div>
		</div>
		
		<div class="col-md-5 col-sm-6">
		<div class="panel panel-default">
		  <div class="panel-heading">TO DO</div>
		  <div class="panel-body">
		  	<ul>
		  		<li>Database layout for:
		  			<ul>
		  				<li>POs</li>
		  				<li>Stock</li>
		  				<li>Receptions</li>
		  				<li>Locations</li>
		  				<li>etc.</li>
		  			</ul>
		  		</li>		  				  		
		  		<li>Add, modify and delete POs</li>
		  		<li>Add, modify and delete receptions</li>
		  		<li>Reports</li>
		  		<li>User rights interface</li> 
		  	</ul>
		  </div>
		</div>
		</div>				
	</div>
	
	<form id="f-logout" action="${logoutUrl}" method="post">
	  <input type="hidden" id="csrf"
		name="${_csrf.parameterName}"
		value="${_csrf.token}" />
	</form>
	
	<script type="text/javascript">
		var startPositionSupplier = 0;
		var countPositionsSupplier = 10;
		var startPositionContract = 0;
		var countPositionsContract = 10;
		
		$(document).ready(function(){
			setTimeout(drawContractsGraph(),1);
		})
		
		function isInt(value) {
			  return !isNaN(value) && 
			         parseInt(Number(value)) == value && 
			         !isNaN(parseInt(value, 10));
			}
		
		function goHome(){
			window.location.replace(".");
		}
		
		function drawContractsGraph(){
			$.ajax({
				url:"./v1/contracts/statistics",
				type:"GET",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				success: function(data){				
					drawGraphContractsOnCanvas(data);
				},
				error: function(err){
					if(err.hasOwnProperty("status") && (err.status==403 || err.status==401)){
						alert("Please relogin!");
						window.location.replace(".");
						return;
					}
					
					console.log(JSON.stringify(err));
					
				}
			});			
		}
		
		function drawGraphContractsOnCanvas(ajaxData){
			var ctx = document.getElementById('contractsGraph').getContext('2d');
			
			ctx.canvas.width = 100;
			ctx.canvas.height = 100;
			var data = {
				datasets: [{
					data: [ajaxData.running,ajaxData.finished,ajaxData.expired,ajaxData.expiring],
					backgroundColor:[
						'#31B404',
						'#A9D0F5',
						'red',
						'yellow'
					]
				}],
				labels: [
					'Valid',
					'Finished',
					'Expired',
					'Expiring'
				]
				
				
			};
			
			var contractsPieChart = new  Chart(ctx,{
				type: 'pie',
				data: data,
				options:{}
			});
		}
		
		function notYetImplemented(mnu){
			$("#container").html("<strong>Sorry, this feature is not yet implemented!</strong>");
			$(".menu-item").removeClass("active");
			$("#"+mnu).addClass("active");
		}
		
		function logout(){
			$("#f-logout").submit();
		}
		
		function showError(element,message){
			$("#"+element).html("<div class='alert alert-danger'>"+message+"</div>");
		}
		
		function processError(element,err){
			switch(err.status){
			case 401:
				showError(element,"You need to relogin!");
				break;
			case 403:
				showError(element,"You do not have access here. Please login with other credentials that have access here.!");
				break;
			default:
				showError(element,"Response status: "+err.status);							
			}
		}
		
		
		function showUsers(){
			
		}
		
		
	</script>
</body>
</html>
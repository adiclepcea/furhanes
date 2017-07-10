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
	        <li class="menu-item" id="mnuUsers"><a href="#" onclick="showUsers()"><span class="glyphicon glyphicon-user"></span> Users </a></li>
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
			$.ajax({
				url:"users/list",
				type: "GET",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				success: function(data){
					$("#container").html(data);
					$(".menu-item").removeClass("active");
					$("#mnuUsers").addClass("active");
				},
				error: function(err){
					if(err.hasOwnProperty("status") && (err.status==403 || err.status==401)){
						alert("Please relogin!");
						window.location.replace(".");
						return;
					}else{
						alert(err);
					}
					
					console.log(JSON.stringify(err));
				}
				
			});
		}
		
		function populateUserEdit(id){
			$.ajax({
				url:"v1/users/"+id,
				type:"GET",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				success: function(data){
					//roles
					var roles = data.roles;
					$("#chkrole_"+id).attr("checked",false);
					roles.forEach(function(role){
						$("#"+role.id+"_"+id).attr("checked",true);
					});
					//details
					$("#update_user_name_"+id).val(data.username);
					$("#update_user_firstname_"+id).val(data.firstName);
					$("#update_user_lastname_"+id).val(data.lastName);
					$("#update_user_email_"+id).val(data.email);
					
					console.log(JSON.stringify(data));
				},
				error: function(err){
					if(err.hasOwnProperty("status") && (err.status==403 ||err.status==401)){
						alert("Please relogin!");
						window.location.replace(".");
						return;
					}else{
						alert(err);
					}
					console.log(JSON.stringify(err));
				}
			});
		}
		
		function addUser(){
			var rez = validateNewUser();
			if(!rez){
				return;
			}
			
			console.log(JSON.stringify(rez));
			
			$.ajax({
				url:"v1/users",
				type: "POST",
				headers: {"Accept":"application/json","Content-Type": "application/json","X-CSRF-TOKEN":$("#csrf").val()},
				data: JSON.stringify(rez),
				success: function(data){
					//alert(JSON.stringify(data));
					showUsers();
				},
				error:  function(err){
					if(err.hasOwnProperty("status") && (err.status==403 ||err.status==401)){
						alert("Please relogin!");
						window.location.replace(".");
						return;
					}else{
						alert(err);
					}
					console.log(JSON.stringify(err));
				}
			});
			
		}
		
		function validateNewUser(){
			var user = {};
			if($("#add_user_name").val()==""){
				alert("Please fill in the username");
				$("#add_user_name").focus();
				return false;
			}
			if($("#add_user_pass").val()==""){
				alert("Please choose a password!");
				$("#add_user_pass").focus();
				return false;
			}
			if($("#add_user_pass").val()!=$("#add_user_pass_confirm").val()){
				alert("The passwords you choose do not match!");
				$("#add_user_pass").focus();
				return false;
			}
			user.username = $("#add_user_name").val();
			if($("#add_user_pass_confirm_"+id).val() == $("#add_user_pass").val()){
				user.pass = $("#add_user_pass").val();
			}else{
				user.pass = null;
			}
			user.firstName = $("#add_user_firstname").val();
			user.lastName = $("#add_user_lastname").val();
			user.email = $("#add_user_email").val();
			user.roles = [];
			user.enabled = true;
			
			return user;
		}
		
		function validateUser(id){
			var user = {};
			if($("#update_user_name_"+id).val()==""){
				alert("Please fill in the username");
				$("#update_user_name_"+id).focus();
				return false;
			}
			if($("#update_user_pass_"+id).val()!=$("#update_user_pass_confirm_"+id).val()){
				alert("The passwords you choose do not match!");
				$("#update_user_pass_"+id).focus();
				return false;
			}
			user.id = id;
			user.username = $("#update_user_name_"+id).val();
			if($("#update_user_pass_confirm_"+id).val() == $("#update_user_pass_"+id).val()){
				user.pass = $("#update_user_pass_"+id).val();
			}else{
				user.pass = null;
			}
			user.firstName = $("#update_user_firstname_"+id).val();
			user.lastName = $("#update_user_lastname_"+id).val();
			user.email = $("#update_user_email_"+id).val();
			user.roles = [];
			user.enabled = true;
			 
			$(".chkrole_"+id).each(function(index,elem){
				if(elem.checked){
					var role = {};
					role.id = parseInt(elem.id.substr(0,elem.id.indexOf("_")));
					role.name = elem.parentElement.textContent.trim();
					user.roles.push(role);
				}
			});
			
			return user;
		}
		
		function saveUser(id){
			var rez = validateUser(id); 
			if(!rez){
				return;
			}
			
			console.log(JSON.stringify(rez));
			
			$.ajax({
				url:"v1/users/"+id,
				type: "PUT",
				headers: {"Accept":"application/json","Content-Type": "application/json","X-CSRF-TOKEN":$("#csrf").val()},
				data: JSON.stringify(rez),
				success: function(data){
					//alert(JSON.stringify(data));
					showUsers();
				},
				error:  function(err){
					if(err.hasOwnProperty("status") && (err.status==403 ||err.status==401)){
						alert("Please relogin!");
						window.location.replace(".");
						return;
					}else{
						alert(err);
					}
					console.log(JSON.stringify(err));
				}
			});
		}
		
		function deleteUser(id){
			if(!confirm("Are you sure you want to delete this user?")){
				return;
			}
			$.ajax({
				url:"v1/users/"+id,
				type:"DELETE",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				success: function(data){
					//alert("Deleted");
					showUsers();
				},
				error: function(err){
					if(err.hasOwnProperty("status") && (err.status==403 ||err.status==401)){
						alert("Please relogin!");
						window.location.replace(".");
						return;
					}else{
						alert(err);
					}
					console.log(JSON.stringify(err));					
				}
			});
		}
		
		function populateRoleEdit(id){
			$.ajax({
				url:"v1/users/roles/"+id,
				type:"GET",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				success: function(data){
					//roles
					var rights = data.rights;
					$("#chkright_"+id).attr("checked",false);
					rights.forEach(function(right){						
						$("#right_"+right.id+"_"+id).attr("checked",true);
					});
					
					console.log(JSON.stringify(data));
				},
				error: function(err){
					if(err.hasOwnProperty("status") && (err.status==403 ||err.status==401)){
						alert("Please relogin!");
						window.location.replace(".");
						return;
					}else{
						alert(err);
					}
					console.log(JSON.stringify(err));
				}
			});	
		}
		
		function validateRole(id){
			var role = {};
			role.id =  id;
			role.name = $("#role_"+id).val();
			if(role.name==""){
				alert("Please choose a name for the role!");
				$("#role_"+id).focus();
				return false;
			}
			role.rights = [];
			
			$(".chkright_"+id).each(function(index,elem){
				if(elem.checked){
					var right = {};
					right.id = parseInt(elem.id.substr(6,elem.id.indexOf("_")));
					right.name = elem.parentElement.textContent.trim();
					role.rights.push(right);
				}
			});
			
			return role;
		}
		
		function saveRole(id){
			var rez = validateRole(id); 
			if(!rez){
				return;
			}
			
			console.log(JSON.stringify(rez));
			
			$.ajax({
				url:"v1/users/roles/"+id,
				type: "PUT",
				headers: {"Accept":"application/json","Content-Type": "application/json","X-CSRF-TOKEN":$("#csrf").val()},
				data: JSON.stringify(rez),
				success: function(data){
					//alert(JSON.stringify(data));
					showUsers();
				},
				error:  function(err){
					if(err.hasOwnProperty("status") && (err.status==403 ||err.status==401)){
						alert("Please relogin!");
						window.location.replace(".");
						return;
					}else{
						alert(err);
					}
					console.log(JSON.stringify(err));
				}
			});
		}
		
		function addRole(){
			var role = {};
			role.name = $("#add_role_name").val();
			if(role.name==""){
				alert("Please choose a name for the new role!");
				$("#add_role_name").focus();
				return;
			}
			role.roles=[];
			
			console.log(JSON.stringify(role));
			
			$.ajax({
				url:"v1/users/roles",
				type: "POST",
				headers: {"Accept":"application/json","Content-Type": "application/json","X-CSRF-TOKEN":$("#csrf").val()},
				data: JSON.stringify(role),
				success: function(data){
					//alert(JSON.stringify(data));
					showUsers();
				},
				error:  function(err){
					if(err.hasOwnProperty("status") && (err.status==403 ||err.status==401)){
						alert("Please relogin!");
						window.location.replace(".");
						return;
					}else{
						alert(err);
					}
					console.log(JSON.stringify(err));
				}
			});
			
		}
		
		function deleteRole(id){
			if(!confirm("Are you sure you want to delete this role?")){
				return;
			}
			$.ajax({
				url:"v1/users/roles/"+id,
				type:"DELETE",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				success: function(data){
					//alert("Deleted");
					showUsers();
				},
				error: function(err){
					if(err.hasOwnProperty("status") && (err.status==403 ||err.status==401)){
						alert("Please relogin!");
						window.location.replace(".");
						return;
					}else{
						alert(err);
					}
					console.log(JSON.stringify(err));					
				}
			});
		}
		
	</script>
</body>
</html>
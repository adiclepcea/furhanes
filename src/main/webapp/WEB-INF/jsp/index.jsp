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
	        		<li><a href="#" onclick="showSuppliersList()">Supplier list</a></li>
	        		<li><a href="#" onclick="showContractsList()">Contract list</a></li>
	        	</ul>
	        </li>
	        <li class="menu-item" id="mnuPOs"><a href="#" onclick="notYetImplemented('mnuPOs')">POs</a></li>
	        <li class="menu-item" id="mnuReceptions" onclick="notYetImplemented('mnuReceptions')"><a href="#">Receptions</a></li>
	        <li class="menu-item" id="mnuStock" onclick="notYetImplemented('mnuStock')"><a href="#">Stock</a></li>
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
		
		function incrementSupplierPos(){
			startPositionSupplier+=countPositionsSupplier;
			showSuppliersList();
		}
		
		function decrementSupplierPos(){			
			startPositionSupplier-=countPositionsSupplier;
			startPositionSupplier = Math.max(0,startPositionSupplier);
			showSuppliersList();
		}
		
		function filterSuppliers(){
			showSuppliersList($("#supplier_filter").val());
		}
		
		function showSuppliersList(name){
			passData = {}
			passData.startFrom = startPositionSupplier;
			passData.count = countPositionsSupplier;
			if(name){
				passData.name = name;
			}
			$.ajax({
				url:"suppliers/list",
				data: passData,
				error:function(err){
					if(err.hasOwnProperty("status") && err.status==403 ||err.status==401){
						window.location.replace(".");//"${loginUrl}?error=Please%20login%20to%20access%20this%20area");
					}
					else{
						processError("container",err);
					}
				}
			}).done(function(data){
				$("#container").html(data);
				$(".menu-item").removeClass("active");
				$("#mnuSuppliers").addClass("active");
				$("#supplier_filter").autocomplete({
					source: function(request, response){
						$.ajax({
							url:"v1/suppliers/filter",	
							headers: {"X-CSRF-TOKEN":$("#csrf").val()},
							type: "GET",
							data:{name:request.term},
							success: function(data){								
								response($.map(data,function(item){
									return{
										label:item.name,
										value:item.name
									}
								}));
							},
							error: function(err){
								console.log(err);
							}
						});
					},	
					minLength: 2
				});
			});
			
		}
		
		function populateSupplierEdit(id){
			//if the element is not shown yet, then populate it
			if(!$("#supplier_edit_"+id).is(":visible")){
				$("#supplier_edit_"+id).html("<img src="+"<spring:url value='/resources/images/Loading_icon.gif'/>"+"/>");
				$.ajax({
					url:"suppliers/input?id="+id,
					error:function(err){
						if(err.hasOwnProperty("status")){
							processError("supplier_edit_"+id,err);				
						}else{
							alert("Error requesting supplier data:\r\n"+err);
						}
					},
					success:function(data,  textStatus,  xhr){						
						$("#supplier_edit_"+id).html(data);
						$("#supplier_msg_"+id).hide();
					}
				});
			}
		}
		function saveSupplier(id){
			$("#supplier_form_"+id+" #supplier_name_group").removeClass("has-error");
			var supplier={};
			supplier.id = $("#supplier_form_"+id+" #supplier_id").val();
			supplier.name = $("#supplier_form_"+id+" #supplier_name").val();
			supplier.address = $("#supplier_form_"+id+" #supplier_address").val();
			supplier.cui = $("#supplier_form_"+id+" #supplier_cui").val();
			supplier.j = $("#supplier_form_"+id+" #supplier_j").val();
			supplier.mail = $("#supplier_form_"+id+" #supplier_mail").val();
			supplier.fax = $("#supplier_form_"+id+" #supplier_fax").val();
			supplier.iban = $("#supplier_form_"+id+" #supplier_iban").val();
			supplier.bank = $("#supplier_form_"+id+" #supplier_bank").val();
			supplier.swift = $("#supplier_form_"+id+" #supplier_swift").val();
			supplier.phone = $("#supplier_form_"+id+" #supplier_phone").val();
			
			if(supplier.name==""){
				$("#supplier_form_"+id+" #supplier_name_group").addClass("has-error");
				return;
			}
			
			console.log("Saving: "+JSON.stringify(supplier));
			
			$.ajax({
				url:("v1/suppliers/"+((supplier.id==0)?"":supplier.id)),
				headers: {"Accept":"application/json","Content-Type": "application/json","X-CSRF-TOKEN":$("#csrf").val()},
				type: ((supplier.id==0)?"POST":"PUT"),
				contentType: "application/json; charset=utf-8",
				data:JSON.stringify(supplier),
				
				cache:false,
				processData:false,				
				error:function(err){
					$("#supplier_msg_"+supplier.id).attr("class","alert alert-danger");
					if(err.hasOwnProperty("status")){						
						$("#supplier_msg_data_"+supplier.id).html("<strong>Error saving supplier</strong>: "+JSON.stringify(err));
					}else{
						$("#supplier_msg_data_"+supplier.id).html("<strong>Error saving supplier</strong>: "+err);	
					}
					$("#supplier_msg_"+supplier.id).show();
				},
				success:function(data){
					redrawSupplier(data);
					//$("#supplier_header_"+supplier.id).click();
					$("#supplier_msg_"+supplier.id).attr("class","alert alert-success");
					$("#supplier_msg_data_"+supplier.id).html("Supplier <strong>"+supplier.name+"</strong> was saved!");
					$("#supplier_msg_"+supplier.id).show();
					setTimeout(closeAddSupplierAndRefreshList(),2000);
				}
			});
		}
		
		function closeAddSupplierAndRefreshList(){
			closeAddSupplier();
			showSuppliersList();
		}
		
		function redrawSupplier(supplier){
			if(document.getElementById("supplier_header_"+supplier.id)!=null){
				
				$("#supplier_header_"+supplier.id).html(supplier.name);
				$("#supplier_details_"+supplier.id).html("<strong>CUI</strong>: "+supplier.cui + 
				", <strong>Phone</strong>: "+ supplier.phone + 
				", <strong>Fax</strong>: "+supplier.fax + 
				", <strong>E-Mail</strong>: "+ supplier.mail +
				", <strong>SWIFT</strong>: "+ supplier.swift + 
				", <strong>Address</strong>: "+ supplier.address);
				
			}
		}
		
		function addSupplier(){
			if(!$("#supplierAddDiv").is(":visible")){
				$("#supplierAddDiv").show();
				$("#supplierHeader").hide();
				$("#btnCancelAddSupplier").show();
				$("#suppliersList").hide();
				$.ajax({
					url:"suppliers/input",
					error:function(err){
						if(err.hasOwnProperty("status")){
							processError("#supplierAddDiv",err);				
						}else{
							alert("Error requesting supplier data:\r\n"+err);
						}
					},
					success:function(data,  textStatus,  xhr){						
						$("#supplierAddDiv").html(data);
						$("#supplier_msg_0").hide();
					}
				});
			}
		}
		
		function closeAddSupplier(){
			$("#supplierAddDiv").hide();
			$("#supplierHeader").show();
			$("#btnCancelAddSupplier").hide();
			$("#suppliersList").show();
		}
		
		function deleteSupplier(id,name){
			if(confirm("Are you sure you want to delete the selected supplier?")){
				$.ajax({
					url:"v1/suppliers/"+id,
					type:"DELETE",
					headers: {"X-CSRF-TOKEN":$("#csrf").val()},
					error:function(err){
						if(err.hasOwnProperty("status") ){
							if(err.status==401){
								window.location.replace(".");
								return;
							}else if(err.status==403){
								alert("You are not authorized to delete suppliers!");
								return;
							}
							alert(JSON.stringify(err));
						}
						alert(err);
					},
					success: function(data,textStatus,xhr){
						showSuppliersList();
					}
				});
			}
		}
		
		function showContactListForSupplier(id,fnc,args){
			$.ajax({
				url:"suppliers/"+id+"/contacts",
				type:"GET",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				error:function(err){
					if(err.hasOwnProperty("status") ){
						if(err.status==401){
							alert("Please relogin!")
							return;
						}else if(err.status==403){
							alert("You are not authorized to view contacts!");
							return;
						}
						alert(JSON.stringify(err));
					}
					alert(err);
				},
				success: function(data,textStatus,xhr){
					$("#supplier_contacts_"+id).html(data);	
					$("#supplier_no_of_contacts_"+id).text($("#supplier_contacts_"+id+" #no_of_contacts").val());
					if(typeof(fnc)!='undefined'){//if we have a function to call...
						fnc(args);
					}
				}
			});
		}
		
		function addContactToSupplier(id){
			var contact={};
			contact.name=$("#supplier_contacts_"+id+" #contact_new_name").val();
			contact.surname=$("#supplier_contacts_"+id+" #contact_new_surname").val();
			contact.title=$("#supplier_contacts_"+id+" #contact_new_title").val();
			contact.mail=$("#supplier_contacts_"+id+" #contact_new_mail").val();
			contact.fax=$("#supplier_contacts_"+id+" #contact_new_fax").val();
			contact.phone=$("#supplier_contacts_"+id+" #contact_new_phone").val();
			contact.observations=$("#supplier_contacts_"+id+" #contact_new_observations").val();
			contact.contactFunction=$("#supplier_contacts_"+id+" #contact_new_function").val();
			contact.mobilePhone=$("#supplier_contacts_"+id+" #contact_new_mobile").val();
			
			if(contact.name=="" || contact.surname==""){
				alert("Please input contact name and surname");
				$("#supplier_contacts_"+id+" #contact_new_name").focus();
				return;
			}
			
			$.ajax({
				url:"v1/suppliers/"+id+"/contacts",
				type: "POST",
				headers: {"Accept":"application/json","Content-Type": "application/json","X-CSRF-TOKEN":$("#csrf").val()},
				contentType: "application/json; charset=utf-8",
				data:JSON.stringify(contact),
				cache:false,
				processData:false,
				error:function(err){
					if(err.hasOwnProperty("status") ){
						if(err.status==401){
							alert("Please relogin!")
							return;
						}else if(err.status==403){
							alert("You are not authorized to add contacts!");
							return;
						}
						alert(JSON.stringify(err));
					}
					alert("Error:\r\n"+err);
				},
				success: function(data,textStatus,xhr){		
					showContactListForSupplier(id);
				} 
			});
		} 
		
		
		function deleteContact(id,supplier_id){
			if(!confirm("Are you sure you want to delete the selected contact?")){
				return;
			}
			$.ajax({
				url:"v1/contacts/"+id,
				type: "DELETE",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				error:function(err){
					if(err.hasOwnProperty("status") ){
						if(err.status==401){
							window.location.replace(".");
							return;
						}else if(err.status==403){
							alert("You are not authorized to delete contacts!");
							return;
						}
						alert(JSON.stringify(err));
					}
					alert(err);
				},
				success: function(data,textStatus,xhr){
					showContactListForSupplier(supplier_id);
				}
			});
		}
		
		function editContact(id,supplier_id){
			showContactListForSupplier(supplier_id,finishEditContact,[id, supplier_id]);
		}
		
		function finishEditContact(arrIds){
			var id=arrIds[0];
			var supplier_id=arrIds[1];
			$("#edit_contact_"+id).hide();
			$("#del_contact_"+id).hide();
			$("#save_contact_"+id).show();
			$("#cancel_edit_contact_"+id).show();
			//alert($("#contact_"+id+" .name").text());
			$("#contact_"+id+" .name").html("<input type='text' value='"+$("#contact_"+id+" .name").text()+"' class='name_update col-sm-12'/>");
			$("#contact_"+id+" .surname").html("<input type='text' value='"+$("#contact_"+id+" .surname").text()+"' class='surname_update col-sm-12'/>");
			$("#contact_"+id+" .title").html("<input type='text' value='"+$("#contact_"+id+" .title").text()+"' class='title_update col-sm-12'/>");
			$("#contact_"+id+" .function").html("<input type='text' value='"+$("#contact_"+id+" .function").text()+"' class='function_update col-sm-12'/>");
			$("#contact_"+id+" .mail").html("<input type='text' value='"+$("#contact_"+id+" .mail").text()+"' class='mail_update col-sm-12'/>");
			$("#contact_"+id+" .mobilePhone").html("<input type='text' value='"+$("#contact_"+id+" .mobilePhone").text()+"' class='mobilePhone_update col-sm-12'/>");
			$("#contact_"+id+" .phone").html("<input type='text' value='"+$("#contact_"+id+" .phone").text()+"' class='phone_update col-sm-12'/>");
			$("#contact_"+id+" .fax").html("<input type='text' value='"+$("#contact_"+id+" .fax").text()+"' class='fax_update col-sm-12'/>");
		}
		
		function saveContact(id, supplier_id){
			var contact = {};
			contact.id = id;
			contact.name = $("#contact_"+id+" .name_update").val();
			contact.surname = $("#contact_"+id+" .surname_update").val();
			contact.title = $("#contact_"+id+" .title_update").val();
			contact.contactFunction = $("#contact_"+id+" .function_update").val();
			contact.mail = $("#contact_"+id+" .mail_update").val();
			contact.mobilePhone = $("#contact_"+id+" .mobilePhone_update").val();
			contact.phone = $("#contact_"+id+" .phone_update").val();
			contact.fax = $("#contact_"+id+" .fax_update").val();
			
			$.ajax({
				url:"v1/contacts/"+id,
				type: "PUT",
				headers: {"Accept":"application/json","Content-Type": "application/json","X-CSRF-TOKEN":$("#csrf").val()},
				contentType: "application/json; charset=utf-8",
				data:JSON.stringify(contact),
				cache:false,
				processData:false,
				error:function(err){
					if(err.hasOwnProperty("status") ){
						if(err.status==401){
							alert("Please relogin!")
							return;
						}else if(err.status==403){
							alert("You are not authorized to modify contacts!");
							return;
						}
						alert(JSON.stringify(err));
					}
					alert("Error:\r\n"+err);
				},
				success: function(data){
					showContactListForSupplier(supplier_id);
				}
			});
		}
		
		function showContact(id,supplier_id){
			$("#edit_contact_"+id).show();
			$("#del_contact_"+id).show();
			$("#save_contact_"+id).hide();
			$("#cancel_edit_contact_"+id).hide();
			showContactListForSupplier(supplier_id);
		}
		
		function showContractListForSupplier(id,fnc,args){
			
			$.ajax({
				url:"suppliers/"+id+"/contracts",
				type:"GET",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				error:function(err){
					if(err.hasOwnProperty("status") ){
						if(err.status==401){
							alert("Please relogin!")
							return;
						}else if(err.status==403){
							alert("You are not authorized to view contracts!");
							return;
						}
						alert(JSON.stringify(err));
					}
					alert(err);
				},
				success: function(data,textStatus,xhr){
					$("#supplier_contracts_"+id).html(data);						
					$("#supplier_no_of_contracts_"+id).text($("#supplier_contracts_"+id+" #no_of_contracts").val());
					$("#contract_new_date_"+id).datepicker( { dateFormat: 'dd.mm.yy' } );
					$("#contract_new_expiration_date_"+id).datepicker({ dateFormat: 'dd.mm.yy' });
					
					if(typeof(fnc)!='undefined'){//if we have a function to call...
						fnc(args);
					}
				}
			});
		}
		
		function validateContract(contractDate, expirationDate,undefinite,internalNumber,paymentTerm){
			var strDate = contractDate.val();
			if(!strDate){
				alert("Please choose a date for the contract");
				contractDate.focus();
				return false;
			}
			var date = $.datepicker.formatDate("yy-mm-dd",$.datepicker.parseDate("dd.mm.yy",strDate));
			
			var strExpDate = expirationDate.val();
			if(!strExpDate && !undefinite.is(':checked')){
				alert("Please choose either a expiration date for the contract or Undefinite!");				
				return false;
			}
			var expDate = $.datepicker.formatDate("yy-mm-dd",$.datepicker.parseDate("dd.mm.yy",strExpDate));
			
			if(!isInt(internalNumber.val())){
				alert("Please choose a correct internal number. Hint: it should be an integer. "+internalNumber.val()+" is not."+parseInt(internalNumber.val()));
				internalNumber.focus();
				return false;
			}
			
			var pt = 0;
			if(paymentTerm.val() === parseInt(paymentTerm.val())){
				pt = paymentTerm.val();
			}
			
			var rez={}
			rez.date=date;
			rez.expDate=expDate;
			rez.internalNumber = internalNumber.val();
			rez.paymentTerm = paymentTerm.val();
			rez.undefinite = undefinite.is(':checked');
			
			return rez;
		}
		
		function addContractToSupplier(supplier_id){
			var rez=validateContract($("#contract_new_date_"+supplier_id), 
					$("#contract_new_expiration_date_"+supplier_id),
					$("#supplier_contracts_"+supplier_id+" #contract_new_undefinite"),
					$("#supplier_contracts_"+supplier_id+" #contract_new_internal_number"),
					$("#supplier_contracts_"+supplier_id+" #contract_new_payment_term"));
			if(!rez){
				return false;
			}
			
			contract={};
			contract.supplierId = supplier_id;
			contract.expirationDate = rez.expDate;
			contract.contractDate = rez.date;
			contract.undefinite = rez.undefinite;
			contract.internalNumber = rez.internalNumber;
			contract.contractObject = $("#supplier_contracts_"+supplier_id+" #contract_new_object").val();
			contract.paymentTerm = rez.paymentTerm;
			contract.undefinite = rez.undefinite;
			contract.filed = $("#supplier_contracts_"+supplier_id+" #contract_new_filed").val();
			contract.doNotRenew = $("#supplier_contracts_"+supplier_id+" #contract_new_do_not_renew").is(':checked');
			contract.observations = $("#supplier_contracts_"+supplier_id+"contract_new_observations").val();
			
			$.ajax({
				url: "v1/suppliers/"+supplier_id+"/contracts",
				type:"POST",
				headers: {"Accept":"application/json","Content-Type": "application/json","X-CSRF-TOKEN":$("#csrf").val()},
				cache:false,
				data:JSON.stringify(contract),
				processData:false,
				success:function(data){
					showContractListForSupplier(supplier_id);
				},
				error: function(data){
					alert(data.responseText);
					console.log(data);
				}
			});
			
		}
		
		function deleteContractFile(id,supplier_id ){
			if(confirm("Are you sure you want to delete the selected contract file?")){
				$("#supplier_contracts_"+supplier_id+" #messageDiv").show();
				$("#supplier_contracts_"+supplier_id+" #messageDiv").attr("class","alert alert-info");
				$("#supplier_contracts_"+supplier_id+" #messageDiv").html("Please wait while the file is being deleted");
				$.ajax({
					url:"v1/contracts/"+id+"/file",
					type:"DELETE",
					headers: {"X-CSRF-TOKEN":$("#csrf").val()},
					success: function(data){
						if(supplier_id){
							$("#supplier_contracts_"+supplier_id+" #messageDiv").hide();						
						}
						repaintContract(id,supplier_id);						
					},
					error: function(err){
						if(err.hasOwnProperty("responseText")){
							$("#supplier_contracts_"+supplier_id+" #messageDiv").html(err.responseText);
							$("#supplier_contracts_"+supplier_id+" #messageDiv").attr("class","alert alert-danger");
							console.log(err);	
						}else{
							$("#supplier_contracts_"+supplier_id+" #messageDiv").html("An unknown error occured!");
							$("#supplier_contracts_"+supplier_id+" #messageDiv").attr("class","alert alert-danger");
							console.log(err);								
						}		
					}
				});
			}
		}
		
		function uploadContractFile( id,supplier_id,list){
			console.log(list);
			if(list.length==0){
				return;
			}
			try{				
				
				
				var frmData = new FormData(document.getElementById("frm_supplier_contracts_"+id));
				$("#supplier_contracts_"+supplier_id+" #messageDiv").show();
				$("#supplier_contracts_"+supplier_id+" #messageDiv").html("Please wait while uploading the file");
				$("#supplier_contracts_"+supplier_id+" #messageDiv").attr("class","alert alert-info");
				console.log(frmData);
				
				$.ajax({
					url: "contracts/"+id+"/file",
					type:"POST",
					headers: {"X-CSRF-TOKEN":$("#csrf").val()},
					data: frmData,
					cache:false,				
					processData:false,
					contentType:false,
					success: function(data){						
						if(supplier_id){
							$("#supplier_contracts_"+supplier_id+" #messageDiv").hide();						
						}
						repaintContract(id,supplier_id);
					},
					error:function(err){
						if(err.hasOwnProperty("responseText")){
							$("#supplier_contracts_"+supplier_id+" #messageDiv").html(err.responseText);
							$("#supplier_contracts_"+supplier_id+" #messageDiv").attr("class","alert alert-danger");
							console.log(err);	
						}else{
							$("#supplier_contracts_"+supplier_id+" #messageDiv").html("An unknown error occured!");
							$("#supplier_contracts_"+supplier_id+" #messageDiv").attr("class","alert alert-danger");
							console.log(err);								
						}		
					}
				});
			}catch(err){
				alert(err);
				console.log(err);
			}
			return false;
		}
		
		function deleteContract(id, supplier_id){
			if(confirm("Are you sure you want to delete the selected contract?")){
				$.ajax({
					url:"v1/contracts/"+id,
					type:"DELETE",
					headers: {"X-CSRF-TOKEN":$("#csrf").val()},
					success: function(data){
						if(supplier_id){
							showContractListForSupplier(supplier_id);
						}else{
							showContractsList();
						}
					},
					error:function(err){
						if(err.hasOwnProperty("responseText")){
							console.log(err);	
						}else{
							console.log(err);								
						}		
					}
				});
			}
		}
		
		function editContract(id, supplier_id){
			//if we edit in the suppliers view, we refresh the view first, else we show the edit directly
			if(supplier_id!=0){
				showContractListForSupplier(supplier_id,finishEditContract,[id, supplier_id]);
			}else{
				finishEditContract([id,supplier_id]);
			}
		}
		
		function finishEditContract(arrIds){
			var id=arrIds[0];
			var supplier_id=arrIds[1];
			var date = $("#contract_"+id+" .date").text();
			var expDate = $("#contract_"+id+" .expiration_date").text();
			var filed = $("#contract_"+id+" .filed").text();
			$("#edit_contract_"+id).hide();
			$("#del_contract_"+id).hide();
			$("#file_contract_"+id).hide();
			$("#del_file_contract_"+id).hide();
			$("#save_contract_"+id).show();
			$("#cancel_edit_contract_"+id).show();
			//alert($("#contact_"+id+" .name").text());
			$("#contract_"+id+" .date").html("<input type='text' id='contract_date_"+id+"' class='date_update col-sm-12'/>");
			$("#contract_"+id+" .internal_number").html("<input type='text' value='"+$("#contract_"+id+" .internal_number").text()+"' class='internal_number_update col-sm-12'/>");
			$("#contract_"+id+" .expiration_date").html("<input type='text' id='contract_expiration_date_"+id+"' class='expiration_date_update col-sm-12'/>");
			$("#contract_"+id+" .object").html("<input type='text' value='"+$("#contract_"+id+" .object").text()+"' class='object_update col-sm-12'/>");
			$("#contract_"+id+" .payment_term").html("<input type='text' value='"+$("#contract_"+id+" .payment_term").text()+"' class='payment_term_update col-sm-12'/>");
			
			$("#contract_"+id+" .filed").html("<select class='filed_update col-sm-12'><option "+
					(filed=="to sign"?"selected":"")+
					">to sign</option><option "+
					(filed=="signed"?"selected":"")+
					">signed</option><option "+
					(filed=="filed"?"selected":"")+
					">filed</option></select>");
			
			$("#contract_"+id+" .undefinite").html("<input type='checkbox' "+
					($("#contract_"+id+" .undefinite").text()=="true"?"checked":"")+
					" class='undefinite_update col-sm-5 checkbox-inline'/>");
			$("#contract_"+id+" .do_not_renew").html("<input type='checkbox' "+
					($("#contract_"+id+" .do_not_renew").text()=="true"?"checked":"")+
					" class='do_not_renew_update col-sm-6 checkbox-inline'/>");

			$("#contract_date_"+id).datepicker({ dateFormat: 'dd.mm.yy' });
			if(date!=""){
				$("#contract_date_"+id).datepicker("setDate",$.datepicker.parseDate("dd.mm.yy", date));
			}
			
			$("#contract_expiration_date_"+id).datepicker({ dateFormat: 'dd.mm.yy' });
			if(expDate!=""){
				$("#contract_expiration_date_"+id).datepicker("setDate",$.datepicker.parseDate("dd.mm.yy", expDate));
			}
			
			$("#contract_expiration_date_"+id).datepicker();
		}
		
		function cancelEditContract(id, supplier_id){
			/*if(supplier_id){
				showContractsListForSupplier(supplier_id);
			}*/
			repaintContract(id,supplier_id);
		}
		
		function repaintContract(id,supplier_id){
			$.ajax({
				url:"v1/contracts/"+id,
				type:"GET",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				error:function(err){
					if(err.hasOwnProperty("status") ){
						if(err.status==401){
							alert("Please relogin!")
							return;
						}else if(err.status==403){
							alert("You are not authorized to view contracts!");
							return;
						}
						alert(JSON.stringify(err));
					}else{
						alert(err);
					}
				},
				success: function(data,textStatus,xhr){
					var date = "";
					//alert(JSON.stringify(data));
					if(data.contractDate){
						date = $.datepicker.formatDate("dd.mm.yy",new Date(data.contractDate));
					}
					$("#contract_"+id+" .date").text(date);
					$("#contract_"+id+" .internal_number").text(data.internalNumber);
					var expDate = "";
					if(data.expirationDate){
						expDate = $.datepicker.formatDate("dd.mm.yy",new Date(data.expirationDate));
					}
					$("#contract_"+id+" .expiration_date").text(expDate);
					$("#contract_"+id+" .undefinite").text(data.undefinite);
					$("#contract_"+id+" .object").text(data.contractObject);
					$("#contract_"+id+" .payment_term").text(data.paymentTerm);
					$("#contract_"+id+" .filed").text(data.filed);
					$("#contract_"+id+" .do_not_renew").text(data.doNotRenew);
					if(data.originalFileName){
						$("#contract_"+id+" .scan").html("<button class=\"btn btn-sm btn-danger\" id=\"del_file_contract_"+id+"\" onclick=\"deleteContractFile("+id+","+supplier_id+")\">"+
						"<span class=\"glyphicon glyphicon-trash\"></span></button> "+					
						"<a download=\""+data.originalFileName+"\" href=\"contracts/"+id+"/download\" title=\""+data.originalFileName+"\">Download</a>");							
					}else{
						$("#contract_"+id+" .scan").html("");
					}
					
					$("#edit_contract_"+id).show();
					$("#del_contract_"+id).show();
					$("#file_contract_"+id).show();
					$("#del_file_contract_"+id).show();
					$("#save_contract_"+id).hide();
					$("#cancel_edit_contract_"+id).hide();
					
					if(data.mustRenew){
						$("#contract_"+id).attr("class","alert-danger");
					}else if(data.mustRenewInDays){
						$("#contract_"+id).attr("class","alert-warning");
					}else if(data.finished){
						$("#contract_"+id).attr("class","alert-info");
					}else{
						$("#contract_"+id).attr("class","");
					}
				}
			});
		}
		
		function saveContract(id, supplier_id){
			var rez=validateContract($("#contract_date_"+id), 
					$("#contract_expiration_date_"+id),
					$("#contract_"+id+" .undefinite_update"),
					$("#contract_"+id+" .internal_number_update"),
					$("#contract_"+id+" .payment_term_update"));
			if(!rez){
				return false;
			}
			
			contract={};
			contract.id = id;
			contract.supplierId = supplier_id;
			contract.expirationDate = rez.expDate;
			contract.contractDate = rez.date;
			contract.undefinite = rez.undefinite;
			contract.internalNumber = rez.internalNumber;
			contract.contractObject = $("#contract_"+id+" .object_update").val();
			contract.paymentTerm = rez.paymentTerm;
			contract.undefinite = rez.undefinite;
			contract.filed = $("#contract_"+id+" .filed_update").val();
			contract.doNotRenew = $("#contract_"+id+" .do_not_renew_update").is(':checked');
			
			$.ajax({
				url: "v1/contracts/"+id,
				type:"PUT",
				headers: {"Accept":"application/json","Content-Type": "application/json","X-CSRF-TOKEN":$("#csrf").val()},
				cache:false,
				data:JSON.stringify(contract),
				processData:false,
				success:function(data){
					if(supplier_id){
						showContractListForSupplier(supplier_id);	
					}else{
						repaintContract(id,supplier_id);
					}
					
				},
				error: function(data){
					alert(data.responseText);
					console.log(data);
				}
			});
		}
		
		function showContractsList(filter){
			var url = "contracts/list?startFrom=0&count=10";
			if(filter){				
				Object.keys(filter).forEach(function (key){
					url+="&"+key+"="+filter[key];	
				});
			}
			$.ajax({
				url:url,
				type:"GET",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				error:function(err){
					if(err.hasOwnProperty("status") ){
						if(err.status==401){
							alert("Please relogin!")
							return;
						}else if(err.status==403){
							alert("You are not authorized to view contracts!");
							return;
						}
						alert(JSON.stringify(err));
					}
					alert(err);
				},
				success: function(data,textStatus,xhr){
					$(".menu-item").removeClass("active");
					$("#mnuSuppliers").addClass("active");
					$("#container").html(data);						
				}
			});
		}
		
		function filterContracts(){
			var filter={};
			filter.expired=$("#chkContractsExpired").is(':checked');
			filter.expiring=$("#chkContractsExpiring").is(':checked');
			filter.running=$("#chkContractsRunning").is(':checked');
			filter.finished=$("#chkContractsFinished").is(':checked');
			showContractsList(filter);
		}
		function downloadContractList(){
			var filter={};
			filter.expired=$("#chkContractsExpired").is(':checked');
			filter.expiring=$("#chkContractsExpiring").is(':checked');
			filter.running=$("#chkContractsRunning").is(':checked');
			filter.finished=$("#chkContractsFinished").is(':checked');
			var url = "contracts/downloadContractList?startFrom=0&count=0";
					
			Object.keys(filter).forEach(function (key){
				url+="&"+key+"="+filter[key];	
			});
			window.location.href=url;
			/*$.ajax({
				url:url,
				type:"GET",
				headers: {"X-CSRF-TOKEN":$("#csrf").val()},
				error:function(err){
					if(err.hasOwnProperty("status") ){
						if(err.status==401){
							alert("Please relogin!")
							return;
						}else if(err.status==403){
							alert("You are not authorized to view contracts!");
							return;
						}
						alert(JSON.stringify(err));
					}
					alert(err);
				},
				success: function(data,textStatus,xhr){
					$(".menu-item").removeClass("active");
					$("#mnuSuppliers").addClass("active");
					$("#container").html(data);						
				}
			});*/	
		}
		
	</script>
</body>
</html>
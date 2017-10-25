<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<title>Add/Edit supplier</title>

<link type="text/css" rel="stylesheet" href="<spring:url value='/resources/css/bootstrap.min.css'/>" />
<link type="text/css" rel="stylesheet" href="<spring:url value='/resources/css/input.css' />" />

</head>
<body>
	<div id="supplier_form_${supplier.id }" class="container-fluid form-signin">
		<!-- <form action=${supplier.id==0?"\"/furhanes/suppliers/\"":"\"/furhanes/suppliers/\"${supplier.id}"} method=${supplier.id==0?"\"POST\"":"\"PUT\""}>  -->			
			<fieldset>				
				<legend>${supplier.id==0?"Add a supplier":""}</legend>				
				<input type="hidden" id="supplier_id" name="id" value="${supplier.id }"/>
				<div class="row">	
					<div class="form-group" id="supplier_name_group">			
					<label class="control-label col-sm-1" for="name">Name:</label>
					<div class="col-sm-5">
						<input readonly="true" type="TEXT" id="supplier_name" name="name" value="${supplier.name}" class="form-control col-sm-12" placeholder="Name of the supplier"/>
					</div>				
					</div>
					<label class="control-label col-sm-1" for="cui">CUI:</label>
					<div class=col-sm-2>
						<input readonly="true" type="TEXT" id="supplier_cui" name="cui" value="${supplier.cui}" class="form-control col-sm-12" placeholder="CUI"/>
					</div>
					
					<label class="control-label col-sm-1" for="j">J:</label>
					<div class="col-sm-2">
						<input readonly="true" type="TEXT" id="supplier_j" name="j" value="${supplier.j}" class="form-control col-sm-12" placeholder="Nr. Reg. Com."/>
					</div>
				</div>
				
				<div class="row">					
					<label class="control-label col-sm-1" for="address">Address:</label>
					<div class="col-sm-7">
						<textarea readonly="true" cols="20" rows="3" id="supplier_address" name="address" class="form-control coll-sm-12" placeholder="Address">${supplier.address}</textarea>
					</div>
					<div class="col-sm-4">
						<label class="control-label col-sm-3" for="mail">E-mail:</label>
						<div class="col-sm-9">
							<input readonly="true" type="TEXT" id="supplier_mail" name="mail" value="${supplier.mail}" class="form-control col-sm-12" placeholder="Suppliers e-mail"/>
						</div>
						
						<label class="control-label col-sm-3" for="phone">Phone:</label>
						<div class=col-sm-9>
							<input readonly="true" type="TEXT" id="supplier_phone" name="phone" value="${supplier.phone}" class="form-control col-sm-12" placeholder="Phone"/>
						</div>
						
						<label class="control-label col-sm-3" for="fax">Fax:</label>
						<div class="col-sm-9">
							<input readonly="true" type="TEXT" id="supplier_fax" name="fax" value="${supplier.fax}" class="form-control col-sm-12" placeholder="Fax"/>
						</div>
					</div>
				</div>
				
				<div class="row">
					<label class="control-label col-sm-1" for="bank">Bank:</label>
					<div class="col-sm-5">
						<input readonly="true" type="TEXT" id="supplier_bank" name="bank" value="${supplier.bank}" class="form-control col-sm-12" placeholder="Suppliers bank"/>
					</div>
					<label class="control-label col-sm-1" for="swift">Swift:</label>
					<div class=col-sm-2>
						<input readonly="true" type="TEXT" id="supplier_swift" name="swift" value="${supplier.swift}" class="form-control col-sm-12" placeholder="SWIFT Code"/>
					</div>
					<label class="control-label col-sm-1" for="swift">IBAN:</label>
					<div class=col-sm-2>
						<input readonly="true" type="TEXT" id="supplier_iban" name="iban" value="${supplier.iban}" class="form-control col-sm-12" placeholder="IBAN code"/>
					</div>	
				</div>
				<div>
				<div class="alert alert-info" id="supplier_msg_${supplier.id}">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<span id="supplier_msg_data_${supplier.id }">You are editing a supplier</span> 
				</div>
				<button class="btn btn-md btn-success alignright" onclick="enableSupplier(${supplier.id })" id="editSupplier_${supplier.id}">Edit</button>
				<button class="btn btn-md btn-success alignright" onclick="disableSupplier(${supplier.id })" id="cancelSupplier_${supplier.id}" style="display:none">Cancel</button>
				<button class="btn btn-md btn-success alignright" onclick="saveSupplier(${supplier.id })" id="saveSupplier_${supplier.id}" style="display:none">Save</button></div>
				
			</fieldset>
			
		<!-- </form>  -->
	</div>

</body>
</html>
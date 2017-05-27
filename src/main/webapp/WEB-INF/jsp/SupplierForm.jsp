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
	<div id="global" class="container-fluid">
		<!-- <form action=${supplier.id==0?"\"/furhanes/suppliers/\"":"\"/furhanes/suppliers/\"${supplier.id}"} method=${supplier.id==0?"\"POST\"":"\"PUT\""}>  -->			
			<fieldset>				
				<legend>${supplier.id==0?"Add a supplier":""}</legend>				
				<input type="hidden" id="supplier_id" name="id" value="${supplier.id }"/>
				<div class="row">				
					<label class="control-label col-sm-1" for="name">Name:</label>
					<div class="col-sm-5">
						<input type="TEXT" id="supplier_name" name="name" value="${supplier.name}" class="form-control col-sm-12" placeholder="Name of the supplier"/>
					</div>				
					
					<label class="control-label col-sm-1" for="cui">CUI:</label>
					<div class=col-sm-2>
						<input type="TEXT" id="supplier_cui" name="cui" value="${supplier.cui}" class="form-control col-sm-12" placeholder="CUI"/>
					</div>
					
					<label class="control-label col-sm-1" for="j">J:</label>
					<div class="col-sm-2">
						<input type="TEXT" id="supplier_j" name="j" value="${supplier.j}" class="form-control col-sm-12" placeholder="Nr. Reg. Com."/>
					</div>
				</div>
				
				<div class="row">					
					<label class="control-label col-sm-1" for="address">Address:</label>
					<div class="col-sm-7">
						<textarea cols="20" rows="3" id="supplier_address" name="address" class="form-control coll-sm-12" placeholder="Address">${supplier.address}</textarea>
					</div>
					<div class="col-sm-4">
						<label class="control-label col-sm-3" for="mail">E-mail:</label>
						<div class="col-sm-9">
							<input type="TEXT" id="supplier_mail" name="mail" value="${supplier.mail}" class="form-control col-sm-12" placeholder="Suppliers e-mail"/>
						</div>
						
						<label class="control-label col-sm-3" for="phone">Phone:</label>
						<div class=col-sm-9>
							<input type="TEXT" id="supplier_phone" name="phone" value="${supplier.phone}" class="form-control col-sm-12" placeholder="Phone"/>
						</div>
						
						<label class="control-label col-sm-3" for="fax">Fax:</label>
						<div class="col-sm-9">
							<input type="TEXT" id="supplier_fax" name="fax" value="${supplier.fax}" class="form-control col-sm-12" placeholder="Fax"/>
						</div>
					</div>
				</div>
				
				<div class="row">
					<label class="control-label col-sm-1" for="bank">Bank:</label>
					<div class="col-sm-5">
						<input type="TEXT" id="supplier_bank" name="bank" value="${supplier.bank}" class="form-control col-sm-12" placeholder="Suppliers bank"/>
					</div>
					<label class="control-label col-sm-1" for="swift">Swift:</label>
					<div class=col-sm-2>
						<input type="TEXT" id="supplier_swift" name="swift" value="${supplier.swift}" class="form-control col-sm-12" placeholder="SWIFT Code"/>
					</div>
					<label class="control-label col-sm-1" for="swift">IBAN:</label>
					<div class=col-sm-2>
						<input type="TEXT" id="supplier_iban" name="iban" value="${supplier.iban}" class="form-control col-sm-12" placeholder="IBAN code"/>
					</div>	
				</div>
				<div><button class="btn btn-md btn-success alignright" onclick="saveSupplier()">Save</button></div>
				
			</fieldset>
		<!-- </form>  -->
	</div>

</body>
</html>
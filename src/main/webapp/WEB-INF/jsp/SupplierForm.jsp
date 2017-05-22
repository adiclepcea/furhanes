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
	<div id="global" class="container">
		<form action=${supplier.id==0?"\".\"":"\"${supplier.id}\""} method=${supplier.id==0?"\"POST\"":"\"PUT\""} class="form-horizontal form">			
			<fieldset>				
				<legend>${supplier.id==0?"Add a supplier":"Edit the supplier"}</legend>				
				<input type="hidden" id="id" name="id" value="${supplier.id }"/>				
				<div class="form-group">
					<label class="control-label col-xs-2" for="name">Name:</label>
					<div class="col-xs-10">
						<input type="TEXT" id="name" name="name" value="${supplier.name}" class="form-control col-sm-10" placeholder="Name of the supplier"/>
					</div>
				</div>
				<div class="form-group">				
						<label class="control-label col-xs-2" for="cui">CUI:</label>
						<div class=col-xs-4>
							<input type="TEXT" id="cui" name="cui" value="${supplier.cui}" class="form-control" placeholder="CUI"/>
						</div>
						<label class="control-label col-xs-2" for="j">J:</label>
						<div class="col-xs-4">
							<input type="TEXT" id="j" name="j" value="${supplier.j}" class="form-control" placeholder="Nr. Reg. Com."/>
						</div>
				</div>
				
				<div class="form-group">					
					<label class="control-label col-xs-2" for="address">Address:</label>
					<div class="col-xs-10">
						<textarea cols="20"rows="5" id="address" name="address" class="form-control coll-sm-10" placeholder="Address">${supplier.address}</textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-2" for="bank">Bank:</label>
					<div class="col-xs-10">
						<input type="TEXT" id="bank" name="bank" value="${supplier.bank}" class="form-control col-sm-10" placeholder="Suppliers bank"/>
					</div>
				</div>
				
				<div class="form-group">				
						<label class="control-label col-xs-2" for="phone">Phone:</label>
						<div class=col-xs-4>
							<input type="TEXT" id="phone" name="phone" value="${supplier.phone}" class="form-control" placeholder="Phone"/>
						</div>
						<label class="control-label col-xs-2" for="fax">Fax:</label>
						<div class="col-xs-4">
							<input type="TEXT" id="fax" name="fax" value="${supplier.fax}" class="form-control" placeholder="Fax"/>
						</div>
				</div>
				<div class="form-group">
					<label class="control-label col-xs-2" for="mail">E-mail:</label>
					<div class="col-xs-10">
						<input type="TEXT" id="mail" name="mail" value="${supplier.mail}" class="form-control col-sm-10" placeholder="Suppliers e-mail"/>
					</div>
				</div>
				
				<div class="form-group">				
						<label class="control-label col-xs-2" for="swift">Swift:</label>
						<div class=col-xs-4>
							<input type="TEXT" id="swift" name="swift" value="${supplier.swift}" class="form-control" placeholder="SWIFT Code"/>
						</div>
						<label class="control-label col-xs-2" for="bic">BIC:</label>
						<div class="col-xs-4">
							<input type="TEXT" id="bic" name="bic" value="${supplier.bic}" class="form-control" placeholder="BIC code"/>
						</div>
				</div>
				<div><button class="btn btn-lg btn-primary btn-block" type="submit">Save</button></div>
				
			</fieldset>
		</form>
	</div>

</body>
</html>
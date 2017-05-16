<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add/Edit supplier</title>
<link type="text/css" rel="stylesheet" href="<spring:url value='/resources/css/input.css' />" />
</head>
<body>
	<div id="global">
		<form action="suppliers/add" method="POST">
			<fieldset style="width:600px">
				<legend>${supplier.id==0?"Add a supplier":"Edit the supplier"}</legend>
				<input type="hidden" id="id" name="id" value="${supplier.id }"/>
				<p>
					<label for="name">Name:</label>
					<input type="TEXT" id="name" name="name" value="${supplier.name}"/>
				</p>
				<p>
					<label for="cui">CUI:</label>
					<input type="TEXT" id="cui" name="cui" value="${supplier.cui}"/>
				</p>
				<p>
					<label for="j">J:</label>
					<input type="TEXT" id="j" name="j" value="${supplier.j}"/>
				</p>
				<p>
					<label for="address">Address:</label>
					<textarea cols="20"rows="5" id="address" name="address">${supplier.address}</textarea>
				</p>
				<div style="text-align:right"><input type="submit" value="Save"/></div>
			</fieldset>
		</form>
	</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div>
	<input type="hidden" id="supplier_id" value="${supplier_id}">
	<input type="hidden" id="no_of_contacts" value="${contacts.size()}">
	
	<input type="text" id="contact_new_name" name="contact_new_name" class="col-sm-2" placeholder="Contact name"/>
	<input type="text" id="contact_new_surname" name="contact_new_surname" class="col-sm-2" placeholder="Contact surname"/>
	<input type="text" id="contact_new_title" name="contact_new_title" class="col-sm-1" placeholder="Title"/>
	<input type="text" id="contact_new_function" name="contact_new_function" class="col-sm-1" placeholder="Function"/>
	<input type="text" id="contact_new_mail" name="contact_new_mail" class="col-sm-2" placeholder="E-mail"/>
	<input type="text" id="contact_new_phone" name="contact_new_phone" class="col-sm-1" placeholder="Phone"/>
	<input type="text" id="contact_new_mobile" name="contact_new_mobile" class="col-sm-1" placeholder="Mobile"/>
	<input type="text" id="contact_new_fax" name="contact_new_fax" class="col-sm-1" placeholder="Fax"/>
	<input type="hidden" id="contact_new_obs" name="contact_new_obs"/>
	<button class="btn btn-sm btn-success col-sm-1" onclick="addContactToSupplier(${supplier_id})">Add contact</button>
	
	<table class="table table-condensed table-hover">
		<thead>
			<tr><td>Name</td><td>Surname</td><td>Title</td><td>Function</td><td>E-mail</td><td>Mobile</td><td>Phone</td><td>Fax</td></tr>
		</thead>
		<tbody>
			<c:forEach var="contact" items="${contacts }">
			<tr>
				<td class="col-sm-2">${contact.name }</td>
				<td class="col-sm-2">${contact.surname }</td>
				<td class="col-sm-1">${contact.title }</td>
				<td class="col-sm-1">${contact.contactFunction }</td>
				<td class="col-sm-2">${contact.mail }</td>
				<td class="col-sm-1">${contact.mobilePhone }</td>
				<td class="col-sm-1">${contact.phone }</td>
				<td class="col-sm-1">${contact.fax }</td>
				<td class="col-sm-1">
					<button class="btn btn-sm btn-danger" onclick="deleteContact(${contact.id},${supplier_id })">Del<span class="glyphicon glyphicon-trash"></span></button>
					<button class="btn btn-sm btn-warning" onclick="editContact(${contact.id},${supplier_id})">Edit</button>
				</td>
				<td>${contact.fax }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
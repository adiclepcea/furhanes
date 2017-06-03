<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<fieldset>
<legend>Contacts</legend>
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
	<button class="btn btn-sm btn-success" onclick="addContactToSupplier(${supplier_id})" style="margin:5px 0px 0px 5px"><span class="glyphicon glyphicon-plus"></span></button>
	
	<table class="table table-condensed table-hover">
		<thead>
			<tr><th>Name</th><th>Surname</th><th>Title</th><th>Function</th><th>E-mail</th><th>Mobile</th><th>Phone</th><th>Fax</th></tr>
		</thead>
		<tbody>
			<c:forEach var="contact" items="${contacts }">
			<tr id="contact_${contact.id}">
				<td class="col-sm-2"><span class="name">${contact.name }</span></td>
				<td class="col-sm-2"><span class="surname">${contact.surname }</span></td>
				<td class="col-sm-1"><span class="title">${contact.title }</span></td>
				<td class="col-sm-1"><span class="function">${contact.contactFunction }</span></td>
				<td class="col-sm-2"><span class="mail">${contact.mail }</span></td>
				<td class="col-sm-1"><span class="mobilePhone">${contact.mobilePhone }</span></td>
				<td class="col-sm-1"><span class="phone">${contact.phone }</span></td>
				<td class="col-sm-1"><span class="fax">${contact.fax }</span></td>
				<td class="col-sm-1">
					<button class="btn btn-sm btn-danger" onclick="deleteContact(${contact.id},${supplier_id })" id="del_contact_${contact.id}" >Del<span class="glyphicon glyphicon-trash"></span></button>
					<button class="btn btn-sm btn-warning" onclick="editContact(${contact.id},${supplier_id})" id="edit_contact_${contact.id}">Edit</button>
					<button class="btn btn-sm btn-info" onclick="showContact(${contact.id},${supplier_id })" id="cancel_edit_contact_${contact.id}" style="display:none">Cancel</button>
					<button class="btn btn-sm btn-success" onclick="saveContact(${contact.id},${supplier_id})" id="save_contact_${contact.id}" style="display:none">Save</button>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</fieldset>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

	<div>
		<div id="userHeader"><button id="btnAddUser" class="btn btn-md btn-success" onclick="addUser()">Add user</button>
			<input type="text" id="user_filter" value="${filter }"/>
			<button id="btnFilter" class="btn btn-md btn-info" onclick="filterUsers()"><span class="glyphicon glyphicon-search"></span></button>
		</div>
		<button id="btnCancelAddUser" class="btn btn-md btn-warning" onclick="closeAddser()" style="display:none">Close add user</button>		
		<div>
			<div id="userAddDiv" style="display:none">
				<h4>Add a user</h4>
			</div>
		</div>
	</div>
	
	
	<div class="list-group" id="usersList">
	
	<c:forEach var="user"  items="${users}" >
		<div class="list-group-item greybackground">
			<h4 class="list-group-item-heading bold" 
				data-toggle="collapse" 
				data-target="#user_edit_${user.id}" 
				id="user_header_${user.id}"  
				onclick="populateUserEdit(${user.id})"
				style="cursor:pointer; cursor:hand">
					
				${user.name}			
			</h4>
			
			<div class="list-group-item-text row">
				<div class="col-md-8" id="user_details_${user.id}">
					<strong>CUI</strong>: ${supplier.cui}, 
					<strong>Phone</strong>: ${supplier.phone}, 
					<strong>Fax</strong>: ${supplier.fax}, 
					<strong>E-Mail</strong>: ${supplier.mail },
					<strong>SWIFT</strong>: ${supplier.swift}, 
					<strong>Address</strong>: ${supplier.address }
				</div>
				<div class="col-md-4">
					<button onclick="deleteSupplier(${supplier.id})" class="btn btn-sm btn-danger alignright">Del<span class="glyphicon glyphicon-trash"></span></button>
					<button data-toggle="collapse" data-target="#supplier_contracts_${supplier.id}" class="btn btn-sm btn-info alignright" onclick="showContractListForSupplier(${supplier.id})"><span class="glyphicon glyphicon-briefcase"></span> <span id="supplier_no_of_contracts_${supplier.id }" class="badge">${supplier.contracts.size() }</span></button>
					<button data-toggle="collapse" data-target="#supplier_contacts_${supplier.id}" class="btn btn-sm btn-info alignright" onclick="showContactListForSupplier(${supplier.id})"><span class="glyphicon glyphicon-user"></span> <span id="supplier_no_of_contacts_${supplier.id }" class="badge">${supplier.contacts.size() }</span></button>								
				</div>
				<div id="supplier_edit_${supplier.id }" class="collapse col-md-12">
					
				</div>
				<div id="supplier_contacts_${supplier.id }" class="collapse col-md-12">
					
				</div>
				<div id="supplier_contracts_${supplier.id }" class="collapse col-md-12">
					
				</div>
			</div>
			
		</div>	
			
	</c:forEach>
	<div class="">
		<ul class="pager">
			<li><a href="#" onclick="decrementSupplierPos()">Previous</a></li>
			<c:if test="${request_count>0 && suppliers.size()==request_count}">
				<li><a href="#" onclick="incrementSupplierPos()">Next</a></li>
			</c:if>
			
		</ul>
	</div>
	
	</div>
		
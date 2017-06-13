<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

	<div>
		<div id="supplierHeader"><button id="btnAddSupplier" class="btn btn-md btn-success" onclick="addSupplier()">Add supplier</button>
			<input type="text" id="supplier_filter" value="${filter }"/>
			<button id="btnFilter" class="btn btn-md btn-info" onclick="filterSuppliers()"><span class="glyphicon glyphicon-search"></span></button>
		</div>
		<button id="btnCancelAddSupplier" class="btn btn-md btn-warning" onclick="closeAddSupplier()" style="display:none">Close add supplier</button>		
		<div>
			<div id="supplierAddDiv" style="display:none">
				<h4>Add a supplier</h4>
			</div>
		</div>
	</div>
	
	
	<div class="list-group" id="suppliersList">
	
	<c:forEach var="supplier"  items="${suppliers}" >
		<div class="list-group-item greybackground">
			<h4 class="list-group-item-heading bold" 
				data-toggle="collapse" 
				data-target="#supplier_edit_${supplier.id}" 
				id="supplier_header_${supplier.id}"  
				onclick="populateSupplierEdit(${supplier.id})"
				style="cursor:pointer; cursor:hand">
				<c:choose>
					<c:when test="${supplier.hasContractsToRenew()}">
						<span class="alert-danger glyphicon glyphicon-time"></span>
					</c:when>
					<c:otherwise>
						<c:if test="${supplier.hasContractsToRenewInDays(20)}">
							<span class="alert-warning glyphicon glyphicon-time"></span>	
						</c:if>
					</c:otherwise>				
				</c:choose>	
				${supplier.name}			
			</h4>
			
			<div class="list-group-item-text row">
				<div class="col-md-8" id="supplier_details_${supplier.id}">
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
		
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

	<div class="list-group">
	
	<c:forEach var="supplier"  items="${suppliers}" >
		<a href="#" class="list-group-item" data-toggle="collapse" data-target="#supplier_edit_${supplier.id}" onclick="populateSupplierEdit(${supplier.id})">
			<h4 class="list-group-item-heading">
				${supplier.name}
			</h4>
			
			<div class="list-group-item-text row">
				<div class="col-md-8">
				CUI: ${supplier.cui}, 
				Phone: ${supplier.phone}, 
				Fax: ${supplier.fax}, 
				E-Mail: ${supplier.mail },
				SWIFT: ${supplier.swift}, 
				Address: ${supplier.address }
				</div>
				<div class="col-md-4">
					<button onclick="deleteSupplier(${supplier.id})" class="btn btn-sm btn-danger alignright">Del<span class="glyphicon glyphicon-trash"></span></button>
					<button data-toggle="collapse" data-target="#suplier_contracts_${supplier.id}" class="btn btn-sm btn-info alignright"><span class="glyphicon glyphicon-briefcase"></span> <span class="badge">1</span></button>
					<button data-toggle="collapse" data-target="#supplier_contacts_${supplier.id}" class="btn btn-sm btn-info alignright"><span class="glyphicon glyphicon-user"></span> <span class="badge">3</span></button>								
				</div>
				<div id="supplier_edit_${supplier.id }" class="collapse col-md-12">
					
				</div>
				<div id="supplier_contacts_${supplier.id }" class="collapse col-md-12">
					
				</div>
				<div id="supplier_contracts_${supplier.id }" class="collapse col-md-12">
					
				</div>
			</div>
			
		</a>		
	</c:forEach>
	
	</div>
		
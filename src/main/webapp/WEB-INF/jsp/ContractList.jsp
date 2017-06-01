<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div>
	<form method="POST" 
		id="frm_supplier_contracts_${supplier_id }" 
		enctype="multipart/form-data" 
		action="<spring:url value='/suppliers/${supplier_id }/contracts'/>">
		<input type="hidden" id="supplier_id" value="${supplier_id}">
		<input type="hidden" id="no_of_contracts" value="${contracts.size()}">
		
		<input type="text" id="contract_new_date" name="contract_new_date" class="col-sm-1" placeholder="Contract date"/>
		<input type="text" id="contract_new_internal_number" name="contract_new_internal_number" class="col-sm-1" placeholder="Internal No"/>
		<input type="text" id="contract_new_expiration_date" name="contract_new_expiration_date" class="col-sm-1" placeholder="Expires on"/>
		<input type="text" id="contract_new_object" name="contract_new_object" class="col-sm-2" placeholder="Contract object"/>
		<input type="text" id="contract_new_payment_term" name="contact_new_payment_term" class="col-sm-1" placeholder="Payment term"/>
		<div class="col-sm-3">
		<div class="checkbox-inline"><label><input type="checkbox" id="contract_new_undefinite" name="contract_new_undefinite" value=""/>Undefinite</label></div>
		<div class="checkbox-inline"><label><input type="checkbox" id="contract_new_filed" name="contract_new_filed" value=""/>Filed</label></div>
		<div class="checkbox-inline"><label><input type="checkbox" id="contract_new_do_not_renew" name="contract_new_do_not_renew" value=""/>Do not renew</label></div>
		</div>
		<input type="hidden" id="contract_new_observations" name="contract_new_observations"/>
		<input id="contract_upload_${supplier_id }" type="file" name="file"  />
		<button class="btn btn-sm btn-info col-sm-1" onclick="document.getElementById('contract_upload_${supplier_id}').click();return false;">Choose file</button>
		<button type="submit" class="btn btn-sm btn-success col-sm-1" onclick="addContractToSupplier(${supplier_id});return false;" style="margin:0px 0px 0px 5px">Add contract</button>
		<input type="hidden" id="csrf"
		name="${_csrf.parameterName}"
		value="${_csrf.token}" />
	</form>
	<table class="table table-condensed table-hover">
		<thead>
			<tr><td>Date</td><td>Internal no</td><td>Expires on</td><td>Contract object</td><td>Payment term  (days)</td><td>Undefinite</td><td>Filed</td><td>Do not renew</td></tr>
		</thead>
		<tbody>
			<c:forEach var="contract" items="${contracts }">
			<tr id="contract_${contract.id}">
				<td class="col-sm-1"><span class="date">${contract.date }</span></td>
				<td class="col-sm-1"><span class="internal_number">${contract.internalNumber }</span></td>
				<td class="col-sm-1"><span class="expiration_date">${contract.expirationDate }</span></td>
				<td class="col-sm-2"><span class="object">${contract.object }</span></td>
				<td class="col-sm-1"><span class="payment_term">${contract.paymentTerm }</span></td>
				<td class="col-sm-1"><span class="undefinite">${contract.undefinite }</span></td>
				<td class="col-sm-1"><span class="filed">${contract.filed }</span></td>
				<td class="col-sm-1"><span class="do_not_renew">${contract.doNotRenew }</span></td>
				<td class="col-sm-1">
					<button class="btn btn-sm btn-danger" onclick="deleteContract(${contract.id},${supplier_id })" id="del_contract_${contract.id}" >Del<span class="glyphicon glyphicon-trash"></span></button>
					<button class="btn btn-sm btn-warning" onclick="editContract(${contract.id},${supplier_id})" id="edit_contract_${contract.id}">Edit</button>
					<button class="btn btn-sm btn-info" onclick="showContract(${contract.id},${supplier_id })" id="cancel_edit_contract_${contract.id}" style="display:none">Cancel</button>
					<button class="btn btn-sm btn-success" onclick="saveContract(${contract.id},${supplier_id})" id="save_contract_${contract.id}" style="display:none">Save</button>
				</td>
				<td>${contact.fax }</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
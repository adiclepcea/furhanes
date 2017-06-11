<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<fieldset>
<legend>Contracts</legend>
<div style="${supplier_id!=0?"display:none":""}">
	<label><input type="checkbox" class="checkbox-inline" id="chkContractsExpired" ${expired?'checked':'' } > Filter expired</label>
	<label><input type="checkbox" class="checkbox-inline" id="chkContractsExpiring" ${expiring?'checked':'' }>Filter expiring</label>
	<label><input type="checkbox" class="checkbox-inline" id="chkContractsRunning" ${running?'checked':'' }>Filter running</label>
	<label><input type="checkbox" class="checkbox-inline" id="chkContractsFinished" ${finished?'checked':'' }>Filter finished</label>
	<button class="btn btn-md btn-info" onclick="filterContracts()"><span class="glyphicon glyphicon-filter"></span></button>
	<button class="btn btn-md btn-info" onclick="downloadContractList()"><span class="glyphicon glyphicon-save"></span></button>
	
</div>
<div>
	<c:if test="${supplier_id!=0 }">
		<div class="col-sm-12" style="margin:0px 0px 0px 0px; padding: 0px 0px 0px 0px">
			<input type="hidden" id="supplier_id" value="${supplier_id}">
			<input type="hidden" id="no_of_contracts" value="${contracts.size()}">
			<div class="col-sm-1"></div>
			<input type="text" id="contract_new_date_${supplier_id }" name="contract_new_date" class="col-sm-1" placeholder="Contract date"/>
			<input type="text" id="contract_new_internal_number" name="contract_new_internal_number" class="col-sm-1" placeholder="Internal No"/>
			<input type="text" id="contract_new_expiration_date_${supplier_id }" name="contract_new_expiration_date" class="col-sm-1" placeholder="Expires on"/>
			<input type="text" id="contract_new_object" name="contract_new_object" class="col-sm-2" placeholder="Contract object"/>
			<input type="text" id="contract_new_payment_term" name="contact_new_payment_term" class="col-sm-1" placeholder="Payment term"/>
			<select class="col-sm-1" id="contract_new_filed" name="contract_new_filed" >
				<option>to sign</option>
				<option>signed</option>
				<option>filed</option>
			</select>
			<div class="col-sm-3">
				<div class="checkbox-inline "><label><input type="checkbox" id="contract_new_undefinite" name="contract_new_undefinite" value=""/>Undefinite</label></div>		
				<div class="checkbox-inline"><label><input type="checkbox" id="contract_new_do_not_renew" name="contract_new_do_not_renew" value=""/>Do not renew</label></div>
				
			</div>
		
		<button class="btn btn-sm btn-success" onclick="addContractToSupplier(${supplier_id});return false;" style="margin:5px 0px 0px 5px"><span class="glyphicon glyphicon-plus"></span></button>
		<input type="hidden" id="contract_new_observations" name="contract_new_observations"/>
		<input type="hidden" id="csrf"
		name="${_csrf.parameterName}"
		value="${_csrf.token}" />
		</div>
	</c:if>
	<div id="messageDiv" class="col-sm-12" style="display:none">Please wait while uploading the file</div>
	<table class="table table-condensed table-hover">
		<thead>
			<tr>
			<th>
			<c:if test="${supplier_id==0 }">
				Supplier
			</c:if>
			</th>
			<th>Date</th><th>Internal no</th><th>Expires on</th><th>Contract object</th><th>Payment term  (days)</th><th>Status</th><th>Undefinite / Do not renew</th><th>Scanned file</th></tr>
		</thead>
		<tbody>
			<c:forEach var="contract" items="${contracts }">
			<tr id="contract_${contract.id}" class="${contract.mustRenew()?"alert-danger":(contract.mustRenewInDays(20)?"alert-warning":(contract.isFinished()?"alert-info":"")) }">
				<td class="col-sm-1">
				<c:if test="${supplier_id==0 }">
					${contract.supplier.name }
				</c:if>
				</td>
				<td class="col-sm-1"><span class="date"><fmt:formatDate pattern = "dd.MM.yyyy" value = "${contract.contractDate }" /></span></td>
				<td class="col-sm-1"><span class="internal_number">${contract.internalNumber }</span></td>
				<td class="col-sm-1"><span class="expiration_date"><fmt:formatDate pattern = "dd.MM.yyyy" value = "${contract.expirationDate }" /></span></td>
				<td class="col-sm-2"><span class="object">${contract.contractObject }</span></td>
				<td class="col-sm-1"><span class="payment_term">${contract.paymentTerm }</span></td>
				<td class="col-sm-1"><span class="filed">${contract.filed }</span></td>
				<td class="col-sm-1"><span class="undefinite col-sm-5">${contract.undefinite }</span><span class="separator col-sm-1"></span><span class="do_not_renew col-sm-6">${contract.doNotRenew }</span></td>
				<td class="col-sm-1"><span class="scan">
					<c:if test="${contract.originalFileName!=null }">
						<button class="btn btn-sm btn-danger" id="del_file_contract_${contract.id }" onclick="deleteContractFile(${contract.id},${supplier_id})">
							<span class="glyphicon glyphicon-trash"></span>
						</button>					
						<a download="${contract.originalFileName }" href="<spring:url value='/contracts/${contract.id }/download'/>" title="${contract.originalFileName }">Download</a>			
					</c:if>	
					</span>
				</td>
				
				<td class="col-sm-2">
					
					<button class="btn btn-sm btn-danger" onclick="deleteContract(${contract.id},${supplier_id });return false;" id="del_contract_${contract.id}" >Del<span class="glyphicon glyphicon-trash"></span></button>
					<button class="btn btn-sm btn-warning" onclick="editContract(${contract.id},${supplier_id});return false;" id="edit_contract_${contract.id}">Edit</button>
					<button class="btn btn-sm btn-info" onclick="cancelEditContract(${contract.id},${supplier_id });return false;" id="cancel_edit_contract_${contract.id}" style="display:none">Cancel</button>
					<button class="btn btn-sm btn-success" onclick="saveContract(${contract.id},${supplier_id});return false;" id="save_contract_${contract.id}" style="display:none">Save</button>
					<button class="btn btn-sm btn-info" onclick="document.getElementById('contract_upload_${contract.id}').click();" id="file_contract_${contract.id}">File<span class="glyphicon glyphicon-upload"></span></button>
					<form method="POST" 
						id="frm_supplier_contracts_${contract.id }"
						enctype="multipart/form-data" 
						action="<spring:url value='/suppliers/${supplier_id }/contracts'/>">
						<input style="width:0px;height:0px" id="contract_upload_${contract.id }" type="file" name="file" style="display:none" onchange="uploadContractFile(${contract.id },${supplier_id },this.files)"/>
					</form>
				</td>
				<td>${contact.fax }</td>				
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
</div>
</fieldset>
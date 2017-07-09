<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

	<div>
		<div id="userHeader"><button id="btnAddUser" class="btn btn-md btn-success" onclick="addUser()">Add user</button>
			<input type="text" id="add_user_name" value="" placeholder="Username"/>
			<input type="password" id="add_user_pass" value="" placeholder="Password"/>
			<input type="password" id="add_user_pass_confirm" value="" placeholder="Confirm password"/>
			<input type="text" id="add_user_email" value="" placeholder="E-mail"/>
			<input type="text" id="add_user_firstname" value="" placeholder="First Name"/>
			<input type="text" id="add_user_lastname" value="" placeholder="Last Name"/>			
		</div>
	</div>
	
	
	<div class="list-group" id="usersList" >
	
	<c:forEach var="user"  items="${users}" >
		<div class="list-group-item greybackground" style="overflow:auto">
			<span class="glyphicon glyphicon-user" style="font-size:40px;float:left;width:15%;cursor:pointer; cursor:hand"></span>
			<div style="float:left;width:70%">
			<h4 class="list-group-item-heading bold" 
				data-toggle="collapse" 
				data-target="#user_edit_${user.id}" 
				id="user_header_${user.id}"  
				onclick="populateUserEdit(${user.id})"
				style="cursor:pointer; cursor:hand">				
				${user.username}			
			</h4>
			<c:forEach var="role" items="${user.roles.toArray() }">
				${role.name }
			</c:forEach>
			</div>
			<button class="btn btn-md btn-danger"  style="float:right; margin:5px 0 0 0;" onclick="deleteUser(${user.id})"><span class="glyphicon glyphicon-trash"></span></button>
			<div id="user_edit_${user.id }" class="collapse col-md-12">
			<ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#user_details_${user.id }">Details</a></li>
				<li><a data-toggle="tab" href="#user_rights_${user.id }">Rights</a></li>
			</ul>
			<div class="tab-content">
				<div id="user_details_${user.id }" class="tab-pane fade in active">
					<input type="text" id="update_user_name_${user.id }" value="" placeholder="Username"/>
					<input type="password" id="update_user_pass_${user.id }" value="" placeholder="Password"/>
					<input type="password" id="update_user_pass_confirm_${user.id }" value="" placeholder="Confirm password"/>
					<input type="text" id="update_user_email_${user.id }" value="" placeholder="Password"/>
					<input type="text" id="update_user_firstname_${user.id }" value="" placeholder="First Name"/>
					<input type="text" id="update_user_lastname_${user.id }" value="" placeholder="Last Name"/>
				</div>
				<div id="user_rights_${user.id }" class="tab-pane fade">
					<c:forEach var="role" items="${roles}">
						<label for="${role.id }_${user.id}"><input type="checkbox" id="${role.id }_${user.id}" class="chkrole_${user.id }"/>${role.name }</label>
					</c:forEach>
				</div>
				
				<button class="btn btn-md btn-success" onclick="saveUser(${user.id})">Save</button>
			</div>
		</div>
		</div>
		
	</c:forEach>
	
	</div>
		
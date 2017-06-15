<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

	<div>
		<div id="userHeader"><button id="btnAddUser" class="btn btn-md btn-success" onclick="addUser()">Add user</button>
			<input type="text" id="add_user_name" value="" placeholder="Username"/>
			<input type="password" id="add_user_pass" value="" placeholder="Password"/>
			<input type="password" id="add_user_pass_confirm" value="" placeholder="Confirm password"/>
			<input type="text" id="add_user_firstname" value="" placeholder="First Name"/>
			<input type="text" id="add_user_lastname" value="" placeholder="Last Name"/>			
		</div>
	</div>
	
	
	<div class="list-group" id="usersList" >
	
	<c:forEach var="user"  items="${users}" >
		<div class="list-group-item greybackground" style="overflow:auto">
			<span class="glyphicon glyphicon-user" style="font-size:40px;float:left;width:15%"></span>
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
			<button class="btn btn-md btn-danger"  style="float:right; margin:5px 0 0 0;"><span class="glyphicon glyphicon-trash"></span></button>
		</div>			
	</c:forEach>
	
	</div>
		